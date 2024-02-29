---@param o Object
---@param target Object
local function hit_effect_normal(o, target)
    target.oInteractStatus = target.oInteractStatus | ATTACK_FAST_ATTACK | INT_STATUS_WAS_ATTACKED | INT_STATUS_INTERACTED | INT_STATUS_TOUCHED_BOB_OMB
end
---@param o Object
---@param target Object
local function hit_effect_contact(o, target)
    target.oInteractStatus = target.oInteractStatus | ATTACK_FAST_ATTACK | INT_STATUS_WAS_ATTACKED | INT_STATUS_INTERACTED | ATTACK_FROM_ABOVE

    spawn_mist_particles()
    obj_mark_for_deletion(o)
end
---@param o Object
---@param target Object
local function hit_effect_bully(o, target)
    target.oInteractStatus = target.oInteractStatus | ATTACK_FAST_ATTACK | INT_STATUS_WAS_ATTACKED | INT_STATUS_INTERACTED

    target.oMoveAngleYaw = o.oMoveAngleYaw
    target.oForwardVel = 40

    spawn_mist_particles()
    obj_mark_for_deletion(o)
end
---@param o Object
---@param target Object
local function hit_effect_mrblizzard(o, target)
    target.oMrBlizzardHeldObj = nil
    target.oAction = MR_BLIZZARD_ACT_DEATH
end
---@param o Object
---@param target Object
local function hit_effect_piranhaplant(o, target)
    target.oAction = PIRANHA_PLANT_ACT_ATTACKED

    spawn_mist_particles()
    obj_mark_for_deletion(o)
end
---@param o Object
---@param target Object
local function hit_effect_kingbobomb(o, target)
    if target.oFlags & OBJ_FLAG_HOLDABLE ~= 0 and target.oAction ~= 8 then
        target.oVelY = 30
        target.oForwardVel = 30
        target.oMoveAngleYaw = o.oMoveAngleYaw
        target.oMoveFlags = 0
        target.oAction = 4
    end

    spawn_mist_particles()
    obj_mark_for_deletion(o)
end
---@param o Object
---@param target Object
local function hit_effect_bullet(o, target)
    spawn_mist_particles_with_sound(SOUND_GENERAL2_BOBOMB_EXPLOSION)
    target.oAction = 3

    spawn_mist_particles()
    obj_mark_for_deletion(o)
end
---@param o Object
---@param target Object
local function hit_effect_chuckya(o, target)
    target.oAction = 2
    target.oVelY = 30
    target.oMoveAngleYaw = o.oMoveAngleYaw
    target.oForwardVel = 30

    spawn_mist_particles()
    obj_mark_for_deletion(o)
end
---@param o Object
---@param target Object
local function hit_effect_destroy(o, target)
    spawn_mist_particles_with_sound(SOUND_GENERAL2_BOBOMB_EXPLOSION)
    obj_mark_for_deletion(target)
    obj_mark_for_deletion(o)
end

