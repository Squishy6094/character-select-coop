ACT_MEMER_WATER_IDLE = allocate_mario_action(ACT_GROUP_SUBMERGED | ACT_FLAG_STATIONARY | ACT_FLAG_WATER_OR_TEXT | ACT_FLAG_SWIMMING_OR_FLYING | ACT_FLAG_METAL_WATER)
ACT_MEMER_SWIMMING = allocate_mario_action(ACT_GROUP_SUBMERGED | ACT_FLAG_MOVING | ACT_FLAG_WATER_OR_TEXT | ACT_FLAG_SWIMMING_OR_FLYING | ACT_FLAG_METAL_WATER)
ACT_MEMER_WATER_SKID = allocate_mario_action(ACT_GROUP_SUBMERGED | ACT_FLAG_MOVING | ACT_FLAG_WATER_OR_TEXT | ACT_FLAG_SWIMMING_OR_FLYING | ACT_FLAG_METAL_WATER)
ACT_MEMER_WATER_CHARGE = allocate_mario_action(ACT_GROUP_SUBMERGED | ACT_FLAG_MOVING | ACT_FLAG_WATER_OR_TEXT | ACT_FLAG_SWIMMING_OR_FLYING | ACT_FLAG_METAL_WATER)
ACT_MEMER_WATER_THROW = allocate_mario_action(ACT_GROUP_SUBMERGED | ACT_FLAG_MOVING | ACT_FLAG_WATER_OR_TEXT | ACT_FLAG_SWIMMING_OR_FLYING | ACT_FLAG_METAL_WATER | ACT_FLAG_THROWING)

ACT_MEMER_FLIGHT_IDLE = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_STATIONARY | ACT_FLAG_DIVING | ACT_FLAG_WATER_OR_TEXT | ACT_FLAG_SWIMMING_OR_FLYING)
ACT_MEMER_FLYING = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_MOVING | ACT_FLAG_DIVING | ACT_FLAG_WATER_OR_TEXT | ACT_FLAG_SWIMMING_OR_FLYING)
ACT_MEMER_FLIGHT_SKID = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_MOVING | ACT_FLAG_DIVING | ACT_FLAG_WATER_OR_TEXT | ACT_FLAG_SWIMMING_OR_FLYING)
ACT_MEMER_FLIGHT_CHARGE = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_MOVING | ACT_FLAG_DIVING | ACT_FLAG_WATER_OR_TEXT | ACT_FLAG_SWIMMING_OR_FLYING)

-- optimization
local set_mario_action, is_anim_at_end, mario_grab_used_object, set_mario_animation, set_mario_anim_with_accel, perform_ground_step,
perform_air_step, apply_water_current, set_mario_particle_flags, math_abs, set_swimming_at_surface_particles, approach_f32, play_sound,
play_mario_sound, mario_get_collided_object =

set_mario_action, is_anim_at_end, mario_grab_used_object, set_mario_animation, set_mario_anim_with_accel, perform_ground_step,
perform_air_step, apply_water_current, set_mario_particle_flags, math.abs, set_swimming_at_surface_particles, approach_f32, play_sound,
play_mario_sound, mario_get_collided_object

local s16 = function(x)
    x = (math.floor(x) & 0xFFFF)
    if x >= 32768 then return x - 65536 end
    return x
end

local clamp = function(x, min, max)
    if x < min then return min end
    if x > max then return max end
    return x
end

----------------------
-- Swimming code !! --
----------------------

local SHELL_DURATION = 30 * 30

local toIdleAction = {
    [ACT_WATER_IDLE] = true,
    [ACT_HOLD_WATER_IDLE] = true,
    [ACT_WATER_ACTION_END] = true,
    [ACT_HOLD_WATER_ACTION_END] = true,
    [ACT_METAL_WATER_FALL_LAND] = true,
    [ACT_METAL_WATER_JUMP_LAND] = true,
    [ACT_METAL_WATER_STANDING] = true,
    [ACT_HOLD_METAL_WATER_STANDING] = true,
    [ACT_HOLD_METAL_WATER_FALL_LAND] = true,
    [ACT_HOLD_METAL_WATER_JUMP_LAND] = true,
}

local toSwimAction = {
    [ACT_BREASTSTROKE] = true,
    [ACT_HOLD_BREASTSTROKE] = true,
    [ACT_FLUTTER_KICK] = true,
    [ACT_HOLD_FLUTTER_KICK] = true,
    [ACT_WATER_PUNCH] = true,
    [ACT_METAL_WATER_FALLING] = true,
    [ACT_METAL_WATER_JUMP] = true,
    [ACT_METAL_WATER_WALKING] = true,
}

local shellTimer = 0

local set_anim_hold_or_normal = function(m, normalAnim, holdAnim, accel)
    if not accel then
        accel = 0x10000
    end
    if m.heldObj then
        return set_mario_anim_with_accel(m, holdAnim, accel)
    else
        return set_mario_anim_with_accel(m, normalAnim, accel)
    end
end

local set_act_hold_or_normal = function(m, normalAct, holdAct, actArg)
    if m.heldObj then
        return set_mario_action(m, holdAct, actArg)
    else
        return set_mario_action(m, normalAct, actArg)
    end
end

