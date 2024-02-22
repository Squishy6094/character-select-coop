-----------------------------------------------------------
-------------------------- Arena --------------------------
-- This does nothing atm but DJ has something planned... --
-----------------------------------------------------------

function arena_update(m)
    if m.playerIndex == 0 then
        if Arena == nil then
            return
        end
        _G.Arena.hammer = {
            rollActions = ACT_KING_BOUNCE,
            attackActions = ACT_KING_BOUNCE,
            poundActions = ACT_KING_BOUNCE_LAND,
        }

        _G.Arena.ChangeThrowAction = king == 0

        if Arena.playerIsMetal == true then
            if m.action == ACT_KING_BOUNCE_LAND then
                m.actionArg = 1
            end
        end
    end
end

hook_event(HOOK_MARIO_UPDATE, arena_update)