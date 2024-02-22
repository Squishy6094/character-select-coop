_G.ACT_KING_BOUNCE = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR | ACT_FLAG_ATTACKING | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)
_G.ACT_KING_BOUNCE_JUMP = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_MOVING | ACT_FLAG_ATTACKING | ACT_FLAG_AIR | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)
_G.ACT_KING_BOUNCE_LAND = allocate_mario_action(ACT_GROUP_STATIONARY | ACT_FLAG_STATIONARY | ACT_FLAG_ATTACKING)
_G.ACT_KING_AIRCHARGE = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR | ACT_FLAG_INVULNERABLE | ACT_FLAG_ATTACKING)
_G.ACT_KING_GRNDCHARGE = allocate_mario_action(ACT_GROUP_STATIONARY | ACT_FLAG_STATIONARY | ACT_FLAG_INVULNERABLE | ACT_FLAG_ATTACKING)
_G.ACT_KING_ROLL = allocate_mario_action(ACT_GROUP_MOVING | ACT_FLAG_MOVING | ACT_FLAG_ATTACKING | ACT_FLAG_BUTT_OR_STOMACH_SLIDE | ACT_FLAG_SHORT_HITBOX)
_G.ACT_KING_AIRROLL = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_MOVING | ACT_FLAG_ATTACKING | ACT_FLAG_AIR | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)
_G.ACT_KING_JUMP = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_MOVING | ACT_FLAG_ATTACKING | ACT_FLAG_AIR | ACT_FLAG_CONTROL_JUMP_HEIGHT)
_G.ACT_KING_DOUBLE_JUMP = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_MOVING | ACT_FLAG_ATTACKING | ACT_FLAG_AIR | ACT_FLAG_CONTROL_JUMP_HEIGHT)
_G.ACT_KING_WALK = allocate_mario_action(ACT_GROUP_MOVING | ACT_FLAG_MOVING | ACT_FLAG_WATER_OR_TEXT)
_G.ACT_KING_WATER_RUN = allocate_mario_action(ACT_GROUP_MOVING | ACT_FLAG_MOVING | ACT_FLAG_RIDING_SHELL | ACT_FLAG_WATER_OR_TEXT)
_G.ACT_KING_HIT_WALL = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR)
_G.ACT_KING_TWIRLING = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR | ACT_FLAG_ATTACKING | ACT_FLAG_SWIMMING_OR_FLYING)

speedMode = 2/3 + (clamp(kingSpeed, 1, 4) / 3)
local doubleJump = 0
local doubleShellJump = 0
local doubleHoldJump = 0
local skimSpeed = 35
local headDir = 0

function memer_walking_door_check(m)
    --replacin' the walking action while make sure the player can still open doors
    local dist = 150
    local doorwarp = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvDoorWarp)
    local door = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvDoor)
    local stardoor = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvStarDoor)
    if m.action == ACT_WALKING then
        if (dist_between_objects(m.marioObj, doorwarp) > dist and doorwarp ~= nil)
        or (dist_between_objects(m.marioObj, door) > dist and door ~= nil)
        or (dist_between_objects(m.marioObj, stardoor) > dist and stardoor ~= nil) then
            return set_mario_action(m, ACT_KING_WALK, 0)
        elseif doorwarp == nil and door == nil and stardoor == nil then
            return set_mario_action(m, ACT_KING_WALK, 0)
        end
    end

    if m.action == ACT_KING_WALK then
        if ((dist_between_objects(m.marioObj, doorwarp) < dist and doorwarp ~= nil)
        or (dist_between_objects(m.marioObj, door) < dist and door ~= nil)
        or (dist_between_objects(m.marioObj, stardoor) < dist and stardoor ~= nil))
        and (m.input & INPUT_NONZERO_ANALOG) ~= 0 then
            return set_mario_action(m, ACT_WALKING, 0)
        end
    end
end

function king_update(m)
    if m.playerIndex == 0 then
        king_update_local(m)
    end
end