local get_v_dir = function(m)
    local vDir = 0
    local goalAngle = 0x4000

    if (m.input & INPUT_A_DOWN) ~= 0 and (m.pos.y < m.waterLevel - 80 and m.pos.y < m.ceilHeight - 160) then
        vDir = vDir + 1
    end

    if (m.input & INPUT_Z_DOWN) ~= 0 and m.pos.y > m.floorHeight then
        vDir = vDir - 1
    end

    vDir = vDir * (1 - m.intendedMag / 64)

    return goalAngle * vDir
end

local common_water_update = function(m)
    local step
    local snowyTerrain = (m.area.terrainType & TERRAIN_MASK) == TERRAIN_SNOW
    local metalSink = (m.flags & MARIO_METAL_CAP) ~= 0 and -12 or 0

    if m.pos.y <= m.floorHeight and m.vel.y <= 0 then
        step = perform_ground_step(m)
    else
        step = perform_air_step(m, 0)
    end

    m.vel.x = m.forwardVel * sins(m.faceAngle.y) * coss(m.faceAngle.x)
    m.vel.y = m.forwardVel * sins(m.faceAngle.x) + metalSink
    m.vel.z = m.forwardVel * coss(m.faceAngle.y) * coss(m.faceAngle.x)

    -- not letting you heal on the surface just because of the metal cap is pretty annoying
    if m.pos.y >= m.waterLevel - 140 and not snowyTerrain then
        m.health = m.health + 0x1A
    end

    if (m.flags & MARIO_METAL_CAP) == 0 then
        set_mario_particle_flags(m, PARTICLE_BUBBLE, 0)

        apply_water_current(m, m.vel)

        if m.pos.y < m.waterLevel - 140 then
            if snowyTerrain then
                m.health = m.health - 3
            else
                m.health = m.health - 1
            end
        end
    end

    return step
end

local headDir = 0

---@param m MarioState
local act_memer_water_idle = function(m)
    local vDir = get_v_dir(m)
    local buoyancy = 0
    local shellMul = obj_has_behavior_id(m.heldObj, id_bhvKoopaShellUnderwater) ~= 0 and 1.82 or 1

    if (m.input & INPUT_A_PRESSED) ~= 0 and m.pos.y >= m.waterLevel - 100 then
        if m.playerIndex == 0 then
            set_camera_mode(m.area.camera, m.area.camera.defMode, 0)
        end
        set_mario_y_vel_based_on_fspeed(m, 50, 0.1)
        return set_act_hold_or_normal(m, ACT_KING_JUMP, ACT_HOLD_JUMP, 0)
    end

    if (m.input & INPUT_B_PRESSED) ~= 0 then
        return set_act_hold_or_normal(m, ACT_MEMER_WATER_CHARGE, ACT_MEMER_WATER_THROW, 0)
    end

    if vDir ~= 0 or (m.input & INPUT_NONZERO_ANALOG) ~= 0 then
        if math_abs(m.forwardVel) < 16 then
            m.faceAngle.y = m.intendedYaw
            m.forwardVel = 8
        end
        return set_mario_action(m, ACT_MEMER_SWIMMING, 0)
    end

    if m.forwardVel > 12 then
        return set_mario_action(m, ACT_MEMER_WATER_SKID, 0)
    end

    if king == 0 or king == 2 then
        return set_mario_action(m, ACT_WATER_ACTION_END, 0)
    end

    m.forwardVel = clamp(m.forwardVel, -48 * shellMul, 48 * shellMul)

    if (m.flags & MARIO_METAL_CAP) == 0 then
        if m.waterLevel - 80 - m.pos.y < 400 then
            buoyancy = 1.25
        else
            buoyancy = -2
        end
    end

    common_water_update(m)

    m.vel.y = m.vel.y + buoyancy

    m.faceAngle.x = approach_s32(m.faceAngle.x, 0, 0x450, 0x450)

    if m.actionArg == 1 then
        set_anim_hold_or_normal(m, MARIO_ANIM_SWIM_PART1, MARIO_ANIM_SWIM_WITH_OBJ_PART1)
        if is_anim_past_end(m) ~= 0 then
            play_sound(SOUND_ACTION_SWIM, m.marioObj.header.gfx.cameraToObject)
            m.actionArg = 0
        end
    elseif m.actionState == 0 then
        set_anim_hold_or_normal(m, MARIO_ANIM_SWIM_PART2, MARIO_ANIM_SWIM_WITH_OBJ_PART2)
        if is_anim_past_end(m) ~= 0 then
            m.actionState = 1
        end
    elseif m.actionState == 1 then
        set_anim_hold_or_normal(m, MARIO_ANIM_WATER_ACTION_END, MARIO_ANIM_WATER_ACTION_END_WITH_OBJ)
        if is_anim_past_end(m) ~= 0 then
            m.actionState = 2
        end
    else
        set_anim_hold_or_normal(m, MARIO_ANIM_WATER_IDLE, MARIO_ANIM_WATER_IDLE_WITH_OBJ)
    end

    m.marioBodyState.handState = MARIO_HAND_OPEN

    m.forwardVel = approach_f32(m.forwardVel, 0, 1 * shellMul, 1 * shellMul)

    set_swimming_at_surface_particles(m, PARTICLE_WAVE_TRAIL)

    m.faceAngle.z = approach_f32(m.faceAngle.z, 0, 0x180, 0x180)

    m.marioObj.header.gfx.angle.x = m.marioObj.header.gfx.angle.x - m.faceAngle.x
    m.marioObj.header.gfx.angle.z = -m.faceAngle.z

    m.marioBodyState.headAngle.x = approach_f32(m.marioBodyState.headAngle.x, 0, 0x400, 0x400)
    --apparently i have to rely on this headDir variable because using approach_f32 on headAngle.y directly doesnt work properly
    -- god i love this fucking game
    if m.playerIndex == 0 then
        if m.actionState > 0 and m.actionArg == 0 then
            headDir = approach_f32(headDir, 0, 0x400, 0x400)
        end
        m.marioBodyState.headAngle.y = headDir
    end
    m.marioBodyState.headAngle.z = m.faceAngle.z

    return 0
