SOUND_KING_BOUNCE = audio_sample_load("Boing.mp3")
SOUND_VANILLA_KING_BOUNCE = SOUND_ARG_LOAD(SOUND_BANK_OBJ, 0x64, 0x81, SOUND_NO_PRIORITY_LOSS | SOUND_DISCRETE)

SOUND_KING_CHARGE = audio_sample_load("Charge.mp3")
SOUND_VANILLA_KING_CHARGE = SOUND_ARG_LOAD(SOUND_BANK_ACTION, 0x5E, 0x81, SOUND_NO_PRIORITY_LOSS | SOUND_DISCRETE)

SOUND_KING_DASH = audio_sample_load("Dash.mp3")
SOUND_VANILLA_KING_DASH = SOUND_ARG_LOAD(SOUND_BANK_ACTION, 0x56, 0x81, SOUND_NO_PRIORITY_LOSS | SOUND_DISCRETE)

SOUND_KING_DJUMP = audio_sample_load("Djump.mp3")
SOUND_KING_JUMP = audio_sample_load("Jump.mp3")
SOUND_VANILLA_KING_JUMP = SOUND_ARG_LOAD(SOUND_BANK_OBJ, 0x4C, 0x81, SOUND_NO_PRIORITY_LOSS | SOUND_DISCRETE)

SOUND_KING_BOING = audio_sample_load("Spring.mp3")
SOUND_VANILLA_KING_BOING = SOUND_ARG_LOAD(SOUND_BANK_GENERAL, 0x6D, 0x81, SOUND_NO_PRIORITY_LOSS | SOUND_DISCRETE)

SOUND_KING_SLAM = audio_sample_load("Slam.mp3")

SOUND_KING_WOKEN_ON = audio_sample_load("WokenOn.mp3")


--Main character sound hook
--This hook is freely modifiable in case you want to make any specific exceptions
--- @param m MarioState
local function no_character_sound(m)
    if king == K_CHAR_NONE then
        return
    end
    return 0
end
hook_event(HOOK_CHARACTER_SOUND, no_character_sound)

SFXMode = 0

function play_king_sfx(m, sound)
    if SFXMode == 0 then
        if sound == 0 then
            audio_sample_stop(SOUND_KING_BOUNCE)
            audio_sample_play(SOUND_KING_BOUNCE, m.pos, 1)
        end
        if sound == 1 then
            audio_sample_stop(SOUND_KING_CHARGE)
            audio_sample_play(SOUND_KING_CHARGE, m.pos, 0.25)
        end
        if sound == 2 then
            audio_sample_stop(SOUND_KING_DASH)
            audio_sample_play(SOUND_KING_DASH, m.pos, 1)
        end
        if sound == 3 then
            audio_sample_stop(SOUND_KING_DJUMP)
            audio_sample_play(SOUND_KING_DJUMP, m.pos, 1)
        end
        if sound == 4 then
            audio_sample_stop(SOUND_KING_JUMP)
            audio_sample_play(SOUND_KING_JUMP, m.pos, 1)
        end
        if sound == 5 then
            audio_sample_stop(SOUND_KING_BOING)
            audio_sample_play(SOUND_KING_BOING, m.pos, 1)
        end
        if sound == 6 then
            audio_sample_stop(SOUND_KING_SLAM)
            audio_sample_play(SOUND_KING_SLAM, m.pos, 2)
        end
    elseif SFXMode == 1 then
        if sound == 0 then
            play_sound(SOUND_VANILLA_KING_BOUNCE, m.marioObj.header.gfx.cameraToObject)
        end
        if sound == 1 then
            play_sound(SOUND_VANILLA_KING_CHARGE, m.marioObj.header.gfx.cameraToObject)
        end
        if sound == 2 then
            play_sound(SOUND_VANILLA_KING_DASH, m.marioObj.header.gfx.cameraToObject)
        end
        if sound == 3 then
            play_sound_with_freq_scale(SOUND_VANILLA_KING_JUMP, m.marioObj.header.gfx.cameraToObject, 1.1)
        end
        if sound == 4 then
            play_sound(SOUND_VANILLA_KING_JUMP, m.marioObj.header.gfx.cameraToObject)
        end
        if sound == 5 then
            play_sound(SOUND_VANILLA_KING_BOING, m.marioObj.header.gfx.cameraToObject)
        end
        if sound == 5 then
            play_sound(SOUND_VANILLA_KING_BOING, m.marioObj.header.gfx.cameraToObject)
        end
        if sound == 6 then
            play_mario_heavy_landing_sound(m, SOUND_ACTION_TERRAIN_HEAVY_LANDING)
        end
    end
end