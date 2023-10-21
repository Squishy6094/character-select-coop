-- name: -Character Select-
-- description: A Library / API made to make adding\nCustom Characters as simple as possible!

local menu = false
local currChar = 1

local E_MODEL_ARMATURE = smlua_model_util_get_id("armature_geo")

local TEX_HEADER = get_texture_info("char-select-text")

local TEXT_PREF_LOAD = mod_storage_load("PrefChar")

local characterTable = {
    [1]  = {
        name = "Default",
        description = "You're good ol' vanilla cast, at least to sm64ex-coop...",
        credit = "Nintendo / sm64ex-coop Team",
        color = {r = 255, b = 100, g = 100},
        model = nil,
        forceChar = nil,
    },
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

-- Localized Functions --
local mod_storage_save = mod_storage_save
local mod_storage_load = mod_storage_load
local camera_freeze = camera_freeze
local camera_unfreeze = camera_unfreeze
local network_local_index_from_global = network_local_index_from_global
local obj_set_model_extended = obj_set_model_extended
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
            local focusPos = {
                x = m.pos.x,
                y = m.pos.y + 150,
                z = m.pos.z,
            }
            vec3f_copy(gLakituState.focus, focusPos)
            gLakituState.pos.x = m.pos.x + sins(m.faceAngle.y) * 500
            gLakituState.pos.y = m.pos.y + 100
            gLakituState.pos.z = m.pos.z + coss(m.faceAngle.y) * 500

            if m.forwardVel == 0 and m.pos.y == m.floorHeight then
                m.action = ACT_READING_NPC_DIALOG
            end
        else
            camera_unfreeze()
        end

        -- Load Prefered Character
        if stallFrame == 1 then
            if mod_storage_load("PrefChar") ~= nil and mod_storage_load("PrefChar") ~= "Default" then
                for i = 2, #characterTable do
                    if characterTable[i].name == mod_storage_load("PrefChar") then
                        currChar = i
                        djui_chat_message_create('Your Prefered Character "'..mod_storage_load("PrefChar")..'" was applied!')
                        TEXT_PREF_LOAD = mod_storage_load("PrefChar")
                        break
                    end
                end
            else
                mod_storage_save("PrefChar", "Default")
            end
        end
        stallFrame = stallFrame + 1
    end
    if gPlayerSyncTable[m.playerIndex].modelId ~= nil then
        obj_set_model_extended(m.marioObj, gPlayerSyncTable[m.playerIndex].modelId)
    end
end

local function set_model(o, id)
    if id == E_MODEL_MARIO or id == E_MODEL_LUIGI or id == E_MODEL_TOAD_PLAYER or id == E_MODEL_WALUIGI or id == E_MODEL_WARIO then
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

local animTimer = 0

local function on_hud_render()
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_NORMAL)

    local width = djui_hud_get_screen_width() + 1.2
    local height = djui_hud_get_screen_height()
    local widthHalf = width*0.5
    local heightHalf = height*0.5

    if menu then
        --Character Buttons
        djui_hud_set_color(characterTable[currChar].color.r, characterTable[currChar].color.g, characterTable[currChar].color.b, 255)
        djui_hud_render_rect(0, 0, 130, height)
        djui_hud_set_color(0, 0, 0, 255)
        djui_hud_render_rect(2, 2, 126, height - 4)

        animTimer = animTimer + 1

        local buttonColor = {}
        for i = -1, 4 do
            if characterTable[i + currChar] ~= nil then
                buttonColor = characterTable[i + currChar].color
                djui_hud_set_color(buttonColor.r, buttonColor.g, buttonColor.b, 255)
                local x = 30
                if i == 0 then x = x + math.sin(animTimer*0.05)*2.5 + 5 end
                local y = (i + 2) * 30 + 30
                djui_hud_render_rect(x, y, 70, 20)
                djui_hud_set_color(0, 0, 0, 255)
                djui_hud_render_rect(x + 1, y + 1, 68, 18)
                djui_hud_set_font(FONT_NORMAL)
                djui_hud_set_color(buttonColor.r, buttonColor.g, buttonColor.b, 255)
                djui_hud_print_text(string_underscore_to_space(characterTable[currChar + i].name), x + 5, y + 5, 0.3)
            end
        end

        djui_hud_set_color(characterTable[currChar].color.r, characterTable[currChar].color.g, characterTable[currChar].color.b, 255)
        djui_hud_render_rect(10, 55, 7, 180)
        djui_hud_set_color(0, 0, 0, 255)
        djui_hud_render_rect(11, 56, 5, 178)
        djui_hud_set_color(characterTable[currChar].color.r, characterTable[currChar].color.g, characterTable[currChar].color.b, 255)
        djui_hud_render_rect(12, 57 + 176 * ((currChar - 1) / #characterTable), 3, 176/#characterTable)

        
        --Character Description
        djui_hud_set_color(characterTable[currChar].color.r, characterTable[currChar].color.g, characterTable[currChar].color.b, 255)
        djui_hud_render_rect(width - 130, 0, 130, height)
        djui_hud_set_color(0, 0, 0, 255)
        djui_hud_render_rect(width - 128, 2, 126, height - 4)
        djui_hud_set_color(characterTable[currChar].color.r, characterTable[currChar].color.g, characterTable[currChar].color.b, 255)
        djui_hud_set_font(FONT_NORMAL)

        local TEXT_NAME = string_underscore_to_space(characterTable[currChar].name)
        local TEXT_CREDIT = "By: "..characterTable[currChar].credit
        local TEXT_PREF = 'Prefered Character: "'..string_underscore_to_space(TEXT_PREF_LOAD)..'"'
        local TEXT_PREF_SAVE = "Press A to Set as Prefered Character"

        djui_hud_print_text(TEXT_NAME, width - 65 - djui_hud_measure_text(TEXT_NAME)*0.35, 55, 0.7)
        djui_hud_print_text(TEXT_CREDIT, width - 65 - djui_hud_measure_text(TEXT_CREDIT)*0.15, 75, 0.3)
        djui_hud_print_text(TEXT_PREF, width - 65 - djui_hud_measure_text(TEXT_PREF)*0.15, height - 20, 0.3)
        djui_hud_print_text(TEXT_PREF_SAVE, width - 65 - djui_hud_measure_text(TEXT_PREF_SAVE)*0.15, height - 30, 0.3)

        --Character Select Header
        djui_hud_set_color(characterTable[currChar].color.r, characterTable[currChar].color.g, characterTable[currChar].color.b, 255)
        djui_hud_render_rect(0, 0, width, 50)
        djui_hud_set_color(0, 0, 0, 255)
        djui_hud_render_rect(2, 2, width - 4, 46)
        djui_hud_set_color(255, 255, 255, 255)
        djui_hud_render_texture(TEX_HEADER, widthHalf - 128, 10, 1, 1)

    end
end

local inputStallTimer = 0
local inputStallTo = 15

local function before_mario_update(m)
    if m.playerIndex ~= 0 then return end
    if inputStallTimer > 0 then inputStallTimer = inputStallTimer - 1 end
    if menu then
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
                mod_storage_save("PrefChar", characterTable[currChar].name)
                TEXT_PREF_LOAD = characterTable[currChar].name
                inputStallTimer = inputStallTo
            end
            if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
                menu = false
            end
        end
        if currChar > #characterTable then currChar = 1 end
        if currChar < 1 then currChar = #characterTable end
        nullify_inputs(m)
    end
end

hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)
hook_event(HOOK_ON_HUD_RENDER, on_hud_render)

--------------
-- Commands --
--------------

local function chat_command(msg)
    if msg == "" then
        menu = not menu
        return true
    end
    
    if msg == "list" then
        for i = 1, #characterTable do
            djui_chat_message_create("Model " .. i .. " / " ..  #characterTable.. "\n" .."Model Name: " .. characterTable[i].name.. "\n" .."Model by: " .. characterTable[i].credit.. "\n" .."Model Description: " .. characterTable[i].description)
        end
        return true
    end


    for i = 1, #characterTable do
        if characterTable[i].name == msg then
            currChar = i
            djui_chat_message_create("Character set to " .. characterTable[currChar].name .." by ".. characterTable[currChar].credit .."\n".. characterTable[currChar].description)
            return true
        end
    end
    djui_chat_message_create("Invalid Model Name Entered")
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
    if description == nil then description = "No description has been provided" end
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

_G.charSelect.character_current_name = function ()
    return characterTable[currChar].name
end