function king_update_local(m)
    local e = gMarioStateExtras[m.playerIndex]

    if king == K_CHAR_KING then
        memer_walking_door_check(m)

        --if m.action == ACT_KING_BOUNCE then
        --    djui_chat_message_create(tostring(ACT_KING_BOUNCE))
        --end
        --if m.action == ACT_KING_BOUNCE_LAND then
        --    djui_chat_message_create(tostring(ACT_KING_BOUNCE_LAND))
        --end

    -- squish squish --

        if m.action == ACT_KING_BOUNCE then
            m.marioObj.header.gfx.scale.x = 1 - clamp(-m.vel.y * 0.005, 0, 0.5)
            m.marioObj.header.gfx.scale.y = 1 + clamp(-m.vel.y * 0.005, 0, 2)
            m.marioObj.header.gfx.scale.z = 1 - clamp(-m.vel.y * 0.005, 0, 0.5)
        end

        if m.action == ACT_CROUCHING or m.action == ACT_KING_BOUNCE_LAND or m.action == ACT_START_CRAWLING or m.action == ACT_CRAWLING or m.action == ACT_STOP_CRAWLING or m.action == ACT_GROUND_POUND_LAND or m.action == ACT_HOLD_JUMP_LAND_STOP then
            m.marioObj.header.gfx.scale.x = 1.25
            m.marioObj.header.gfx.scale.y = 0.75
            m.marioObj.header.gfx.scale.z = 1.25
        end

        if (m.action == ACT_KING_GRNDCHARGE and m.actionArg == 1) or m.action == ACT_KING_AIRCHARGE then
            m.marioObj.header.gfx.scale.x = 1 - (((e.dashspeed - 2) / 13) * 0.1)
            m.marioObj.header.gfx.scale.y = 1 + (((e.dashspeed - 2) / 13) * 0.5)
            m.marioObj.header.gfx.scale.z = 1 - (((e.dashspeed - 2) / 13) * 0.2)
            m.marioObj.header.gfx.angle.x = 0 + (((e.dashspeed - 2) / 13) * 0x2000)
        end

        if m.action == ACT_KING_HIT_WALL then
            m.marioObj.header.gfx.scale.x = 1.25
            m.marioObj.header.gfx.scale.y = 1.25
            m.marioObj.header.gfx.scale.z = 0.75
        end

    -- faster jump landing --

        if m.action == ACT_FREEFALL_LAND_STOP then
            m.actionTimer = m.actionTimer + 1

            m.marioObj.header.gfx.scale.x = 1.25
            m.marioObj.header.gfx.scale.y = 0.75
            m.marioObj.header.gfx.scale.z = 1.25

            if m.actionTimer > 1 then
                set_mario_action(m, ACT_IDLE, 0)
            end
        end

        if m.action == ACT_HOLD_FREEFALL_LAND_STOP then
            m.actionTimer = m.actionTimer + 1

            m.marioObj.header.gfx.scale.x = 1.25
            m.marioObj.header.gfx.scale.y = 0.75
            m.marioObj.header.gfx.scale.z = 1.25

            if m.actionTimer > 1 then
                set_mario_action(m, ACT_HOLD_IDLE, 0)
            end
        end

    -- actions that use the jumpball --

        if m.action == ACT_KING_AIRROLL or m.action == ACT_KING_HIT_WALL or (m.action == ACT_KING_GRNDCHARGE and m.actionArg == 1)
        or m.action == ACT_KING_AIRCHARGE or m.action == ACT_KING_BOUNCE or m.action == ACT_KING_JUMP
        or m.action == ACT_KING_DOUBLE_JUMP or m.action == ACT_KING_BOUNCE_JUMP or m.action == ACT_KING_BOUNCE_LAND
        or m.action == ACT_GROUND_POUND_LAND or m.action == ACT_KING_ROLL or m.action == ACT_MEMER_FLIGHT_CHARGE
        or m.action == ACT_MEMER_WATER_CHARGE then
            e.modelState = 1
        --elseif balls == BALLS then
        --    if m.actionTimer % 2 ~= 0 then
        --        e.modelState = 1
        --    else
        --        e.modelState = 0
        --    end
        else
            e.modelState = 0
        end

        if m.action == ACT_KING_GRNDCHARGE or m.action == ACT_KING_AIRCHARGE then
            do_big_dust(m)
        end

        --if m.forwardVel > 100 * speedMode then
        --    do_after_image(m)
        --end

    -- actions with smooth turning --

        if m.action == ACT_FREEFALL or m.action == ACT_HOLD_JUMP or m.action == ACT_HOLD_FREEFALL or m.action == ACT_HANG_MOVING or m.action == ACT_RIDING_SHELL_GROUND or m.action == ACT_RIDING_SHELL_JUMP or m.action == ACT_RIDING_SHELL_FALL or m.action == ACT_CRAWLING then
            m.faceAngle.y = m.intendedYaw - approach_s32(convert_s16(m.intendedYaw - m.faceAngle.y), 0, 0x1000, 0x1000)
            if m.faceAngle.y ~= m.intendedYaw and m.forwardVel > 32 then
                mario_set_forward_vel(m, approach_f32(m.forwardVel, 0, m.forwardVel/16, m.forwardVel/16))
            else
                mario_set_forward_vel(m, m.forwardVel)
            end
        end

        if m.action == ACT_SHOT_FROM_CANNON or m.action == ACT_WALL_KICK_AIR then
            update_air_with_turn(m)
        end

    -- double jumping --

        if m.action == ACT_FREEFALL or m.action == ACT_RIDING_SHELL_JUMP or m.action == ACT_RIDING_SHELL_FALL or m.action == ACT_HOLD_JUMP or m.action == ACT_HOLD_FREEFALL or m.action == ACT_TOP_OF_POLE_JUMP then
            m.actionTimer = m.actionTimer + 1
            if m.actionTimer > 1 and (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                do_king_double_jump(m)
            end
        end

        if doubleJump == 1 then
            if m.action ~= ACT_KING_DOUBLE_JUMP then
                doubleJump = 0
            end
        end

        if m.action == ACT_RIDING_SHELL_JUMP or m.action == ACT_RIDING_SHELL_FALL then
            if doubleShellJump == 1 then
                m.actionTimer = m.actionTimer + 1
                if m.actionTimer <= 10 then
                    m.marioObj.header.gfx.angle.y = m.marioObj.header.gfx.angle.y + (m.actionTimer * 6553.6)
                end
            end
        end
        if doubleShellJump == 1 then
            if m.action ~= ACT_RIDING_SHELL_JUMP and m.action ~= ACT_RIDING_SHELL_FALL then
                doubleShellJump = 0
            end
        end

        if doubleHoldJump == 1 then
            if m.action ~= ACT_HOLD_JUMP and m.action ~= ACT_HOLD_FREEFALL then
                doubleHoldJump = 0
            end
        end

    -- extra crouch/roll/charge code --

        if m.action == ACT_CROUCHING then
            m.actionTimer = m.actionTimer + 1
            if m.actionTimer > 0 then 
                if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                    do_memer_jump_height(m, m.forwardVel, 50, 1, 1, 2, ACT_KING_JUMP)
                end
                if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
                    do_king_chargup(m)
                end
            end
        end

    -- extra slide code

        if m.action == ACT_BUTT_SLIDE or m.action == ACT_DIVE_SLIDE or m.action == ACT_STOMACH_SLIDE then
            m.actionTimer = m.actionTimer + 1

            if m.actionTimer > 1 then
                if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
                    do_king_chargup(m)
                elseif (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                    do_memer_jump_height(m, m.forwardVel, 50, 1, 1, 2, ACT_KING_JUMP)
                end
            end
            if (m.controller.buttonDown & Z_TRIG) ~= 0 then
                set_mario_action(m, ACT_KING_ROLL, 0)
            end
        end

        if m.action == ACT_FORWARD_ROLLOUT or m.action == ACT_BACKWARD_ROLLOUT then
            if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
                do_king_chargup(m)
            else
                do_memer_jump_height(m, m.forwardVel, 50, 1, 1, 2, ACT_KING_JUMP)
            end
        end

    -- extra tree/pole jump code --

        if m.action == ACT_TOP_OF_POLE_JUMP then
            m.actionTimer = m.actionTimer + 1

            if m.actionTimer > 1 then
                if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
                    set_mario_action(m, ACT_DIVE, 0)
                end
                if (m.controller.buttonPressed & Z_TRIG) ~= 0 then
                    set_mario_action(m, ACT_GROUND_POUND, 0)
                end
            end
        end

    -- visual bullshit --

        if m.action == ACT_KING_WALK or m.action == ACT_KING_WATER_RUN or m.action == ACT_KING_GRNDCHARGE then
            if m.marioObj.header.gfx.animInfo.animID == MARIO_ANIM_RUNNING_UNUSED then
                smlua_anim_util_set_animation(m.marioObj, "KING_RUN_ANIM")
                m.marioBodyState.eyeState = 6
            end
            if m.marioObj.header.gfx.animInfo.animID == MARIO_ANIM_RUNNING then
                smlua_anim_util_set_animation(m.marioObj, "KING_JOG_ANIM")
            end
        end

        if m.action == ACT_END_PEACH_CUTSCENE and m.actionArg >= 9 then --END_PEACH_CUTSCENE_STAR_DANCE
            set_mario_animation(m, MARIO_ANIM_DYING_ON_BACK)
            set_anim_to_frame(m, e.animFrame)
            if e.animFrame == 40 then
                play_mario_heavy_landing_sound(m, SOUND_ACTION_TERRAIN_BODY_HIT_GROUND)
            end
            if e.animFrame >= m.marioObj.header.gfx.animInfo.curAnim.loopEnd then
                e.animFrame = m.marioObj.header.gfx.animInfo.curAnim.loopEnd
            else
                e.animFrame = e.animFrame + 1
            end
            m.marioBodyState.eyeState = 8
        end

    -- metal cant waterrun --

        if (m.flags & MARIO_METAL_CAP) ~= 0 then
            skimSpeed = 999
        else
            skimSpeed = 35
        end

    -- all this for sideways speed :skull:

        --if e.sidewardVel > 0 then
        --    e.sidewardVel = e.sidewardVel - 1
        --elseif e.sidewardVel < 0 then
        --    e.sidewardVel = e.sidewardVel + 1
        --end
        e.sidewardVel = approach_f32(e.sidewardVel, 0, 1, 1)

    -- hitbox

        --if (m.action & ACT_FLAG_SHORT_HITBOX) ~= 0 then
        --    m.marioObj.hitboxHeight = 80
        --else
        --    m.marioObj.hitboxHeight = 100
        --end
    end
end

function mario_on_set_action(m)
    local e = gMarioStateExtras[m.playerIndex]
    if king == K_CHAR_KING then

    -- actions that are set to jump --

        if m.action == ACT_STEEP_JUMP or m.action == ACT_SIDE_FLIP or m.action == ACT_BACKFLIP or m.action == ACT_DOUBLE_JUMP or (m.action == ACT_KING_DOUBLE_JUMP and doubleJump == 0) or m.action == ACT_LONG_JUMP or m.action == ACT_JUMP then
            do_memer_jump_height(m, m.forwardVel, 50, 1, 1, 2, ACT_KING_JUMP)
        end

        if m.action == ACT_VERTICAL_WIND then
            set_mario_action(m, ACT_KING_JUMP, 1)
        end

    -- landing bs --

        if m.action == ACT_JUMP_LAND or m.action == ACT_DOUBLE_JUMP_LAND or m.action == ACT_TRIPLE_JUMP_LAND or m.action == ACT_LONG_JUMP_LAND or m.action == ACT_FREEFALL_LAND or m.action == ACT_AIR_THROW_LAND or m.action == ACT_TWIRL_LAND then
            if (m.controller.buttonDown & Z_TRIG) ~= 0 then
                if m.forwardVel > 0 then
                    return set_mario_action(m, ACT_KING_ROLL, 0)
                else
                    return set_mario_action(m, ACT_CROUCHING, 0)
                end
            else
                if m.forwardVel > 0 then
                    return set_mario_action(m, ACT_KING_WALK, 0)
                else
                    return set_mario_action(m, ACT_FREEFALL_LAND_STOP, 0)
                end
            end
        end

    -- actions that are set to hold land stop --

        if m.action == ACT_HOLD_JUMP_LAND or m.action == ACT_HOLD_FREEFALL_LAND then
            if m.forwardVel > 0 then
                return set_mario_action(m, ACT_HOLD_WALKING, 0)
            else
                return set_mario_action(m, ACT_HOLD_FREEFALL_LAND_STOP, 0)
            end
        end

    -- setting ground pound to bounce --

        if m.action == ACT_GROUND_POUND then
            return set_mario_action(m, ACT_KING_BOUNCE, 0)
        end

    -- fast crouching --

        if m.action == ACT_START_CROUCHING then
            return set_mario_action(m, ACT_CROUCHING, 0)
        end
        if m.action == ACT_STOP_CROUCHING then
            return set_mario_action(m, ACT_IDLE, 0)
        end

    -- instant crawling --

        if m.action == ACT_START_CRAWLING then
            return set_mario_action(m, ACT_CRAWLING, 0)
        end
        if m.action == ACT_STOP_CRAWLING then
            return set_mario_action(m, ACT_CROUCHING, 0)
        end

    -- fast hanging --

        if m.action == ACT_START_HANGING then
            return set_mario_action(m, ACT_HANGING, 0)
        end

    -- actions that are set to rolling/charging --

        if m.action == ACT_CROUCH_SLIDE then
            return set_mario_action(m, ACT_KING_ROLL, 0)
        end

        if m.action == ACT_MOVE_PUNCHING or m.action == ACT_PUNCHING or m.action == ACT_JUMP_KICK or m.action == ACT_DIVE then
            do_king_chargup(m)
        end

    -- king is a strong bith --

        if m.action == ACT_HOLD_HEAVY_IDLE then
            return set_mario_action(m, ACT_HOLD_IDLE, 0)
        end

    -- weak knockback --

        if m.action == ACT_HARD_BACKWARD_GROUND_KB then
            return set_mario_action(m, ACT_BACKWARD_GROUND_KB, 0)
        end
        if m.action == ACT_HARD_FORWARD_GROUND_KB then
            return set_mario_action(m, ACT_FORWARD_GROUND_KB, 0)
        end

    -- prevent from getting stuck on platform --

        if m.action == ACT_KING_JUMP or m.action == ACT_HOLD_JUMP_LAND or m.action == ACT_KING_BOUNCE_JUMP then
            if m.marioObj.platform ~= nil then
                m.pos.y = m.pos.y + 10
            end
        end

    -- slide to freefall --

        if m.action == ACT_BUTT_SLIDE_AIR then
            return set_mario_action(m, ACT_FREEFALL, 1)
        end
        if m.action == ACT_HOLD_BUTT_SLIDE_AIR then
            return set_mario_action(m, ACT_HOLD_FREEFALL, 1)
        end

    -- wall --

        if m.action == ACT_AIR_HIT_WALL then
            return set_mario_action(m, ACT_KING_HIT_WALL, 0)
        end

    -- twirling --

        if m.action == ACT_TWIRLING then
            return set_mario_action(m, ACT_KING_TWIRLING, m.actionArg)
        end
    end
end

function mario_before_phys_step(m)
    local e = gMarioStateExtras[m.playerIndex]

    if king == K_CHAR_KING then

    -- speed --

        if m.forwardVel > 250 then
            mario_set_forward_vel(m, 250)
        end

        if m.action == ACT_KING_ROLL or m.action == ACT_KING_GRNDCHARGE then
            if m.forwardVel < -250 then
                mario_set_forward_vel(m, -250)
            end
        end

    -- slow af actions --

        if m.action == ACT_CRAWLING then
            m.vel.x = m.vel.x * 5
            m.vel.z = m.vel.z * 5
        end

    -- sidewardvel --

        m.vel.x = m.vel.x + e.sidewardVel * sins(m.faceAngle.y + 0x4000)
        m.vel.z = m.vel.z + e.sidewardVel * coss(m.faceAngle.y + 0x4000)

    -- speed modes --

        m.vel.x = m.vel.x / speedMode
        m.vel.z = m.vel.z / speedMode
    end
end

function act_king_bounce_land(m)
    local e = gMarioStateExtras[m.playerIndex]

    m.actionTimer = m.actionTimer + 1

    m.actionState = 1

    set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING)

    if (m.flags & MARIO_METAL_CAP) ~= 0 or m.actionArg == 1 then
        if m.actionTimer > 3 or (m.input & INPUT_OFF_FLOOR) ~= 0 then
            set_camera_shake_from_hit(SHAKE_GROUND_POUND)
            play_king_sfx(m, 6)

            if (m.controller.buttonDown & B_BUTTON) ~= 0 then
                set_mario_action(m, ACT_KING_ROLL, 0)
                if (e.lastforwardVel * 3) > 100 then
                    mario_set_forward_vel(m, e.lastforwardVel * 3)
                else
                    mario_set_forward_vel(m, 100)
                end
                play_king_sfx(m, 2)
            elseif m.specialTripleJump == 1 then
                do_memer_jump_height(m, e.lastforwardVel, 90, 1, 0, 1, ACT_KING_TWIRLING)
                play_character_sound(m, CHAR_SOUND_TWIRL_BOUNCE)
                play_king_sfx(m, 5)
            else
                do_memer_jump_height(m, e.lastforwardVel, 80, 1, 0, 1, ACT_KING_BOUNCE_JUMP)
                play_king_sfx(m, 0)
            end
        end
    else
        if m.actionTimer > 0 or (m.input & INPUT_OFF_FLOOR) ~= 0 then
            if (m.controller.buttonDown & B_BUTTON) ~= 0 then
                set_mario_action(m, ACT_KING_ROLL, 0)
                if (e.lastforwardVel * 2) > 80 then
                    mario_set_forward_vel(m, e.lastforwardVel * 2)
                else
                    mario_set_forward_vel(m, 80)
                end
                play_king_sfx(m, 2)
            elseif m.specialTripleJump == 1 then
                do_memer_jump_height(m, e.lastforwardVel, 70, 1, 0, 1, ACT_KING_TWIRLING)
                play_character_sound(m, CHAR_SOUND_TWIRL_BOUNCE)
                play_king_sfx(m, 5)
            else
                do_memer_jump_height(m, e.lastforwardVel, 60, 1, 0, 1, ACT_KING_BOUNCE_JUMP)
                play_king_sfx(m, 0)
            end
        end
    end

    return 0
end

function memer_update_air(m)
    local sidewaysSpeed = 0
    local dragThreshold = 0
    local intendedDYaw = 0
    local intendedMag = 0

    if (check_horizontal_wind(m)) == 0 then
        dragThreshold = 64

        if (m.input & INPUT_NONZERO_ANALOG) == 0 or (m.action == ACT_KING_AIRROLL and m.actionArg == 1) then
            m.forwardVel = approach_f32(m.forwardVel, 0, 1, 1)
        else
            intendedDYaw = m.intendedYaw - m.faceAngle.y
            intendedMag = m.intendedMag / 32
            m.forwardVel = m.forwardVel + intendedMag * coss(intendedDYaw) * 1.5
            if m.forwardVel > dragThreshold then
                m.forwardVel = m.forwardVel - 1.5
            end
            sidewaysSpeed = intendedMag * sins(intendedDYaw) * dragThreshold
        end

        --! Uncapped air speed. Net positive when moving forward.
        if (m.forwardVel > dragThreshold) then
            m.forwardVel = m.forwardVel - 0.5
        end
        if (m.forwardVel < -32) then
            m.forwardVel = m.forwardVel + 2
        end

        m.slideVelX = m.forwardVel * sins(m.faceAngle.y)
        m.slideVelZ = m.forwardVel * coss(m.faceAngle.y)

        m.slideVelX = m.slideVelX + sidewaysSpeed * sins(m.faceAngle.y + 0x4000)
        m.slideVelZ = m.slideVelZ + sidewaysSpeed * coss(m.faceAngle.y + 0x4000)

        m.vel.x = approach_f32(m.vel.x, m.slideVelX, 1, 1)
        m.vel.z = approach_f32(m.vel.z, m.slideVelZ, 1, 1)
    end
end

function do_king_double_jump(m)
    if m.action == ACT_RIDING_SHELL_JUMP or m.action == ACT_RIDING_SHELL_FALL then
        if doubleShellJump == 0 then
            doubleShellJump = 1
            m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE
            m.vel.y = 40 / speedMode
        end
    elseif m.action == ACT_HOLD_JUMP or m.action == ACT_HOLD_FREEFALL then
        if doubleHoldJump == 0 then
            doubleHoldJump = 1
            m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE
            m.vel.y = 40 / speedMode
        end
    else
        if doubleJump == 0 then
            doubleJump = 1
            m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE
            set_mario_action(m, ACT_KING_DOUBLE_JUMP, 0)
        end
    end
end

function do_king_chargup(m)
    local e = gMarioStateExtras[m.playerIndex]

    e.dashspeed = 0
    play_king_sfx(m, 1)

    if perform_ground_step(m) == GROUND_STEP_LEFT_GROUND then
        return set_mario_action(m, ACT_KING_AIRCHARGE, 0)
    else
        if (m.controller.buttonDown & Z_TRIG) ~= 0 then
            return set_mario_action(m, ACT_KING_GRNDCHARGE, 1)
        else
            return set_mario_action(m, ACT_KING_GRNDCHARGE, 0)
        end
    end
end

function king_common_air_action_step(m, landAction, animation, stepArg, turning, keepMomentum)
    local stepResult = perform_air_step(m, stepArg)

    memer_update_air(m)
    if turning then
        m.faceAngle.y = m.intendedYaw - approach_s32(convert_s16(m.intendedYaw - m.faceAngle.y), 0, 0x1000, 0x1000)
        if m.faceAngle.y ~= m.intendedYaw and m.forwardVel > 32 then
            mario_set_forward_vel(m, approach_f32(m.forwardVel, 0, m.forwardVel/16, m.forwardVel/16))
        else
            mario_set_forward_vel(m, m.forwardVel)
        end
    else
        update_air_with_turn(m)
    end

    if (m.action == ACT_BUBBLED and stepResult == AIR_STEP_HIT_LAVA_WALL) then
        stepResult = AIR_STEP_HIT_WALL
    end

    if stepResult == AIR_STEP_NONE then
        set_mario_animation(m, animation)
    elseif stepResult == AIR_STEP_LANDED then
        m.marioObj.oMarioWalkingPitch = 0x0000
        if (check_fall_damage_or_get_stuck(m, ACT_BACKWARD_GROUND_KB) == 0) then
            if m.forwardVel ~= 0 and keepMomentum then
                if (m.controller.buttonDown & Z_TRIG) ~= 0 then
                    set_mario_action(m, ACT_KING_ROLL, 0)
                    play_mario_landing_sound(m, SOUND_ACTION_TERRAIN_BODY_HIT_GROUND)
                else
                    set_mario_action(m, ACT_KING_WALK, 0)
                    play_mario_landing_sound(m, SOUND_ACTION_TERRAIN_LANDING)
                end
            else
                set_mario_action(m, landAction, 0)
                play_mario_landing_sound(m, SOUND_ACTION_TERRAIN_LANDING)
            end
        end
    elseif stepResult == AIR_STEP_HIT_WALL then
        set_mario_animation(m, animation)

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
    elseif stepResult == AIR_STEP_GRABBED_LEDGE then
        set_mario_animation(m, MARIO_ANIM_IDLE_ON_LEDGE)
        drop_and_set_mario_action(m, ACT_LEDGE_GRAB, 0)
    elseif stepResult == AIR_STEP_GRABBED_CEILING then
        set_mario_action(m, ACT_START_HANGING, 0)
    elseif stepResult == AIR_STEP_HIT_LAVA_WALL then
        lava_boost_on_wall(m)
    end

    return stepResult
end

function act_king_bounce(m)
    local e = gMarioStateExtras[m.playerIndex]

    update_air_with_turn(m)

    m.actionState = 1

    -- landing code --

    e.lastforwardVel = m.forwardVel * 0.85

    if perform_air_step(m, 0) == AIR_STEP_LANDED then
        set_mario_action(m, ACT_KING_BOUNCE_LAND, 0)
        m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE | PARTICLE_HORIZONTAL_STAR
    else

    -- main code --

        if (m.flags & MARIO_METAL_CAP) ~= 0 then
            if (20 * m.actionTimer) > -500 then
                m.vel.y = m.vel.y - (20 * m.actionTimer)
            end
        else
            m.vel.y = -100
        end

        set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING)
        set_anim_to_frame(m, e.animFrame)
        if e.animFrame >= m.marioObj.header.gfx.animInfo.curAnim.loopEnd then
            e.animFrame = e.animFrame - m.marioObj.header.gfx.animInfo.curAnim.loopEnd
        end
        e.animFrame = e.animFrame + 2

        if m.actionTimer < 1 then
            play_character_sound(m, CHAR_SOUND_GROUND_POUND_WAH)
            play_king_sfx(m, 0)
        end

        if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
            set_mario_action(m, ACT_KING_AIRROLL, 0)
            m.vel.y = 10
        end
    end

    m.actionTimer = m.actionTimer + 1

    return 0