end

---@param m MarioState
local update_swim_speed = function(m)
    local vDir = get_v_dir(m)
    local intendedDYaw = s16(m.intendedYaw - m.faceAngle.y)
    local shellMul = obj_has_behavior_id(m.heldObj, id_bhvKoopaShellUnderwater) ~= 0 and 1.82 or 1

    local speedGain = m.forwardVel < 28 * shellMul and 2.4 * shellMul or 0.8

    if (m.input & INPUT_NONZERO_ANALOG) == 0 and vDir == 0 then
        m.forwardVel = clamp(approach_f32(m.forwardVel, 0, 2, 2), -150 * shellMul, 150 * shellMul)
    else
        m.forwardVel = m.forwardVel + speedGain
        if m.forwardVel > 48 then
            m.forwardVel = clamp(approach_f32(m.forwardVel, 0, 2, 2), -150 * shellMul, 150 * shellMul)
        else
            m.forwardVel = clamp(m.forwardVel, -150 * shellMul, 150 * shellMul)
        end
    end

    m.faceAngle.y = m.intendedYaw - approach_s32(intendedDYaw, 0, 0x900, 0x900)
    m.faceAngle.x = approach_s32(m.faceAngle.x, vDir, 0x450, 0x450)
    m.faceAngle.z = approach_f32(m.faceAngle.z, clamp(intendedDYaw, -0xD00, 0xD00), 0x260, 0x260)

    m.marioBodyState.headAngle.x = approach_f32(m.marioBodyState.headAngle.x, clamp(m.faceAngle.x - vDir, -0x1800, 0x5C00), 0x6A0, 0x6A0)
    if m.playerIndex == 0 then
        headDir = approach_f32(headDir, clamp(intendedDYaw, -0x2400, 0x2400), 0x6A0, 0x6A0)
        m.marioBodyState.headAngle.y = headDir
    end
    m.marioBodyState.headAngle.z = m.faceAngle.z

    m.marioObj.header.gfx.angle.z = -m.faceAngle.z

    step = common_water_update(m)

    return step
end

---@param m MarioState
local act_memer_swimming = function(m)
    local vDir = get_v_dir(m)
    local intendedDYaw = s16(m.intendedYaw - m.faceAngle.y)
    local actArg = 0
    local marioAnim = m.marioObj.header.gfx.animInfo

    if m.actionState == 0 then
        actArg = 1
        set_anim_hold_or_normal(m, MARIO_ANIM_SWIM_PART1, MARIO_ANIM_SWIM_WITH_OBJ_PART1)
        if marioAnim.animFrame >= marioAnim.curAnim.loopEnd - 6 then
            m.actionTimer = 4
        end

        if is_anim_past_end(m) ~= 0 then
            m.actionState = 1
            if m.forwardVel < 28 then
                play_sound(SOUND_ACTION_SWIM, m.marioObj.header.gfx.cameraToObject)
            else
                play_sound(SOUND_ACTION_SWIM_FAST, m.marioObj.header.gfx.cameraToObject)
            end
        end
    else
        set_anim_hold_or_normal(m, MARIO_ANIM_SWIM_PART2, MARIO_ANIM_SWIM_WITH_OBJ_PART2)
        if is_anim_past_end(m) ~= 0 and math_abs(m.faceAngle.x - vDir) <= 0x1800 and math_abs(intendedDYaw) <= 0x1800 then
            m.actionState = 0
        end
    end

    if m.forwardVel <= 6 then
        return set_mario_action(m, ACT_MEMER_WATER_IDLE, 0)
    end

    if (m.input & INPUT_A_PRESSED) ~= 0 and m.pos.y >= m.waterLevel - 100 then
        if m.playerIndex == 0 then
            set_camera_mode(m.area.camera, m.area.camera.defMode, 0)
        end
        set_mario_y_vel_based_on_fspeed(m, 50, 0.1)
        return set_act_hold_or_normal(m, ACT_KING_JUMP, ACT_HOLD_JUMP, 0)
    end

    if (m.input & INPUT_B_PRESSED) ~= 0 then
        return set_act_hold_or_normal(m, ACT_MEMER_WATER_CHARGE, ACT_MEMER_WATER_THROW, 0)
    end

    if analog_stick_held_back(m) ~= 0 and vDir == 0 then
        if m.forwardVel > 12 then
            return set_mario_action(m, ACT_MEMER_WATER_SKID, 0)
        else
            return set_mario_action(m, ACT_MEMER_WATER_IDLE, actArg)
        end
    end

    if king == 0 or king == 2 then
        return set_mario_action(m, ACT_WATER_ACTION_END, 0)
    end

    local step = update_swim_speed(m)

    --if step == GROUND_STEP_HIT_WALL or step == AIR_STEP_HIT_WALL then
    --    m.forwardVel = 0
    --end

    m.marioBodyState.handState = MARIO_HAND_OPEN
    set_swimming_at_surface_particles(m, PARTICLE_WAVE_TRAIL)

    m.marioObj.header.gfx.angle.x = m.marioObj.header.gfx.angle.x - m.faceAngle.x

    return 0
