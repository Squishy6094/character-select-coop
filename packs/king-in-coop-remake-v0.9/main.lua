-- description: \\#8980E0\\King\\#dbdbdb\\ is back, and now he has a far cleaner moveset, more features, and NEW models!\n\nMain coder:\n\\#8980E0\\king \\#8560D0\\the \\#8040C0\\memer\\#dbdbdb\\\n\nMario muting code:\n\\#ff6b91\\SMS Alfredo\\#dbdbdb\\\n\nImproved swimming and flying\n+ Head turning:\n\\#B80000\\Sharen\\#dbdbdb\\\n\nCharacter Select support\n+ Options Menu:\n\\#008000\\Squishy\\#dbdbdb\\\n\nShoutouts to \\#00FFFF\\steven\\#dbdbdb\\ for letting me edit some\nSonic code- this wouldn't exist without him
-- name: King in SM64Ex Co-op Remake v0.9 BETA

_G.ACT_CHAR_SELECT = allocate_mario_action(ACT_GROUP_STATIONARY | ACT_FLAG_IDLE | ACT_FLAG_INVULNERABLE | ACT_FLAG_PAUSE_EXIT)

E_MODEL_BALL = smlua_model_util_get_id("ball_geo")
E_MODEL_BALL_AFT = smlua_model_util_get_id("ball_aft_geo")
E_MODEL_KING = smlua_model_util_get_id("king_geo")
E_MODEL_KING_AFT = smlua_model_util_get_id("king_aft_geo")
E_MODEL_OLD_BALL = smlua_model_util_get_id("old_ball_geo")
E_MODEL_OLD_KING = smlua_model_util_get_id("old_king_geo")
--TEX_MOVESET_KING = get_texture_info("king moveset")

_G.K_CHAR_NONE = 0
_G.K_CHAR_KING = 1
_G.K_CHAR_OLD = 2
_G.K_CHAR_MAX = 3

_G.king = K_CHAR_NONE
local hasGotKing = 0
local hasGotOld = 0
local xL = 0
local xR = 0
local slopeSpeed = 0
local aftModel = E_MODEL_KING_AFT

if kingSpeed == nil then
    _G.kingSpeed = 1
end
speedMode = 2/3 + (clamp(kingSpeed, 1, 4) / 3)

gMarioStateExtras = {}
for i = 0, (MAX_PLAYERS - 1) do
    gMarioStateExtras[i] = {}
    local m = gMarioStates[i]
    local e = gMarioStateExtras[i]
    e.rotAngle = 0
    e.animFrame = 0
    e.runspeed = 0
    e.lastforwardVel = 0
    e.dashspeed = 0
    e.modelState = 0
    e.moveAngle = 0
    e.spawnDelay = 0
    e.slopeAngle = 0
    e.slopeSideAngle = 0
    e.sidewardVel = 0
end

function king_command(msg)
    local m = gMarioStates[0]
    msg = string.lower(msg)
    if _G.charSelectExists == nil then
        if msg == 'on' then
            if king == 0 then
                _G.king = K_CHAR_KING
                play_sound(SOUND_MENU_HAND_APPEAR, m.marioObj.header.gfx.cameraToObject)
                djui_chat_message_create('King is now on!\nHold X and Y, then press L to change character')
            else
                play_sound(SOUND_MENU_CAMERA_BUZZ, m.marioObj.header.gfx.cameraToObject)
                djui_chat_message_create('King is already on')
            end
            return true
        elseif msg == 'off' then
            if king ~= 0 then
                _G.king = K_CHAR_NONE
                play_sound(SOUND_MENU_HAND_DISAPPEAR, m.marioObj.header.gfx.cameraToObject)
                djui_chat_message_create('sad no kign :(')
            else
                play_sound(SOUND_MENU_CAMERA_BUZZ, m.marioObj.header.gfx.cameraToObject)
                djui_chat_message_create('King is already off')
            end
            return true
        elseif msg == 'settings' then
            if king ~= 0 then
                options_command()
            else
                play_sound(SOUND_MENU_CAMERA_BUZZ, m.marioObj.header.gfx.cameraToObject)
                djui_chat_message_create('King is off')
            end
            return true
        end
    elseif msg == 'settings' then
        if king ~= 0 then
            options_command()
        else
            play_sound(SOUND_MENU_CAMERA_BUZZ, m.marioObj.header.gfx.cameraToObject)
            djui_chat_message_create('King is off')
        end
        return true
    else
        play_sound(SOUND_MENU_CAMERA_BUZZ, m.marioObj.header.gfx.cameraToObject)
        djui_chat_message_create('King is unusable using the King command\nUse the Character Select command instead')
        return true
    end
