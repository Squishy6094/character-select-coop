_G.ACT_OLD_BOUNCE = allocate_mario_action(ACT_GROUP_AIRBORNE | ACT_FLAG_AIR | ACT_FLAG_ATTACKING | ACT_FLAG_ALLOW_VERTICAL_WIND_ACTION)
_G.ACT_OLD_ROLLDASH = allocate_mario_action(ACT_GROUP_MOVING | ACT_FLAG_MOVING | ACT_FLAG_ATTACKING | ACT_FLAG_BUTT_OR_STOMACH_SLIDE)
_G.ACT_OLD_ROLL = allocate_mario_action(ACT_GROUP_MOVING | ACT_FLAG_MOVING | ACT_FLAG_ATTACKING | ACT_FLAG_BUTT_OR_STOMACH_SLIDE | ACT_FLAG_SHORT_HITBOX)

local doubleJump = 0
local doubleShellJump = 0
local doubleHoldJump = 0
local doubleBurnJump = 0
local specialBounce = 0
local hasJumpSoundPlayed = 0
local hasDiveSoundPlayed = 0
local hasPunch1SoundPlayed = 0
local hasPunch2SoundPlayed = 0

---------------
-- main code --
---------------

function old_update(m)
    if m.playerIndex == 0 then
        old_update_local(m)
    end
end