-- HUGE shoutouts to ganewatch
local flameInteractionTable = {
    [id_bhvMario] = function () end,
    [id_bhvGoomba] = hit_effect_normal,
    [id_bhvBobomb] = hit_effect_normal,
    [id_bhvKoopa] = hit_effect_normal,
    [id_bhvFlyGuy] = hit_effect_normal,
    [id_bhvMontyMole] = hit_effect_normal,
    [id_bhvSpindrift] = hit_effect_normal,
    [id_bhvBoo] = hit_effect_normal,
    [id_bhvGhostHuntBoo] = hit_effect_normal,
    [id_bhvBooInCastle] = hit_effect_normal,
    [id_bhvBooWithCage] = hit_effect_normal,
    [id_bhvMerryGoRoundBoo] = hit_effect_normal,
    [id_bhvFlyingBookend] = hit_effect_normal,
    [id_bhvSkeeter] = hit_effect_normal,
    [id_bhvMoneybag] = hit_effect_normal,
    [id_bhvSnufit] = hit_effect_normal,
    [id_bhvSwoop] = hit_effect_normal,
    [id_bhvEnemyLakitu] = hit_effect_normal,
    [id_bhvSpiny] = hit_effect_normal,
    [id_bhvPokey] = hit_effect_normal,
    [id_bhvPokeyBodyPart] = hit_effect_normal,
    [id_bhvSkeeter] = hit_effect_normal,

    [id_bhvFirePiranhaPlant] = hit_effect_contact,
    [id_bhvBalconyBigBoo] = hit_effect_contact,
    [id_bhvGhostHuntBigBoo] = hit_effect_contact,
    [id_bhvMerryGoRoundBigBoo] = hit_effect_contact,
    [id_bhvChainChomp] = hit_effect_contact,
    [id_bhvBreakableBox] = hit_effect_contact,
    [id_bhvWigglerHead] = hit_effect_contact,
    [id_bhvEyerokHand] = hit_effect_contact,
    [id_bhvKlepto] = hit_effect_contact,

    [id_bhvHeaveHo] = hit_effect_destroy,

    [id_bhvSmallBully] = hit_effect_bully,
    [id_bhvBigBully] = hit_effect_bully,
    [id_bhvSmallChillBully] = hit_effect_bully,
    [id_bhvBigChillBully] = hit_effect_bully,
    [id_bhvMrBlizzard] = hit_effect_mrblizzard,
    [id_bhvPiranhaPlant] = hit_effect_piranhaplant,
    [id_bhvBulletBill] = hit_effect_bullet,
    [id_bhvChuckya] = hit_effect_chuckya,

    [id_bhvKingBobomb] = hit_effect_kingbobomb,
}

define_custom_obj_fields({oBowserFireballTimer = 'u32'})

---@param obj Object
local function bhv_bowser_player_fireball_init(obj)
    --flags
    obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE
    obj.activeFlags = obj.activeFlags | ACTIVE_FLAG_UNK9
    obj.oGraphYOffset = 85.0

    -- physics
    obj.oGravity            = 0.05
    obj.oBounciness         = -0.75
    obj.oDragStrength       = 0.0
    obj.oFriction           = 1.0
    obj.oBuoyancy           = -2.0
    obj.oWallHitboxRadius   = 5

    --hitbox
    obj.hitboxDownOffset    = 50
    obj.hitboxRadius        = 120
    obj.hitboxHeight        = 250
    obj.hurtboxRadius       = 120
    obj.hurtboxHeight       = 250
    obj.oDamageOrCoinValue  = 2
    obj.oHealth             = 0
    obj.oInteractType       = INTERACT_FLAME
    obj.oNumLootCoins       = 0

    cur_obj_scale(0.01)
    cur_obj_become_tangible()

    --network thing
    network_init_object(obj, true, {'oBowserFireballTimer'})

    -- object specific fields
    obj.oBowserFireballTimer = 0

end

---@param obj Object
local function bhv_bowser_player_fireball_loop(obj)
    -- phys step
    local step = object_step_without_floor_orient()

    -- setup for targetting
    local targetObj
    local targetDist = 0x20000.0
    -- attack enemies
    for key, hit_effect in pairs(flameInteractionTable) do
        local otherObj = cur_obj_nearest_object_with_behavior(get_behavior_from_id(key))
        if otherObj ~= nil and not (key == id_bhvMario and otherObj.globalPlayerIndex == obj.globalPlayerIndex) then
            -- yoinks the nearest damageable object
            local dist = dist_between_objects(obj, otherObj)
            if dist < targetDist then
                targetDist = dist
                targetObj = otherObj
            end
            -- apply hit effects
            if obj_check_hitbox_overlap(obj, otherObj) then
                hit_effect(obj, otherObj)
            end
        end
    end

    -- targetting
    if targetObj ~= nil and targetDist < 800 then
        local yaw = approach_s16_symmetric(obj.oFaceAngleYaw, obj_angle_to_object(obj, targetObj), 0x280)
        obj.oFaceAngleYaw = yaw
        obj.oMoveAngleYaw = yaw

        obj.oPosY = approach_f32(obj.oPosY, targetObj.oPosY, 16, 0.0)
    end

    -- timer
    obj.oBowserFireballTimer = obj.oBowserFireballTimer + 1

    -- gfx
    obj.oAnimState = obj.oAnimState + 1
    cur_obj_set_billboard_if_vanilla_cam()
    local scale = math.min(obj.oBowserFireballTimer * 0.5, 5.0)
    obj.header.gfx.scale.x = scale
    obj.header.gfx.scale.y = scale * 0.8
    obj.header.gfx.scale.z = scale
    obj.oGraphYOffset = math.min(85, obj.oBowserFireballTimer * 5 + 25)

    if obj.oBowserFireballTimer >= 80 or step & (OBJ_COL_FLAG_HIT_WALL | OBJ_COL_FLAG_UNDERWATER) ~= 0 then
        spawn_mist_particles_with_sound(SOUND_OBJ_DEFAULT_DEATH)
        obj_mark_for_deletion(obj)
        return
    end