end

function convert_s16(num)
    local min = -32768
    local max = 32767
    while (num < min) do
        num = max + (num - min)
    end
    while (num > max) do
        num = min + (num - max)
    end
    return num
end

function convert_s32(num)
    local min = -2^31
    local max = 2^31 - 1
    while (num < min) do
        num = max + (num - min)
    end
    while (num > max) do
        num = min + (num - max)
    end
    return num
end

function do_big_dust(m)
    if m.playerIndex ~= 0 then return end

    spawn_sync_object(
        id_bhvSmoke,
        E_MODEL_SMOKE,
        m.pos.x,
        m.pos.y,
        m.pos.z,
        function(o)
            o.oMoveAngleYaw = m.marioObj.header.gfx.angle.y + math.random(-0x1000, 0x1000)
            o.oGraphYOffset = o.oGraphYOffset - math.random(20, 40)
            o.oVelY = math.random(0, 5)
            o.oForwardVel = -10
            --obj_scale(o, math.random(1, 2))
        end
    )
    spawn_sync_object(
        id_bhvSmoke,
        E_MODEL_SMOKE,
        m.pos.x,
        m.pos.y,
        m.pos.z,
        function(o)
            o.oMoveAngleYaw = m.marioObj.header.gfx.angle.y + math.random(-0x1000, 0x1000)
            o.oGraphYOffset = o.oGraphYOffset - math.random(20, 40)
            o.oVelY = math.random(0, 5)
            o.oForwardVel = -10
            --obj_scale(o, math.random(1, 2))
        end
    )
    return 0
end

--SOUND_TERRAIN_WATER

function play_step_sound_with_dust(m, frame1, frame2)
    if is_anim_past_frame(m, frame1) ~= 0 or is_anim_past_frame(m, frame2) ~= 0 then
        if (m.flags & MARIO_METAL_CAP) ~= 0 then
            if m.marioObj.header.gfx.animInfo.animID == MARIO_ANIM_TIPTOE then
                play_sound_and_spawn_particles(m, SOUND_ACTION_METAL_STEP_TIPTOE, 0)
                m.particleFlags = m.particleFlags | PARTICLE_DUST
            else
                play_sound_and_spawn_particles(m, SOUND_ACTION_METAL_STEP, 0)
                m.particleFlags = m.particleFlags | PARTICLE_DUST
            end
        elseif m.quicksandDepth > 50 then
            play_sound(SOUND_ACTION_QUICKSAND_STEP, m.marioObj.header.gfx.cameraToObject)
        elseif m.marioObj.header.gfx.animInfo.animID == MARIO_ANIM_TIPTOE then
            play_sound_and_spawn_particles(m, SOUND_ACTION_TERRAIN_STEP_TIPTOE, 0)
            m.particleFlags = m.particleFlags | PARTICLE_DUST
        else
            play_sound_and_spawn_particles(m, SOUND_ACTION_TERRAIN_STEP, 0)
            m.particleFlags = m.particleFlags | PARTICLE_DUST
        end
    end
end