end

function act_king_grndcharge(m)
    local e = gMarioStateExtras[m.playerIndex]
    local MAXDASH = 15
    local MINDASH = 2
    local stepResult = perform_ground_step(m)

    -- Revving.
    if stepResult == GROUND_STEP_LEFT_GROUND then
        return set_mario_action(m, ACT_KING_AIRCHARGE, 0)
    end

    -- Direction changing.
    if (m.input & INPUT_NONZERO_ANALOG) ~= 0 then
        m.faceAngle.y = m.intendedYaw
    end

    -- Dash limit.
    if e.dashspeed < MINDASH then
        e.dashspeed = MINDASH
    elseif e.dashspeed > MAXDASH then
        e.dashspeed = MAXDASH
        m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
        --do_after_image(m)
    end

    if m.actionArg == 1 then
        if e.dashspeed == 6 or e.dashspeed == 10 or e.dashspeed == 14 then
            play_king_sfx(m, 1)
        end
    end

    -- Animations.

    if m.actionArg == 1 then
        set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING)
    else
        set_mario_animation(m, MARIO_ANIM_RUNNING_UNUSED)
    end

    set_anim_to_frame(m, e.animFrame)
    if e.animFrame >= m.marioObj.header.gfx.animInfo.curAnim.loopEnd then
        e.animFrame = e.animFrame - m.marioObj.header.gfx.animInfo.curAnim.loopEnd
    end
    if m.actionArg == 0 then
        e.animFrame = e.animFrame + (e.dashspeed * 1.5)
    else
        e.animFrame = e.animFrame + (e.dashspeed / 3.75)
    end

    -- Dash release.
    if (m.controller.buttonDown & B_BUTTON) == 0 then
        if m.actionArg == 1 then
            mario_set_forward_vel(m, (math.abs(m.forwardVel) + e.dashspeed * 8) * 2)
        else
            mario_set_forward_vel(m, (e.dashspeed * 8) * 2)
        end

        play_king_sfx(m, 2)

        if m.actionArg == 1 then
            set_mario_action(m, ACT_KING_ROLL, 0)
        else
            set_mario_action(m, ACT_KING_WALK, 0)
        end
    elseif (m.controller.buttonPressed & A_BUTTON) ~= 0 then
        do_memer_jump_height(m, m.forwardVel, 50, 1, 1, 2, ACT_KING_JUMP)
    end

    -- Physics 'n stuff
    if m.playerIndex == 0 then
        if mario_check_object_grab(m) ~= 0 then
            mario_grab_used_object(m)
            if m.interactObj.behavior == get_behavior_from_id(id_bhvBowser) then
                m.marioBodyState.grabPos = GRAB_POS_BOWSER
                return 1
            elseif m.heldObj.oInteractionSubtype & INT_SUBTYPE_GRABS_MARIO then
                m.marioBodyState.grabPos = GRAB_POS_HEAVY_OBJ
                set_mario_action(m, ACT_HOLD_HEAVY_IDLE, 0)
                return 0
            else
                m.marioBodyState.grabPos = GRAB_POS_LIGHT_OBJ
                set_mario_action(m, ACT_HOLD_IDLE, 0)
                return 1
            end
        end
    end

    if m.actionArg == 0 then
        mario_set_forward_vel(m, m.forwardVel / 1.3)
        e.dashspeed = e.dashspeed + 1.5
    else
        if m.forwardVel < 0 then
            mario_set_forward_vel(m, m.forwardVel / 1.3)
        end
        e.dashspeed = e.dashspeed + 0.5

        if stepResult == GROUND_STEP_NONE then
            apply_slope_decel(m, 0.5)
        elseif stepResult == GROUND_STEP_HIT_WALL then
            queue_rumble_data_mario(m, 5, 40)
            mario_bonk_reflection(m, true)
        end

        if m.pos.y <= m.waterLevel and math.abs(m.forwardVel) > skimSpeed then
            m.pos.y = m.waterLevel
            if math.abs(m.forwardVel) > 96 then
                m.vel.y = 96 / 2
            else
                m.vel.y = math.abs(m.forwardVel) / 2
            end
            set_mario_action(m, ACT_KING_AIRCHARGE, 0)
            play_mario_landing_sound(m, SOUND_ACTION_TERRAIN_LANDING)
        end
    end

    m.actionTimer = m.actionTimer + 1
    return 0
