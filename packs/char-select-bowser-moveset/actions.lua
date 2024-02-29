-- free object action ID used for both
ACT_BREATHE_FIRE = (0x1A0 | ACT_FLAG_STATIONARY)
ACT_SHELL_SLIDE = (0x1A0 | ACT_FLAG_MOVING | ACT_FLAG_ATTACKING | ACT_FLAG_SHORT_HITBOX)


---@param m MarioState
function act_breathe_fire_loop(m)
    if m.actionTimer == 0 then
        set_mario_animation(m, CHAR_ANIM_BREAKDANCE)
        m.marioObj.header.gfx.animInfo.animFrame = 0

    elseif m.actionTimer == 5 then
        play_character_sound(m, CHAR_SOUND_GROUND_POUND_WAH)
        play_sound(SOUND_AIR_BOWSER_SPIT_FIRE, m.marioObj.header.gfx.cameraToObject)
        mario_set_forward_vel(m, 0.0)

        if m.playerIndex == 0 then
            local xForward = sins(m.faceAngle.y) * 100.0
            local zForward = coss(m.faceAngle.y) * 100.0
            spawn_sync_object(id_bhvBowserPlayerFireball, E_MODEL_RED_FLAME, m.pos.x + xForward, m.pos.y + 30, m.pos.z + zForward,
                ---@param o Object
                function (o)
                    o.oFaceAngleYaw = m.faceAngle.y
                    o.oMoveAngleYaw = o.oFaceAngleYaw
                    o.oForwardVel = 42.0
                    o.globalPlayerIndex = network_global_index_from_local(m.playerIndex)
            end)
        end

    end

    perform_ground_step(m)

    m.actionTimer = m.actionTimer + 1
    if m.actionTimer >= 16 then
        if m.input & INPUT_NONZERO_ANALOG ~= 0 then
            set_mario_action(m, ACT_WALKING, 0)
        elseif m.input & INPUT_A_PRESSED ~= 0 then
            set_mario_action(m, ACT_JUMP, 0)
        elseif m.input & INPUT_B_PRESSED ~= 0 and m.actionTimer >= 20 then
            set_mario_action(m, ACT_PUNCHING, 0)
        end
    end
    if m.actionTimer >= 25 then
        return set_mario_action(m, ACT_IDLE, 0)
    end

    return 0
end
---@param m MarioState
function act_breathe_fire_gravity(m)
    return
end
hook_mario_action(ACT_BREATHE_FIRE, {every_frame = act_breathe_fire_loop, gravity = act_breathe_fire_gravity})