function king_slope_accel(m)
    local floor = m.floor
    local steepness = sqrf(floor.normal.x * floor.normal.x + floor.normal.z * floor.normal.z)
    local floorDYaw = m.floorAngle - m.faceAngle.y

    if floorDYaw > -0x4000 and floorDYaw < 0x4000 then
        m.forwardVel = m.forwardVel + (5.3 * steepness)
    else
        m.forwardVel = m.forwardVel - (5.3 * steepness)
    end

    m.slideYaw = m.faceAngle.y

    m.slideVelX = m.forwardVel * sins(m.faceAngle.y)
    m.slideVelZ = m.forwardVel * coss(m.faceAngle.y)

    m.vel.x = m.slideVelX
    m.vel.y = 0
    m.vel.z = m.slideVelZ

    mario_update_moving_sand(m)
    mario_update_windy_ground(m)
end

local charSelectTablePlacements = {
    king = 0,
    kingOld = 0,
}

local oldKingSave = mod_storage_load("KingOld")
if not oldKingSave then
    mod_storage_save("KingOld", "false")
    oldKingSave = mod_storage_load("KingOld")
end

function mario_update(m)
    if m.playerIndex == 0 then
        mario_update_local(m)
    end

    -- old unlock --
    if m.numStars >= 70 then
        if oldKingSave == "false" then
            djui_chat_message_create('You got 70 Stars!')
            djui_chat_message_create('Now you can play as an \\#6060c0\\old friend\\#6060c0\\.')
            play_puzzle_jingle()
            mod_storage_save("KingOld", "true")
            oldKingSave = mod_storage_load("KingOld")
        end
    end

    if hasGotKing == 0 then
        hasGotKing = 1
        if _G.charSelectExists then -- Add King
            _G.charSelect.character_add("King the Memer", {"King is a bouncy little hedgehog", "that HATES being mistaken for", "Sonic... that's why he wears his", "signature crown.", "", "King is able to roll down slopes", "to gain speed, and he can bounce", "and double jump to reach heights", "that Mario couldn't dream of."}, "king the memer", {r = 111, g = 102, b = 198}, E_MODEL_KING, CT_MARIO)
            charSelectTablePlacements.king = _G.charSelect.character_get_number_from_string("King the Memer")
        end
    end

    if oldKingSave == "true" and hasGotOld == 0 then
        hasGotOld = 1
        if _G.charSelectExists then -- Add Old King
            _G.charSelect.character_add("Old King", {"Old King is... well, he's an older", "version of King.", "", "Old King is far less polished than", "the King we have today, but he's", "WAY more powerful- he jumps", "higher, he rolls faster, and he", "can easily clip through doors with", "enough speed, making 1 star a", "cake walk."}, "king the memer", {r = 96, g = 96, b = 192}, E_MODEL_OLD_KING, CT_MARIO)
            charSelectTablePlacements.kingOld = _G.charSelect.character_get_number_from_string("Old King")
        end
    end
end

local uTimer = 0
local U_STICK_PRESS = 0
local U_STICK_DOWN = 0
local dTimer = 0
local D_STICK_PRESS = 0
local D_STICK_DOWN = 0
local lTimer = 0
local L_STICK_PRESS = 0
local L_STICK_DOWN = 0
local rTimer = 0
local R_STICK_PRESS = 0
local R_STICK_DOWN = 0

