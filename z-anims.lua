-- Animations --

if incompatibleClient then return 0 end

-- localize functions to improve performance - z-anims.lua
local smlua_anim_util_set_animation = smlua_anim_util_set_animation

local function character_anims(m)
    p = gPlayerSyncTable[m.playerIndex]
    if characterAnims[p.modelId] then
        local animID = characterAnims[p.modelId][m.marioObj.header.gfx.animInfo.animID]
        if animID then
            smlua_anim_util_set_animation(m.marioObj, animID)
        end
    end
end

hook_event(HOOK_MARIO_UPDATE, character_anims)