end

function act_king_aircharge(m)
    local e = gMarioStateExtras[m.playerIndex]
    local MAXDASH = 15
    local MINDASH = 2
    local stepResult = perform_air_step(m, 0)
    local ChargeupActionArg

    -- Revving.
    if (m.controller.buttonDown & Z_TRIG) ~= 0 then
        ChargeupActionArg = 1
    else
        ChargeupActionArg = 0
    end

    if stepResult == AIR_STEP_LANDED then
        return set_mario_action(m, ACT_KING_GRNDCHARGE, ChargeupActionArg)
    end

    -- Direction changing.
    if (m.input & INPUT_NONZERO_ANALOG) ~= 0 then
        m.faceAngle.y = m.intendedYaw
    end

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

    set_anim_to_frame(m, e.animFrame)
    if e.animFrame >= m.marioObj.header.gfx.animInfo.curAnim.loopEnd then
        e.animFrame = e.animFrame - m.marioObj.header.gfx.animInfo.curAnim.loopEnd
    end
    e.animFrame = e.animFrame + (e.dashspeed / 3.75)

    -- Dash release.
    if (m.controller.buttonDown & B_BUTTON) == 0 then
        mario_set_forward_vel(m, (math.abs(m.forwardVel) + e.dashspeed * 8) * 2)

        play_king_sfx(m, 2)

        if (m.flags & MARIO_WING_CAP) ~= 0 then
            set_mario_action(m, ACT_FLYING, 1)
        else
            set_mario_action(m, ACT_KING_AIRROLL, 0)
        end
    else
        if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
            set_mario_action(m, ACT_KING_AIRROLL, 0)
        end
        if (m.controller.buttonPressed & Z_TRIG) ~= 0 then
            set_mario_action(m, ACT_KING_BOUNCE, 0)
        end
    end

    -- Physics 'n stuff
    if m.playerIndex == 0 then
        if mario_check_object_grab(m) ~= 0 then
            mario_grab_used_object(m)
            if m.interactObj.behavior == get_behavior_from_id(id_bhvBowser) then
                m.marioBodyState.grabPos = GRAB_POS_BOWSER
                return 1
            elseif m.heldObj.oInteractionSubtype & INT_SUBTYPE_GRABS_MARIO then
                m.marioBodyState.grabPos = GRAB_POS_HEAVY_OBJ
                set_mario_action(m, ACT_HOLD_FREEFALL, 0)
                return 0
            else
                m.marioBodyState.grabPos = GRAB_POS_LIGHT_OBJ
                set_mario_action(m, ACT_HOLD_FREEFALL, 0)
                return 1
            end
        end
    end

    m.actionTimer = m.actionTimer + 1
    e.dashspeed = e.dashspeed + 0.5
    mario_set_forward_vel(m, m.forwardVel / 1.1)
    if m.vel.y <= 0 then
        m.vel.y = 0
    end
    return 0