function mario_update_local(m)
    local e = gMarioStateExtras[m.playerIndex]

    if m.controller.stickY > 60 then
        uTimer = uTimer + 1
        if uTimer <= 1 then
            U_STICK_PRESS = 1
            U_STICK_DOWN = 1
        else
            U_STICK_PRESS = 0
            U_STICK_DOWN = 1
        end
    else
        uTimer = 0
        U_STICK_PRESS = 0
        U_STICK_DOWN = 0
    end

    if m.controller.stickY < -60 then
        dTimer = dTimer + 1
        if dTimer <= 1 then
            D_STICK_PRESS = 1
            D_STICK_DOWN = 1
        else
            D_STICK_PRESS = 0
            D_STICK_DOWN = 1
        end
    else
        dTimer = 0
        D_STICK_PRESS = 0
        D_STICK_DOWN = 0
    end

    if m.controller.stickX < -60 then
        lTimer = lTimer + 1
        if lTimer <= 1 then
            L_STICK_PRESS = 1
            L_STICK_DOWN = 1
        else
            L_STICK_PRESS = 0
            L_STICK_DOWN = 1
        end
    else
        lTimer = 0
        L_STICK_PRESS = 0
        L_STICK_DOWN = 0
    end

    if m.controller.stickX > 60 then
        rTimer = rTimer + 1
        if rTimer <= 1 then
            R_STICK_PRESS = 1
            R_STICK_DOWN = 1
        else
            R_STICK_PRESS = 0
            R_STICK_DOWN = 1
        end
    else
        rTimer = 0
        R_STICK_PRESS = 0
        R_STICK_DOWN = 0
    end

    if _G.charSelectExists then
        local currModelNum = _G.charSelect.character_get_current_model_number()
        if currModelNum == charSelectTablePlacements.king then
            _G.king = K_CHAR_KING
        elseif currModelNum == charSelectTablePlacements.kingOld then
            _G.king = K_CHAR_OLD
        else
            _G.king = K_CHAR_NONE
        end
    end

    if king ~= K_CHAR_NONE then
        if king == K_CHAR_KING then
            if e.modelState == 1 then
                if not _G.charSelectExists then
                    gPlayerSyncTable[0].modelId = E_MODEL_BALL
                else
                    _G.charSelect.character_edit(charSelectTablePlacements.king, nil, nil, nil, nil, E_MODEL_BALL)
                end
                aftModel = E_MODEL_BALL_AFT
            else
                if not _G.charSelectExists then
                    gPlayerSyncTable[0].modelId = E_MODEL_KING
                else
                    _G.charSelect.character_edit(charSelectTablePlacements.king, nil, nil, nil, nil, E_MODEL_KING)
                end
                aftModel = E_MODEL_KING_AFT
            end
        elseif king == K_CHAR_OLD then
            if e.modelState == 1 then
                if not _G.charSelectExists then
                    gPlayerSyncTable[0].modelId = E_MODEL_OLD_BALL
                else
                    _G.charSelect.character_edit(charSelectTablePlacements.kingOld, nil, nil, nil, nil, E_MODEL_OLD_BALL)
                end
            else
                if not _G.charSelectExists then
                    gPlayerSyncTable[0].modelId = E_MODEL_OLD_KING
                else
                    _G.charSelect.character_edit(charSelectTablePlacements.kingOld, nil, nil, nil, nil, E_MODEL_OLD_KING)
                end
            end
        else -- big bobomb bug finder
            if e.modelState == 1 then
                gPlayerSyncTable[0].modelId = E_MODEL_BOWLING_BALL
            else
                gPlayerSyncTable[0].modelId = E_MODEL_KING_BOBOMB
            end
        end

        if not _G.charSelectExists then -- Mod check to allow binds
            if m.action == ACT_IDLE or m.action == ACT_PANTING or m.action == ACT_START_SLEEPING or m.action == ACT_SLEEPING or m.action == ACT_WAKING_UP then
                if (m.controller.buttonDown & X_BUTTON) ~= 0 and (m.controller.buttonDown & Y_BUTTON) ~= 0 then
                    if (m.controller.buttonPressed & L_TRIG) ~= 0 then
                        play_sound(SOUND_MENU_HAND_APPEAR, m.marioObj.header.gfx.cameraToObject)
                        return set_mario_action(m, ACT_CHAR_SELECT, 0)
                    end
                end
            elseif m.action == ACT_CHAR_SELECT then
                if (m.controller.buttonPressed & R_JPAD) ~= 0 or R_STICK_PRESS ~= 0 then
                    if king == K_CHAR_MAX - 1 or oldKingSave == "false" then
                        play_sound(SOUND_MENU_CAMERA_BUZZ, m.marioObj.header.gfx.cameraToObject)
                    else
                        play_sound(SOUND_MENU_CHANGE_SELECT, m.marioObj.header.gfx.cameraToObject)
                        _G.king = king + 1
                    end
                end
                if (m.controller.buttonPressed & L_JPAD) ~= 0 or L_STICK_PRESS ~= 0 then
                    if king == K_CHAR_NONE + 1 then
                        play_sound(SOUND_MENU_CAMERA_BUZZ, m.marioObj.header.gfx.cameraToObject)
                    else
                        play_sound(SOUND_MENU_CHANGE_SELECT, m.marioObj.header.gfx.cameraToObject)
                        _G.king = king - 1
                    end
                end
            end
        end

        if (m.controller.buttonPressed & L_JPAD) ~= 0 or L_STICK_PRESS ~= 0 then
            xL = 10
        elseif xL > 0 then
            xL = xL -2
        else
            xL = 0
        end

        if (m.controller.buttonPressed & R_JPAD) ~= 0 or R_STICK_PRESS ~= 0 then
            xR = 10
        elseif xR > 0 then
            xR = xR -2
        else
            xR = 0
        end

    -- metal just being heavy in general --

        if (m.flags & MARIO_METAL_CAP) == 0 then
            m.peakHeight = m.pos.y
        end

    -- visual bullshit --

        if m.action == ACT_HARD_BACKWARD_AIR_KB or m.action == ACT_BACKWARD_AIR_KB
        or m.action == ACT_HARD_FORWARD_AIR_KB or m.action == ACT_FORWARD_AIR_KB
        or m.action == ACT_FORWARD_WATER_KB or m.action == ACT_BACKWARD_WATER_KB
        or m.action == ACT_DROWNING then
            m.marioBodyState.eyeState = 8
        end

        if (m.action & ACT_GROUP_MASK) == ACT_GROUP_AIRBORNE or (m.action & ACT_GROUP_MASK) == ACT_GROUP_SUBMERGED then
            e.slopeAngle = 0
            e.slopeSideAngle = 0
        elseif m.action == ACT_KING_BOUNCE_LAND then
            e.slopeAngle = find_floor_slope(m, 0) / 200
            e.slopeSideAngle = find_floor_slope(m, 0x4000) / 200
        else
            e.slopeAngle = approach_s32(e.slopeAngle, find_floor_slope(m, 0) / 200, 2, 2)
            e.slopeSideAngle = approach_s32(e.slopeSideAngle, find_floor_slope(m, 0x4000) / 200, 2, 2)
        end
    else

    -- set player model to mario --

        gPlayerSyncTable[0].modelId = nil
        --if (m.action & ACT_FLAG_SHORT_HITBOX) ~= 0 then
        --    m.marioObj.hitboxHeight = 100
        --else
        --    m.marioObj.hitboxHeight = 160
        --end
    end