end

---@param m MarioState
local act_memer_water_skid = function(m)
    local step
    local vDir = get_v_dir(m)
    local shellMul = obj_has_behavior_id(m.heldObj, id_bhvKoopaShellUnderwater) ~= 0 and 1.82 or 1

    if m.forwardVel <= 6 then
        return set_mario_action(m, ACT_MEMER_WATER_IDLE, 0)
    end

    if ((m.input & INPUT_NONZERO_ANALOG) ~= 0 and analog_stick_held_back(m) == 0) or vDir ~= 0 then
        if math_abs(m.forwardVel) < 16 then
            m.faceAngle.y = m.intendedYaw
            m.forwardVel = 8
        end
        return set_mario_action(m, ACT_MEMER_SWIMMING, 0)
    end

    if (m.input & INPUT_B_PRESSED) ~= 0 then
        return set_act_hold_or_normal(m, ACT_MEMER_WATER_CHARGE, ACT_MEMER_WATER_THROW, 0)
    end

    if king == 0 or king == 2 then
        return set_mario_action(m, ACT_WATER_ACTION_END, 0)
    end

    m.forwardVel = clamp(approach_s32(m.forwardVel, 0, 2.4 * shellMul, 2.4 * shellMul), -48, 48)

    common_water_update(m)

    set_mario_animation(m, MARIO_ANIM_SKID_ON_GROUND)

    set_swimming_at_surface_particles(m, PARTICLE_WAVE_TRAIL)
    set_mario_particle_flags(m, PARTICLE_PLUNGE_BUBBLE, 0)

    play_sound(SOUND_ACTION_SWIM, m.marioObj.header.gfx.cameraToObject)

    m.faceAngle.z = approach_f32(m.faceAngle.z, 0, 0x240, 0x240)

    m.marioObj.header.gfx.angle.x = m.marioObj.header.gfx.angle.x - m.faceAngle.x
    m.marioObj.header.gfx.angle.z = -m.faceAngle.z

    m.marioBodyState.headAngle.x = approach_f32(m.marioBodyState.headAngle.x, 0, 0x4A0, 0x4A0)
    if m.playerIndex == 0 then
        headDir = approach_f32(headDir, 0, 0x4A0, 0x4A0)
        m.marioBodyState.headAngle.y = headDir
    end
    m.marioBodyState.headAngle.z = m.faceAngle.z

    return 0
end

---@param m MarioState
local grab_obj_in_water = function(m)
    if m.playerIndex ~= 0 then return end

    if (m.marioObj.collidedObjInteractTypes & INTERACT_GRABBABLE) ~= 0 then
        local o = mario_get_collided_object(m, INTERACT_GRABBABLE)
        local dx = o.oPosX - m.pos.x
        local dz = o.oPosZ - m.pos.z
        local angleToObj = atan2s(dz, dx) - m.faceAngle.y

        if math_abs(angleToObj) <= 0x2AAA then
            m.usedObj = o
            mario_grab_used_object(m)
            if m.heldObj ~= nil then
                m.marioBodyState.grabPos = GRAB_POS_LIGHT_OBJ
                return true
            end
        end
    end

    return false
end

---@param m MarioState
local act_memer_water_charge = function(m)
    local vDir = get_v_dir(m)
    local e = gMarioStateExtras[m.playerIndex]
    local MAXDASH = 15
    local MINDASH = 2
    local marioAnim = m.marioObj.header.gfx.animInfo

    -- Revving.
    if m.actionTimer == 0 then
        e.dashspeed = 0
        play_king_sfx(m, 1)
    end

    -- Direction changing.
    if (m.input & INPUT_NONZERO_ANALOG) ~= 0 then
        m.faceAngle.y = m.intendedYaw
    end
    m.faceAngle.x = vDir

    -- Dash limit.
    if e.dashspeed < MINDASH then
        e.dashspeed = MINDASH
    elseif e.dashspeed > MAXDASH then
        e.dashspeed = MAXDASH
        m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
        --do_after_image(m)
    end

    if e.dashspeed == 6 or e.dashspeed == 10 or e.dashspeed == 14 then
        play_king_sfx(m, 1)
    end

    -- Dash release.
    if (m.controller.buttonDown & B_BUTTON) == 0 then
        m.faceAngle.y = m.marioObj.header.gfx.angle.y
        mario_set_forward_vel(m, (math.abs(m.forwardVel) + e.dashspeed * 8) * 2)

        play_king_sfx(m, 2)

        set_mario_action(m, ACT_MEMER_SWIMMING, 0)
    end

    -- Object grabbing.
    grab_obj_in_water(m)

    if m.heldObj ~= nil then-- Animations.
        set_mario_animation(m, MARIO_ANIM_WATER_PICK_UP_OBJ)
        if m.playerIndex == 0 and obj_has_behavior_id(m.heldObj, id_bhvKoopaShellUnderwater) ~= 0 then
            shellTimer = SHELL_DURATION
            play_shell_music()
        end
        if is_anim_at_end(m) ~= 0 then
            return set_mario_action(m, ACT_MEMER_SWIMMING, 0)
        end
    else
        -- Animations.
        set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING)
        set_anim_to_frame(m, marioAnim.animFrame + (e.dashspeed / 3.75))
        if marioAnim.animFrame >= marioAnim.curAnim.loopEnd then
            marioAnim.animFrame = marioAnim.animFrame - marioAnim.curAnim.loopEnd
        end
    end

    -- Physics 'n stuff.
    m.actionTimer = m.actionTimer + 1
    e.dashspeed = e.dashspeed + 0.5
    mario_set_forward_vel(m, m.forwardVel / 1.1)

    -- Water stuff.
    common_water_update(m)

    set_swimming_at_surface_particles(m, PARTICLE_WAVE_TRAIL)
    set_mario_particle_flags(m, PARTICLE_PLUNGE_BUBBLE, 0)

    m.faceAngle.z = approach_f32(m.faceAngle.z, 0, 0x240, 0x240)

    m.marioObj.header.gfx.angle.x = (m.marioObj.header.gfx.angle.x - m.faceAngle.x) + (((e.dashspeed - 2) / 13) * 0x2000)
    m.marioObj.header.gfx.angle.z = -m.faceAngle.z
