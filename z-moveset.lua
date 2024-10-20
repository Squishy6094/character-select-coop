local function find_character_number(index)
    if index == nil then index = 0 end
    for i = 1, #characterTable do
        if characterTable[i].saveName == gPlayerSyncTable[index].saveName then
            return i
        end
    end
    return 1
end

local function mario_update(m)
    if stopMovesets or optionTable[optionTableRef.localMoveset].toggle == 0 then return end
    local hook = HOOK_MARIO_UPDATE
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    return currMoveset[hook](m)
end
hook_event(HOOK_MARIO_UPDATE, mario_update)

local function before_mario_update(m)
    if stopMovesets or optionTable[optionTableRef.localMoveset].toggle == 0 then return end
    local hook = HOOK_BEFORE_MARIO_UPDATE
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    return currMoveset[hook](m)
end
hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)

local function before_phys_step(m, stepType)
    if stopMovesets then return end
    local hook = HOOK_BEFORE_MARIO_UPDATE
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    return currMoveset[hook](m, stepType)
end
hook_event(HOOK_BEFORE_PHYS_STEP, before_phys_step)

local function allow_pvp_attack(attacker, victim, int)
    if stopMovesets then return end
    local hook = HOOK_ON_PVP_ATTACK
    local attackerMoveset = characterMovesets[find_character_number(attacker.playerIndex)]
    local victimMoveset = characterMovesets[find_character_number(victim.playerIndex)]
    if (attackerMoveset ~= nil and attackerMoveset[hook] ~= nil) then
        attackerMoveset[hook](attacker, victim, int)
    end
    if (victimMoveset ~= nil and victimMoveset[hook] ~= nil) then
        victimMoveset[hook](attacker, victim, int)
    end
end
hook_event(HOOK_ALLOW_PVP_ATTACK, allow_pvp_attack)

local function on_pvp_attack(attacker, victim, int)
    if stopMovesets or optionTable[optionTableRef.localMoveset].toggle == 0 then return end
    local hook = HOOK_ON_PVP_ATTACK
    local attackerMoveset = characterMovesets[find_character_number(attacker.playerIndex)]
    local victimMoveset = characterMovesets[find_character_number(victim.playerIndex)]
    if (attackerMoveset ~= nil and attackerMoveset[hook] ~= nil) then
        attackerMoveset[hook](attacker, victim, int)
    end
    if (victimMoveset ~= nil and victimMoveset[hook] ~= nil) then
        victimMoveset[hook](attacker, victim, int)
    end
end
hook_event(HOOK_ON_PVP_ATTACK, on_pvp_attack)

local function on_interact(m, o, intType, intValue)
    if stopMovesets or optionTable[optionTableRef.localMoveset].toggle == 0 then return end
    local hook = HOOK_ON_INTERACT
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    return currMoveset[hook](m, o, intType, intValue)
end
hook_event(HOOK_ON_INTERACT, on_interact)

local function allow_interact(m, o, intType)
    if stopMovesets or optionTable[optionTableRef.localMoveset].toggle == 0 then return end
    local hook = HOOK_ON_INTERACT
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    return currMoveset[hook](m, o, intType)
end
hook_event(HOOK_ALLOW_INTERACT, allow_interact)

local function on_set_mario_action(m)
    if stopMovesets or optionTable[optionTableRef.localMoveset].toggle == 0 then return end
    local hook = HOOK_ON_SET_MARIO_ACTION
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    return currMoveset[hook](m)
end
hook_event(HOOK_ON_SET_MARIO_ACTION, on_set_mario_action)

local function before_set_mario_action(m, nextAct)
    if stopMovesets or optionTable[optionTableRef.localMoveset].toggle == 0 then return end
    local hook = HOOK_BEFORE_SET_MARIO_ACTION
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    return currMoveset[hook](m, nextAct)
end
hook_event(HOOK_BEFORE_SET_MARIO_ACTION, before_set_mario_action)

local function on_death(m)
    if stopMovesets or optionTable[optionTableRef.localMoveset].toggle == 0 then return end
    local hook = HOOK_BEFORE_SET_MARIO_ACTION
    local currMoveset = characterMovesets[find_character_number(m.playerIndex)]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    return currMoveset[hook](m)
end
hook_event(HOOK_ON_DEATH, on_death)

