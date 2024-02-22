-- Option Menu Made by Squishy >v<

local options = false
local currOption = 1
local isPressingB = 0

local optionTableRef = {
    sfx = 1,
    afterImages = 2,
    debugInfo = 3,
}

local optionTable = {
    [optionTableRef.sfx] = {
        name = "SFX Mode",
        toggle = tonumber(mod_storage_load("SFX")),
        toggleSaveName = "SFX",
        toggleDefault = 0,
        toggleMax = 1,
        toggleNames = {"Sega Genesis", "Super Mario 64"},
    },
    [optionTableRef.afterImages] = {
        name = "UNFINISHED",
        toggle = tonumber(mod_storage_load("AfterImages")),
        toggleSaveName = "AfterImages",
        toggleDefault = 0,
        toggleMax = 0,
    },
    [optionTableRef.debugInfo] = {
        name = "Debugging Info",
        toggle = 0,
        toggleDefault = 0,
        toggleMax = 1,
    },
}

local function nullify_inputs(m)
    m.controller.rawStickY = 0 
    m.controller.rawStickX = 0 
    m.controller.stickX = 0 
    m.controller.stickY = 0 
    m.controller.stickMag = 0 
    m.controller.buttonPressed = 0 
    m.controller.buttonDown = 0
end

local function failsafe_options()
    for i = 1, #optionTable do
        if optionTable[i].toggle == nil then
            optionTable[i].toggle = optionTable[i].toggleDefault
            if optionTable[i].toggleSaveName ~= nil then
                mod_storage_save(optionTable[i].toggleSaveName, tostring(optionTable[i].toggle))
            end
        end
        if optionTable[i].toggleNames == nil then
            optionTable[i].toggleNames = {"Off", "On"}
        end
    end
end

local stallFrame = 0

local TEXT_OPTIONS = "Options"

-- Menu Renderer
local function on_hud_render()
    if stallFrame == 1 then
        failsafe_options()
    end

    if stallFrame < 2 then
        stallFrame = stallFrame + 1
    end

    djui_hud_set_resolution(RESOLUTION_N64)
    local widthHalf = djui_hud_get_screen_width()*0.5

    if options then
        djui_hud_set_font(FONT_HUD)
        djui_hud_set_color(255, 255, 255, 255)
        djui_hud_print_text(TEXT_OPTIONS, widthHalf - djui_hud_measure_text(TEXT_OPTIONS)*0.5, 32, 1)

        djui_hud_set_font(FONT_TINY)
        djui_hud_set_color(0, 0, 0, 150)
        djui_hud_render_rect(widthHalf - 60, 50, 120, 10 + 10 * #optionTable)
        for i = 1, #optionTable do
            local optionName = optionTable[i].name..":"
            local toggleName = optionTable[i].toggleNames[optionTable[i].toggle + 1]
            local toggleNameLength = djui_hud_measure_text(toggleName)*0.6
            djui_hud_set_color(0, 0, 0, 255)
            djui_hud_print_text(optionName, widthHalf - 44.5, 45.5 + 10*i, 0.6)
            djui_hud_print_text(toggleName, widthHalf + 45.5 - toggleNameLength, 45.5 + 10*i, 0.6)
            if i == currOption then
                djui_hud_set_color(255, 255, 255, 255)
            else
                djui_hud_set_color(150, 150, 150, 255)
            end
            djui_hud_print_text(optionName, widthHalf - 45, 45 + 10*i, 0.6)
            djui_hud_print_text(toggleName, widthHalf + 45 - toggleNameLength, 45 + 10*i, 0.6)
        end
        djui_hud_set_color(0, 0, 0, 255)
        djui_hud_print_text(">", widthHalf - 49.5, 45.5 + 10*currOption, 0.6)
        djui_hud_print_text("<", widthHalf + 47.5, 45.5 + 10*currOption, 0.6)
        djui_hud_set_color(255, 255, 255, 255)
        djui_hud_print_text(">", widthHalf - 50, 45 + 10*currOption, 0.6)
        djui_hud_print_text("<", widthHalf + 47, 45 + 10*currOption, 0.6)
    end

    -- Update Toggles
    SFXMode = optionTable[optionTableRef.sfx].toggle
    show_info = optionTable[optionTableRef.debugInfo].toggle
end

-- Menu Input System
local inputStallTimer = 0
local inputStallTo = 10
local function before_mario_update(m)
    if m.playerIndex ~= 0 then return end
    if inputStallTimer > 0 then inputStallTimer = inputStallTimer - 1 end

    local cameraToObject = gMarioStates[0].marioObj.header.gfx.cameraToObject

    if options then
        if inputStallTimer == 0 then
            if (m.controller.buttonPressed & D_JPAD) ~= 0 then
                currOption = currOption + 1
                inputStallTimer = inputStallTo
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
            end
            if (m.controller.buttonPressed & U_JPAD) ~= 0 then
                currOption = currOption - 1
                inputStallTimer = inputStallTo
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
            end
            if m.controller.stickY < -60 then
                currOption = currOption + 1
                inputStallTimer = inputStallTo
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
            end
            if m.controller.stickY > 60 then
                currOption = currOption - 1
                inputStallTimer = inputStallTo
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
            end
            if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                optionTable[currOption].toggle = optionTable[currOption].toggle + 1
                if optionTable[currOption].toggle > optionTable[currOption].toggleMax then optionTable[currOption].toggle = 0 end
                if optionTable[currOption].toggleSaveName ~= nil then
                    mod_storage_save(optionTable[currOption].toggleSaveName, tostring(optionTable[currOption].toggle))
                end
                inputStallTimer = inputStallTo
                play_sound(SOUND_MENU_CHANGE_SELECT, cameraToObject)
            end
            if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
                play_sound(SOUND_MENU_HAND_DISAPPEAR, m.marioObj.header.gfx.cameraToObject)
                options = false
            end
        end
        if currOption > #optionTable then currOption = 1 end
        if currOption < 1 then currOption = #optionTable end
        nullify_inputs(m)
        if is_game_paused() then
            m.controller.buttonPressed = START_BUTTON
        end
    end
end

hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)
hook_event(HOOK_ON_HUD_RENDER, on_hud_render)

function options_command()
    local m = gMarioStates[0]
    options = not options
    if options then
        play_sound(SOUND_MENU_HAND_APPEAR, m.marioObj.header.gfx.cameraToObject)
    else
        play_sound(SOUND_MENU_HAND_DISAPPEAR, m.marioObj.header.gfx.cameraToObject)
    end
    return true
end