end

---@param m MarioState
local act_memer_water_throw = function(m)
    set_mario_animation(m, MARIO_ANIM_WATER_THROW_OBJ)
    play_mario_sound(m, SOUND_ACTION_SWIM, CHAR_SOUND_YAH_WAH_HOO)

    if is_anim_at_end(m) ~= 0 then
        return set_mario_action(m, ACT_MEMER_SWIMMING, 0)
    end

    m.actionTimer = m.actionTimer + 1

    if m.actionTimer == 5 then
        if m.playerIndex == 0 then
            stop_shell_music()
            shellTimer = 0
        end
        mario_throw_held_object(m)
        queue_rumble_data_mario(m, 3, 50)
    end

    if m.forwardVel >= 0.29 then
        m.forwardVel = m.forwardVel - 0.29
    end

    common_water_update(m)

    set_swimming_at_surface_particles(m, PARTICLE_WAVE_TRAIL)

    m.faceAngle.z = approach_f32(m.faceAngle.z, 0, 0x240, 0x240)

    m.marioObj.header.gfx.angle.x = m.marioObj.header.gfx.angle.x - m.faceAngle.x
    m.marioObj.header.gfx.angle.z = -m.faceAngle.z

    m.marioBodyState.headAngle.x = approach_f32(m.marioBodyState.headAngle.x, 0, 0x4A0, 0x4A0)
    if m.playerIndex == 0 then
        headDir = approach_f32(headDir, 0, 0x4A0, 0x4A0)
        m.marioBodyState.headAngle.y = headDir
    end
    m.marioBodyState.headAngle.z = m.faceAngle.z
end

--------------------
-- Flying code !! --
--------------------

local get_v_dir_fly = function(m)
    local vDir = 0
    local goalAngle = 0x4000

    if (m.input & INPUT_A_DOWN) ~= 0 and m.pos.y < m.ceilHeight then
        vDir = vDir + 1
    end

    if (m.input & INPUT_Z_DOWN) ~= 0 and m.pos.y > m.floorHeight then
        vDir = vDir - 1
    end

    vDir = vDir * (1 - m.intendedMag / 64)

    return goalAngle * vDir
end

local common_flight_update = function(m)
    local step

    step = perform_air_step(m, 0)

    m.vel.x = m.forwardVel * sins(m.faceAngle.y) * coss(m.faceAngle.x) * 1.5
    m.vel.y = m.forwardVel * sins(m.faceAngle.x) * 1.5
    m.vel.z = m.forwardVel * coss(m.faceAngle.y) * coss(m.faceAngle.x) * 1.5

    return step
end

---@param m MarioState
local act_memer_flight_idle = function(m)
    local vDir = get_v_dir_fly(m)
    local marioAnim = m.marioObj.header.gfx.animInfo

    if (m.input & INPUT_B_PRESSED) ~= 0 then
        return set_mario_action(m, ACT_MEMER_FLIGHT_CHARGE, 0)
    end

    if vDir ~= 0 or (m.input & INPUT_NONZERO_ANALOG) ~= 0 then
        if math_abs(m.forwardVel) < 16 then
            m.faceAngle.y = m.intendedYaw
            m.forwardVel = 8
        end
        return set_mario_action(m, ACT_MEMER_FLYING, 0)
    end

    if m.forwardVel > 12 then
        return set_mario_action(m, ACT_MEMER_FLIGHT_SKID, 0)
    end

    if king == 0 or king == 2 then
        return set_mario_action(m, ACT_FREEFALL, 0)
    end

    m.forwardVel = clamp(m.forwardVel, -48, 48)

    common_flight_update(m)

    m.faceAngle.x = approach_s32(m.faceAngle.x, 0, 0x450, 0x450)

    -- Animations.
    set_mario_animation(m, MARIO_ANIM_WING_CAP_FLY)
    set_anim_to_frame(m, marioAnim.animFrame + 1)
    if marioAnim.animFrame >= marioAnim.curAnim.loopEnd then
        marioAnim.animFrame = marioAnim.animFrame - marioAnim.curAnim.loopEnd
    end

    m.marioBodyState.handState = MARIO_HAND_OPEN

    m.forwardVel = approach_f32(m.forwardVel, 0, 1, 1)

    m.faceAngle.z = approach_f32(m.faceAngle.z, 0, 0x180, 0x180)

    m.marioObj.header.gfx.angle.x = (m.marioObj.header.gfx.angle.x - m.faceAngle.x)
    m.marioObj.header.gfx.angle.z = -m.faceAngle.z

    m.marioBodyState.headAngle.x = approach_f32(m.marioBodyState.headAngle.x, 0, 0x400, 0x400)
    if m.playerIndex == 0 then
        if m.actionState > 0 and m.actionArg == 0 then
            headDir = approach_f32(headDir, 0, 0x400, 0x400)
        end
        m.marioBodyState.headAngle.y = headDir
    end
    m.marioBodyState.headAngle.z = m.faceAngle.z

    return 0
