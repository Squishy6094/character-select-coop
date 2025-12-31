if incompatibleClient then return 0 end

DEFAULT_DIALOG_NAME = "Mario"

local ogDialog = {}

local function dialog_update(dialogId)
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

    local dialog = ogDialog[dialogId]
    local charName = characterTable[currChar].nickname
    -- Check for Override Dialog and use it instead
    local overrideDialog = false
    if characterDialog[currChar] ~= nil and characterDialog[currChar][dialogId] ~= nil then
        dialog = characterDialog[currChar][dialogId]
        overrideDialog = true
    end

    -- Set color if Dialog has Character's Name
    reset_dialog_override_color()
    if dialog.text:find(DIALOG_NAME) or overrideDialog then
        local charColor = characterTable[currChar][characterTable[currChar].currAlt].color
        set_dialog_override_color(charColor.r*0.3, charColor.g*0.3, charColor.b*0.3, 150, 255, 255, 255, 255)
    end

    -- Apply Text Changes
    smlua_text_utils_dialog_replace(
        dialogId,
        dialog.unused,
        dialog.linesPerBox,
        dialog.leftOffset,
        dialog.width,
        (overrideDialog and dialog.text or dialog.text:gsub(DIALOG_NAME, charName))
    )

    -- Reminder to later change this to true, string
    return true
end

hook_event(HOOK_ON_DIALOG, dialog_update)