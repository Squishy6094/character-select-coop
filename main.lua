-- name: -Character Select-
-- description: A Library / API made to make adding and\nusing Custom Characters as simple as possible!\n\nCreated by:\\#008800\\ Squishy 6094\n\\#dcdcdc\\Concepts by:\\#FF8800\\ AngelicMiracles\\#AAAAFF\\\n\nGithub:\nSQUISHY6094/character-select-coop
local modVersion = "In-Dev"

local menu = false
local options = false

local currChar = 1
local currOption = 1

local E_MODEL_ARMATURE = smlua_model_util_get_id("armature_geo")

local TEX_HEADER = get_texture_info("char-select-text")

local TEXT_PREF_LOAD = "Default"

local characterTable = {
    [1]  = {
        name = "Default",
        description = {"The vanilla cast for sm64ex-coop!", "", "These Characters are interchangeable", "via the default Options Menu"},
        credit = "Nintendo / sm64ex-coop Team",
        color = {r = 255, b = 50, g = 50},
        model = nil,
        forceChar = nil,
    },
}

local optionTableRef = {
    openInputs = 1,
    MenuColor = 2,
    anims = 3,
    prefToDefault = 4,
}

local optionTable = {
    [optionTableRef.openInputs] = {
        name = "Menu Bind",
        toggle = tonumber(mod_storage_load("MenuInput")),
        toggleSaveName = "MenuInput",
        toggleDefault = 0,
        toggleMax = 2,
        toggleNames = {"None", "Down D-pad", "Z (Pause Menu)"},
    },
    [optionTableRef.MenuColor] = {
        name = "Menu Color",
        toggle = tonumber(mod_storage_load("MenuColor")),
        toggleSaveName = "MenuColor",
        toggleDefault = 0,
        toggleMax = 8,
        toggleNames = {"Auto", "Red", "Orange", "Yellow", "Green", "Blue", "Purple", "White", "Black"},
    },
    [optionTableRef.anims] = {
        name = "Menu Animations",
        toggle = tonumber(mod_storage_load("Anims")),
        toggleSaveName = "Anims",
        toggleDefault = 1,
        toggleMax = 1,
    },
    [optionTableRef.prefToDefault] = {
        name = "Set Preference to Default",
        toggle = 0,
        toggleDefault = 0,
        toggleMax = 1,
        toggleNames = {"", ""},
    },
}

menuColorTable = {
    {r = 255, g = 50, b = 50},
    {r = 255, g = 100, b = 50},
    {r = 255, g = 255, b = 50},
    {r = 50, g = 255, b = 50},
    {r = 50, g = 50, b = 255},
    {r = 130, g = 25, b = 130},
    {r = 255, g = 255, b = 255},
    {r = 50, g = 50, b = 50},
}

---------------
-- Functions --
---------------

local function nullify_inputs(m)
    m.controller.rawStickY = 0 
    m.controller.rawStickX = 0 
    m.controller.stickX = 0 
    m.controller.stickY = 0 
    m.controller.stickMag = 0 
    m.controller.buttonPressed = 0 
    m.controller.buttonDown = 0
end

local function string_underscore_to_space(string)
    local s = ''
    for i = 1, #string do
        local c = string:sub(i,i)
        if c ~= '_' then
            s = s .. c
        else
            s = s .. " "
        end
    end
    return s
end

local function string_space_to_underscore(string)
    local s = ''
    for i = 1, #string do
        local c = string:sub(i,i)
        if c ~= ' ' then
            s = s .. c
        else
            s = s .. "_"
        end
    end
    return s
end

local function load_prefered_char()
    if mod_storage_load("PrefChar") ~= nil and mod_storage_load("PrefChar") ~= "Default" then
        for i = 2, #characterTable do
            if characterTable[i].name == mod_storage_load("PrefChar") then
                currChar = i
                djui_chat_message_create('Your Prefered Character "'..string_underscore_to_space(mod_storage_load("PrefChar"))..'" was applied!')
                TEXT_PREF_LOAD = mod_storage_load("PrefChar")
                break
            end
        end
    elseif mod_storage_load("PrefChar") == nil then
        mod_storage_save("PrefChar", "Default")
        TEXT_PREF_LOAD = mod_storage_load("PrefChar")
    end
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