end

function update_rolling_angle(m, accel, lossFactor)
    local newFacingDYaw
    local facingDYaw

    local floor = m.floor
    local slopeAngle = atan2s(floor.normal.z, floor.normal.x)
    local steepness = math.sqrt(floor.normal.x * floor.normal.x + floor.normal.z * floor.normal.z)
    local normalY = floor.normal.y

    m.slideVelX = m.slideVelX + accel * steepness * sins(slopeAngle)
    m.slideVelZ = m.slideVelZ + accel * steepness * coss(slopeAngle)

    m.slideVelX = m.slideVelX * lossFactor
    m.slideVelZ = m.slideVelZ * lossFactor

    m.slideYaw = atan2s(m.slideVelZ, m.slideVelX)

    facingDYaw = convert_s16(m.faceAngle.y - m.slideYaw)
    newFacingDYaw = convert_s32(facingDYaw)

    --! -0x4000 not handled - can slide down a slope while facing perpendicular to it
    if newFacingDYaw > 0 and newFacingDYaw <= 0x4000 then
        newFacingDYaw = newFacingDYaw - 0x200
        if newFacingDYaw < 0 then
            newFacingDYaw = 0
        end
    elseif newFacingDYaw > -0x4000 and newFacingDYaw < 0 then
        newFacingDYaw = newFacingDYaw + 0x200
        if newFacingDYaw > 0 then
            newFacingDYaw = 0
        end
    elseif newFacingDYaw > 0x4000 and newFacingDYaw < 0x8000 then
        newFacingDYaw = newFacingDYaw + 0x200
        if newFacingDYaw > 0x8000 then
            newFacingDYaw = 0x8000
        end
    elseif newFacingDYaw > -0x8000 and newFacingDYaw < -0x4000 then
        newFacingDYaw = newFacingDYaw - 0x200
        if newFacingDYaw < -0x8000 then
            newFacingDYaw = -0x8000
        end
    end

    m.faceAngle.y = (m.slideYaw - newFacingDYaw - approach_s32(convert_s16(m.slideYaw - newFacingDYaw - m.faceAngle.y), 0, 0x1000, 0x1000))

    m.vel.x = m.slideVelX
    m.vel.y = 0
    m.vel.z = m.slideVelZ

    mario_update_moving_sand(m)
    mario_update_windy_ground(m)

    m.forwardVel = math.sqrt(m.slideVelX * m.slideVelX + m.slideVelZ * m.slideVelZ)

    if newFacingDYaw < -0x4000 or newFacingDYaw > 0x4000 then
        m.forwardVel = m.forwardVel * -1
    end
