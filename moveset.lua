
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

local function moveset_is_active(index)
    index = index or 0
    return gCSPlayers[index].movesetToggle
end

local function mario_update(m)
    if not moveset_is_active(m.playerIndex) then return end
    local hook = HOOK_MARIO_UPDATE
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook](m)
    if returnVar ~= nil then
        return returnVar
    end
end

local function before_mario_update(m)
    if not moveset_is_active(m.playerIndex) then return end
    local hook = HOOK_BEFORE_MARIO_UPDATE
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook](m)
    if returnVar ~= nil then
        return returnVar
    end
end

local function before_phys_step(m, stepType, stepArg)
    if not moveset_is_active(m.playerIndex) then return end
    local hook = HOOK_BEFORE_PHYS_STEP
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook](m, stepType, stepArg)
    if returnVar ~= nil then
        return returnVar
    end
end

local function allow_pvp_attack(attacker, victim, int)
    if not moveset_is_active(attacker.playerIndex) and not moveset_is_active(victim.playerIndex) then return end
    local hook = HOOK_ALLOW_PVP_ATTACK
    local attackerMoveset = characterMovesets[find_character_number(attacker.playerIndex)]
    local victimMoveset = characterMovesets[find_character_number(victim.playerIndex)]
    local returnVar
    if gCSPlayers[attacker.playerIndex].movesetToggle then
        if (attackerMoveset ~= nil and attackerMoveset[hook] ~= nil) then
            returnVar = attackerMoveset[hook](attacker, victim, int)
            if returnVar ~= nil then
                return returnVar
            end
        end
    end
    if gCSPlayers[victim.playerIndex].movesetToggle then
        if (victimMoveset ~= nil and victimMoveset[hook] ~= nil) then
            returnVar = victimMoveset[hook](attacker, victim, int)
            if returnVar ~= nil then
                return returnVar
            end
        end
    end
end

local function on_pvp_attack(attacker, victim, int)
    if not moveset_is_active(attacker.playerIndex) and not moveset_is_active(victim.playerIndex) then return end
    local hook = HOOK_ON_PVP_ATTACK
    local attackerMoveset = characterMovesets[find_character_number(attacker.playerIndex)]
    local victimMoveset = characterMovesets[find_character_number(victim.playerIndex)]
    if gCSPlayers[attacker.playerIndex].movesetToggle then
        if (attackerMoveset ~= nil and attackerMoveset[hook] ~= nil) then
            local returnVar = attackerMoveset[hook](attacker, victim, int)
            if returnVar ~= nil then
                return returnVar
            end
        end
    end
    if gCSPlayers[victim.playerIndex].movesetToggle then
        if (victimMoveset ~= nil and victimMoveset[hook] ~= nil) then
            local returnVar = victimMoveset[hook](attacker, victim, int)
            if returnVar ~= nil then
                return returnVar
            end
        end
    end
end

local function on_interact(m, o, intType, intValue)
    if not moveset_is_active(m.playerIndex) then return end
    local hook = HOOK_ON_INTERACT
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook](m, o, intType, intValue)
    if returnVar ~= nil then
        return returnVar
    end
end

local function allow_interact(m, o, intType)
    if not moveset_is_active(m.playerIndex) then return end
    local hook = HOOK_ALLOW_INTERACT
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook](m, o, intType)
    if returnVar ~= nil then
        return returnVar
    end
end

local function on_set_mario_action(m)
    if not moveset_is_active(m.playerIndex) then return end
    local hook = HOOK_ON_SET_MARIO_ACTION
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook](m)
    if returnVar ~= nil then
        return returnVar
    end
end

local function before_set_mario_action(m, nextAct, actionArg)
    if not moveset_is_active(m.playerIndex) then return end
    local hook = HOOK_BEFORE_SET_MARIO_ACTION
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook](m, nextAct, actionArg)
    if returnVar ~= nil then
        return returnVar
    end
end

local function on_death(m)
    if not moveset_is_active(m.playerIndex) then return end
    local hook = HOOK_ON_DEATH
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook](m)
    if returnVar ~= nil then
        return returnVar
    end
end