-- Localized Functions --
local camera_freeze = camera_freeze
local camera_unfreeze = camera_unfreeze
local network_local_index_from_global = network_local_index_from_global
local obj_set_model_extended = obj_set_model_extended
local hud_hide = hud_hide
local hud_show = hud_show
local djui_chat_message_create = djui_chat_message_create
local djui_hud_set_resolution = djui_hud_set_resolution
local djui_hud_set_font = djui_hud_set_font
local djui_hud_set_color = djui_hud_set_color
local djui_hud_get_screen_width = djui_hud_get_screen_width
local djui_hud_get_screen_height = djui_hud_get_screen_height
local djui_hud_render_rect = djui_hud_render_rect
local djui_hud_print_text = djui_hud_print_text
local djui_hud_render_texture = djui_hud_render_texture


-------------------
-- Model Handler --
-------------------

local stallFrame = 0

-- Respecfully, GO FUCK YOURSELVES. I hate EVERY SINGLE ONE OF YOU. Your lives are NOTHING. You serve ZERO PURPOSE. You should kill yourselves, NOW!
local ignored_surfaces = {
    SURFACE_BURNING, SURFACE_QUICKSAND, SURFACE_INSTANT_QUICKSAND, SURFACE_INSTANT_MOVING_QUICKSAND, SURFACE_DEEP_MOVING_QUICKSAND, SURFACE_INSTANT_QUICKSAND, SURFACE_DEEP_QUICKSAND, SURFACE_SHALLOW_MOVING_QUICKSAND,
    SURFACE_SHALLOW_QUICKSAND, SURFACE_WARP, SURFACE_LOOK_UP_WARP, SURFACE_WOBBLING_WARP, SURFACE_INSTANT_WARP_1B, SURFACE_INSTANT_WARP_1C, SURFACE_INSTANT_WARP_1D, SURFACE_INSTANT_WARP_1E
}
-- Yes, floral gave me permission to use this table full of USELESS PIECES OF SHITS

--- @param m MarioState
local function mario_update(m)
    if m.playerIndex == 0 then
        if currChar ~= 1 then
            gPlayerSyncTable[0].modelId = characterTable[currChar].model
            if characterTable[currChar].forceChar ~= nil and gPlayerSyncTable[m.playerIndex].modelId ~= nil then
                gNetworkPlayers[m.playerIndex].overrideModelIndex = characterTable[currChar].forceChar
            end
        else
            gPlayerSyncTable[0].modelId = nil
        end

        if menu then
            camera_freeze()
            hud_hide()
            local focusPos = {
                x = m.pos.x,
                y = m.pos.y + 150,
                z = m.pos.z,
            }
            vec3f_copy(gLakituState.focus, focusPos)
            gLakituState.pos.x = m.pos.x + sins(m.faceAngle.y) * 500
            gLakituState.pos.y = m.pos.y + 100
            gLakituState.pos.z = m.pos.z + coss(m.faceAngle.y) * 500

            if m.forwardVel == 0 and m.pos.y == m.floorHeight and not ignored_surfaces[m.floor.type] then
                set_mario_action(m, ACT_IDLE, 0)
                set_mario_animation(m, MARIO_ANIM_STAR_DANCE)
            end
        else
            camera_unfreeze()
            hud_show()
        end

        -- Load Prefered Character and FailSafe Options
        if stallFrame == 1 then
            load_prefered_char()
            failsafe_options()
        end

        if stallFrame < 2 then
            stallFrame = stallFrame + 1
        end
    end
    if gPlayerSyncTable[m.playerIndex].modelId ~= nil then
        obj_set_model_extended(m.marioObj, gPlayerSyncTable[m.playerIndex].modelId)
    end

    --Set Pref to Default Check
    if optionTable[optionTableRef.prefToDefault].toggle > 0 then
        mod_storage_save("PrefChar", "Default")
        TEXT_PREF_LOAD = "Default"
        optionTable[optionTableRef.prefToDefault].toggle = 0
    end
end

local function set_model(o, id)
    if id == E_MODEL_MARIO then
        local i = network_local_index_from_global(o.globalPlayerIndex)
        if gPlayerSyncTable[i].modelId ~= nil then
            obj_set_model_extended(o, gPlayerSyncTable[i].modelId)
        end
    end
end

hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_OBJECT_SET_MODEL, set_model)

------------------
-- Menu Handler --
------------------

local buttonAnimTimer = 0

local optionAnimTimer = -200
local optionAnimTimerCap = optionAnimTimer