end

function before_mario_update(m)
    local e = gMarioStateExtras[m.playerIndex]
    if m.playerIndex ~= 0 then return end
    if king == 0 then return end
    if king == 2 then return end

    if (m.forwardVel > 100 * speedMode)
    or ((m.action == ACT_KING_AIRCHARGE or m.action == ACT_KING_GRNDCHARGE or m.action == ACT_MEMER_WATER_CHARGE or m.action == ACT_MEMER_FLIGHT_CHARGE) and e.dashspeed >= 15) then
        if mod_storage_load("AfterImages") == "1" then
            spawn_sync_object(
                id_bhvAfterImage,
                aftModel,
                0,
                0,
                0,
                function(o)
                    o.header.gfx.animInfo.animAccel = m.marioObj.header.gfx.animInfo.animAccel
                    o.header.gfx.animInfo.animFrame = m.marioObj.header.gfx.animInfo.animFrame
                    o.header.gfx.animInfo.animFrameAccelAssist = m.marioObj.header.gfx.animInfo.animFrameAccelAssist
                    o.header.gfx.animInfo.animID = m.marioObj.header.gfx.animInfo.animID
                    o.header.gfx.animInfo.animTimer = m.marioObj.header.gfx.animInfo.animTimer
                    o.header.gfx.animInfo.animYTrans = m.marioObj.header.gfx.animInfo.animYTrans
                    o.header.gfx.animInfo.curAnim = m.marioObj.header.gfx.animInfo.curAnim
                    o.header.gfx.animInfo.prevAnimFrame = m.marioObj.header.gfx.animInfo.prevAnimFrame
                    o.header.gfx.animInfo.prevAnimFrameTimestamp = m.marioObj.header.gfx.animInfo.prevAnimFrameTimestamp
                    o.header.gfx.animInfo.prevAnimID = m.marioObj.header.gfx.animInfo.prevAnimID
                    o.header.gfx.animInfo.prevAnimPtr = m.marioObj.header.gfx.animInfo.prevAnimPtr
                    vec3s_copy(o.header.gfx.angle, m.marioObj.header.gfx.angle)
                    vec3s_copy(o.header.gfx.pos, m.marioObj.header.gfx.pos)
                    vec3f_copy(o.header.gfx.scale, m.marioObj.header.gfx.scale)
                end
            )
        end
    end
end

