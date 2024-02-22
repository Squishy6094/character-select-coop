---@diagnostic disable: assign-type-mismatch

BOWS_SOUND_SHELL = audio_sample_load('shell_speen.ogg')

local bowsVoiceTable = {
    [CHAR_SOUND_ATTACKED] = 'bw_ouch.ogg',
    [CHAR_SOUND_DOH] = 'bw_bonk2.ogg',
    [CHAR_SOUND_DROWNING] = 'bw_dying.ogg',
    [CHAR_SOUND_DYING] = 'bw_dying.ogg',
    [CHAR_SOUND_EEUH] = 'bw_jump0.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'bw_bonk0.ogg',
    [CHAR_SOUND_HAHA] = 'bw_haha.ogg',
    [CHAR_SOUND_HAHA_2] = 'bw_haha.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'bw_herewego.ogg',
    [CHAR_SOUND_HOOHOO] = 'bw_doublejump.ogg',
    [CHAR_SOUND_HRMM] = 'bw_bonk2.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'bw_mamamia.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'bw_letsgo.ogg',
    [CHAR_SOUND_ON_FIRE] = 'bw_hothot.ogg',
    [CHAR_SOUND_OOOF] = 'bw_bonk0.ogg',
    [CHAR_SOUND_OOOF2] = 'bw_bonk0.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'bw_attack2.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'bw_jump1.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'bw_attack1.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'bw_haha.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'bw_wahoo1.ogg',
    [CHAR_SOUND_UH2] = 'bw_bonk1.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'bw_falling.ogg',
    [CHAR_SOUND_WAH2] = 'bw_attack2.ogg',
    [CHAR_SOUND_WHOA] = 'bw_bonk2.ogg',
    [CHAR_SOUND_YAHOO] = 'bw_wahoo1.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'bw_wahoo0.ogg', 'bw_wahoo1.ogg'},
    [CHAR_SOUND_YAH_WAH_HOO] = {'bw_jump0.ogg', 'bw_jump1.ogg'},
}

if _G.charSelectExists then

    _G.charSelect.character_add_voice(E_MODEL_BOWSER_PLAYER, bowsVoiceTable)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == bowsVoiceTable then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == bowsVoiceTable then return _G.charSelect.voice.snore(m) end
    end)

else
    -- do my own sound system bs

    -- load all audio samples over the values from voice table
    for key, value in pairs(bowsVoiceTable) do
        if type(value) == 'table' then
            for i = 1, #value, 1 do
                bowsVoiceTable[key][i] = audio_sample_load(value[i])
            end
        else
            bowsVoiceTable[key] = audio_sample_load(value)
        end
    end

    -- table that tracks the last played custom voice sample for each player
    ---@type table<integer, BassAudio>
    gPrevCustomSamples = {}

    ---@param m MarioState
    ---@param soundID CharacterSound
    hook_event(HOOK_CHARACTER_SOUND, function (m, soundID)
        if gPlayerSyncTable[m.playerIndex].bowserState == 0 then return end

        ---@type BassAudio|table
        local charSound = bowsVoiceTable[soundID]
        if charSound == nil then return 0 end

        local sample = gPrevCustomSamples[m.playerIndex]
        -- stop the last playing audio sample
        if sample ~= nil then audio_sample_stop(sample) end

        -- shit code checks if this is a sample or table of samples
        if charSound.file == nil then
            sample = charSound[math.random(#charSound)]
        else
            sample = charSound
        end

        if m.playerIndex == 0 and (m.area == nil or m.area.camera == nil) then
            -- adjust playback for menus, etc.
            audio_sample_play(sample, {x=0, y=0, z=0}, 1.0)
        else
            play_bowser_character_sound(m, sample, 1.0)
        end
        gPrevCustomSamples[m.playerIndex] = sample

        return 0
    end)

end

---@param m MarioState
---@param sample BassAudio
function play_bowser_character_sound(m, sample, vol)
    if is_game_paused() then vol = 0.1 end
    audio_sample_play(sample, m.pos, vol)
end