end

function act_king_roll(m)
    local e = gMarioStateExtras[m.playerIndex]

    if m.actionTimer == 0 then
        e.rotAngle = 0x000
    end

    if (m.input & INPUT_A_PRESSED) ~= 0 then
        do_memer_jump_height(m, m.forwardVel, 50, 1, 1, 2, ACT_KING_JUMP)
        return
    end

    if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
        do_king_chargup(m)
    end

    if (m.controller.buttonDown & Z_TRIG) == 0 then
        set_mario_action(m, ACT_KING_WALK, 0)
    end

    set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING)
    play_sound(SOUND_MOVING_TERRAIN_SLIDE + m.terrainSoundAddend, m.marioObj.header.gfx.cameraToObject)
    adjust_sound_for_speed(m)

    local stepResult = perform_ground_step(m)

    if stepResult == GROUND_STEP_NONE then
        align_with_floor(m)
        m.faceAngle.y = m.intendedYaw - approach_s32(convert_s16(m.intendedYaw - m.faceAngle.y), 0, 0x1000, 0x1000)
        mario_set_forward_vel(m, approach_f32(m.forwardVel, 0, 1, 1))
    elseif stepResult == GROUND_STEP_HIT_WALL then
        queue_rumble_data_mario(m, 5, 40)
        mario_bonk_reflection(m, true)
        m.faceAngle.y = m.faceAngle.y + 0x8000
    end

    update_rolling(m, 5, stepResult, true)

    e.rotAngle = e.rotAngle + (0x60 * math.abs(m.forwardVel / speedMode))
    if e.rotAngle > 0x9000 then
        e.rotAngle = e.rotAngle - 0x9000
    end
    if m.forwardVel < 0 then
        set_anim_to_frame(m, 10 - (10 * e.rotAngle / 0x9000))
    else
        set_anim_to_frame(m, 10 * e.rotAngle / 0x9000)
    end

    if m.pos.y <= m.waterLevel and math.abs(m.forwardVel) > skimSpeed then
        m.pos.y = m.waterLevel
        if math.abs(m.forwardVel) > 96 then
            m.vel.y = 96 / 2 / speedMode
        else
            m.vel.y = math.abs(m.forwardVel) / 2 / speedMode
        end
        set_mario_action(m, ACT_KING_AIRROLL, 1)
        play_mario_landing_sound(m, SOUND_ACTION_TERRAIN_LANDING)
    end

    m.actionTimer = m.actionTimer + 1
    return 0
end