end
id_bhvBowserPlayerFireball = hook_behavior(nil, OBJ_LIST_GENACTOR, true,
    bhv_bowser_player_fireball_init, bhv_bowser_player_fireball_loop, "bhvBowserPlayerFireball")


--[[
---@param o Object
function obj_get_nearest_object(o)
    ---@type Object
    local obj = gMarioStates[0].marioObj
    local closestObj
    local shortestDist = 0x20000

    while obj ~= nil do
        if obj.activeFlags & ACTIVE_FLAG_ACTIVE ~= 0 and get_object_list_from_behavior(obj.behavior) ~= OBJ_LIST_UNIMPORTANT then
            
        end

        --dangit
        obj = obj.header.next
    end
end
]]

smlua_anim_util_register_animation('b_shell_spin', 0, 189, 0, 0, 20, {
	0x0000, 0x004A, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 
	0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0xFFFF, 
	0x0000, 0x0CCD, 0x199A, 0x2666, 0x3333, 0x4000, 0x4CCD, 0x5999, 0x6666, 
	0x7333, 0x8000, 0x8CCC, 0x9999, 0xA666, 0xB333, 0xBFFF, 0xCCCC, 0xD999, 
	0xE666, 0xF332, 0x0000, 0xFFFF, 0x0000, 0xFFFF, 0xFFFF, 0x0000, 
},
{
	0x0001, 0x0000, 0x0001, 0x0001, 0x0001, 0x0002, 0x000F, 0x0003, 0x0015, 
	0x0012, 0x0005, 0x0027, 
})

---@type function
local obj_transform_to_mario

if SM64COOPDX_VERSION ~= nil then
    ---@param obj Object
    obj_transform_to_mario = function(obj)
        local m = gMarioStates[network_local_index_from_global(obj.globalPlayerIndex)]
        local mObj = m.marioObj

        obj_copy_pos(obj, mObj)
        obj.header.gfx.throwMatrix = mObj.header.gfx.throwMatrix
        obj.header.gfx.animInfo.animAccel = mObj.header.gfx.animInfo.animAccel
        obj_copy_scale(obj, mObj)
    end
else
    ---@param obj Object
    obj_transform_to_mario = function(obj)
        local m = gMarioStates[network_local_index_from_global(obj.globalPlayerIndex)]
        local mObj = m.marioObj

        obj_copy_pos(obj, mObj)
        obj.header.gfx.animInfo.animAccel = mObj.header.gfx.animInfo.animAccel
        obj_copy_scale(obj, mObj)
    end
end


---@param obj Object
local function bhv_bowser_player_shell_init(obj)
    obj.oFlags = OBJ_FLAG_UPDATE_GFX_POS_AND_ANGLE

    network_init_object(obj, true, {})

    smlua_anim_util_set_animation(obj, 'b_shell_spin')
    obj_transform_to_mario(obj)
end

---@param obj Object
local function bhv_bowser_player_shell_loop(obj)
    obj_transform_to_mario(obj)
end

id_bhvBowserPlayerShell = hook_behavior(nil, OBJ_LIST_DEFAULT, true,
    bhv_bowser_player_shell_init, bhv_bowser_player_shell_loop, "bhvBowserPlayerShell")
