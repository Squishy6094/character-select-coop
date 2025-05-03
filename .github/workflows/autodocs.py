
import re
import os
import datetime
import pytz

GITHUB_REPO = "character-select-coop"

def parse_lua_file(lua_file_path):
    """
    Parses a Lua file to extract functions and their annotations from the _G.charSelect table.
    """
    print(f"Debug: Starting to parse Lua file: {lua_file_path}")

    if not os.path.exists(lua_file_path):
        print(f"Error: File {lua_file_path} does not exist.")
        return None

    with open(lua_file_path, 'r') as lua_file:
        lua_content = lua_file.read()

    print("Debug: Successfully read Lua file content.")

    # Remove comments from the Lua content to avoid false positives
    # lua_content_no_comments = re.sub(r"--.*", "", lua_content)  # Remove single-line comments
    # lua_content_no_comments = re.sub(r"--\[\[.*?\]\]", "", lua_content_no_comments, flags=re.DOTALL)  # Remove multi-line comments

    print("Debug: Removed comments from Lua content.")
    functions = []
    forcedoc_functions = []

    # Iterate through each line to find functions and forcedoc annotations
    for line in lua_content.splitlines():
        function_match = re.search(r"function\s+(\w+)", line) or re.search(r"---@forcedoc\s+(\w+)", line)
        if function_match:
            functions.append(function_match.group(1))
            print(f"Debug: Found function: {function_match.group(1)}")

    # Add forcedoc functions to the list of functions
    functions.extend(forcedoc_functions)

    # Regex to find annotations
    param_pattern = re.compile(r"---@param\s+(.+)")
    return_pattern = re.compile(r"---@return\s+(.+)")
    description_pattern = re.compile(r"---@description\s+(.+)")
    ignore_pattern = re.compile(r"---@ignore\s+(.+)")
    note_pattern = re.compile(r"---@note\s+(.+)")
    version_pattern = re.compile(r"---@added\s+(.+)")
    header_pattern = re.compile(r"---@header\s+(.+)")

    documentation = []

    for func in functions:
        print(f"Debug: Processing function: {func}")
        # Determine if the function is a forcedoc or a regular function
        if lua_content.find(f"---@forcedoc {func}") != -1:
            print(f"Debug: Function {func} is forced (---@forcedoc).")
            func_start = lua_content.find(f"---@forcedoc {func}")
            func_end = func_start + len(f"---@forcedoc {func}")
            func_block = lua_content[func_start:func_end]
        else:
            func_start = lua_content.find(f"function {func}(")
            if func_start == -1:
                print(f"Warning: Function {func} not found.")
                continue
            func_end = lua_content.find("end", func_start) + 3  # Include the "end" keyword
            func_block = lua_content[func_start:func_end]

        print(f"Debug: Function block for {func}:\n{func_block}")

        # Extract annotations ABOVE the function definition, stopping at an empty line
        annotation_lines = []
        current_line_start = func_start if func_start != -1 else lua_content.find(f"---@forcedoc {func}")

        while True:
            current_line_start = lua_content.rfind("\n", 0, current_line_start)
            if current_line_start == -1:
                break  # Reached the start of the file
            line_start = current_line_start + 1
            line_end = lua_content.find("\n", line_start)
            line = lua_content[line_start:line_end].strip()
            if line == "":
                break  # Stop at the first empty line
            annotation_lines.insert(0, line)

        annotation_block = "\n".join(annotation_lines)
        print(f"Debug: Annotation block for {func}:\n{annotation_block}")


        # Check for ignore annotation
        if ignore_pattern.search(annotation_block):
            print(f"Debug: Function {func} is marked to be ignored. Skipping documentation.")
            continue

        params = param_pattern.findall(annotation_block)
        returns = return_pattern.findall(annotation_block)
        description = description_pattern.findall(annotation_block)
        note = [match.lstrip(" ") if match.startswith(" ") else match for match in note_pattern.findall(annotation_block)]
        version = version_pattern.findall(annotation_block)
        header = header_pattern.findall(annotation_block)

        # Preserve indentation for notes
        note = []
        for match in note_pattern.finditer(annotation_block):
            start_index = match.start()
            line_start = annotation_block.rfind("\n", 0, start_index) + 1
            note_line = annotation_block[line_start:match.end()]
            print(f"Debug: Found note line: {note_line.strip()}")
            note.append(note_line.replace("---@note ", ""))
        print(f"Debug: Extracted notes: {note}")

        # Build documentation entry
        doc_entry = {
            "function": func,
            "params": params,
            "returns": returns,
            "description": description[0] if description else "No description provided.",
            "note": note,
            "version": version[0] if version else "?",
            "header": True if header else False,
        }
        documentation.append(doc_entry)

    print(f"Debug: Completed parsing. Documentation: {documentation}")
    return documentation