function update_rolling(m, stopSpeed, stepResult, slopeMom, stopAct)
    local lossFactor
    local accel
    local oldSpeed
    local newSpeed
    local slopeAct

    local stopped = false

    local intendedDYaw = m.intendedYaw - m.slideYaw
    local forward = coss(intendedDYaw)
    local sideward = sins(intendedDYaw)

    --! 10k glitch
    if forward < 0 and m.forwardVel >= 0 then
        forward = forward * 0.5 + 0.5 * m.forwardVel / 100
    end

    accel = 10
    lossFactor = m.intendedMag / 32 * forward * 0.02 + 0.98

    oldSpeed = math.sqrt(m.slideVelX * m.slideVelX + m.slideVelZ * m.slideVelZ)

    -- This is attempting to use trig derivatives to rotate Mario's speed.
    -- It is slightly off/asymmetric since it uses the new X speed, but the old
    -- Z speed.
    m.slideVelZ = m.slideVelZ + m.slideVelZ * (m.intendedMag / 32) * sideward * 0.05
    m.slideVelX = m.slideVelX - m.slideVelX * (m.intendedMag / 32) * sideward * 0.05

    newSpeed = math.sqrt(m.slideVelX * m.slideVelX + m.slideVelZ * m.slideVelZ)

    if oldSpeed > 0 and newSpeed > 0 then
        m.slideVelX = m.slideVelX * oldSpeed / newSpeed
        m.slideVelZ = m.slideVelZ * oldSpeed / newSpeed
    end

    update_rolling_angle(m, accel, lossFactor)

    if king == K_CHAR_KING then
        slopeAct = ACT_KING_BOUNCE_JUMP
    else
        slopeAct = ACT_FREEFALL
    end

    if slopeMom == true then
        do_memer_slope_speed(m, slopeAct)
    else
        if stepResult == GROUND_STEP_LEFT_GROUND then
            set_mario_action(m, slopeAct, 0)
        end
    end

    if stopSpeed ~= 0 then
        if ((mario_floor_is_slope(m)) == 0 and m.forwardVel * m.forwardVel < stopSpeed * stopSpeed) then
            if stopAct then
                set_mario_action(m, stopAct, 0)
            else
                set_mario_action(m, ACT_CROUCHING, 0)
            end
            mario_set_forward_vel(m, 0)
            stopped = true
        end
    else
        stopped = false
    end

    return stopped
end

function do_memer_slope_speed(m, slopeAct)
    local e = gMarioStateExtras[m.playerIndex]
    if m.playerIndex ~= 0 then
        return
    end

    if (m.input & INPUT_OFF_FLOOR) == 0 then
        slopeSpeed = e.slopeAngle
    else
        if slopeAct then set_mario_action(m, slopeAct, 0) end
        m.vel.y = slopeSpeed * (m.forwardVel / 100)
        mario_set_forward_vel(m, m.forwardVel - slopeSpeed)
    end
end

function do_memer_jump_height(m, forwardVel, jumpHeight, sSpdtoyVel, fVeltoyVel, sideSlopeDiv, jumpAct)
    local e = gMarioStateExtras[m.playerIndex]
    if m.playerIndex ~= 0 then
        return
    end

    if fVeltoyVel == 1 then
        set_mario_y_vel_based_on_fspeed(m, jumpHeight / speedMode, 0.1)
    else
        m.vel.y = jumpHeight / speedMode
    end

    set_mario_action(m, jumpAct, 0)

    if sideSlopeDiv > 0 then
        mario_set_sideward_vel(m, e.sidewardVel - (e.slopeSideAngle / sideSlopeDiv))
    end

    mario_set_forward_vel(m, forwardVel - e.slopeAngle)

    if sSpdtoyVel == 1 then
        m.vel.y = m.vel.y + (e.slopeAngle * forwardVel/100)
    end
end

function mario_set_sideward_vel(m, sidewardVel)
    local e = gMarioStateExtras[m.playerIndex]
    e.sidewardVel = sidewardVel
end