function act_king_airroll(m)
    local e = gMarioStateExtras[m.playerIndex]
    local spinSpeed = 0

    if m.actionTimer == 0 then
        e.rotAngle = 0x000
    end

    if m.actionArg == 1 then
        local stepResult = king_common_air_action_step(m, ACT_FREEFALL_LAND_STOP, MARIO_ANIM_FORWARD_SPINNING, AIR_STEP_CHECK_LEDGE_GRAB | AIR_STEP_CHECK_HANG, false, true)

        if m.actionTimer > 0 then
            if (m.controller.buttonPressed & Z_TRIG) ~= 0 then
                return set_mario_action(m, ACT_KING_BOUNCE, 0)
            end
            if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
                return do_king_chargup(m)
            end
        end
    else
        m.particleFlags = m.particleFlags | PARTICLE_DUST
        local stepResult = king_common_air_action_step(m, ACT_FREEFALL_LAND_STOP, MARIO_ANIM_FORWARD_SPINNING, AIR_STEP_CHECK_LEDGE_GRAB | AIR_STEP_CHECK_HANG, true, true)

        if m.actionTimer > 0 and m.vel.y < 0 then
            if (m.controller.buttonPressed & Z_TRIG) ~= 0 then
                return set_mario_action(m, ACT_KING_BOUNCE, 0)
            end
        end
    end

    if m.forwardVel > 50 then
        spinSpeed = m.forwardVel / speedMode
    else
        spinSpeed = 50 / speedMode
    end

    e.rotAngle = e.rotAngle + (0x60 * math.abs(spinSpeed))
    if e.rotAngle > 0x9000 then
        e.rotAngle = e.rotAngle - 0x9000
    end
    if spinSpeed < 0 then
        set_anim_to_frame(m, 10 - (10 * e.rotAngle / 0x9000))
    else
        set_anim_to_frame(m, 10 * e.rotAngle / 0x9000)
    end

    if (m.controller.buttonDown & Z_TRIG) ~= 0 then
        if m.pos.y <= m.waterLevel and math.abs(m.forwardVel) > skimSpeed then
            m.actionArg = 1
            m.pos.y = m.waterLevel
            m.vel.y = -m.vel.y * 0.5 / speedMode
            play_mario_landing_sound(m, SOUND_ACTION_TERRAIN_LANDING)
        end
    end

    m.actionTimer = m.actionTimer + 1
end

function act_king_jump(m)
    local e = gMarioStateExtras[m.playerIndex]
    local spinSpeed = 0

    if m.actionTimer == 0 then
        e.rotAngle = 0x000
        if m.actionArg == 0 then
            play_character_sound_if_no_flag(m, CHAR_SOUND_YAH_WAH_HOO, MARIO_ACTION_SOUND_PLAYED)
            play_king_sfx(m, 4)
        end
    end

    local stepResult = king_common_air_action_step(m, ACT_FREEFALL_LAND_STOP, MARIO_ANIM_FORWARD_SPINNING, AIR_STEP_CHECK_LEDGE_GRAB | AIR_STEP_CHECK_HANG, true, true)

    if m.actionTimer > 0 then
        if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
            do_king_chargup(m)
        end
        if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
            return do_king_double_jump(m)
        end
        if (m.controller.buttonPressed & Z_TRIG) ~= 0 then
            return set_mario_action(m, ACT_KING_BOUNCE, 0)
        end
    end

    if m.forwardVel > 50 then
        spinSpeed = m.forwardVel / speedMode
    else
        spinSpeed = 50 / speedMode
    end

    e.rotAngle = e.rotAngle + (0x60 * math.abs(spinSpeed))
    if e.rotAngle > 0x9000 then
        e.rotAngle = e.rotAngle - 0x9000
    end
    if spinSpeed < 0 then
        set_anim_to_frame(m, 10 - (10 * e.rotAngle / 0x9000))
    else
        set_anim_to_frame(m, 10 * e.rotAngle / 0x9000)
    end

    if (m.controller.buttonDown & Z_TRIG) ~= 0 then
        if m.pos.y <= m.waterLevel and math.abs(m.forwardVel) > skimSpeed then
            m.pos.y = m.waterLevel
            set_mario_action(m, ACT_KING_AIRROLL, 1)
        end
    end

    m.actionTimer = m.actionTimer + 1
end

function act_king_double_jump(m)
    local e = gMarioStateExtras[m.playerIndex]
    local spinSpeed = 0

    if m.actionTimer == 0 then
        e.rotAngle = 0x000
        play_character_sound_if_no_flag(m, CHAR_SOUND_HOOHOO, MARIO_ACTION_SOUND_PLAYED)
        play_king_sfx(m, 3)
        m.vel.y = 40 / speedMode
    end

    local stepResult = king_common_air_action_step(m, ACT_FREEFALL_LAND_STOP, MARIO_ANIM_FORWARD_SPINNING, AIR_STEP_CHECK_LEDGE_GRAB | AIR_STEP_CHECK_HANG, true, true)

    if m.actionTimer > 0 then
        if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
            do_king_chargup(m)
        end
        if (m.controller.buttonPressed & Z_TRIG) ~= 0 then
            return set_mario_action(m, ACT_KING_BOUNCE, 0)
        end
    end

    if m.forwardVel > 50 then
        spinSpeed = m.forwardVel / speedMode
    else
        spinSpeed = 50 / speedMode
    end

    e.rotAngle = e.rotAngle + (0x60 * math.abs(spinSpeed))
    if e.rotAngle > 0x9000 then
        e.rotAngle = e.rotAngle - 0x9000
    end
    if spinSpeed < 0 then
        set_anim_to_frame(m, 10 - (10 * e.rotAngle / 0x9000))
    else
        set_anim_to_frame(m, 10 * e.rotAngle / 0x9000)
    end

    if (m.controller.buttonDown & Z_TRIG) ~= 0 then
        if m.pos.y <= m.waterLevel and math.abs(m.forwardVel) > skimSpeed then
            m.pos.y = m.waterLevel
            set_mario_action(m, ACT_KING_AIRROLL, 1)
        end
    end

    m.actionTimer = m.actionTimer + 1
end

function act_king_bounce_jump(m)
    local e = gMarioStateExtras[m.playerIndex]
    local spinSpeed = 0

    if m.actionTimer == 0 then
        e.rotAngle = 0x000
    end

    if m.actionTimer == 0 then
        play_character_sound_if_no_flag(m, CHAR_SOUND_YAHOO_WAHA_YIPPEE, MARIO_ACTION_SOUND_PLAYED)
    end

    local stepResult = king_common_air_action_step(m, ACT_FREEFALL_LAND_STOP, MARIO_ANIM_FORWARD_SPINNING, AIR_STEP_CHECK_LEDGE_GRAB | AIR_STEP_CHECK_HANG, true, true)

    if m.actionTimer > 0 then
        if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
            do_king_chargup(m)
        end
        if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
            return do_king_double_jump(m)
        end
        if (m.controller.buttonPressed & Z_TRIG) ~= 0 then
            return set_mario_action(m, ACT_KING_BOUNCE, 0)
        end
    end

    if m.forwardVel > 50 then
        spinSpeed = m.forwardVel / speedMode
    else
        spinSpeed = 50 / speedMode
    end

    if (m.input & INPUT_Z_DOWN) == 0 and m.vel.y > 20 then
        m.vel.y = m.vel.y / 1.3
    end

    e.rotAngle = e.rotAngle + (0x60 * math.abs(spinSpeed))
    if e.rotAngle > 0x9000 then
        e.rotAngle = e.rotAngle - 0x9000
    end
    if spinSpeed < 0 then
        set_anim_to_frame(m, 10 - (10 * e.rotAngle / 0x9000))
    else
        set_anim_to_frame(m, 10 * e.rotAngle / 0x9000)
    end

    if (m.controller.buttonDown & Z_TRIG) ~= 0 then
        if m.pos.y <= m.waterLevel and math.abs(m.forwardVel) > skimSpeed then
            m.pos.y = m.waterLevel
            set_mario_action(m, ACT_KING_AIRROLL, 1)
        end
    end

    m.actionTimer = m.actionTimer + 1
end

