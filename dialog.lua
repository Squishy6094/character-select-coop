-- Made by EliteMasterEric along with CoopDX PR #321 to replace dialog depending on character --
-- https://github.com/coop-deluxe/sm64coopdx/pull/321 --
if not smlua_text_utils_dialog_get then return end

local DIALOG_NAME = "Mario"

---@param name string
function dialog_set_replace_name(name)
    DIALOG_NAME = name
end

local prevChar = currChar

local function dialog_swap()
    for i = DIALOG_000, DIALOG_COUNT - 1 do
        local dialog = smlua_text_utils_dialog_get(i)
        local name = characterTable[currChar].name
        local replaced_dialog = dialog.str:gsub(DIALOG_NAME, currChar)
        smlua_text_utils_dialog_replace(DIALOG_034, dialog.unused, dialog.linesPerBox, dialog.leftOffset, dialog.width, replaced_dialog)
    end
end

local function update()
    -- Query Character Swapped
    if prevChar ~= currChar then
        dialog_swap()
        prevChar = currChar
    end
end


hook_event(HOOK_UPDATE, update)