local TEXT_OPTIONS_HEADER = "Options"
local TEXT_RES_UNSUPPORTED = "Your Current Resolution is Unsupported!!!"
local TEXT_PREF_SAVE = "Press A to Set as Prefered Character"
local TEXT_Z_OPEN = "Z Button - Character Select"

local function on_hud_render()
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_NORMAL)

    local width = djui_hud_get_screen_width() + 1.4
    local height = djui_hud_get_screen_height()
    local widthHalf = width*0.5
    local heightHalf = height*0.5
    local widthScale = math.max(width, 321.4)*0.00311332503

    if menu then
        if optionTable[optionTableRef.MenuColor].toggle ~= 0 then
            menuColor = menuColorTable[optionTable[optionTableRef.MenuColor].toggle]
        else
            menuColor = characterTable[currChar].color
        end
        
        --Character Buttons
        local x = 135 * widthScale * 0.8
        djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
        djui_hud_render_rect(0, 0, x, height)
        djui_hud_set_color(0, 0, 0, 255)
        djui_hud_render_rect(2, 2, x - 4, height - 4)

        if optionTable[optionTableRef.anims].toggle > 0 then
            buttonAnimTimer = buttonAnimTimer + 1
        end

        local buttonColor = {}
        for i = -1, 4 do
            if characterTable[i + currChar] ~= nil then
                buttonColor = characterTable[i + currChar].color
                djui_hud_set_color(buttonColor.r, buttonColor.g, buttonColor.b, 255)
                local buttonX = 20 * widthScale
                if i == 0 then buttonX = buttonX + math.sin(buttonAnimTimer*0.05)*2.5 + 5 end
                local y = (i + 2) * 30 + 30
                djui_hud_render_rect(buttonX, y, 70, 20)
                djui_hud_set_color(0, 0, 0, 255)
                djui_hud_render_rect(buttonX + 1, y + 1, 68, 18)
                djui_hud_set_font(FONT_NORMAL)
                djui_hud_set_color(buttonColor.r, buttonColor.g, buttonColor.b, 255)
                djui_hud_print_text(string_underscore_to_space(characterTable[currChar + i].name), buttonX + 5, y + 5, 0.3)
            end
        end

        -- Scroll Bar
        djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
        djui_hud_render_rect(7 * widthScale, 55, 7, 180)
        djui_hud_set_color(0, 0, 0, 255)
        djui_hud_render_rect(7 * widthScale + 1, 56, 5, 178)
        djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
        djui_hud_render_rect(7 * widthScale + 2, 57 + 176 * ((currChar - 1) / #characterTable), 3, 176/#characterTable)

        
        --Character Description
        djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
        djui_hud_render_rect(width - x, 0, x, height)
        djui_hud_set_color(0, 0, 0, 255)
        djui_hud_render_rect(width - x + 2, 2, x - 4, height - 4)
        djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
        djui_hud_set_font(FONT_NORMAL)

        local TEXT_NAME = string_underscore_to_space(characterTable[currChar].name)
        local TEXT_CREDIT = "By: "..characterTable[currChar].credit
        local TEXT_DESCRIPTION = "Character Description:"
        local TEXT_DESCRIPTION_TABLE = characterTable[currChar].description
        local TEXT_PREF = 'Prefered Character: "'..string_underscore_to_space(TEXT_PREF_LOAD)..'"'

        local textX = x * 0.5
        djui_hud_print_text(TEXT_NAME, width - textX - djui_hud_measure_text(TEXT_NAME)*0.3, 55, 0.6)
        djui_hud_print_text(TEXT_CREDIT, width - textX - djui_hud_measure_text(TEXT_CREDIT)*0.15, 72, 0.3)
        djui_hud_print_text(TEXT_DESCRIPTION, width - textX - djui_hud_measure_text(TEXT_DESCRIPTION)*0.2, 85, 0.4)
        for i = 1, #TEXT_DESCRIPTION_TABLE do
            djui_hud_print_text(TEXT_DESCRIPTION_TABLE[i], width - textX - djui_hud_measure_text(TEXT_DESCRIPTION_TABLE[i])*0.15, 90 + i*9, 0.3)
        end
        djui_hud_print_text(TEXT_PREF, width - textX - djui_hud_measure_text(TEXT_PREF)*0.15, height - 20, 0.3)
        djui_hud_print_text(TEXT_PREF_SAVE, width - textX - djui_hud_measure_text(TEXT_PREF_SAVE)*0.15, height - 30, 0.3)

        --Character Select Header
        djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
        djui_hud_render_rect(0, 0, width, 50)
        djui_hud_set_color(0, 0, 0, 255)
        djui_hud_render_rect(2, 2, width - 4, 46)
        djui_hud_set_color(255, 255, 255, 255)
        djui_hud_render_texture(TEX_HEADER, widthHalf - 128, 10, 1, 1)
        djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
        djui_hud_set_font(FONT_TINY)
        djui_hud_print_text("Version: "..modVersion, 5, 3, 0.5)
        --Unsupported Res Warning
        if width < 321.2 then
            djui_hud_print_text(TEXT_RES_UNSUPPORTED, 5, 39, 0.5)
        end

        --Options display
        if options or optionAnimTimer > optionAnimTimerCap then
            djui_hud_set_color(0, 0, 0, 205 + math.max(-200, optionAnimTimer))
            djui_hud_render_rect(0, 0, width, height)
            djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
            djui_hud_render_rect(width*0.5 - 50 * widthScale, 55 + optionAnimTimer * -1, 100 * widthScale, 200)
            djui_hud_set_color(0, 0, 0, 255)
            djui_hud_render_rect(width*0.5 - 50 * widthScale + 2, 55 + optionAnimTimer * -1 + 2, 100 * widthScale - 4, 196)
            djui_hud_set_font(FONT_NORMAL)
            djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
            djui_hud_print_text(TEXT_OPTIONS_HEADER, widthHalf - djui_hud_measure_text(TEXT_OPTIONS_HEADER)*0.5, 65 + optionAnimTimer * -1, 1)

            for i = 1, #optionTable do
                local toggleName = optionTable[i].name
                local scale = 0.5
                local yOffset = 95 + i * 9 * widthScale + optionAnimTimer * -1
                if i == currOption then
                    djui_hud_set_font(FONT_NORMAL)
                    scale = 0.3
                    yOffset = yOffset - 1
                    if optionTable[i].toggleNames[optionTable[i].toggle + 1] ~= "" then
                        toggleName = "> " .. toggleName .. " - " .. optionTable[i].toggleNames[optionTable[i].toggle + 1]
                    else
                        toggleName = "> " .. toggleName
                    end
                else
                    djui_hud_set_font(FONT_TINY)
                end
                scale = scale * widthScale
                djui_hud_print_text(toggleName, widthHalf - djui_hud_measure_text(toggleName)*scale*0.5, yOffset, scale)
            end
        end
        if options then
            if optionTable[optionTableRef.anims].toggle > 0 then
                if optionAnimTimer < -1 then
                    optionAnimTimer = optionAnimTimer/1.1
                end
            else
                optionAnimTimer = -1
            end
        else
            if optionTable[optionTableRef.anims].toggle > 0 then
                if optionAnimTimer > optionAnimTimerCap then
                    optionAnimTimer = optionAnimTimer*1.2
                end
            else
                optionAnimTimer = optionAnimTimerCap
            end
        end
    else
        options = false
        optionAnimTimer = optionAnimTimerCap
    end

    if is_game_paused() and not djui_hud_is_pause_menu_created() and optionTable[optionTableRef.openInputs].toggle == 2 then
        djui_hud_set_resolution(RESOLUTION_DJUI)
        local width = djui_hud_get_screen_width()
        djui_hud_set_font(FONT_NORMAL)
        djui_hud_set_color(0, 0, 0, 255)
        djui_hud_print_text(TEXT_Z_OPEN, width - djui_hud_measure_text(TEXT_Z_OPEN) - 19, 17, 1)
        djui_hud_set_color(255, 255, 255, 255)
        djui_hud_print_text(TEXT_Z_OPEN, width - djui_hud_measure_text(TEXT_Z_OPEN) - 20, 16, 1)
    end
end

local inputStallTimer = 0
local inputStallTo = 15

local function before_mario_update(m)
    if m.playerIndex ~= 0 then return end
    if inputStallTimer > 0 then inputStallTimer = inputStallTimer - 1 end

    -- Menu Inputs
    if (m.controller.buttonPressed & D_JPAD) ~= 0 and optionTable[optionTableRef.openInputs].toggle == 1 then
        menu = true
    end
    if is_game_paused() and (m.controller.buttonPressed & Z_TRIG) ~= 0 and optionTable[optionTableRef.openInputs].toggle == 2 then
        menu = true
    end

    if menu and not options then
        if inputStallTimer == 0 then
            if (m.controller.buttonPressed & D_JPAD) ~= 0 then
                currChar = currChar + 1
                inputStallTimer = inputStallTo
            end
            if (m.controller.buttonPressed & U_JPAD) ~= 0 then
                currChar = currChar - 1
                inputStallTimer = inputStallTo
            end
            if m.controller.stickY < -60 then
                currChar = currChar + 1
                inputStallTimer = inputStallTo
            end
            if m.controller.stickY > 60 then
                currChar = currChar - 1
                inputStallTimer = inputStallTo
            end
            if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                TEXT_PREF_LOAD = characterTable[currChar].name
                mod_storage_save("PrefChar", TEXT_PREF_LOAD)
                inputStallTimer = inputStallTo
            end
            if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
                menu = false
            end
            if (m.controller.buttonPressed & START_BUTTON) ~= 0 then
                options = true
            end
        end
        if currChar > #characterTable then currChar = 1 end
        if currChar < 1 then currChar = #characterTable end
        nullify_inputs(m)
        if is_game_paused() then
            m.controller.buttonPressed = START_BUTTON
        end
    end

    if options then
        if inputStallTimer == 0 then
            if (m.controller.buttonPressed & D_JPAD) ~= 0 then
                currOption = currOption + 1
                inputStallTimer = inputStallTo
            end
            if (m.controller.buttonPressed & U_JPAD) ~= 0 then
                currOption = currOption - 1
                inputStallTimer = inputStallTo
            end
            if m.controller.stickY < -60 then
                currOption = currOption + 1
                inputStallTimer = inputStallTo
            end
            if m.controller.stickY > 60 then
                currOption = currOption - 1
                inputStallTimer = inputStallTo
            end
            if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                optionTable[currOption].toggle = optionTable[currOption].toggle + 1
                if optionTable[currOption].toggle > optionTable[currOption].toggleMax then optionTable[currOption].toggle = 0 end
                if optionTable[currOption].toggleSaveName ~= nil then
                    mod_storage_save(optionTable[currOption].toggleSaveName, tostring(optionTable[currOption].toggle))
                end
                inputStallTimer = inputStallTo
            end
            if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
                options = false
                inputStallTimer = inputStallTo
            end
        end
        if currOption > #optionTable then currOption = 1 end
        if currOption < 1 then currOption = #optionTable end
        nullify_inputs(m)
    end
end

hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)
hook_event(HOOK_ON_HUD_RENDER, on_hud_render)

--------------
-- Commands --
--------------

local function chat_command()
    menu = not menu
    return true
end

hook_chat_command("char-select", "Opens the Character Select Menu", chat_command)


---------
-- API --
---------

_G.charSelectExists = true
_G.charSelect = {}

_G.charSelect.character_add = function(name, description, credit, color, modelInfo, forceChar)
    if name == nil then name = "Untitled" end
    name = string_space_to_underscore(name)
    if description == nil then description = {"No description has been provided"} end
    if credit == nil then credit = "Unknown" end
    if color == nil then color = {r = 255, g = 255, b = 255} end
    if modelInfo == nil then modelInfo = E_MODEL_ARMATURE end

    characterTable[#characterTable + 1] = {
        name = name,
        description = description,
        credit = credit,
        color = color,
        model = modelInfo,
        forceChar = forceChar,
    }
end


_G.charSelect.character_edit = function(charNum, name, description, credit, color, modelInfo, forceChar)
    if name == nil then name = characterTable[charNum].name end
    name = string_space_to_underscore(name)
    if description == nil then description = characterTable[charNum].description end
    if credit == nil then credit = characterTable[charNum].credit end
    if color == nil then color = characterTable[charNum].color end
    if modelInfo == nil then modelInfo = characterTable[charNum].model end
    if forceChar == nil then forceChar = characterTable[charNum] end

    characterTable[charNum] = {
        name = name,
        description = description,
        credit = credit,
        color = color,
        model = modelInfo,
        forceChar = forceChar,
    }
end

_G.charSelect.character_get_current_name = function ()
    return characterTable[currChar].name
end

_G.charSelect.character_get_current_model_number = function ()
    return currChar
end

_G.charSelect.character_get_number_from_string = function (string)
    for i = 2, #characterTable do
        if characterTable[i].name == string then
            return i
        end
    end
    return false
end

_G.charSelect.version_get = function ()
    return modVersion
end