function old_update_local(m)
    local e = gMarioStateExtras[m.playerIndex]

    if king == K_CHAR_OLD then

    -- animations --

        if m.action == ACT_SHOT_FROM_CANNON or m.action == ACT_JUMP or (m.action == ACT_DOUBLE_JUMP and (m.flags & MARIO_WING_CAP) == 0) or m.action == ACT_TRIPLE_JUMP or m.action == ACT_TOP_OF_POLE_JUMP or m.action == ACT_METAL_WATER_JUMP or m.action == ACT_WATER_JUMP or m.action == ACT_BURNING_JUMP or m.action == ACT_LONG_JUMP then
            set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING)
            set_anim_to_frame(m, e.animFrame)
            if e.animFrame >= m.marioObj.header.gfx.animInfo.curAnim.loopEnd then
                e.animFrame = e.animFrame - m.marioObj.header.gfx.animInfo.curAnim.loopEnd
            end
            e.animFrame = e.animFrame + 2
        end
        
        if m.action == ACT_WALKING then
            if (m.flags & MARIO_WING_CAP) ~= 0 and m.forwardVel >= 30 then
                set_mario_animation(m, MARIO_ANIM_WING_CAP_FLY)
                set_anim_to_frame(m, e.animFrame)
                    if e.animFrame >= m.marioObj.header.gfx.animInfo.curAnim.loopEnd then
                    e.animFrame = e.animFrame - m.marioObj.header.gfx.animInfo.curAnim.loopEnd
                end
                e.animFrame = e.animFrame + 2
                m.marioBodyState.handState = 1
                m.marioBodyState.torsoAngle.x = 0
                m.marioObj.header.gfx.pos.y = m.marioObj.header.gfx.pos.y + 50
            else
                m.marioBodyState.torsoAngle.y = m.marioBodyState.torsoAngle.y * 4
                m.marioBodyState.torsoAngle.z = 0
            end
        end

    -- squish squish --

        if m.action == ACT_OLD_BOUNCE then
            m.marioObj.header.gfx.scale.x = 0.5
            m.marioObj.header.gfx.scale.y = 1.5
            m.marioObj.header.gfx.scale.z = 0.5
        end

        if m.action == ACT_CROUCHING or m.action == ACT_START_CRAWLING or m.action == ACT_CRAWLING or m.action == ACT_STOP_CRAWLING or m.action == ACT_GROUND_POUND_LAND or m.action == ACT_HOLD_JUMP_LAND_STOP then
            m.marioObj.header.gfx.scale.x = 1.5
            m.marioObj.header.gfx.scale.y = 0.5
            m.marioObj.header.gfx.scale.z = 1.5
        end

        if m.action == ACT_OLD_ROLLDASH then
            m.marioObj.header.gfx.scale.y = 1.2
            m.marioObj.header.gfx.scale.z = 0.8
            m.marioObj.header.gfx.angle.x = 0x2000
        end

    -- actions that use the jumpball --

        if m.action == ACT_SHOT_FROM_CANNON or m.action == ACT_OLD_BOUNCE or m.action == ACT_TOP_OF_POLE_JUMP or m.action == ACT_JUMP or m.action == ACT_TRIPLE_JUMP or m.action == ACT_GROUND_POUND_LAND or m.action == ACT_OLD_ROLL or m.action == ACT_WATER_JUMP or m.action == ACT_METAL_WATER_JUMP or m.action == ACT_BURNING_JUMP or m.action == ACT_OLD_ROLLDASH or m.action == ACT_LONG_JUMP then
            e.modelState = 1
        else
            e.modelState = 0
        end

    -- actions with smooth turning --

        if m.action == ACT_HANG_MOVING or m.action == ACT_WALKING or m.action == ACT_MOVE_PUNCHING or m.action == ACT_TOP_OF_POLE_JUMP or m.action == ACT_CRAWLING or m.action == ACT_JUMP or m.action == ACT_DOUBLE_JUMP or m.action == ACT_TRIPLE_JUMP or m.action == ACT_RIDING_SHELL_GROUND or m.action == ACT_RIDING_SHELL_JUMP or m.action == ACT_HOLD_WALKING or m.action == ACT_HOLD_JUMP or m.action == ACT_BURNING_GROUND or m.action == ACT_BURNING_JUMP or m.action == ACT_BURNING_FALL or m.action == ACT_LAVA_BOOST or m.action == ACT_LONG_JUMP or (m.action & ACT_FLAG_METAL_WATER) ~= 0 then
            m.faceAngle.y = m.intendedYaw - approach_s32(convert_s16(m.intendedYaw - m.faceAngle.y), 0, 0x1000, 0x1000)
            if m.faceAngle.y ~= m.intendedYaw and m.forwardVel > 32 then
                mario_set_forward_vel(m, approach_f32(m.forwardVel, 0, m.forwardVel/16, m.forwardVel/16))
            else
                mario_set_forward_vel(m, m.forwardVel)
            end
        end

        if m.action == ACT_SHOT_FROM_CANNON or m.action == ACT_FREEFALL or m.action == ACT_JUMP_KICK or m.action == ACT_DIVE or m.action == ACT_FORWARD_ROLLOUT or m.action == ACT_BACKWARD_ROLLOUT then
            update_air_with_turn(m)
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

    -- bounce landing code --

        if m.action == ACT_GROUND_POUND_LAND then
            m.actionTimer = m.actionTimer + 1

            if m.actionTimer > 2 then
                set_mario_action(m, ACT_TRIPLE_JUMP, 0)
                play_king_sfx(m, 0)
                mario_set_forward_vel(m, e.lastforwardVel)
            elseif m.actionTimer < 2 then
                set_mario_action(m, ACT_GROUND_POUND_LAND, 99)
            end
        end

    -- double jumping --

        if m.action == ACT_JUMP then
            if hasJumpSoundPlayed == 0 then
                play_king_sfx(m, 4)
                hasJumpSoundPlayed = 1
            end
        else
            hasJumpSoundPlayed = 0
        end

        if m.action == ACT_JUMP or m.action == ACT_TRIPLE_JUMP or m.action == ACT_BUTT_SLIDE_AIR or m.action == ACT_FREEFALL or m.action == ACT_TOP_OF_POLE_JUMP or m.action == ACT_LAVA_BOOST or m.action == ACT_TWIRLING then
            m.actionTimer = m.actionTimer + 1
            if m.actionTimer > 1 and (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                if doubleJump == 0 then
                    doubleJump = 1
                    m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE
                    set_mario_action(m, ACT_DOUBLE_JUMP, 0)
                    play_king_sfx(m, 3)
                end
            end
        end

        if m.action == ACT_DOUBLE_JUMP then
            if (m.flags & MARIO_WING_CAP) == 0 then
                e.modelState = 1
            else
                e.modelState = 0
                if (m.controller.buttonDown & A_BUTTON) ~= 0 then
                    m.vel.y = 50
                end
            end
        end

        if doubleJump == 1 then
            if m.action ~= ACT_DOUBLE_JUMP then
                doubleJump = 0
            end
        end

        if m.action == ACT_RIDING_SHELL_JUMP or m.action == ACT_RIDING_SHELL_FALL then
            m.actionTimer = m.actionTimer + 1
            if m.actionTimer > 1 and (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                if doubleShellJump == 0 then
                    m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE
                    set_mario_action(m, ACT_RIDING_SHELL_JUMP, 0)
                    doubleShellJump = 1
                end
            end
            if doubleShellJump == 1 then
                if m.actionTimer <= 10 then
                    m.marioObj.header.gfx.angle.y = m.marioObj.header.gfx.angle.y + (m.actionTimer * 6553.6)
                end
            end
        end

        if doubleShellJump == 1 then
            if m.action ~= ACT_RIDING_SHELL_JUMP then
                doubleShellJump = 0
            end
        end

        if m.action == ACT_HOLD_JUMP or m.action == ACT_HOLD_FREEFALL then
            m.actionTimer = m.actionTimer + 1
            if m.actionTimer > 1 and (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                if doubleHoldJump == 0 then
                    m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE
                    set_mario_action(m, ACT_HOLD_JUMP, 0)
                    doubleHoldJump = 1
                end
            end
        end

        if doubleHoldJump == 1 then
            if m.action ~= ACT_HOLD_JUMP then
                doubleHoldJump = 0
            end
        end

        if m.action == ACT_BURNING_FALL or m.action == ACT_BURNING_JUMP then
            m.actionTimer = m.actionTimer + 1
            if m.actionTimer > 1 and (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                if doubleBurnJump == 0 then
                    m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE
                    set_mario_action(m, ACT_BURNING_JUMP, 0)
                    doubleBurnJump = 1
                end
            end
        end

        if doubleBurnJump == 1 then
            if m.action ~= ACT_BURNING_JUMP then
                doubleBurnJump = 0
            end
        end

        if m.action == ACT_METAL_WATER_JUMP or m.action == ACT_METAL_WATER_FALLING then
            m.actionTimer = m.actionTimer + 1
            if m.actionTimer > 1 and (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                set_mario_action(m, ACT_METAL_WATER_JUMP, 0)
            end
        end

    -- extra crouch code --

        if m.action == ACT_CROUCHING then
            m.actionTimer = m.actionTimer + 1
            if m.actionTimer > 0 then 
                if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                    set_mario_action(m, ACT_JUMP, 0)
                end
                if (m.controller.buttonDown & Z_TRIG) ~= 0 and (m.controller.buttonPressed & B_BUTTON) ~= 0 then
                    set_mario_action(m, ACT_OLD_ROLLDASH, 0)
                    play_king_sfx(m, 1)
                end
            end
        end

    -- extra punching/kicking code --

		if m.action == ACT_PUNCHING then
            if m.actionArg == 3 then
                if hasPunch2SoundPlayed == 0 then
                    play_sound(SOUND_ACTION_SPIN, m.marioObj.header.gfx.cameraToObject)
                    hasPunch2SoundPlayed = 1
                end
            else
                if hasPunch1SoundPlayed == 0 then
                    play_sound(SOUND_ACTION_SPIN, m.marioObj.header.gfx.cameraToObject)
                    hasPunch1SoundPlayed = 1
                end
            end

            if m.actionArg == 6 then
			    set_mario_action(m, ACT_PUNCHING, 0)
                hasPunch1SoundPlayed = 0
                hasPunch2SoundPlayed = 0
            end
        elseif m.action == ACT_MOVE_PUNCHING then
            m.actionTimer = m.actionTimer + 1

            if m.actionTimer > 1 then
                if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                    set_mario_action(m, ACT_JUMP, 0)
                end
            end

            if m.actionArg == 3 then
                if hasPunch2SoundPlayed == 0 then
                    play_sound(SOUND_ACTION_SPIN, m.marioObj.header.gfx.cameraToObject)
                    hasPunch2SoundPlayed = 1
                end
            else
                if hasPunch1SoundPlayed == 0 then
                    play_sound(SOUND_ACTION_SPIN, m.marioObj.header.gfx.cameraToObject)
                    hasPunch1SoundPlayed = 1
                end
            end

            if m.actionArg == 6 then
			    set_mario_action(m, ACT_MOVE_PUNCHING, 0)
                hasPunch1SoundPlayed = 0
                hasPunch2SoundPlayed = 0
            end
        else
            hasPunch1SoundPlayed = 0
            hasPunch2SoundPlayed = 0
        end

        if m.action == ACT_JUMP_KICK then
            m.actionTimer = m.actionTimer + 1

            if m.actionTimer == 1 then
                play_sound(SOUND_ACTION_SPIN, m.marioObj.header.gfx.cameraToObject)
            end
        end

    -- extra long jump code --

        if m.action == ACT_LONG_JUMP then
            m.actionTimer = m.actionTimer + 1

            m.particleFlags = m.particleFlags | PARTICLE_DUST

            if m.actionTimer == 2 then
                set_mario_y_vel_based_on_fspeed(m, 20, 0.2)
            end

            if m.actionTimer > 2 then
                if (m.controller.buttonPressed & Z_TRIG) ~= 0 then
                    set_mario_action(m, ACT_GROUND_POUND, 0)
                end
                if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
                    set_mario_action(m, ACT_DIVE, 0)
                end
                if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                    if doubleJump == 0 then
                        doubleJump = 1
                        m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE
                        set_mario_action(m, ACT_DOUBLE_JUMP, 0)
                        play_king_sfx(m, 3)
                    end
                end
            end
        end

    -- extra dive code --

        if m.action == ACT_DIVE then
            m.actionTimer = m.actionTimer + 1

            if m.actionTimer <= 2 then
                m.faceAngle.y = m.intendedYaw

                if m.vel.y < 25 then
                    m.vel.y = 25
                end

                if m.forwardVel < 10 then
                    m.forwardVel = 10
                end
            end
            if hasDiveSoundPlayed == 0 then
                play_king_sfx(m, 5)
                hasDiveSoundPlayed = 1
            end
        else
            hasDiveSoundPlayed = 0
        end

    -- extra slide code

        if m.action == ACT_BUTT_SLIDE or m.action == ACT_DIVE_SLIDE or m.action == ACT_STOMACH_SLIDE then
            m.actionTimer = m.actionTimer + 1

            if m.actionTimer > 1 then
                if (m.controller.buttonPressed & A_BUTTON) ~= 0 then
                    set_mario_action(m, ACT_JUMP, 0)
                end
            end
            if (m.controller.buttonDown & Z_TRIG) ~= 0 then
                set_mario_action(m, ACT_OLD_ROLL, 0)
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

    -- extra twirling code --

        if m.action == ACT_TWIRLING then
            m.actionTimer = m.actionTimer + 1

            if m.actionTimer > 1 then
                if (m.controller.buttonPressed & B_BUTTON) ~= 0 then
                    set_mario_action(m, ACT_FREEFALL, 0)
                end
                if (m.controller.buttonPressed & Z_TRIG) ~= 0 then
                    set_mario_action(m, ACT_GROUND_POUND, 0)
                end
            end

            if specialBounce == 1 then
                m.particleFlags = m.particleFlags | PARTICLE_SPARKLES
            end
        else
            specialBounce = 0
        end

    -- og mario swimming is ass --

        if (m.action & ACT_GROUP_MASK) == ACT_GROUP_SUBMERGED and (m.action & ACT_FLAG_METAL_WATER) == 0 and m.action ~= ACT_BACKWARD_WATER_KB and m.action ~= ACT_FORWARD_WATER_KB and m.action ~= ACT_WATER_PLUNGE then
            m.faceAngle.y = m.faceAngle.y + m.controller.stickX * -20
            if m.controller.stickY ~= 0 then
                if m.faceAngle.x < 15000 and m.faceAngle.x > -15000 then
                    m.faceAngle.x = m.faceAngle.x + m.controller.stickY * -20
                end
            elseif m.faceAngle.x ~= 0 then
                m.faceAngle.x = m.faceAngle.x - (m.faceAngle.x * 0.25)
            end
        end
    end
end

function mario_on_set_action(m)
    if king == K_CHAR_OLD then

    -- actions that are set to jump --

        if m.action == ACT_STEEP_JUMP or m.action == ACT_SIDE_FLIP or m.action == ACT_BACKFLIP or (m.action == ACT_DOUBLE_JUMP and doubleJump == 0) then
            return set_mario_action(m, ACT_JUMP, 0)
        end

    -- special bounce jump --

        if m.action == ACT_SPECIAL_TRIPLE_JUMP then
            set_mario_action(m, ACT_TWIRLING, 0)
            play_king_sfx(m, 5)
            specialBounce = 1
            m.vel.y = 100
        end

    -- actions that are set to jump land stop --

        if m.action == ACT_JUMP_LAND or m.action == ACT_DOUBLE_JUMP_LAND or m.action == ACT_TRIPLE_JUMP_LAND or m.action == ACT_LONG_JUMP_LAND or m.action == ACT_FREEFALL_LAND or m.action == ACT_AIR_THROW_LAND or m.action == ACT_TWIRL_LAND then
            return set_mario_action(m, ACT_FREEFALL_LAND_STOP, 0)
        end

    -- actions that are set to hold jump land stop --

        if m.action == ACT_HOLD_JUMP_LAND or m.action == ACT_HOLD_FREEFALL_LAND then
            return set_mario_action(m, ACT_HOLD_FREEFALL_LAND_STOP, 0)
        end

    -- fast crouch slide from jump land --

        if m.action == ACT_FREEFALL_LAND_STOP then
            if (m.controller.buttonDown & Z_TRIG) ~= 0 then
                if m.forwardVel > 0 then
                    set_mario_action(m, ACT_OLD_ROLL, 0)
                else
                    set_mario_action(m, ACT_CROUCHING, 0)
                end
            end
        end

    -- setting ground pound to bounce --

        if m.action == ACT_GROUND_POUND then
            return set_mario_action(m, ACT_OLD_BOUNCE, 0)
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

    -- actions that are set to rolling/rolldashing --

        if m.action == ACT_SLIDE_KICK or m.action == ACT_SLIDE_KICK_SLIDE or m.action == ACT_SLIDE_KICK_SLIDE_STOP or m.action == ACT_CROUCH_SLIDE then
            return set_mario_action(m, ACT_OLD_ROLL, 0)
        end

        if (m.action == ACT_MOVE_PUNCHING or m.action == ACT_PUNCHING) and (m.actionArg == 9 or m.prevAction == ACT_CRAWLING) then
            return set_mario_action(m, ACT_OLD_ROLLDASH, 0)
        end

    -- disable dive from ground --

        if m.action == ACT_DIVE and m.prevAction == ACT_WALKING then
            return set_mario_action(m, ACT_MOVE_PUNCHING, 0)
        end

    -- more controlable jump kick --

        if m.prevAction ~= ACT_WALKING then -- this is never true, but you will always be holding A to do a jump kick so it works anyway
            if m.action == ACT_DIVE then
                if (m.controller.buttonDown & A_BUTTON) ~= 0 then
                    set_mario_action(m, ACT_JUMP_KICK, 0)
                end
            end
            if m.action == ACT_JUMP_KICK then
                if (m.controller.buttonDown & A_BUTTON) == 0 then
                    set_mario_action(m, ACT_DIVE, 0)
                end
            end
        end

    -- king is a strong bith --

        if m.action == ACT_HOLD_HEAVY_IDLE then
            return set_mario_action(m, ACT_HOLD_IDLE, 0)
        end

    -- fuck knockback smh --

        if m.action == ACT_HARD_BACKWARD_AIR_KB then
            return set_mario_action(m, ACT_BACKWARD_AIR_KB, 0)
        end
        if m.action == ACT_HARD_FORWARD_AIR_KB then
            return set_mario_action(m, ACT_FORWARD_AIR_KB, 0)
        end
        if m.action == ACT_HARD_BACKWARD_GROUND_KB then
            return set_mario_action(m, ACT_BACKWARD_GROUND_KB, 0)
        end
        if m.action == ACT_HARD_FORWARD_GROUND_KB then
            return set_mario_action(m, ACT_FORWARD_GROUND_KB, 0)
        end

    -- actions that are set to freefall --

        if m.action == ACT_FLYING or m.action == ACT_BUTT_SLIDE_AIR then
            return set_mario_action(m, ACT_FREEFALL, 0)
        end
    end
end

function mario_before_phys_step(m)
    local e = gMarioStateExtras[m.playerIndex]
    local speed = 1

    if king == K_CHAR_OLD then

    -- speed --

        if m.forwardVel > 100 then
            m.forwardVel = 100
        end

        if m.forwardVel < -100 then
            m.forwardVel = -100
        end

    -- actions with increased speed --

        if m.action == ACT_MOVE_PUNCHING or m.action == ACT_JUMP_KICK or m.action == ACT_TOP_OF_POLE_JUMP or m.action == ACT_TWIRLING or m.action == ACT_WALKING or m.action == ACT_JUMP or m.action == ACT_DOUBLE_JUMP or m.action == ACT_TRIPLE_JUMP or m.action == ACT_FREEFALL or m.action == ACT_OLD_ROLL or m.action == ACT_HOLD_WALKING or m.action == ACT_HOLD_JUMP or m.action == ACT_BURNING_GROUND or m.action == ACT_BURNING_JUMP or m.action == ACT_BURNING_FALL or m.action == ACT_LAVA_BOOST or m.action == ACT_LONG_JUMP or m.action == ACT_OLD_BOUNCE or (m.action & ACT_FLAG_METAL_WATER) ~= 0 then
            speed = speed * 2
        end

        if m.action == ACT_SHOT_FROM_CANNON or m.action == ACT_RIDING_SHELL_GROUND or m.action == ACT_RIDING_SHELL_JUMP or m.action == ACT_RIDING_SHELL_FALL or m.action == ACT_DIVE or m.action == ACT_DIVE_SLIDE or m.action == ACT_FORWARD_ROLLOUT or m.action == ACT_BACKWARD_ROLLOUT or m.action == ACT_BUTT_SLIDE or m.action == ACT_WALL_KICK_AIR then
            speed = speed * 1.5
        end

    -- swim speed --

        if (m.action & ACT_FLAG_SWIMMING) ~= 0 then
            if m.action ~= ACT_BACKWARD_WATER_KB and m.action ~= ACT_FORWARD_WATER_KB then
                speed = speed * 2
                if m.action ~= ACT_WATER_PLUNGE then
                    m.vel.y = m.vel.y * 2
                end
            end
        end

    -- slow af actions --

        if m.action == ACT_CRAWLING then
            speed = speed * 7.5
        end

    -- running --

        if m.action == ACT_WALKING then
            if m.forwardVel >= 30 then
                if (m.flags & MARIO_WING_CAP) == 0 then
                    m.particleFlags = m.particleFlags | PARTICLE_DUST
                end
            end
        end

    -- keep momentum for certain actions --

        if m.action == ACT_MOVE_PUNCHING or m.action == ACT_OLD_ROLL then
            if (m.input & INPUT_NONZERO_ANALOG) ~= 0 then
                if m.forwardVel < 30 and m.forwardVel > 0 then
                    mario_set_forward_vel(m, m.forwardVel * 1.1)
                end
            end
        end

        m.vel.x = m.vel.x * (speed * 0.8)
        m.vel.z = m.vel.z * (speed * 0.8)
    end
end

------------------------------------------------
-------------------- bounce --------------------
-- (edited from steven's sonic character mod) --
------------------------------------------------

function act_old_bounce(m)
    local e = gMarioStateExtras[m.playerIndex]

    update_air_with_turn(m)

    m.actionState = 1

    -- landing code --

    e.lastforwardVel = m.forwardVel * 0.85

    if perform_air_step(m, 0) == AIR_STEP_LANDED then
        set_mario_action(m, ACT_GROUND_POUND_LAND, 0)
        m.particleFlags = m.particleFlags | PARTICLE_MIST_CIRCLE
    else

    -- main code --

        m.vel.y = -100

        set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING)
        set_anim_to_frame(m, e.animFrame)
        if e.animFrame >= m.marioObj.header.gfx.animInfo.curAnim.loopEnd then
            e.animFrame = e.animFrame - m.marioObj.header.gfx.animInfo.curAnim.loopEnd
        end
        e.animFrame = e.animFrame + 2

        if m.actionTimer < 1 then
            play_king_sfx(m, 0)
        end
    end

    -- bounce dive --

    if (m.input & INPUT_B_PRESSED) ~= 0 then
        set_mario_action(m, ACT_DIVE, 0)
    end

    m.actionTimer = m.actionTimer + 1

    return 0
end

function act_old_rolldash(m)
    local e = gMarioStateExtras[m.playerIndex]
    local rolldashCharge = off
    local rolldashSpeed = 1
    local rolldashAnimSpeed = 0

    m.actionTimer = m.actionTimer + 1

    -- dash speed and charge timer --

    if rolldashCharge == on then
        if m.actionTimer >= 20 then
            rolldashSpeed = 100
        elseif m.actionTimer <= 10 then
            rolldashSpeed = 50
        else
            rolldashSpeed = m.actionTimer * 5
        end
    elseif rolldashCharge == off then
        rolldashSpeed = 1
    end

    -- funi roll animation speed --

    if m.actionTimer > 20 then
        rolldashAnimSpeed = 4
    else
        rolldashAnimSpeed = m.actionTimer * 0.2
    end

    m.actionState = 1

    -- setting the roll animation --

    set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING)
    set_anim_to_frame(m, e.animFrame)
    if e.animFrame >= m.marioObj.header.gfx.animInfo.curAnim.loopEnd then
        e.animFrame = e.animFrame - m.marioObj.header.gfx.animInfo.curAnim.loopEnd
        play_sound(SOUND_ACTION_SPIN, m.marioObj.header.gfx.cameraToObject)
    end
    e.animFrame = e.animFrame + rolldashAnimSpeed

    m.faceAngle.y = m.intendedYaw
    m.marioObj.header.gfx.angle.y = m.intendedYaw

    -- starts charging a rolldash if ur currently rolldashing too slow --

    if m.forwardVel < 25 then
        m.actionArg = 1
    end

    -- rolldash charging code --

    stationary_ground_step(m)

    if (m.controller.buttonDown & Z_TRIG) ~= 0 and (m.controller.buttonDown & B_BUTTON) ~= 0 then
        rolldashCharge = off
        m.particleFlags = m.particleFlags | PARTICLE_DUST
        mario_set_forward_vel(m, m.forwardVel - (m.forwardVel / 2))
        if m.actionTimer > 1 and (m.controller.buttonPressed & A_BUTTON) ~= 0 then
            set_mario_action(m, ACT_JUMP, 0)
        end
        if m.actionTimer == 2 then
            play_king_sfx(m, 1)
        end
    elseif (m.controller.buttonDown & Z_TRIG) == 0 or (m.controller.buttonDown & B_BUTTON) == 0 then
        m.particleFlags = m.particleFlags | PARTICLE_VERTICAL_STAR
        play_king_sfx(m, 2)
        set_mario_action(m, ACT_OLD_ROLL, 0)
        mario_set_forward_vel(m, rolldashSpeed)
        rolldashCharge = off
    end

    return 0
end

function act_old_roll(m)
    local e = gMarioStateExtras[m.playerIndex]

    if m.actionTimer == 0 then
        e.rotAngle = 0x000
    end

    e.lastforwardVel = m.forwardVel

    if (m.input & INPUT_A_PRESSED) ~= 0 then
        set_mario_action(m, ACT_LONG_JUMP, 0)

        m.particleFlags = m.particleFlags | PARTICLE_VERTICAL_STAR
        play_king_sfx(m, 5)

        if m.forwardVel < 48 then
            m.forwardVel = 48
        else
            m.forwardVel = e.lastforwardVel
        end
    end

    if m.actionTimer > 0 and (m.controller.buttonDown & Z_TRIG) ~= 0 and (m.controller.buttonPressed & B_BUTTON) ~= 0 then
        if (m.input & INPUT_NONZERO_ANALOG) ~= 0 and m.forwardVel > 20 then
            m.particleFlags = m.particleFlags | PARTICLE_VERTICAL_STAR
            play_king_sfx(m, 2)
            mario_set_forward_vel(m, m.forwardVel + m.forwardVel)
        else
            set_mario_action(m, ACT_OLD_ROLLDASH, 0)
        end
    end

    if (m.controller.buttonDown & Z_TRIG) == 0 then
        set_mario_action(m, ACT_WALKING, 0)
    end

    set_mario_animation(m, MARIO_ANIM_FORWARD_SPINNING)
    play_sound(SOUND_MOVING_TERRAIN_SLIDE + m.terrainSoundAddend, m.marioObj.header.gfx.cameraToObject)
    adjust_sound_for_speed(m)

    local stepResult = perform_ground_step(m)

    if stepResult == GROUND_STEP_NONE then
        apply_slope_accel(m)
        m.faceAngle.y = m.intendedYaw - approach_s32(convert_s16(m.intendedYaw - m.faceAngle.y), 0, 0x1000, 0x1000)
        mario_set_forward_vel(m, approach_f32(m.forwardVel, 0, 1, 1))
    elseif stepResult == GROUND_STEP_HIT_WALL then
        mario_set_forward_vel(m, -16.0)

        m.particleFlags = m.particleFlags | PARTICLE_VERTICAL_STAR
        return set_mario_action(m, ACT_GROUND_BONK, 0)
    end

    update_rolling(m, 5, stepResult, false)

    e.rotAngle = e.rotAngle + (0x60 * math.abs(m.forwardVel))
    if e.rotAngle > 0x9000 then
        e.rotAngle = e.rotAngle - 0x9000
    end
    if m.forwardVel < 0 then
        set_anim_to_frame(m, 10 - (10 * e.rotAngle / 0x9000))
    else
        set_anim_to_frame(m, 10 * e.rotAngle / 0x9000)
    end

    m.actionTimer = m.actionTimer + 1
    return 0
end

-----------
-- hooks --
-----------

hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_MARIO_UPDATE, old_update)
hook_event(HOOK_ON_SET_MARIO_ACTION, mario_on_set_action)
hook_event(HOOK_BEFORE_PHYS_STEP, mario_before_phys_step)
hook_mario_action(ACT_OLD_BOUNCE, act_old_bounce, INT_GROUND_POUND_OR_TWIRL)
hook_mario_action(ACT_OLD_ROLLDASH, act_old_rolldash)
hook_mario_action(ACT_OLD_ROLL, act_old_roll, INT_FAST_ATTACK_OR_SHELL)