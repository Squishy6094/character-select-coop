for i = 0, MAX_PLAYERS -1, 1 do
    gPlayerSyncTable[i].customVoice = 0
end

local killVoice = true
local voicecount = 0
local unloadedvoices = {}

--How many snores the sleep-talk has, or rather, how long the sleep-talk lasts
--If you omit the sleep-talk you can ignore this
local SLEEP_TALK_SNORES = 8

--Define what actions play what voice clips
--If an action has more than one voice clip, put those clips inside a table
--CHAR_SOUND_SNORING3 requires two or three voice clips to work properly...
--but you can omit it if your character does not sleep-talk


--Define the table of samples that will be used for each player
--Global so if multiple mods use this they won't create unneeded samples
--DON'T MODIFY THIS SINCE IT'S GLOBAL FOR USE BY OTHER MODS!
gCustomVoiceSamples = {}
gCustomVoiceSamplesBackup = {}
gCustomVoiceStream = nil

--Define what triggers the custom voice
local function use_custom_voice(m)
    return _G.charSelect.character_get_voice(m) ~= nil and gPlayerSyncTable[m.playerIndex].customVoice and killVoice
end

--Get the player's sample, stop whatever sound
--it's playing if it doesn't match the provided sound
--DON'T MODIFY THIS SINCE IT'S GLOBAL FOR USE BY OTHER MODS!
--- @param m MarioState
function stop_custom_character_sound(m, sound)
    local voice_sample = gCustomVoiceSamples[m.playerIndex]
    if voice_sample == false and gCustomVoiceSamplesBackup[m.playerIndex].loaded then
        audio_sample_stop(gCustomVoiceSamplesBackup[m.playerIndex])
        audio_sample_destroy(gCustomVoiceSamplesBackup[m.playerIndex])
        voicecount = voicecount - 1
        gCustomVoiceSamplesBackup[m.playerIndex] = nil
        return
    end
    if voice_sample == nil or type(voice_sample) == "boolean" then
        return
    end
    --TO-DO: write code that uses the backup table when required (set backup index to true, then detect true in code)
    if not voice_sample.loaded then
        -- table.insert(unloadedvoices, voice_sample)
        -- voicecount = voicecount - 1
        print("rerouting to backup")
        gCustomVoiceSamplesBackup[m.playerIndex] = true
        -- gCustomVoiceSamples[m.playerIndex] = nil
        return
    end

    audio_sample_stop(voice_sample)
    if voice_sample.file.relativePath:match('^.+/(.+)$') == sound then
        return voice_sample
    end
    audio_sample_destroy(voice_sample)
    voicecount = voicecount - 1
end