local function hud_render()
    if not moveset_is_active(0) then return end
    local hook = HOOK_ON_HUD_RENDER
    local currMoveset = characterMovesets[find_character_number(0)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook]()
    if returnVar ~= nil then
        return returnVar
    end
end

local function hud_render_behind()
    if not moveset_is_active(0) then return end
    local hook = HOOK_ON_HUD_RENDER_BEHIND
    local currMoveset = characterMovesets[find_character_number(0)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook]()
    if returnVar ~= nil then
        return returnVar
    end
end

local function level_init(type, levelNum, areaIdx, nodeId, arg)
    if not moveset_is_active(0) then return end
    local hook = HOOK_ON_LEVEL_INIT
    local currMoveset = characterMovesets[find_character_number(0)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook](type, levelNum, areaIdx, nodeId, arg)
    if returnVar ~= nil then
        return returnVar
    end
end

local function sync_valid()
    if not moveset_is_active(0) then return end
    local hook = HOOK_ON_SYNC_VALID
    local currMoveset = characterMovesets[find_character_number(0)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook]()
    if returnVar ~= nil then
        return returnVar
    end
end

local function object_render(obj)
    if not moveset_is_active(0) then return end
    local hook = HOOK_ON_OBJECT_RENDER
    local currMoveset = characterMovesets[find_character_number(0)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook](obj)
    if returnVar ~= nil then
        return returnVar
    end
end

local function allow_water_action(m, water)
    if not moveset_is_active(m.playerIndex) then return end
    local hook = HOOK_ALLOW_FORCE_WATER_ACTION
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook](m, water)
    if returnVar ~= nil then
        return returnVar
    end
end

local function mario_override_floor_class(m, floorClass)
    if not moveset_is_active(m.playerIndex) then return end
    local hook = HOOK_ALLOW_FORCE_WATER_ACTION
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook](m, floorClass)
    if returnVar ~= nil then
        return returnVar
    end
end

local function override_phys_step_defacto_speed(m)
    if not moveset_is_active(m.playerIndex) then return end
    local hook = HOOK_MARIO_OVERRIDE_PHYS_STEP_DEFACTO_SPEED
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook](m)
    if returnVar ~= nil then
        return returnVar
    end
end

local function on_play_sound(soundBits, pos)
    if not moveset_is_active(0) then return end
    local hook = HOOK_ON_PLAY_SOUND
    local currMoveset = characterMovesets[find_character_number(0)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    local returnVar = currMoveset[hook](soundBits, pos)
    if returnVar ~= nil then
        return returnVar
    end
end

-- Hook everything after other mods
hook_event(HOOK_ON_MODS_LOADED, function()
    hook_event(HOOK_MARIO_UPDATE, mario_update)
    hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)
    hook_event(HOOK_BEFORE_PHYS_STEP, before_phys_step)
    hook_event(HOOK_ALLOW_PVP_ATTACK, allow_pvp_attack)
    hook_event(HOOK_ON_PVP_ATTACK, on_pvp_attack)
    hook_event(HOOK_ON_INTERACT, on_interact)
    hook_event(HOOK_ALLOW_INTERACT, allow_interact)
    hook_event(HOOK_ON_SET_MARIO_ACTION, on_set_mario_action)
    hook_event(HOOK_BEFORE_SET_MARIO_ACTION, before_set_mario_action)
    hook_event(HOOK_ON_DEATH, on_death)
    hook_event(HOOK_ON_HUD_RENDER, hud_render)
    hook_event(HOOK_ON_HUD_RENDER_BEHIND, hud_render_behind)
    hook_event(HOOK_ON_LEVEL_INIT, level_init)
    hook_event(HOOK_ON_SYNC_VALID, sync_valid)
    hook_event(HOOK_ON_OBJECT_RENDER, object_render)
    hook_event(HOOK_ALLOW_FORCE_WATER_ACTION, allow_water_action)
    hook_event(HOOK_MARIO_OVERRIDE_FLOOR_CLASS, mario_override_floor_class)
    hook_event(HOOK_MARIO_OVERRIDE_PHYS_STEP_DEFACTO_SPEED, override_phys_step_defacto_speed)
    hook_event(HOOK_ON_PLAY_SOUND, on_play_sound)
end)