# Character Select API Documantation
### Gives full descriptions of all API functions and their use cases

## _G.charSelectExists
A Varible checking if the Mod is active, this is useful for preventing script errors when the mod isn't on.

Example: `if not _G.charSelectExists then return end`

## _G.charSelect.character_add()
A function that Adds a Character to the Character Table, has 6 inputs:

### Name:
String (Spaces replace Underscores when Displaying)

Example `"Custom Model"`

### Description:
Table containing Strings

Example `{"Custom Description", "Custom Description"}`

### Credit:
String

Example: `Custom Model Creator`

### Color:
Table containing variables r, g, and b. Colors use Decimal Format

Example: `{r = 255, g = 150, b = 150}`

### Model Info:
Model Information Recieved from `smlua_model_util_get_id()`

Example: `smlua_model_util_get_id("armature_geo")`

### Forced Character
Character Type, Inputs can be `CT_MARIO`, `CT_LUIGI`, `CT_TOAD`, `CT_WALUIGI`, `CT_WARIO`

Example: `CT_MARIO`

### Full Example:
```
_G.charSelect.character_add("Custom Model Name", {"Custom Model Description", "Custom Model Description"}, "Custom Model Creator", {r = 255, g = 200, b = 200}, E_MODEL_CUSTOM_MODEL, CT_MARIO)
```

## _G.charSelect.character_edit()
A function that Edits an Existing Character, has 7 inputs

### Original Character Number:
The Number of the Character you want to edit, this can be found using `_G.charSelect.character_get_number_from_string`

Example: `_G.charSelect.character_get_number_from_string("Custom Model")`

**All 6 other inputs are the same as [`_G.charSelect.character_add()`](https://github.com/SQUISHY6094/character-select-coop/blob/main/API-doc.md#_gcharselectcharacter_add)**

## _G.charSelect.character_get_current_name()
A function that returns the Current Character's Name String

## _G.charSelect.character_get_current_model_number
A function that returns the Current Character's Number in the Character Table

## _G.charSelect.character_get_number_from_string()
A function that returns a character's number in the table based off the inputted name string, has 1 input

### Character Name:
Character's Name String

Example: `"Custom Model"`

## _G.charSelect.version_get()
A function that returns the current version of the mod in a string format

## _G.charSelect.is_menu_open()
A function that returns the either True or False if the Menu is Open or not.

## _G.charSelect.is_options_open()
A function that returns the either True or False if the Menu Options is Open or not.

## _G.charSelect.get_status()
A function that returns the status of an inputted value relitive to the option table

Inputs can be `1 (Open Binds)`, `2 (Menu Color)`, `3 (Animations)`, `4 (Menu Scrolling Speed)`, `5 (Locally Display Models)`