--Play a custom character's sound
--DON'T MODIFY THIS SINCE IT'S GLOBAL FOR USE BY OTHER MODS!
--- @param m MarioState
function play_custom_character_sound(m, voice)
    --Get sound, if it's a table, get a random entry from it
    local sound
    if type(voice) == "table" then
        sound = voice[math.random(#voice)]
    else
        sound = voice
    end
    if sound == nil then return 0 end

    --Get current sample and stop it
    local voice_sample = stop_custom_character_sound(m, sound)

    --If the new sound isn't a string, let's assume it's
    --a number to return to the character sound hook
    if type(sound) ~= "string" then
        return sound
    end

    --Load a new sample and play it! Don't make a new one if we don't need to
    if (m.area == nil or m.area.camera == nil) and m.playerIndex == 0 then
        if gCustomVoiceStream ~= nil then
            audio_stream_stop(gCustomVoiceStream)
            audio_stream_destroy(gCustomVoiceStream)
        end
        gCustomVoiceStream = audio_stream_load(sound)
        audio_stream_play(gCustomVoiceStream, true, 1)
    else
        if voice_sample == nil then
            voice_sample = audio_sample_load(sound)
			while not voice_sample.loaded do end
            voicecount = voicecount + 1
        end
        audio_sample_play(voice_sample, m.pos, 1)

        if gCustomVoiceSamplesBackup[m.playerIndex] ~= nil and not(gCustomVoiceSamples[m.playerIndex] == false) then
            gCustomVoiceSamplesBackup[m.playerIndex] = voice_sample
        else
            gCustomVoiceSamples[m.playerIndex] = voice_sample
        end
    end
    return 0
end

--Main character sound hook
--This hook is freely modifiable in case you want to make any specific exceptions
--- @param m MarioState
local function custom_character_sound(m, characterSound)
    if not _G.charSelect.character_get_voice(m) then return end
    if characterSound == CHAR_SOUND_SNORING3 then return 0 end
    if characterSound == CHAR_SOUND_HAHA and m.hurtCounter > 0 then return 0 end

    local voice = _G.charSelect.character_get_voice(m)[characterSound]
    if voice ~= nil then
        return play_custom_character_sound(m, voice)
    end
    return 0
end

--hook_event(HOOK_CHARACTER_SOUND, custom_character_sound)

--Snoring logic for CHAR_SOUND_SNORING3 since we have to loop it manually
--This code won't activate on the Japanese version, due to MARIO_MARIO_SOUND_PLAYED not being set
local STARTING_SNORE = 46
local SLEEP_TALK_START = STARTING_SNORE + 49
local SLEEP_TALK_END = SLEEP_TALK_START + SLEEP_TALK_SNORES

--Main hook for snoring
--- @param m MarioState
local function custom_character_snore(m)
    if not _G.charSelect.character_get_voice(m) then return end
    if gCustomVoiceSamplesBackup[m.playerIndex] ~= nil and not (gCustomVoiceSamples[m.playerIndex] == false) then
        if gCustomVoiceSamples[m.playerIndex].loaded then
            audio_sample_destroy(gCustomVoiceSamples[m.playerIndex])
            voicecount = voicecount - 1
            --djui_chat_message_create("eliminated unloaded voice")
            gCustomVoiceSamples[m.playerIndex] = false
        end
    end
    local SNORE3_TABLE = _G.charSelect.character_get_voice(m)[CHAR_SOUND_SNORING3]
    
    --Stop the snoring!
    if m.action ~= ACT_SLEEPING then
        if m.isSnoring > 0 then
            --stop_custom_character_sound(m)
            play_custom_character_sound(m, 'rien.mp3')
        end
        return

    --You're not in deep snoring
    elseif not (m.actionState == 2 and (m.flags & MARIO_MARIO_SOUND_PLAYED) ~= 0) then
        return
    end

    local animFrame = m.marioObj.header.gfx.animInfo.animFrame

    --Behavior for CHAR_SOUND_SNORING3
    if SNORE3_TABLE ~= nil and #SNORE3_TABLE >= 2 then
        --Exhale sound
        if animFrame == 2 and m.actionTimer < SLEEP_TALK_START then
            play_custom_character_sound(m, SNORE3_TABLE[2])

        --Inhale sound
        elseif animFrame == 25 then
            
            --Count up snores
            if #SNORE3_TABLE >= 3 then
                m.actionTimer = m.actionTimer + 1

                --End sleep-talk
                if m.actionTimer >= SLEEP_TALK_END then
                    m.actionTimer = STARTING_SNORE
                end
    
                --Enough snores? Start sleep-talk
                if m.actionTimer == SLEEP_TALK_START then
                    play_custom_character_sound(m, SNORE3_TABLE[3])
                
                --Regular snoring
                elseif m.actionTimer < SLEEP_TALK_START then
                    play_custom_character_sound(m, SNORE3_TABLE[1])
                end
            
            --Definitely regular snoring
            else
                play_custom_character_sound(m, SNORE3_TABLE[1])
            end
        end

    --No CHAR_SOUND_SNORING3, just use regular snoring
    elseif animFrame == 2 then
        play_character_sound(m, CHAR_SOUND_SNORING2)

    elseif animFrame == 25 then
        play_character_sound(m, CHAR_SOUND_SNORING1)
    end
end
--hook_event(HOOK_MARIO_UPDATE, custom_character_snore)

_G.charSelect.voice = {
    sound = custom_character_sound,
    snore = custom_character_snore
}

gPlayerSyncTable[0].customVoice = true

-- function togglevoice_command(msg)
--     gPlayerSyncTable[0].customVoice = not gPlayerSyncTable[0].customVoice
--     if gPlayerSyncTable[0].customVoice then
-- 		gPlayerSyncTable[0].customShift = true
--         djui_chat_message_create("Custom voice is \\#30FF30\\ON!")
--     else
--         djui_chat_message_create("Custom voice is \\#FF3030\\OFF!")
--     end
--     return true
-- end

-- hook_chat_command("customvoice_m", "- Toggle custom voices for your player!", togglevoice_command)

-- hook_chat_command("stopallvoice_m", "- Locally stop custom voices for everyone, in case they get muted!", function ()
--     killVoice = false
-- 	djui_chat_message_create("\\#FF3030\\Custom voices permanently disabled! \\#FFFFFF\\Rejoin or rehost to restore them!")
-- 	return true
-- end)
--[[hook_event(HOOK_ON_HUD_RENDER, function ()
    djui_hud_set_resolution(RESOLUTION_DJUI)
    local x = djui_hud_get_mouse_x()
    local y = djui_hud_get_mouse_y()
    djui_hud_print_text(tostring(voicecount),x,y,djui_hud_get_screen_height()/700)
    djui_hud_print_text(tostring(#unloadedvoices),x,y+20*djui_hud_get_screen_height()/700,djui_hud_get_screen_height()/700)
end)
hook_event(HOOK_UPDATE,function ()
    if #unloadedvoices == 0 then return end
    print(#unloadedvoices)
    print(unloadedvoices[#unloadedvoices].loaded)
    if unloadedvoices[#unloadedvoices].loaded then
        audio_sample_destroy(unloadedvoices[#unloadedvoices])
        table.remove(unloadedvoices, #unloadedvoices)
        djui_chat_message_create("unloaded sample destroyed")
    end
end)]]