---@param m MarioState
function act_shell_slide_loop(m)
    if m.actionTimer == 0 then
        set_mario_animation(m, MARIO_ANIM_SLOW_LONGJUMP)
        play_bowser_character_sound(m, BOWS_SOUND_SHELL, 0.5)

        -- 0 is ground, 1 is air, 2 is on water
        m.actionState = 0
        -- ok so that's what this function does
        mario_set_forward_vel(m, math.max(m.forwardVel, 50.0))

    elseif m.actionTimer > 2 then
        if m.actionTimer == 3 then
            -- enter shell
            enable_bowser_shell_model(m)
        end
        -- sound effects and spin anim
        local animSpeed = math.max(10.0, m.forwardVel) / 40.0 * 0x10000
        set_mario_anim_with_accel(m, MARIO_ANIM_FALL_FROM_SLIDE_KICK, animSpeed)
        if is_anim_past_frame(m, 1) ~= 0 or is_anim_past_frame(m, 11) ~= 0 then
            play_sound(SOUND_GENERAL_SWISH_AIR, m.marioObj.header.gfx.cameraToObject)
        end
    end
    -- act as kicking if speed is high enough
    --if m.forwardVel > 40.0 then m.flags = m.flags | MARIO_KICKING end

    -- timer
    m.actionTimer = m.actionTimer + 1

    local forward = coss(m.intendedYaw - m.slideYaw)

    if m.actionState == 0 then
        -- GROUNDED
        -- i love min/max functions
        mario_set_forward_vel(m, math.max(math.min(m.forwardVel, 120.0), math.min(m.forwardVel + math.max(math.min(forward + 1.0, 1.0), 0.1) * 4.0, 65.0)))

        m.intendedMag = 35.0
        update_sliding(m, 10.0)
        m.peakHeight = m.pos.y

        local step = perform_ground_step(m)

        -- sliding sound and particles
        play_sound(SOUND_MOVING_TERRAIN_SLIDE + m.terrainSoundAddend, m.marioObj.header.gfx.cameraToObject)
        adjust_sound_for_speed(m)
        set_mario_particle_flags(m, PARTICLE_DUST, 0)

        -- cancels
        if m.controller.buttonPressed & A_BUTTON ~= 0 then
            -- restrict movement when jumping up a slope
            if abs_angle_diff(m.floorAngle, m.faceAngle.y) > 0x4000 and (m.floor.normal.y < 0.9 or mario_floor_is_slippery(m) ~= 0) then
                mario_set_forward_vel(m, m.forwardVel * 0.75)
            end
            m.actionState = 1
            m.vel.y = 30.0

            play_sound(SOUND_ACTION_BONK, m.marioObj.header.gfx.cameraToObject)
            return 0
        end
        if m.controller.buttonPressed & B_BUTTON ~= 0 and m.actionTimer > 1 then
            return set_mario_action(m, ACT_FORWARD_ROLLOUT, 0)
        end
        if m.controller.buttonPressed & Z_TRIG ~= 0 then
            return set_mario_action(m, ACT_CROUCH_SLIDE, 0)
        end
        if m.forwardVel < 10.0 then
            return set_mario_action(m, ACT_STOP_CROUCHING, 0)
        end

        if m.pos.y <= m.waterLevel then
            m.pos.y = m.waterLevel - 5
            m.actionState = 2
            play_sound(SOUND_OBJ_WALKING_WATER, m.marioObj.header.gfx.cameraToObject)
            return 0
        end

        if step == GROUND_STEP_LEFT_GROUND then
            m.actionState = 1
            m.vel.y = 0
            return 0
        end
        if (step == GROUND_STEP_HIT_WALL and (m.wall ~= nil or gServerSettings.bouncyLevelBounds ~= 1))
        or (m.ceil ~= nil and m.ceilHeight < m.pos.y + 50) then
            mario_bonk_reflection(m, 0)
        end
        -- rotate based on floor normal; down here because this game is silly
        align_with_floor(m)
        --mario_update_quicksand(m, 0.25)
    elseif m.actionState == 1 then
        -- AIR

        update_air_without_turn(m)

        local step = perform_air_step(m, 0)

        -- cancels
        if m.controller.buttonPressed & Z_TRIG ~= 0 then
            return set_mario_action(m, ACT_GROUND_POUND, 0)
        end

        if m.pos.y <= m.waterLevel then
            m.pos.y = m.waterLevel - 5
            m.actionState = 2
            play_sound(SOUND_OBJ_WALKING_WATER, m.marioObj.header.gfx.cameraToObject)
            return 0
        end

        if step == AIR_STEP_LANDED then
            if check_fall_damage_or_get_stuck(m, ACT_HARD_FORWARD_GROUND_KB) == 0 then
                m.actionState = 0
            end
            return 0
        end
        if step == AIR_STEP_HIT_WALL and (m.wall ~= nil or gServerSettings.bouncyLevelBounds ~= 1) then
            mario_bonk_reflection(m, 0)
        end
    else
        -- ON WATER
        mario_set_forward_vel(m, math.max(math.min(m.forwardVel, 120.0), math.min(m.forwardVel + math.max(math.min(forward + 0.8, 1.0), 0.1) * 3.5, 65.0)))

        update_air_with_turn(m)

        local step = perform_air_step(m, 0)
        m.pos.y = m.waterLevel - math.max(60.0 - m.forwardVel * 0.8, 0.0)
        m.vel.y = 0

        play_sound(SOUND_MOVING_TERRAIN_RIDING_SHELL + m.terrainSoundAddend, m.marioObj.header.gfx.cameraToObject)
        adjust_sound_for_speed(m)
        set_mario_particle_flags(m, PARTICLE_SHALLOW_WATER_WAVE, 0)

        -- cancels
        if m.controller.buttonPressed & A_BUTTON ~= 0 then
            m.actionState = 1
            m.vel.y = 25.0
            m.pos.y = m.waterLevel

            play_sound(SOUND_ACTION_BONK, m.marioObj.header.gfx.cameraToObject)
            return 0
        end
        if m.controller.buttonPressed & B_BUTTON ~= 0 and m.actionTimer > 1 then
            return set_mario_action(m, ACT_FORWARD_ROLLOUT, 0)
        end
        if m.controller.buttonPressed & Z_TRIG ~= 0 or m.forwardVel < 25.0 then
            return set_mario_action(m, ACT_CROUCH_SLIDE, 0)
        end

        if step == AIR_STEP_LANDED then
            m.actionState = 0
            return 0
        end
        if step == AIR_STEP_HIT_WALL and (m.wall ~= nil or gServerSettings.bouncyLevelBounds ~= 1)
        or (m.ceil ~= nil and m.ceilHeight < m.pos.y + 50) then
            mario_bonk_reflection(m, 0)
        end
    end

    return 0
end
---@param m MarioState
function act_shell_slide_gravity(m)
    if m.actionState == 1 and m.vel.y > 0.0 and m.controller.buttonDown & A_BUTTON ~= 0 then
        m.vel.y = math.max(m.vel.y - 2.5, -70.0)
    else
        m.vel.y = math.max(m.vel.y - 5.0, -70.0)
    end
end
hook_mario_action(ACT_SHELL_SLIDE, {every_frame = act_shell_slide_loop, gravity = act_shell_slide_gravity}, INT_SLIDE_KICK)