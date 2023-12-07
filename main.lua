-- name: Character Select
-- description: A Library / API made to make adding and\nusing Custom Characters as simple as possible!\n\nCreated by:\\#008800\\ Squishy6094\n\\#dcdcdc\\Concepts by:\\#4496f5\\ AngelicMiracles\\#AAAAFF\\\n\nGithub:\nSquishy6094/character-select-coop
local modVersion = "1.1"

local menu = false
local options = false

local currChar = 1
local currOption = 1

local E_MODEL_ARMATURE = smlua_model_util_get_id("armature_geo")

local TEX_HEADER = get_texture_info("char-select-text")

local TEXT_PREF_LOAD = "Default"

local ommActive = _G.OmmApi ~= nil

--[[
    Note: Do NOT add characters via the characterTable below,
    We highly reccomend you create your own mod and use the
    API to add characters, this ensures your pack is easy
    to use for anyone and low on file space!
]]
local characterTable = {
    [1]  = {
        name = "Default",
        description = {"The vanilla cast for sm64ex-coop!", "", "These Characters are swappable", "via the default Options Menu"},
        credit = "Nintendo / Coop Team",
        color = {r = 255, g = 50, b = 50},
        model = nil,
        forceChar = nil,
    },
}

local optionTableRef = {
    openInputs = 1,
    menuColor = 2,
    anims = 3,
    inputLatency = 4,
    localModels = 5,
    prefToDefault = 6,
}