end

---@param m MarioState
local update_flight_speed = function(m)
    local vDir = get_v_dir_fly(m)
    local intendedDYaw = s16(m.intendedYaw - m.faceAngle.y)

    local speedGain = m.forwardVel < 28 and 2.4 or 0.8

    if (m.input & INPUT_NONZERO_ANALOG) == 0 and vDir == 0 then
        m.forwardVel = clamp(approach_f32(m.forwardVel, 0, 2, 2), -150, 150)
    else
        m.forwardVel = m.forwardVel + speedGain
        if m.forwardVel > 75 then
            m.forwardVel = clamp(approach_f32(m.forwardVel, 0, 1, 1), -150, 150)
        else
            m.forwardVel = clamp(m.forwardVel, -150, 150)
        end
    end

    m.faceAngle.y = m.intendedYaw - approach_s32(intendedDYaw, 0, 0x900, 0x900)
    m.faceAngle.x = approach_s32(m.faceAngle.x, vDir, 0x450, 0x450)
    m.faceAngle.z = approach_f32(m.faceAngle.z, clamp(intendedDYaw, -0xD00, 0xD00), 0x260, 0x260)

    m.marioBodyState.headAngle.x = approach_f32(m.marioBodyState.headAngle.x, clamp(m.faceAngle.x - vDir, -0x1800, 0x5C00), 0x6A0, 0x6A0)
    if m.playerIndex == 0 then
        headDir = approach_f32(headDir, clamp(intendedDYaw, -0x2400, 0x2400), 0x6A0, 0x6A0)
        m.marioBodyState.headAngle.y = headDir
    end
    m.marioBodyState.headAngle.z = m.faceAngle.z

    m.marioObj.header.gfx.angle.z = -m.faceAngle.z

    step = common_flight_update(m)

    return step
end

---@param m MarioState
local act_memer_flying = function(m)
    local vDir = get_v_dir_fly(m)
    local actArg = 0
    local marioAnim = m.marioObj.header.gfx.animInfo

    -- Animations.
    set_mario_animation(m, MARIO_ANIM_WING_CAP_FLY)
    set_anim_to_frame(m, marioAnim.animFrame + 1)
    if marioAnim.animFrame >= marioAnim.curAnim.loopEnd then
        marioAnim.animFrame = marioAnim.animFrame - marioAnim.curAnim.loopEnd
    end

    if m.forwardVel <= 6 then
        return set_mario_action(m, ACT_MEMER_FLIGHT_IDLE, 0)
    end

    if (m.input & INPUT_B_PRESSED) ~= 0 then
        return set_mario_action(m, ACT_MEMER_FLIGHT_CHARGE, 0)
    end

    if analog_stick_held_back(m) ~= 0 and vDir == 0 then
        if m.forwardVel > 12 then
            return set_mario_action(m, ACT_MEMER_FLIGHT_SKID, 0)
        else
            return set_mario_action(m, ACT_MEMER_FLIGHT_IDLE, actArg)
        end
    end

    if king == 0 or king == 2 then
        return set_mario_action(m, ACT_FREEFALL, 0)
    end

    local step = update_flight_speed(m)

    if step == AIR_STEP_LANDED then
        if m.playerIndex == 0 then
            set_camera_mode(m.area.camera, m.area.camera.defMode, 0)
        end
        if m.forwardVel ~= 0 then
            if (m.controller.buttonDown & Z_TRIG) ~= 0 then
                set_mario_action(m, ACT_KING_ROLL, 0)
                play_mario_landing_sound(m, SOUND_ACTION_TERRAIN_BODY_HIT_GROUND)
            else
                set_mario_action(m, ACT_KING_WALK, 0)
                play_mario_landing_sound(m, SOUND_ACTION_TERRAIN_LANDING)
            end
        else
            set_mario_action(m, ACT_FREEFALL_LAND_STOP, 0)
            play_mario_landing_sound(m, SOUND_ACTION_TERRAIN_LANDING)
        end
    elseif step == AIR_STEP_HIT_WALL then
        if m.playerIndex == 0 then
            set_camera_mode(m.area.camera, m.area.camera.defMode, 0)
        end
        if (m.forwardVel > 16.0) then
            queue_rumble_data_mario(m, 5, 40)
            mario_bonk_reflection(m, false)
            m.faceAngle.y = m.faceAngle.y + 0x8000

            if (m.wall ~= nil) then
                if m.action == ACT_KING_AIRROLL and m.actionArg == 0 then
                    return set_mario_action(m, ACT_KING_HIT_WALL, 1)
                else
                    return set_mario_action(m, ACT_KING_HIT_WALL, 0)
                end
            else
                if m.vel.y > 0 then
                    m.vel.y = 0
                end

                --! Hands-free holding. Bonking while no wall is referenced
                -- sets Mario's action to a non-holding action without
                -- dropping the object, causing the hands-free holding
                -- glitch. This can be achieved using an exposed ceiling,
                -- out of bounds, grazing the bottom of a wall while
                -- falling such that the final quarter step does not find a
                -- wall collision, or by rising into the top of a wall such
                -- that the final quarter step detects a ledge, but you are
                -- not able to ledge grab it.
                if m.forwardVel >= 38 then
                    set_mario_particle_flags(m, PARTICLE_VERTICAL_STAR, false)
                    set_mario_action(m, ACT_BACKWARD_AIR_KB, 0)
                else
                    if m.forwardVel > 8 then
                        mario_set_forward_vel(m, -8)
                    end
                    return set_mario_action(m, ACT_SOFT_BONK, 0)
                end
            end
        else
            mario_set_forward_vel(m, 0.0)
        end
    end

    m.marioBodyState.handState = MARIO_HAND_OPEN
    set_mario_particle_flags(m, PARTICLE_DUST, false)
    play_sound(SOUND_MOVING_FLYING, m.marioObj.header.gfx.cameraToObject)
    adjust_sound_for_speed(m)

    m.marioObj.header.gfx.angle.x = m.marioObj.header.gfx.angle.x - m.faceAngle.x

    return 0
