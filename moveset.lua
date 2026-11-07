if incompatibleClient then return 0 end

hookedByChar = {}

local function find_character_number(index)
    if not startup_init_stall() then return 0 end
    if index == nil then index = 0 end
    for i = 1, #characterTable do
        if characterTable[i].saveName == gCSPlayers[index].saveName then
            return i
        end
    end
    return 0
end

local function get_mario_index(m) return m.playerIndex end

local getIndex = {
    [HOOK_MARIO_UPDATE] = get_mario_index,
    [HOOK_BEFORE_MARIO_UPDATE] = get_mario_index,
    [HOOK_ON_SET_MARIO_ACTION] = get_mario_index,
    [HOOK_BEFORE_PHYS_STEP] = get_mario_index,
    [HOOK_ON_PLAYER_CONNECTED] = get_mario_index,
    [HOOK_ON_PLAYER_DISCONNECTED] = get_mario_index,
    [HOOK_ALLOW_INTERACT] = get_mario_index,
    [HOOK_ON_INTERACT] = get_mario_index,
    [HOOK_ON_DEATH] = get_mario_index,
    [HOOK_ALLOW_HAZARD_SURFACE] = get_mario_index,
    [HOOK_ON_CHAT_MESSAGE] = get_mario_index,
    [HOOK_CHARACTER_SOUND] = get_mario_index,
    [HOOK_BEFORE_SET_MARIO_ACTION] = get_mario_index,
    [HOOK_ON_COLLIDE_LEVEL_BOUNDS] = get_mario_index,
    [HOOK_MARIO_OVERRIDE_PHYS_STEP_DEFACTO_SPEED] = get_mario_index,
    [HOOK_ON_ATTACK_OBJECT] = get_mario_index,
    [HOOK_MARIO_OVERRIDE_GEOMETRY_INPUTS] = get_mario_index,
    [HOOK_ON_INTERACTIONS] = get_mario_index,
    [HOOK_ALLOW_FORCE_WATER_ACTION] = get_mario_index,
    [HOOK_MARIO_OVERRIDE_FLOOR_CLASS] = get_mario_index,
}

-- Hook everything after other mods
hook_event(HOOK_ON_MODS_LOADED, function ()
    for hookId = 0, HOOK_MAX - 1 do
        hook_event(hookId, function (...)
            if not hookedByChar[hookId] then return end

            -- special case for PVP
            if hookId == HOOK_ALLOW_PVP_ATTACK
            or hookId == HOOK_ON_PVP_ATTACK then
                local a, v = ...
                a, v = a.playerIndex, v.playerIndex
                if gCSPlayers[a].movesetToggle then
                    local charNum = find_character_number(a)
                    local currMoveset = characterMovesets[charNum]

                    if currMoveset and currMoveset[hookId] then
                        a = currMoveset[hookId](...)
                    else a = nil end
                else a = nil end
                if gCSPlayers[v].movesetToggle then
                    local charNum = find_character_number(v)
                    local currMoveset = characterMovesets[charNum]

                    if currMoveset and currMoveset[hookId] then
                        v = currMoveset[hookId](...)
                    else v = nil end
                else v = nil end

                if v ~= nil then return v
                else return a end
            else
                local get = getIndex[hookId]
                local index = get and get(...) or 0

                if not gCSPlayers[index].movesetToggle then return end

                local charNum = find_character_number(index)
                local currMoveset = characterMovesets[charNum]

                if not currMoveset or not currMoveset[hookId] then return end
                return currMoveset[hookId](...)
            end
        end)
    end
end)