local optionTable = {
    [optionTableRef.openInputs] = {
        name = "Open Binds",
        toggle = tonumber(mod_storage_load("MenuInput")),
        toggleSaveName = "MenuInput",
        toggleDefault = 0,
        toggleMax = 2,
        toggleNames = {"None", ommActive and "D-pad Down + R" or "D-pad Down", "Z (Pause Menu)"},
    },
    [optionTableRef.menuColor] = {
        name = "Menu Color",
        toggle = tonumber(mod_storage_load("MenuColor")),
        toggleSaveName = "MenuColor",
        toggleDefault = 0,
        toggleMax = 9,
        toggleNames = {"Auto", "Red", "Orange", "Yellow", "Green", "Blue", "Pink", "Purple", "White", "Black"},
    },
    [optionTableRef.anims] = {
        name = "Animations",
        toggle = tonumber(mod_storage_load("Anims")),
        toggleSaveName = "Anims",
        toggleDefault = 1,
        toggleMax = 1,
    },
    [optionTableRef.inputLatency] = {
        name = "Scroll Speed",
        toggle = tonumber(mod_storage_load("Latency")),
        toggleSaveName = "Latency",
        toggleDefault = 1,
        toggleMax = 2,
        toggleNames = {"Slow", "Normal", "Fast"},
    },
    [optionTableRef.localModels] = {
        name = "Locally Display Models",
        toggle = tonumber(mod_storage_load("localModels")),
        toggleSaveName = "localModels",
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

local menuColorTable = {
    {r = 255, g = 50,  b = 50 },
    {r = 255, g = 100, b = 50 },
    {r = 255, g = 255, b = 50 },
    {r = 50,  g = 255, b = 50 },
    {r = 100,  g = 100,  b = 255},
    {r = 251, g = 148, b = 220},
    {r = 130, g = 25,  b = 130},
    {r = 255, g = 255, b = 255},
    {r = 50,  g = 50,  b = 50 },
}

local defaultPlayerColors = {
    [CT_MARIO] = {r = 255, g = 50, b = 50},
    [CT_LUIGI] = {r = 50, g = 255, b = 50},
    [CT_TOAD] = {r = 100,  g = 100,  b = 255},
    [CT_WALUIGI] = {r = 130, g = 25,  b = 130},
    [CT_WARIO] = {r = 255, g = 255, b = 50},
}

local latencyValueTable = {15, 10, 5}

---------------
-- Functions --
---------------

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
local djui_hud_render_rect = djui_hud_render_rect
local djui_hud_print_text = djui_hud_print_text
local djui_hud_render_texture = djui_hud_render_texture
local math_max = math.max
local math_min = math.min
local math_sin = math.sin
local math_random = math.random
local play_sound = play_sound
local mod_storage_save = mod_storage_save
local mod_storage_load = mod_storage_load

-- Custom Functions --
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
                djui_popup_create('Character Select:\nYour Prefered Character\n"'..string_underscore_to_space(characterTable[i].name)..'"\nwas applied successfully!', 4)
                break
            end
        end
    elseif mod_storage_load("PrefChar") == nil then
        mod_storage_save("PrefChar", "Default")
    end
    TEXT_PREF_LOAD = mod_storage_load("PrefChar")
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
-------------------
-- Model Handler --
-------------------

local stallFrame = 0
local noLoop = false

-- Respecfully, GO FUCK YOURSELVES. I hate EVERY SINGLE ONE OF YOU. Your lives are NOTHING. You serve ZERO PURPOSE. You should kill yourselves, NOW!
local ignored_surfaces = {
    SURFACE_BURNING, SURFACE_QUICKSAND, SURFACE_INSTANT_QUICKSAND, SURFACE_INSTANT_MOVING_QUICKSAND, SURFACE_DEEP_MOVING_QUICKSAND, SURFACE_INSTANT_QUICKSAND, SURFACE_DEEP_QUICKSAND, SURFACE_SHALLOW_MOVING_QUICKSAND,
    SURFACE_SHALLOW_QUICKSAND, SURFACE_WARP, SURFACE_LOOK_UP_WARP, SURFACE_WOBBLING_WARP, SURFACE_INSTANT_WARP_1B, SURFACE_INSTANT_WARP_1C, SURFACE_INSTANT_WARP_1D, SURFACE_INSTANT_WARP_1E
}
-- Yes, floral gave me permission to use this table full of USELESS PIECES OF SHITS

--- @param m MarioState
local function mario_update(m)
    if stallFrame == 1 then
        load_prefered_char()
        failsafe_options()
        if #characterTable == 1 then
            djui_popup_create("Character Select:\nNo Characters were Found", 2)
        end
        if optionTable[optionTableRef.openInputs].toggle == 1 and ommActive then
            djui_popup_create('Character Select:\nYour Open bind has changed to:\nD-pad Down + R\nDue to OMM Rebirth being active!', 4)
        end
    end

    if stallFrame < 2 then
        stallFrame = stallFrame + 1
    end
    
    if m.playerIndex == 0 and stallFrame > 1 then
        characterTable[1].forceChar = gNetworkPlayers[m.playerIndex].modelIndex
        if currChar == 1 then
            characterTable[1].color = defaultPlayerColors[gNetworkPlayers[m.playerIndex].modelIndex]
        end
        if optionTable[optionTableRef.localModels].toggle > 0 then
            gPlayerSyncTable[0].modelId = characterTable[currChar].model
            gPlayerSyncTable[0].capModelId = characterTable[currChar].capModel
            if characterTable[currChar].forceChar ~= nil then
                gNetworkPlayers[m.playerIndex].overrideModelIndex = characterTable[currChar].forceChar
            end
        else
            gPlayerSyncTable[0].modelId = nil
            gPlayerSyncTable[0].capModelId = nil
            gNetworkPlayers[m.playerIndex].overrideModelIndex = characterTable[1].forceChar
        end

        if menu then
            camera_freeze()
            hud_hide()
            if _G.PersonalStarCounter then
                _G.PersonalStarCounter.hide_star_counters(true)
            end
            local focusPos = {
                x = m.pos.x,
                y = m.pos.y + 120,
                z = m.pos.z,
            }
            vec3f_copy(gLakituState.focus, focusPos)
            gLakituState.pos.x = m.pos.x + sins(m.faceAngle.y) * 500
            gLakituState.pos.y = m.pos.y + 100
            gLakituState.pos.z = m.pos.z + coss(m.faceAngle.y) * 500

            if m.forwardVel == 0 and m.pos.y == m.floorHeight and not ignored_surfaces[m.floor.type] and m.health > 255 then
                set_mario_action(m, ACT_IDLE, 0)
                set_mario_animation(m, MARIO_ANIM_STAR_DANCE)
            end
            noLoop = false
        elseif not noLoop then
            camera_unfreeze()
            hud_show()
            if _G.PersonalStarCounter then
                _G.PersonalStarCounter.hide_star_counters(false)
            end
            noLoop = true
        end
    end

    --Set Pref to Default Check
    if optionTable[optionTableRef.prefToDefault].toggle > 0 then
        mod_storage_save("PrefChar", "Default")
        TEXT_PREF_LOAD = "Default"
        optionTable[optionTableRef.prefToDefault].toggle = 0
    end
end

function set_model(o)
    if obj_has_behavior_id(o, id_bhvMario) ~= 0 then
        local i = network_local_index_from_global(o.globalPlayerIndex)
        if gPlayerSyncTable[i].modelId ~= nil and obj_has_model_extended(o, gPlayerSyncTable[i].modelId) == 0 then
            obj_set_model_extended(o, gPlayerSyncTable[i].modelId)
        end
    end
    if obj_has_behavior_id(o, id_bhvNormalCap) +
       obj_has_behavior_id(o, id_bhvWingCap) +
       obj_has_behavior_id(o, id_bhvVanishCap) +
       obj_has_behavior_id(o, id_bhvMetalCap) ~= 0 then
        local i = network_local_index_from_global(o.globalPlayerIndex)
        if gPlayerSyncTable[i].capModelId ~= nil and obj_has_model_extended(o, gPlayerSyncTable[i].capModelId) == 0 then
            obj_set_model_extended(o, gPlayerSyncTable[i].capModelId)
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

local TEXT_OPTIONS_HEADER = "Menu Options"
local TEXT_RATIO_UNSUPPORTED = "Your Current Aspect-Ratio isn't Supported!"
local TEXT_DESCRIPTION = "Character Description:"
local TEXT_PREF_SAVE = "Press A to Set as Prefered Character"
local TEXT_PAUSE_Z_OPEN = "Z Button - Character Select"
local TEXT_PAUSE_CURR_CHAR = "Current Character: "
if math_random(100) == 64 then -- Easter Egg if you get lucky loading the mod >v<
    TEXT_PAUSE_Z_OPEN = "Z - DynOS" -- Referencing the original sm64ex DynOS options
    TEXT_PAUSE_CURR_CHAR = "Model: "
end
local TEXT_OPTIONS_OPEN = "Press START to open Options"
local TEXT_MENU_CLOSE = "Press B to Exit Menu"
local TEXT_OPTIONS_SELECT = "A - Select | B - Exit  "
local TEXT_LOCAL_MODEL_OFF = "Locally Display Models is Off"
local TEXT_LOCAL_MODEL_OFF_OPTIONS = "You can turn it back on in the Options Menu"

local menuColor = characterTable[currChar].color

local function on_hud_render()
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_NORMAL)

    local width = djui_hud_get_screen_width() + 1.4
    local height = 240
    local widthHalf = width*0.5
    local heightHalf = height*0.5
    local widthScale = math_max(width, 321.4)*0.00311332503

    if menu then
        if optionTable[optionTableRef.menuColor].toggle ~= 0 then
            menuColor = menuColorTable[optionTable[optionTableRef.menuColor].toggle]
        else
            menuColor = characterTable[currChar].color
        end

        if optionTable[optionTableRef.localModels].toggle == 0 then
            djui_hud_set_color(0, 0, 0, 200)
            djui_hud_render_rect(0, 0, width, height)
            djui_hud_set_color(255, 255, 255, 255)
            djui_hud_print_text(TEXT_LOCAL_MODEL_OFF, widthHalf - djui_hud_measure_text(TEXT_LOCAL_MODEL_OFF)*0.15*widthScale, heightHalf, 0.3 * widthScale)
            djui_hud_print_text(TEXT_LOCAL_MODEL_OFF_OPTIONS, widthHalf - djui_hud_measure_text(TEXT_LOCAL_MODEL_OFF_OPTIONS)*0.1*widthScale, heightHalf + 10*widthScale, 0.2*widthScale)
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
                if optionTable[optionTableRef.anims].toggle > 0 then
                    if i == 0 then buttonX = buttonX + math_sin(buttonAnimTimer*0.05)*2.5 + 5 end
                else
                    if i == 0 then buttonX = buttonX + 10 end
                end
                local y = (i + 2) * 30 + 30
                djui_hud_render_rect(buttonX, y, 70, 20)
                djui_hud_set_color(0, 0, 0, 255)
                djui_hud_render_rect(buttonX + 1, y + 1, 68, 18)
                djui_hud_set_font(FONT_TINY)
                djui_hud_set_color(buttonColor.r, buttonColor.g, buttonColor.b, 255)
                djui_hud_print_text(string_underscore_to_space(characterTable[currChar + i].name), buttonX + 5, y + 5, 0.6)
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
        local TEXT_DESCRIPTION_TABLE = characterTable[currChar].description
        local TEXT_PREF = 'Preferred Character: "'..string_underscore_to_space(TEXT_PREF_LOAD)..'"'

        local textX = x * 0.5
        djui_hud_print_text(TEXT_NAME, width - textX - djui_hud_measure_text(TEXT_NAME)*0.3, 55, 0.6)
        djui_hud_set_font(FONT_TINY)
        djui_hud_print_text(TEXT_CREDIT, width - textX - djui_hud_measure_text(TEXT_CREDIT)*0.3, 72, 0.6)
        djui_hud_set_font(FONT_NORMAL)
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
        djui_hud_set_color(menuColor.r * 0.5 + 127, menuColor.g * 0.5 + 127, menuColor.b * 0.5 + 127, 255)
        djui_hud_render_texture(TEX_HEADER, widthHalf - 128, 10, 1, 1)
        djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
        djui_hud_set_font(FONT_TINY)
        djui_hud_print_text("Version: "..modVersion, 5, 3, 0.5)
        --Unsupported Res Warning
        if width < 321.2 or width > 575 then
            djui_hud_print_text(TEXT_RATIO_UNSUPPORTED, 5, 39, 0.5)
        end

        --Options display
        if options or optionAnimTimer > optionAnimTimerCap then
            djui_hud_set_color(menuColor.r * 0.25, menuColor.g * 0.25, menuColor.b * 0.25, 205 + math_max(-200, optionAnimTimer))
            djui_hud_render_rect(0, 0, width, height)
            djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
            djui_hud_render_rect(width*0.5 - 50 * widthScale, 55 + optionAnimTimer * -1, 100 * widthScale, 200)
            djui_hud_set_color(0, 0, 0, 255)
            djui_hud_render_rect(width*0.5 - 50 * widthScale + 2, 55 + optionAnimTimer * -1 + 2, 100 * widthScale - 4, 196)
            djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
            djui_hud_render_rect(width*0.5 - 50 * widthScale, height - 2, 100 * widthScale, 2)
            djui_hud_set_font(FONT_NORMAL)
            djui_hud_set_color(menuColor.r * 0.5 + 127, menuColor.g * 0.5 + 127, menuColor.b * 0.5 + 127, 255)
            djui_hud_print_text(TEXT_OPTIONS_HEADER, widthHalf - djui_hud_measure_text(TEXT_OPTIONS_HEADER)*0.3*widthScale, 65 + optionAnimTimer * -1, 0.6*widthScale)

            djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
            for i = 1, #optionTable do
                local toggleName = optionTable[i].name
                local scale = 0.5
                local yOffset = 70 + 10 * math_min(widthScale, 1.8) + i * 9 * math_min(widthScale, 1.8) + optionAnimTimer * -1
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
                scale = scale * math_min(widthScale, 1.8)
                djui_hud_print_text(toggleName, widthHalf - djui_hud_measure_text(toggleName)*scale*0.5, yOffset, scale)
            end

            djui_hud_set_font(FONT_TINY)
            djui_hud_print_text(TEXT_OPTIONS_SELECT, widthHalf - djui_hud_measure_text(TEXT_OPTIONS_SELECT)*0.3, height - 20 - optionAnimTimer, 0.6)
        end

        -- How to open options display
        if not options or optionAnimTimer < -1 then
            local widthScaleUnlimited = widthScale
            local widthScale = math_min(widthScale, 1.42)
            djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
            djui_hud_render_rect(widthHalf - 50 * widthScaleUnlimited, height - 25 * widthScale + optionAnimTimer + 200, 100 * widthScaleUnlimited, 26 * widthScale)
            djui_hud_set_color(0, 0, 0, 255)
            djui_hud_render_rect(widthHalf - 50 * widthScaleUnlimited + 2, height - 25 * widthScale + optionAnimTimer + 202, 100 * widthScaleUnlimited - 4, 22 * widthScale)
            djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
            djui_hud_render_rect(widthHalf - 50 * widthScaleUnlimited, height - 2, 100 * widthScaleUnlimited, 2)
            djui_hud_set_font(FONT_NORMAL)
            djui_hud_print_text(TEXT_OPTIONS_OPEN, widthHalf - djui_hud_measure_text(TEXT_OPTIONS_OPEN)*0.175 * widthScale, height - 23 * widthScale + optionAnimTimer + 202, 0.35 * widthScale)
            djui_hud_set_font(FONT_TINY)
            djui_hud_print_text(TEXT_MENU_CLOSE, widthHalf - djui_hud_measure_text(TEXT_MENU_CLOSE)*0.25 * widthScale, height - 13 * widthScale + optionAnimTimer + 202, 0.5 * widthScale)
        end

        -- Anim logic
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
        optionAnimTimer = math_max(optionAnimTimer, -200)
    else
        options = false
        optionAnimTimer = optionAnimTimerCap
    end

    if is_game_paused() and not djui_hud_is_pause_menu_created() and gMarioStates[0].action ~= ACT_EXIT_LAND_SAVE_DIALOG then
        local currCharY = 0
        djui_hud_set_resolution(RESOLUTION_DJUI)
        if optionTable[optionTableRef.openInputs].toggle == 2 then
            currCharY = 27
            local width = djui_hud_get_screen_width() - djui_hud_measure_text(TEXT_PAUSE_Z_OPEN)
            djui_hud_set_font(FONT_NORMAL)
            djui_hud_set_color(0, 0, 0, 255)
            djui_hud_print_text(TEXT_PAUSE_Z_OPEN, width - 19, 17, 1)
            djui_hud_set_color(255, 255, 255, 255)
            djui_hud_print_text(TEXT_PAUSE_Z_OPEN, width - 20, 16, 1)
        end

        if optionTable[optionTableRef.localModels].toggle == 1 then
            local charName = string_underscore_to_space(characterTable[currChar].name)
            local TEXT_PAUSE_CURR_CHAR_WITH_NAME = TEXT_PAUSE_CURR_CHAR..charName
            local width = djui_hud_get_screen_width() - djui_hud_measure_text(TEXT_PAUSE_CURR_CHAR_WITH_NAME)
            local charColor = characterTable[currChar].color
            djui_hud_set_font(FONT_NORMAL)
            djui_hud_set_color(0, 0, 0, 255)
            djui_hud_print_text(TEXT_PAUSE_CURR_CHAR_WITH_NAME, width - 19, 17 + currCharY, 1)
            djui_hud_set_color(255, 255, 255, 255)
            djui_hud_print_text(TEXT_PAUSE_CURR_CHAR, width - 20, 16 + currCharY, 1)
            djui_hud_set_color(charColor.r, charColor.g, charColor.b, 255)
            djui_hud_print_text(charName, djui_hud_get_screen_width() - djui_hud_measure_text(charName) - 20, 16 + currCharY, 1)
        else
            local width = djui_hud_get_screen_width() - djui_hud_measure_text(TEXT_LOCAL_MODEL_OFF)
            djui_hud_set_font(FONT_NORMAL)
            djui_hud_set_color(0, 0, 0, 255)
            djui_hud_print_text(TEXT_LOCAL_MODEL_OFF, width - 19, 17 + currCharY, 1)
            djui_hud_set_color(255, 255, 255, 255)
            djui_hud_print_text(TEXT_LOCAL_MODEL_OFF, width - 20, 16 + currCharY, 1)
        end
    end
end

local inputStallTimer = 0
local inputStallTo = 15
local ACT_C_UP = 201327143

local function before_mario_update(m)
    if m.playerIndex ~= 0 then return end
    if inputStallTimer > 0 then inputStallTimer = inputStallTimer - 1 end
    
    if menu and inputStallTo ~= latencyValueTable[optionTable[optionTableRef.inputLatency].toggle + 1] then
        inputStallTo = latencyValueTable[optionTable[optionTableRef.inputLatency].toggle + 1]
    end

    -- Menu Inputs
    if not menu and (m.controller.buttonDown & D_JPAD) ~= 0 and m.action ~= ACT_EXIT_LAND_SAVE_DIALOG and optionTable[optionTableRef.openInputs].toggle == 1 then
        if ommActive then
            if (m.controller.buttonDown & R_TRIG) ~= 0 then
                menu = true
            end
        else
            menu = true
        end
        inputStallTimer = inputStallTo
    end
    if is_game_paused() and m.action ~= ACT_EXIT_LAND_SAVE_DIALOG and (m.controller.buttonPressed & Z_TRIG) ~= 0 and optionTable[optionTableRef.openInputs].toggle == 2 then
        menu = true
    end

    local cameraToObject = gMarioStates[0].marioObj.header.gfx.cameraToObject

    -- C-up Failsafe (Camera Softlocks)
    if m.action == ACT_C_UP or (m.prevAction == ACT_C_UP and is_game_paused()) then
        menu = false
    elseif m.prevAction == ACT_C_UP and not is_game_paused() then
        m.prevAction = ACT_WALKING
    end

    if menu and not options then
        if inputStallTimer == 0 then
            if (m.controller.buttonPressed & D_JPAD) ~= 0 then
                currChar = currChar + 1
                inputStallTimer = inputStallTo
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
            end
            if (m.controller.buttonPressed & U_JPAD) ~= 0 then
                currChar = currChar - 1
                inputStallTimer = inputStallTo
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
            end
            if (m.controller.buttonPressed & D_CBUTTONS) ~= 0 then
                currChar = currChar + 1
                inputStallTimer = inputStallTo*0.6
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
            end
            if (m.controller.buttonPressed & U_CBUTTONS) ~= 0 then
                currChar = currChar - 1
                inputStallTimer = inputStallTo*0.6
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
            end
            if m.controller.stickY < -60 then
                currChar = currChar + 1
                inputStallTimer = inputStallTo
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
            end
            if m.controller.stickY > 60 then
                currChar = currChar - 1
                inputStallTimer = inputStallTo
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
            end
            if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                if characterTable[currChar] ~= nil then
                    TEXT_PREF_LOAD = characterTable[currChar].name
                    mod_storage_save("PrefChar", TEXT_PREF_LOAD)
                    inputStallTimer = inputStallTo
                    play_sound(SOUND_MENU_CLICK_FILE_SELECT, cameraToObject)
                else
                    play_sound(SOUND_MENU_CAMERA_BUZZ, cameraToObject)
                end
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

hook_chat_command("char-select", "- Opens the Character Select Menu", chat_command)

---------
-- API --
---------

_G.charSelectExists = true -- Ace
_G.charSelect = {
    ---@param name string Underscores turn into Spaces
    ---@param description table {"string"}
    ---@param credit string
    ---@param color Color {r, g, b}
    ---@param modelInfo ModelExtendedId|table Use smlua_model_util_get_id()
    ---@param forceChar CharacterType CT_MARIO, CT_LUIGI, CT_TOAD, CT_WALUIGI, CT_WARIO
    character_add = function(name, description, credit, color, modelInfo, forceChar)
        table.insert(characterTable, {
            name = name and string_space_to_underscore(name) or "Untitled",
            description = description and description or {"No description has been provided"},
            credit = credit and credit or "Unknown",
            color = color and color or menuColorTable[8],
            model = modelInfo and (type(modelInfo) == "table" and modelInfo[1] or modelInfo) or E_MODEL_ARMATURE,
            capModel = type(modelInfo) == "table" and modelInfo[2] or nil,
            forceChar = forceChar and forceChar or CT_MARIO,
        })
        return #characterTable
    end,

    character_add_voice = function(charNum, clips)
        if characterTable[charNum] and clips then
            characterTable[charNum].voice = clips
        end
    end,

    ---@param charNum integer Use _G.charSelect.character_get_number_from_string() or _G.charSelect.character_add()'s return value
    ---@param name string Underscores turn into Spaces
    ---@param description table {"string"}
    ---@param credit string
    ---@param color Color {r, g, b}
    ---@param modelInfo ModelExtendedId|table Use smlua_model_util_get_id()
    ---@param forceChar CharacterType CT_MARIO, CT_LUIGI, CT_TOAD, CT_WALUIGI, CT_WARIO
    character_edit = function(charNum, name, description, credit, color, modelInfo, forceChar)
        characterTable[charNum] = characterTable[charNum] and {
            name = name and string_space_to_underscore(name) or characterTable[charNum].name,
            description = description and description or characterTable[charNum].description,
            credit = credit and credit or characterTable[charNum].credit,
            color = color and color or characterTable[charNum].color,
            model = modelInfo and (type(modelInfo) == "table" and modelInfo[1] or modelInfo) or characterTable[charNum].model,
            capModel = type(modelInfo) == "table" and modelInfo[2] or characterTable[charNum].capModel,
            forceChar = forceChar and forceChar or characterTable[charNum].forceChar,
        } or nil
    end,

    character_get_current_name = function ()
        return currChar > 1 and string_underscore_to_space(characterTable[currChar].name) or gMarioStates[0].character.name
    end,

    character_get_current_model_number = function ()
        return currChar
    end,

    ---@param name string
    character_get_number_from_string = function (name)
        for i = 2, #characterTable do
            if characterTable[i].name == name or characterTable[i].name == string_space_to_underscore(name) then
                return i
            end
        end
        return false
    end,

    ---@param m MarioState
    character_get_voice = function (m)
        for i = 2, #characterTable do
            if characterTable[i].model == gPlayerSyncTable[m.playerIndex].modelId then
                return characterTable[i].voice and characterTable[i].voice or false
            end
        end
        return false
    end,

    version_get = function ()
        return modVersion
    end,

    is_menu_open = function ()
        return menu
    end,

    is_options_open = function ()
        return options
    end,

    optionTableRef = optionTableRef,

    ---@param tableNum integer
    get_status = function (tableNum)
        return optionTable[tableNum].toggle
    end
}