def func_to_link(text, functions):
    """
    Converts mentions of Lua functions in the text into markdown links and replaces groups of five spaces with new lines.
    """
    #text = text.replace("     ", "\n")
    
    for func in functions:
        # Replace function mentions with markdown links
        pattern = r"\b" + re.escape(func["function"]) + r"\b"
        replacement = f"[`{func['function']}()`](#{func['function']})"
        text = re.sub(pattern, replacement, text)
    return text

def write_readme(documentation, output_file_path):
    """
    Writes the extracted documentation to a README file.
    """
    print(f"Debug: Writing documentation to {output_file_path}")

    with open(output_file_path, 'w') as readme_file:
        readme_file.write("# Note Before Reading\n")
        readme_file.write("We highly recommend messing around with our [Character Select Template](https://github.com/Squishy6094/character-select-coop/raw/main/char-select-template.zip) while first reading this doc to get a handle on everything here. DO NOT modify/add any content within the Character Select mod itself, please use the API and an individual mod when adding characters. If you're confused about anything from outside of Character Select's Documentation, Please refer to [SM64CoopDX's Lua Documentation](https://github.com/coop-deluxe/sm64coopdx/blob/main/docs/lua/lua.md).\n\n")
        timeAware = datetime.datetime.now(pytz.timezone('US/Pacific'))
        readme_file.write("<sub>[Automatic Documentation](https://github.com/Squishy6094/character-select-coop/actions/workflows/autodocs.yml) for " + GITHUB_REPO + " written at " + timeAware.strftime("%m/%d/%Y - %I:%M:%S %p") + " PST</sub>\n\n")
        for entry in documentation:
            if entry['header']:
                readme_file.write((f"# {entry['function']}\n").replace("_", " "))
            else:
                print(f"Debug: Writing documentation for function: {entry['function']}")
                readme_file.write(f"## {entry['function']}\n")
                readme_file.write(f"`charSelect.{entry['function']}` - " + "v" + entry['version'] + " - " + func_to_link(entry['description'], documentation) + "\n\n")
    
                if entry['params']:
                    readme_file.write(f"| Variable | Input Types | Description/Examples |\n")
                    readme_file.write(f"| ----- | ----- | ----- |\n")
                    for param in entry['params']:
                        # Replace existing "|" with ", " and split at the first 3 spaces
                        param = param.replace("|", "/")
                        parts = param.split(" ", 2)
                        formatted_param = " | ".join(parts) if len(parts) > 3 else " | ".join(parts + [""] * (4 - len(parts)))
                        readme_file.write(f"| " + func_to_link(formatted_param, documentation) + "\n")
    
                readme_file.write("\n")
                if entry['returns']:
                    for ret in entry['returns']:
                        # Split the return description using "--" as a delimiter
                        parts = ret.split("--", 1)
                        formatted_return = f"{parts[0].strip()} - {parts[1].strip()}" if len(parts) > 1 else parts[0].strip()
                        readme_file.write(f"**Returns**: {formatted_return}\n\n")
                if entry['note']:
                    readme_file.write(f"**Notes**:\n")
                    for note in entry['note']:
                        # Check if the line is inside a code block
                        readme_file.write(f"{func_to_link(note, documentation)}\n")
                readme_file.write("\n\n")

    print(f"Debug: Documentation successfully written to {output_file_path}")

if __name__ == "__main__":
    lua_file_path = str(os.getcwd() + "/o-api.lua")
    output_file_path = str(os.getcwd() + "/" + GITHUB_REPO + ".wiki/API-Documentation.md")

    print("Debug: Starting script execution.")
    documentation = parse_lua_file(lua_file_path)
    if documentation:
        write_readme(documentation, output_file_path)
        print(f"Documentation written to {output_file_path}")
    else:
        print("No functions found in the Lua file.")
    print("Debug: Script execution completed.")