end

---@param m MarioState
local act_memer_flight_skid = function(m)
    local step
    local vDir = get_v_dir_fly(m)

    if m.forwardVel <= 6 then
        return set_mario_action(m, ACT_MEMER_FLIGHT_IDLE, 0)
    end

    if ((m.input & INPUT_NONZERO_ANALOG) ~= 0 and analog_stick_held_back(m) == 0) or vDir ~= 0 then
        if math_abs(m.forwardVel) < 16 then
            m.faceAngle.y = m.intendedYaw
            m.forwardVel = 8
        end
        return set_mario_action(m, ACT_MEMER_FLYING, 0)
    end

    if (m.input & INPUT_B_PRESSED) ~= 0 then
        return set_mario_action(m, ACT_MEMER_FLIGHT_CHARGE, 0)
    end

    if king == 0 or king == 2 then
        return set_mario_action(m, ACT_FREEFALL, 0)
    end

    m.forwardVel = clamp(approach_s32(m.forwardVel, 0, 2.4, 2.4), -48, 48)

    common_flight_update(m)

    set_mario_animation(m, MARIO_ANIM_SKID_ON_GROUND)

    m.faceAngle.z = approach_f32(m.faceAngle.z, 0, 0x240, 0x240)

    m.marioObj.header.gfx.angle.x = m.marioObj.header.gfx.angle.x - m.faceAngle.x
    m.marioObj.header.gfx.angle.z = -m.faceAngle.z

    m.marioBodyState.headAngle.x = approach_f32(m.marioBodyState.headAngle.x, 0, 0x4A0, 0x4A0)
    if m.playerIndex == 0 then
        headDir = approach_f32(headDir, 0, 0x4A0, 0x4A0)
        m.marioBodyState.headAngle.y = headDir
    end
    m.marioBodyState.headAngle.z = m.faceAngle.z

    return 0
end

---@param m MarioState
local act_memer_flight_charge = function(m)
    local vDir = get_v_dir_fly(m)
    local e = gMarioStateExtras[m.playerIndex]
    local MAXDASH = 15
    local MINDASH = 2
    local marioAnim = m.marioObj.header.gfx.animInfo

    -- Revving.
    if m.actionTimer == 0 then
        e.dashspeed = 0
        play_king_sfx(m, 1)
    end

    -- Direction changing.
    if (m.input & INPUT_NONZERO_ANALOG) ~= 0 then
        m.faceAngle.y = m.intendedYaw
    end
    m.faceAngle.x = vDir

    -- Dash limit.
    if e.dashspeed < MINDASH then
        e.dashspeed = MINDASH
    elseif e.dashspeed > MAXDASH then
        e.dashspeed = MAXDASH
        m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
        --do_after_image(m)
    end

    if e.dashspeed == 6 or e.dashspeed == 10 or e.dashspeed == 14 then
        play_king_sfx(m, 1)
    end

    -- Animations.
    set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING)
    set_anim_to_frame(m, marioAnim.animFrame + (e.dashspeed / 3.75))
    if marioAnim.animFrame >= marioAnim.curAnim.loopEnd then
        marioAnim.animFrame = marioAnim.animFrame - marioAnim.curAnim.loopEnd
    end

    -- Dash release.
    if (m.controller.buttonDown & B_BUTTON) == 0 then
        mario_set_forward_vel(m, (math.abs(m.forwardVel) + e.dashspeed * 8) * 2)

        play_king_sfx(m, 2)

        set_mario_action(m, ACT_MEMER_FLYING, 0)
    end

    -- Physics 'n stuff.
    m.actionTimer = m.actionTimer + 1
    e.dashspeed = e.dashspeed + 0.5
    mario_set_forward_vel(m, m.forwardVel / 1.1)
    do_big_dust(m)

    -- Flight stuff.
    common_flight_update(m)

    m.faceAngle.z = approach_f32(m.faceAngle.z, 0, 0x240, 0x240)

    m.marioObj.header.gfx.angle.x = (m.marioObj.header.gfx.angle.x - m.faceAngle.x) + (((e.dashspeed - 2) / 13) * 0x2000)
    m.marioObj.header.gfx.angle.z = -m.faceAngle.z
