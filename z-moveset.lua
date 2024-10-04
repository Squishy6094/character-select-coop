local function mario_update(m)
    local currMoveset = characterMovesets[currChar]
    if currMoveset == nil or #currMoveset < 1 then return end
    for i = 1, #currMoveset do
        if currMoveset[i].hook == HOOK_MARIO_UPDATE then
            currMoveset[i].func(m)
        end
    end
end

local function on_pvp_attack(attacker, victim)
    local currMoveset = characterMovesets[currChar]
    if currMoveset == nil or #currMoveset < 1 then return end
    for i = 1, #currMoveset do
        if currMoveset[i].hook == HOOK_ON_PVP_ATTACK then
            currMoveset[i].func(attacker, victim)
        end
    end
end

local function on_interact(m, o, intType)
    local currMoveset = characterMovesets[currChar]
    if currMoveset == nil or #currMoveset < 1 then return end
    for i = 1, #currMoveset do
        if currMoveset[i].hook == HOOK_ON_INTERACT then
            currMoveset[i].func(m, o, intType)
        end
    end
end

local function before_set_mario_action(m, nextAct)
    local currMoveset = characterMovesets[currChar]
    if currMoveset == nil or #currMoveset < 1 then return end
    for i = 1, #currMoveset do
        if currMoveset[i].hook == HOOK_BEFORE_SET_MARIO_ACTION then
            currMoveset[i].func(m, nextAct)
        end
    end
end

hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_ON_PVP_ATTACK, on_pvp_attack)
hook_event(HOOK_ON_INTERACT, on_interact)
hook_event(HOOK_BEFORE_SET_MARIO_ACTION, before_set_mario_action)