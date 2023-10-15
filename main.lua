-- name: *Character Selector*
-- description: WIP

local menu = false
local currChar = 1

local E_MODEL_ARMATURE = smlua_model_util_get_id("armature_geo")

local characterTable = {
    [1]  = {
        name = "Default",
        description = "You're good ol' vanilla cast, at least to sm64ex-coop...",
        credit = "Nintendo / sm4ex-coop Team",
        color = {r = 255, g = 0, b = 0},
        model = nil,
        forceChar = nil,
    },
}

local animTable = {
    [1] = {
        name = "Default"
    }
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

local function lerp(a, b, t) return a * (1 - t) + b * t end

--- @param a Color
--- @param b Color
--- @return Color
local function color_lerp(a, b, t)
    return {
        r = lerp(a.r, b.r, t),
        g = lerp(a.g, b.g, t),
        b = lerp(a.b, b.b, t)
    }
end

-------------------
-- Model Handler --
-------------------

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
    end
    if gPlayerSyncTable[m.playerIndex].modelId ~= nil then
        obj_set_model_extended(m.marioObj, gPlayerSyncTable[m.playerIndex].modelId)
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

local animTimer = 0

local function on_hud_render()
    djui_hud_set_resolution(RESOLUTION_N64)

    local width = djui_hud_get_screen_width() + 3
    local height = djui_hud_get_screen_height()
    local widthHalf = width*0.5
    local heightHalf = height*0.5

    if menu then
        djui_hud_set_color(characterTable[currChar].color.r, characterTable[currChar].color.g, characterTable[currChar].color.b, 255)
        djui_hud_render_rect(0, 0, 150, height)
        djui_hud_set_color(0, 0, 0, 255)
        djui_hud_render_rect(2, 2, 146, height - 4)


        for i = -1, 4 do
            if characterTable[i + currChar] ~= nil then
                buttonColor = characterTable[i + currChar].color
                djui_hud_set_color(buttonColor.r, buttonColor.g, buttonColor.b, 255)
                local x = 30
                if i == 0 then x = x + math.sin(animTimer*0.05)*2.5 + 5 end
                djui_hud_render_rect(x, (i + 2) * 30 + 10, 70, 20)
                djui_hud_set_color(0, 0, 0, 255)
                djui_hud_render_rect(x + 1, (i + 2) * 30 + 11, 68, 18)
                djui_hud_set_font(FONT_NORMAL)
                djui_hud_set_color(buttonColor.r, buttonColor.g, buttonColor.b, 255)
                djui_hud_print_text(characterTable[currChar + i].name, x + 5, (i + 2) * 30 + 15, 0.3)
            end
        end
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
                prevColor = characterTable[currChar].color
                transTimer = 1
                currChar = currChar + 1
                inputStallTimer = inputStallTo
            end
            if (m.controller.buttonPressed & U_JPAD) ~= 0 then
                prevColor = characterTable[currChar].color
                transTimer = 1
                currChar = currChar - 1
                inputStallTimer = inputStallTo
            end
            if m.controller.stickY < -60 then
                prevColor = characterTable[currChar].color
                transTimer = 1
                currChar = currChar + 1
                inputStallTimer = inputStallTo
            end
            if m.controller.stickY > 60 then
                prevColor = characterTable[currChar].color
                transTimer = 1
                currChar = currChar - 1
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