end

hook_mario_action(ACT_MEMER_WATER_IDLE, act_memer_water_idle)
hook_mario_action(ACT_MEMER_SWIMMING, act_memer_swimming)
hook_mario_action(ACT_MEMER_WATER_SKID, act_memer_water_skid)
hook_mario_action(ACT_MEMER_WATER_CHARGE, act_memer_water_charge)
hook_mario_action(ACT_MEMER_WATER_THROW, act_memer_water_throw)

hook_mario_action(ACT_MEMER_FLIGHT_IDLE, act_memer_flight_idle)
hook_mario_action(ACT_MEMER_FLYING, act_memer_flying)
hook_mario_action(ACT_MEMER_FLIGHT_SKID, act_memer_flight_skid)
hook_mario_action(ACT_MEMER_FLIGHT_CHARGE, act_memer_flight_charge)

hook_event(HOOK_MARIO_UPDATE, function(m)
    local e = gMarioStateExtras[m.playerIndex]

    if king == 0 or king == 2 then
        return
    end

    if m.playerIndex == 0 then
        if (m.flags & MARIO_WING_CAP) ~= 0 then
            if m.action == ACT_FLYING then
                set_mario_action(m, ACT_MEMER_FLYING, 0)
            end
            if m.action == ACT_KING_AIRCHARGE then
                set_mario_action(m, ACT_MEMER_FLIGHT_CHARGE, 0)
            end
        end

        if toIdleAction[m.action] then
            set_mario_action(m, ACT_MEMER_WATER_IDLE, 0)
        elseif toSwimAction[m.action] then
            set_mario_action(m, ACT_MEMER_SWIMMING, 0)
        end

        if m.action == ACT_MEMER_FLIGHT_IDLE
        or m.action == ACT_MEMER_FLYING
        or m.action == ACT_MEMER_FLIGHT_SKID
        or m.action == ACT_MEMER_FLIGHT_CHARGE then
            set_camera_mode(m.area.camera, CAMERA_MODE_BEHIND_MARIO, 0)
            if (m.flags & MARIO_WING_CAP) == 0 then
                set_camera_mode(m.area.camera, m.area.camera.defMode, 0)
                set_mario_action(m, ACT_FREEFALL, 0)
            end
        end

        if m.action == ACT_MEMER_WATER_IDLE
        or m.action == ACT_MEMER_SWIMMING
        or m.action == ACT_MEMER_WATER_SKID
        or m.action == ACT_MEMER_WATER_CHARGE
        or m.action == ACT_MEMER_WATER_THROW then
            set_camera_mode(m.area.camera, CAMERA_MODE_BEHIND_MARIO, 0)
        end
    end

    if m.action == ACT_MEMER_FLIGHT_CHARGE or m.action == ACT_MEMER_WATER_CHARGE then
        m.marioObj.header.gfx.scale.x = 1 - (((e.dashspeed - 2) / 13) * 0.1)
        m.marioObj.header.gfx.scale.y = 1 + (((e.dashspeed - 2) / 13) * 0.5)
        m.marioObj.header.gfx.scale.z = 1 - (((e.dashspeed - 2) / 13) * 0.2)
    end

    if obj_has_behavior_id(m.heldObj, id_bhvKoopaShellUnderwater) ~= 0 and m.playerIndex == 0 and m.action ~= ACT_MEMER_WATER_CHARGE then
        shellTimer = shellTimer - 1

        if shellTimer == 60 then
            --fadeout_shell_music() doesnt exist so i replicated what fadeout_cap_music() does but with the shell's sequence id
            fadeout_background_music(SEQ_EVENT_POWERUP | SEQ_VARIATION, 600)
        end

        if shellTimer <= 0 then
            stop_shell_music()
            spawn_mist_particles()
            m.heldObj.oInteractStatus = INT_STATUS_STOP_RIDING
            m.heldObj = nil
        end
    end
end)

hook_event(HOOK_ON_SET_MARIO_ACTION, function(m)
    if king == 0 or king == 2 then
        return
    end

    if m.action == ACT_WATER_PLUNGE then
        m.vel.y = m.vel.y * 0.75
        m.forwardVel = m.forwardVel * 2.2

        m.faceAngle.x = atan2s(m.forwardVel, m.vel.y)
        if m.forwardVel < 0 then
            m.faceAngle.y = m.faceAngle.y + 0x8000
        end
        m.forwardVel = math.abs(m.forwardVel) + math_abs(m.vel.y)
        m.actionTimer = 21
    end

    if m.action == ACT_KING_JUMP or m.action == ACT_HOLD_JUMP then
        vec3f_set(m.marioBodyState.headAngle, 0, 0, 0)
    end
end)