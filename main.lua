-- name: *Character Selector*
-- description: WIP

local menu = false
local currChar = 1

local E_MODEL_ARMATURE = smlua_model_util_get_id("armature_geo")

local characterTable = {
    [1]  = {
        name = "Default",
        description = "You're good ol' vanilla cast, at least to sm64ex-coop...",
        model = nil,
        forceChar = nil,
    },
}

local animTable = {
    [1] = {
        name = "Default"
    }
}

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

hook_event(HOOK_MARIO_UPDATE, mario_update)

local function set_model(o, id)
    if id == E_MODEL_MARIO then
        local i = network_local_index_from_global(o.globalPlayerIndex)
        if gPlayerSyncTable[i].modelId ~= nil then
            obj_set_model_extended(o, gPlayerSyncTable[i].modelId)
        end
    end
end

hook_event(HOOK_OBJECT_SET_MODEL, set_model)

local function chat_command(msg)
    if msg == nil then
        menu = not menu
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
end

hook_chat_command("char-select", "Opens the Character Select Menu", chat_command)


---------
-- API --
---------

_G.charSelectExists = true
_G.charSelect = {}

_G.charSelect.character_add = function(name, description, credit, modelInfo, forceChar)
    if name == nil then name = "Untitled" end
    if description == nil then description = "No description has been provided" end
    if credit == nil then credit = "Unknown" end
    if modelInfo == nil then modelInfo = E_MODEL_ARMATURE end

    characterTable[#characterTable + 1] = {
        name = name,
        description = description,
        model = modelInfo,
        forceChar = forceChar,
    }
end

_G.charSelect.character_current_name = function ()
    return characterTable[currChar].name
end
