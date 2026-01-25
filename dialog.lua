if incompatibleClient then return 0 end

local DIALOG_TYPE_ROTATE = 0 -- used in NPCs and level messages
local DIALOG_TYPE_ZOOM = 1    -- used in signposts and wall signs and etc

DEFAULT_DIALOG_NAME = "Mario"

local ogDialog = {}

local function dialog_update(dialogId)
    local m = gMarioStates[0]

    -- Save Original Dialog
    if ogDialog[dialogId] == nil then
        local dialog = smlua_text_utils_dialog_get(dialogId)
        ogDialog[dialogId] = {
            unused = dialog.unused,
            linesPerBox = dialog.linesPerBox,
            leftOffset = dialog.leftOffset,
            width = dialog.width,
            text = dialog.text
        }
    end

    -- Clone original dialog table
    local dialog = {
        unused = ogDialog[dialogId].unused,
        linesPerBox = ogDialog[dialogId].linesPerBox,
        leftOffset = ogDialog[dialogId].leftOffset,
        width = ogDialog[dialogId].width,
        text = ogDialog[dialogId].text
    }
    local charName = characterTable[currChar].nickname
    local charAuto = characterTable[currChar].autoDialog
    -- Check for Override Dialog and use it instead
    local colorDialog = false
    if characterDialog[currChar] ~= nil and characterDialog[currChar][dialogId] ~= nil then
        dialog = characterDialog[currChar][dialogId]
        colorDialog = true
    elseif charAuto then
        colorDialog = dialog.text:find(DEFAULT_DIALOG_NAME) ~= nil
        dialog.text = dialog.text:gsub(DEFAULT_DIALOG_NAME, charName)
    end

    -- Get Dialog Color (DialogBoxType isn't exposed to lua)
    local gDialogBoxType = DIALOG_TYPE_ROTATE
    if m.action == ACT_READING_SIGN then
        -- Assume you're talking to a signpost
        gDialogBoxType = DIALOG_TYPE_ZOOM
    end

    -- Set color if Dialog has Character's Name
    reset_dialog_override_color()
    if colorDialog then
        local charColor = characterTable[currChar][characterTable[currChar].currAlt].color
        if gDialogBoxType == DIALOG_TYPE_ZOOM then
            set_dialog_override_color(178 + charColor.r*0.3, 178 + charColor.g*0.3, 178 + charColor.b*0.3, 150, 0, 0, 0, 255)
        else
            set_dialog_override_color(charColor.r*0.3, charColor.g*0.3, charColor.b*0.3, 150, 255, 255, 255, 255)
        end
    end

    -- Apply Text Changes
    smlua_text_utils_dialog_replace(
        dialogId,
        dialog.unused,
        dialog.linesPerBox,
        dialog.leftOffset,
        dialog.width,
        dialog.text
    )

    return true, dialog.text
end

hook_event(HOOK_ON_DIALOG, dialog_update)