function memer_anim_and_audio_for_walk(m)
    local e = gMarioStateExtras[m.playerIndex]
    local val14 = 0
    local val0C = true
    local val04 = 4.0

    if m.forwardVel > 2 then
        val04 = math.abs(m.forwardVel)
    else
        val04 = 5
    end

    if val14 < 4 then
        val14 = 4
    end

    if m.action ~= ACT_KING_WATER_RUN then
        if m.actionTimer == 4 then
            if m.flags & MARIO_WING_CAP == 0 then
                align_with_floor(m)
            end
        else
            align_with_floor(m)
        end
    end

    if (m.quicksandDepth > 50.0) then
        val14 = (val04 / 4.0 * 0x10000) / speedMode
        set_mario_anim_with_accel(m, MARIO_ANIM_MOVE_IN_QUICKSAND, val14)
        play_step_sound(m, 19, 93)
        m.actionTimer = 0
    else
        if val0C == true then
            if m.actionTimer == 0 then
                set_mario_animation(m, MARIO_ANIM_START_TIPTOE)
                play_step_sound(m, 7, 22)
                if is_anim_past_frame(m, 23) or val04 > 8 then
                    m.actionTimer = 2
                end

                val0C = false
            elseif m.actionTimer == 1 then
                set_mario_animation(m, MARIO_ANIM_TIPTOE)
                play_step_sound(m, 14, 72)
                if val04 > 8 then
                    m.actionTimer = 2
                end

                val0C = false
            elseif m.actionTimer == 2 then
                val14 = (val04 / 4.0 * 0x10000) / speedMode
                set_mario_anim_with_accel(m, MARIO_ANIM_WALKING, val14)
                play_step_sound(m, 10, 49)
                if val04 < 7 then
                    m.actionTimer = 1
                elseif val04 > 20 then
                    m.actionTimer = 3
                end

                val0C = false
            elseif m.actionTimer == 3 then
                val14 = (val04 / 4.0 * 0x10000) / speedMode
                set_mario_anim_with_accel(m, MARIO_ANIM_RUNNING, val14)
                play_step_sound(m, 11, 45)
                if val04 < 19 then
                    m.actionTimer = 2
                elseif val04 > 40 then
                    m.actionTimer = 4
                end

                val0C = false
            elseif m.actionTimer == 4 then
                if m.flags & MARIO_WING_CAP ~= 0 then
                    set_mario_anim_with_accel(m, MARIO_ANIM_WING_CAP_FLY, 40)
                    m.marioBodyState.handState = 1
                    m.marioObj.header.gfx.pos.y = m.marioObj.header.gfx.pos.y + 50
                    m.marioObj.oMarioWalkingPitch = convert_s16(approach_s32(m.marioObj.oMarioWalkingPitch, find_floor_slope(m, 0x8000), 0x800, 0x800))
                    m.marioObj.header.gfx.angle.x = m.marioObj.oMarioWalkingPitch
                    play_sound(SOUND_MOVING_FLYING, m.marioObj.header.gfx.cameraToObject)
                    adjust_sound_for_speed(m)
                else
                    val14 = (val04 / 4.0 * 0x10000) / speedMode
                    set_mario_anim_with_accel(m, MARIO_ANIM_RUNNING_UNUSED, val14)
                    play_step_sound_with_dust(m, 11, 45)
                end
                if val04 < 39 then
                    m.actionTimer = 3
                end

                val0C = false
            end
        end
    end
end

function update_memer_walking_speed(m, slopeAccel)
    local maxTargetSpeed = 0
    local targetSpeed = 0

    maxTargetSpeed = 64

    if m.intendedMag * 2 < 64 then
        targetSpeed = m.intendedMag * 2
    else
        targetSpeed = maxTargetSpeed
    end

    if (m.quicksandDepth > 10.0) then
        targetSpeed = targetSpeed * (6.25 / m.quicksandDepth)
    end

    if (m.forwardVel <= 0) then
        m.forwardVel = m.forwardVel + 2
    elseif (m.forwardVel <= targetSpeed) then
        m.forwardVel = m.forwardVel + (2 - m.forwardVel / targetSpeed)
    elseif (m.forwardVel > targetSpeed) then
        m.forwardVel = m.forwardVel - 0.5
    end

    m.faceAngle.y = m.intendedYaw - approach_s32(convert_s16(m.intendedYaw - m.faceAngle.y), 0, 0xA00, 0xA00)

    if slopeAccel == true then
        --king_slope_accel(m)
        --apply_slope_accel(m)
        apply_slope_decel(m, 0)
    end

    if m.playerIndex == 0 then
        m.marioBodyState.headAngle.z = approach_f32(m.marioBodyState.headAngle.z, clamp(convert_s16(m.intendedYaw - m.faceAngle.y), -0x6A0, 0x6A0), 0x260, 0x260)
        headDir = approach_f32(headDir, clamp(convert_s16(m.intendedYaw - m.faceAngle.y), -0x2400, 0x2400), 0x6A0, 0x6A0)
        m.marioBodyState.headAngle.y = headDir
        m.marioBodyState.headAngle.x = 0
    end
end

function act_king_walk(m)
    local e = gMarioStateExtras[m.playerIndex]

    m.actionState = 0
    update_memer_walking_speed(m, true)
    local stepResult = perform_ground_step(m)

    if stepResult == GROUND_STEP_NONE then
        memer_anim_and_audio_for_walk(m)
		m.vel.x = sins(m.faceAngle.y) * m.forwardVel
		m.vel.z = coss(m.faceAngle.y) * m.forwardVel
    elseif stepResult == GROUND_STEP_HIT_WALL then
        push_or_sidle_wall(m, m.pos)
        m.actionTimer = 0
    elseif stepResult == GROUND_STEP_LEFT_GROUND then
        set_mario_animation(m, MARIO_ANIM_GENERAL_FALL)
    end

    do_memer_slope_speed(m, ACT_FREEFALL)

    check_ledge_climb_down(m)

    if should_begin_sliding(m) ~= 0 and m.forwardVel <= 0 then
        return set_mario_action(m, ACT_BEGIN_SLIDING, 0)
    end

    if (m.controller.buttonDown & Z_TRIG) ~= 0 then
        return set_mario_action(m, ACT_KING_ROLL, 0)
    end

    if (m.input & INPUT_FIRST_PERSON) ~= 0 then
        return begin_braking_action(m)
    end

    if (m.input & INPUT_A_PRESSED) ~= 0 then
        do_memer_jump_height(m, m.forwardVel, 50, 1, 1, 2, ACT_KING_JUMP)
    end

    if (m.input & INPUT_B_PRESSED) ~= 0 then
        do_king_chargup(m)
    end

    if (m.input & INPUT_ZERO_MOVEMENT) ~= 0 then
        mario_set_forward_vel(m, approach_f32(m.forwardVel, 0, 3, 3))
        if ((math.abs(m.forwardVel) * math.abs(m.forwardVel)) < (2 * 2)) then
            set_mario_action(m, ACT_IDLE, 0)
            mario_set_forward_vel(m, 0)
        end
    end

    if analog_stick_held_back(m) ~= 0 then
        m.faceAngle.y = m.intendedYaw + 0x8000
        return set_mario_action(m, ACT_TURNING_AROUND, 0)
    end

    if m.pos.y <= m.waterLevel then
		if math.abs(m.forwardVel) > skimSpeed then
            m.pos.y = m.waterLevel
			return set_mario_action(m, ACT_KING_WATER_RUN, 0)
		end
    end

    return 0
end

