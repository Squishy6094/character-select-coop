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

-- Hook everything after other mods
hook_event(HOOK_ON_MODS_LOADED, function()
    for hookId = 0, HOOK_MAX - 1 do
        hook_event(hookId, function(...)
            if not hookedByChar[hookId] then return end
            if not gCSPlayers[0].movesetToggle then return end

            local charNum = find_character_number(0)
            local currMoveset = characterMovesets[charNum]

            if not currMoveset or not currMoveset[hookId] then return end
            return currMoveset[hookId](...)
        end)
    end
end)