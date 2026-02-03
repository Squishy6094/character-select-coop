
if incompatibleClient then return 0 end

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

local function get_mario_state(...)
    local out = {}
    local n = select("#", ...)

    for i = 1, n do
        local v = select(i, ...)
        if type(v) == "table" and v.marioObj ~= nil then
            out[#out + 1] = v
        end
    end

    if #out == 0 then
        return gMarioStates[0]
    end

    return table.unpack(out)
end

local function moveset_is_active(index)
    index = index or 0
    return gCSPlayers[index].movesetToggle
end

-- Hook everything after other mods
hook_event(HOOK_ON_MODS_LOADED, function()
    for hookId = 0, HOOK_MAX - 1 do
        hook_event(hookId, function(...)
            for _, m in ipairs({get_mario_state(...)}) do
                if not moveset_is_active(m.playerIndex) then return end

                local charNum = find_character_number(m.playerIndex)
                local currMoveset = characterMovesets[charNum]

                if not currMoveset or not currMoveset[hookId] then return end
                return currMoveset[hookId](...)
            end
        end)
    end
end)