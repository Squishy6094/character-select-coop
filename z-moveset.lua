local function mario_update(m)
    local hook = HOOK_MARIO_UPDATE
    local currMoveset = characterMovesets[currChar]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    return currMoveset[hook](m)
end

local function before_mario_update(m)
    local hook = HOOK_BEFORE_MARIO_UPDATE
    local currMoveset = characterMovesets[currChar]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    return currMoveset[hook](m)
end

local function on_pvp_attack(attacker, victim)
    local hook = HOOK_ON_PVP_ATTACK
    local currMoveset = characterMovesets[currChar]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    return currMoveset[hook](attacker, victim)
end

local function on_interact(m, o, intType)
    local hook = HOOK_ON_INTERACT
    local currMoveset = characterMovesets[currChar]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    return currMoveset[hook](m, o, intType)
end

local function on_set_mario_action(m)
    local hook = HOOK_ON_SET_MARIO_ACTION
    local currMoveset = characterMovesets[currChar]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    return currMoveset[hook](m)
end

local function before_set_mario_action(m, nextAct)
    local hook = HOOK_BEFORE_SET_MARIO_ACTION
    local currMoveset = characterMovesets[currChar]
    if currMoveset == nil or currMoveset[hook] == nil then return end
    return currMoveset[hook](m, nextAct)
end

hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)
hook_event(HOOK_ON_PVP_ATTACK, on_pvp_attack)
hook_event(HOOK_ON_INTERACT, on_interact)
hook_event(HOOK_ON_SET_MARIO_ACTION, on_set_mario_action)
hook_event(HOOK_BEFORE_SET_MARIO_ACTION, before_set_mario_action)