function act_char_select(m)
    local e = gMarioStateExtras[m.playerIndex]
    local stepResult = perform_ground_step(m)

    if stepResult == GROUND_STEP_LEFT_GROUND then
        return set_mario_action(m, ACT_FREEFALL, 0)
    end

    m.vel.x = 0
    m.vel.z = 0
    m.forwardVel = 0
    e.rotAngle = (m.actionTimer * 1000) + m.faceAngle.y
    m.marioObj.header.gfx.angle.y = e.rotAngle
    set_mario_animation(m, MARIO_ANIM_A_POSE)

    if (m.controller.buttonPressed & L_TRIG) ~= 0 then
        m.actionTimer = 65534
    end

    if m.actionTimer == 65535
    or _G.charSelectExists ~= nil then
        play_sound(SOUND_MENU_HAND_DISAPPEAR, m.marioObj.header.gfx.cameraToObject)
        set_mario_action(m, ACT_IDLE, 0)
        m.marioObj.header.gfx.angle.y = m.faceAngle.y
    end

    m.actionTimer = m.actionTimer + 1

    return 0
end

local kingCharName = {
    [0] = {
        name = "None",
        subName = "Literally Nobody",
    },
    [1] = {
        name = "King",
        subName = "The Memer",
    },
    [2] = {
        name = "Old",
        subName = "King from v2",
    },
    [3] = {
        name = "Maximum",
        subName = "this isnt technically a character, i just use it so the character select cant go over the highest character slot",
    }
}

function hud_char()
    local m = gMarioStates[0]
    local character = "None"
    local string = ''

    djui_hud_set_resolution(RESOLUTION_N64)

    local screenHeight = djui_hud_get_screen_height()
    local screenWidth = djui_hud_get_screen_width()

    character = kingCharName[king].name
    string = kingCharName[king].subName

    local y = (screenHeight / 2) - 32

    if m.action == ACT_CHAR_SELECT then
        --if (m.controller.buttonDown & B_BUTTON) ~= 0 then
        --    if king == K_CHAR_KING then
        --        djui_hud_render_texture(TEX_MOVESET_KING, screenWidth / 2, y, 1, 1)
        --    end
        --end

        djui_hud_set_font(FONT_HUD)
        djui_hud_print_text(character, ((screenWidth / 2) - (djui_hud_measure_text(character) / 2) * 1), y + 110, 1)
        djui_hud_print_text("Character Select", ((screenWidth / 2) - (djui_hud_measure_text("Character Select") / 2) * 1), y - 80, 1)

        djui_hud_set_font(FONT_MENU)
        djui_hud_print_text("<", (((screenWidth / 2) - (djui_hud_measure_text("<") / 2) * 0.75) - (screenWidth / 2.5)) - xL, y, 0.75)
        djui_hud_print_text(">", (((screenWidth / 2) - (djui_hud_measure_text(">") / 2) * 0.75) + (screenWidth / 2.5)) + xR, y, 0.75)

        djui_hud_set_font(FONT_NORMAL)

        djui_hud_set_color(0, 0, 0, 128)
        djui_hud_print_text(string, ((screenWidth / 2) - (djui_hud_measure_text(string) / 2) * 0.5) + 1, y + 125 + 1, 0.5)

        djui_hud_set_color(252, 252, 252, 255)
        djui_hud_print_text(string, ((screenWidth / 2) - (djui_hud_measure_text(string) / 2) * 0.5), y + 125, 0.5)
    end
end

function on_hud_render()
    hud_char()
end

-----------
-- hooks --
-----------

hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)
hook_event(HOOK_ON_HUD_RENDER, on_hud_render)

hook_mario_action(ACT_CHAR_SELECT, act_char_select)
hook_chat_command("king", "[On|Off|Settings] Toggle King On/Off and Enter the Settings", king_command)

hook_event(HOOK_OBJECT_SET_MODEL, function(o, id)
    if obj_has_behavior_id(o, id_bhvMario) ~= 0 then
        local i = network_local_index_from_global(o.globalPlayerIndex)
        if gPlayerSyncTable[i].modelId ~= nil and obj_has_model_extended(o, gPlayerSyncTable[i].modelId) == 0 then
            obj_set_model_extended(o, gPlayerSyncTable[i].modelId)
        end
    end
end)