function act_king_water_run(m)
    local e = gMarioStateExtras[m.playerIndex]

    m.actionState = 0
    update_memer_walking_speed(m, false)
    local stepResult = perform_ground_step(m)

    if stepResult == GROUND_STEP_LEFT_GROUND then
        set_mario_action(m, ACT_FREEFALL, 0)
        set_mario_animation(m, MARIO_ANIM_GENERAL_FALL)
    elseif stepResult == GROUND_STEP_NONE then
        memer_anim_and_audio_for_walk(m)
        m.marioObj.header.gfx.angle.x = 0

		-- Double checks, since it refuses t' work well on water.
		m.vel.x = sins(m.faceAngle.y) * m.forwardVel
		m.vel.z = coss(m.faceAngle.y) * m.forwardVel
    elseif stepResult == GROUND_STEP_HIT_WALL then
        queue_rumble_data_mario(m, 5, 40)
        mario_bonk_reflection(m, false)
        m.faceAngle.y = m.faceAngle.y + 0x8000
        mario_set_forward_vel(m, -16.0)

        m.particleFlags = m.particleFlags | PARTICLE_VERTICAL_STAR
        return set_mario_action(m, ACT_SOFT_BONK, 0)
    end

    check_ledge_climb_down(m)

    if m.pos.y <= m.waterLevel then
        if (m.controller.buttonDown & Z_TRIG) ~= 0 then
            m.pos.y = m.waterLevel
            if math.abs(m.forwardVel) > 96 then
                m.vel.y = 96 / 2
            else
                m.vel.y = math.abs(m.forwardVel) / 2
            end
            set_mario_action(m, ACT_KING_AIRROLL, 1)
            play_mario_landing_sound(m, SOUND_ACTION_TERRAIN_LANDING)
        end

        if (m.input & INPUT_A_PRESSED) ~= 0 then
            set_mario_y_vel_based_on_fspeed(m, 50 / speedMode, 0.1)
            set_mario_action(m, ACT_KING_JUMP, 0)
        end

        if (m.input & INPUT_B_PRESSED) ~= 0 then
            do_king_chargup(m)
        end

        if (m.input & INPUT_ZERO_MOVEMENT) ~= 0 then
            mario_set_forward_vel(m, approach_f32(m.forwardVel, 0, 3, 3))
            if math.abs(m.forwardVel) < skimSpeed then
                return set_mario_action(m, ACT_FREEFALL, 0)
            end
        end

        if (m.flags & MARIO_METAL_CAP) ~= 0 then
            return set_mario_action(m, ACT_FREEFALL, 0)
        end

        if analog_stick_held_back(m) ~= 0 then
            return set_mario_action(m, ACT_FREEFALL, 0)
        end

        m.floorHeight = m.waterLevel
        m.floor = get_water_surface_pseudo_floor()
        m.floor.originOffset = m.waterLevel -- Negative origin offset

        set_mario_particle_flags(m, PARTICLE_IDLE_WATER_WAVE | PARTICLE_WAVE_TRAIL | PARTICLE_SHALLOW_WATER_SPLASH, false)
    else
        return set_mario_action(m, ACT_KING_WALK, 0)
    end

    return 0
end

function on_interact(m, o, intType)
    if m.action == ACT_KING_GRNDCHARGE or m.action == ACT_KING_AIRCHARGE then
        if (intType & (INTERACT_GRABBABLE) ~= 0) and o.oInteractionSubtype & (INT_SUBTYPE_NOT_GRABBABLE) == 0 then
            m.interactObj = o
            m.input = m.input | INPUT_INTERACT_OBJ_GRABBABLE
            if o.oSyncID ~= 0 then
                network_send_object(o, true)
            end
        end
    end
end

function act_king_hit_wall(m)
    if (m.heldObj ~= nil) then
        mario_drop_held_object(m)
    end

    if m.actionArg ~= 1 and m.actionTimer < 5 then
        if (m.input & INPUT_A_PRESSED) ~= 0 then
            m.faceAngle.y = m.faceAngle.y + 0x8000
            set_mario_action(m, ACT_WALL_KICK_AIR, 0)
            if m.vel.y < 40 then
                m.vel.y = 40
            end
            return
        end
    else
        m.faceAngle.y = m.faceAngle.y + 0x8000
        return set_mario_action(m, ACT_KING_AIRROLL, 1)
    end

    set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING)
    if m.wall ~= nil then
        m.marioObj.header.gfx.angle.y = atan2s(m.wall.normal.z, m.wall.normal.x)
    else
        m.marioObj.header.gfx.angle.y = m.faceAngle.y
    end

    m.actionTimer = m.actionTimer + 1
    return 0
end

function apply_twirl_gravity(m)
    local terminalVelocity
    local heaviness = 1

    if m.angleVel.y > 1024 then
        heaviness = 1024 / m.angleVel.y
    end

    terminalVelocity = -75 * heaviness

    m.vel.y = m.vel.y - 4 * heaviness
    if m.vel.y < terminalVelocity then
        m.vel.y = terminalVelocity
    end
end

function update_memer_twirling(m)
    local intendedDYaw
    local intendedMag

    if (m.input & INPUT_NONZERO_ANALOG) ~= 0 then
        intendedDYaw = m.intendedYaw - m.faceAngle.y
        intendedMag = m.intendedMag / 32

        m.forwardVel = m.forwardVel + coss(intendedDYaw) * intendedMag
        m.faceAngle.y = m.faceAngle.y + sins(intendedDYaw) * intendedMag * 2048
    else
        m.forwardVel = approach_f32(m.forwardVel, 0, 1, 1)
    end

    if m.forwardVel < 0 then
        m.faceAngle.y = m.faceAngle.y + 0x8000
        m.forwardVel = m.forwardVel * -1
    end

    if m.forwardVel > 64 then
        m.forwardVel = m.forwardVel - 2
    end

    if m.vel.y < 0 then
        apply_twirl_gravity(m)
    end

    m.slideVelX = m.forwardVel * sins(m.faceAngle.y)
    m.slideVelZ = m.forwardVel * coss(m.faceAngle.y)
    m.vel.x = m.slideVelX
    m.vel.z = m.slideVelZ
end

function act_king_twirling(m)
    local startTwirlYaw = m.twirlYaw
    local yawVelTarget = 0x2000

    m.angleVel.y = approach_s32(m.angleVel.y, yawVelTarget, 0x200, 0x200)
    m.twirlYaw = m.twirlYaw + m.angleVel.y

    if m.actionArg == 0 then
        set_mario_animation(m, MARIO_ANIM_START_TWIRL)
    else
        set_mario_animation(m, MARIO_ANIM_TWIRL)
    end
    if is_anim_past_end(m) then
        m.actionArg = 1
    end

    if startTwirlYaw > m.twirlYaw then
        play_sound(SOUND_ACTION_TWIRL, m.marioObj.header.gfx.cameraToObject)
    end

    update_memer_twirling(m)

    local case = perform_air_step(m, 0)
    if case == AIR_STEP_LANDED then
        set_mario_action(m, ACT_TWIRL_LAND, 0)
    elseif case == AIR_STEP_HIT_WALL then
        mario_bonk_reflection(m, false)
    elseif case == AIR_STEP_HIT_LAVA_WALL then
        lava_boost_on_wall(m)
    end

    if m.prevAction == ACT_KING_BOUNCE_LAND and m.specialTripleJump == 1 then
        m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
    end

    if m.actionTimer > 0 then
        if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
            do_king_chargup(m)
        end
        if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
            return do_king_double_jump(m)
        end
        if (m.controller.buttonPressed & Z_TRIG) ~= 0 then
            return set_mario_action(m, ACT_KING_BOUNCE, 0)
        end
    end

    m.actionTimer = 1

    m.marioObj.header.gfx.angle.y = m.marioObj.header.gfx.angle.y + m.twirlYaw
    return false
end

-----------
-- hooks --
-----------

hook_event(HOOK_MARIO_UPDATE, king_update)
hook_event(HOOK_ON_SET_MARIO_ACTION, mario_on_set_action)
hook_event(HOOK_BEFORE_PHYS_STEP, mario_before_phys_step)
hook_event(HOOK_ALLOW_INTERACT, on_interact)

hook_mario_action(ACT_KING_BOUNCE, act_king_bounce, INT_GROUND_POUND_OR_TWIRL)
hook_mario_action(ACT_KING_BOUNCE_LAND, act_king_bounce_land, INT_GROUND_POUND_OR_TWIRL)
hook_mario_action(ACT_KING_BOUNCE_JUMP, act_king_bounce_jump)
hook_mario_action(ACT_KING_GRNDCHARGE, act_king_grndcharge, INT_PUNCH)
hook_mario_action(ACT_KING_AIRCHARGE, act_king_aircharge, INT_PUNCH)
hook_mario_action(ACT_KING_ROLL, act_king_roll, INT_FAST_ATTACK_OR_SHELL)
hook_mario_action(ACT_KING_AIRROLL, act_king_airroll, INT_FAST_ATTACK_OR_SHELL)
hook_mario_action(ACT_KING_JUMP, act_king_jump)
hook_mario_action(ACT_KING_DOUBLE_JUMP, act_king_double_jump)
hook_mario_action(ACT_KING_WALK, act_king_walk)
hook_mario_action(ACT_KING_WATER_RUN, act_king_water_run)
hook_mario_action(ACT_KING_HIT_WALL, act_king_hit_wall)
hook_mario_action(ACT_KING_TWIRLING, act_king_twirling, INT_GROUND_POUND_OR_TWIRL)