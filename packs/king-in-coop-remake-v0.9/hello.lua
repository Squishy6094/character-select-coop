local headDir = 0
local kngSncInt = function() return false end

_G.ACT_HELLO = allocate_mario_action(ACT_GROUP_STATIONARY | ACT_FLAG_IDLE | ACT_FLAG_PAUSE_EXIT | ACT_FLAG_WATER_OR_TEXT)

function clamp(x, min, max)
    if x < min then return min end
    if x > max then return max end
    return x
end

function run_mario_animation(m, animation, speed)
    local e = gMarioStateExtras[m.playerIndex]

    set_mario_animation(m, animation)
    set_anim_to_frame(m, e.animFrame)
    if e.animFrame >= m.marioObj.header.gfx.animInfo.curAnim.loopEnd then
        e.animFrame = e.animFrame - m.marioObj.header.gfx.animInfo.curAnim.loopEnd
    end
    e.animFrame = e.animFrame + speed
end

kngSncInt = function(k, s, intType)
    if intType ~= INTERACT_PLAYER or k.playerIndex ~= 0 then
        return false
    end

    if king == K_CHAR_KING then
        if (k.action == ACT_IDLE or k.action == ACT_WAKING_UP or k.action == ACT_PANTING or k.action == ACT_START_SLEEPING or k.action == ACT_SLEEPING or k.action == ACT_KING_WALK)
        and (k.controller.buttonPressed & Y_BUTTON) ~= 0 then
            k.action = ACT_HELLO
            k.vel.x = 0
            k.vel.z = 0
            k.forwardVel = 0
            return true
        elseif k.action == ACT_IDLE then
            k.actionTimer = 0
            return true
        elseif k.action == ACT_HELLO then
            headDir = obj_angle_to_object(k.marioObj, s) - approach_f32(convert_s16(obj_angle_to_object(k.marioObj, s) - headDir), 0, 0x400, 0x400)
            k.marioBodyState.headAngle.y = headDir - k.faceAngle.y
            k.faceAngle.y = clamp(k.faceAngle.y, (k.marioBodyState.headAngle.y + k.faceAngle.y) - 0x2000, (k.marioBodyState.headAngle.y + k.faceAngle.y) + 0x2000)
            return true
        end
    end

    return false
end

function act_hello(m)
    local stepResult = perform_ground_step(m)

    m.marioBodyState.handState = MARIO_HAND_RIGHT_OPEN

    if m.actionTimer > 1 then
        if (m.controller.buttonPressed & Y_BUTTON) ~= 0 then
            m.marioBodyState.handState = MARIO_HAND_FISTS
            return set_mario_action(m, ACT_IDLE, 0)
        elseif check_common_idle_cancels(m) ~= 0 then
            m.marioBodyState.handState = MARIO_HAND_FISTS
            return 1
        end
    end

    m.vel.x = 0
    m.vel.z = 0
    m.forwardVel = 0

    run_mario_animation(m, MARIO_ANIM_CREDITS_WAVING, 1)
    m.actionTimer = m.actionTimer + 1

    return 0
end

hook_mario_action(ACT_HELLO, act_hello)
hook_event(HOOK_ON_INTERACT, kngSncInt)