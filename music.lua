local currMusicData = {
    [SEQ_PLAYER_ENV] = nil,
    [SEQ_PLAYER_LEVEL] = nil,
    [SEQ_PLAYER_SFX] = nil,
}

local function on_sequence_load(player, seqId)
    if optionTable[optionTableRef.localVisuals].toggle ~= 1 then
        return
    end
    local sequence = run_func_or_get_var(characterTable[currChar].replaceSeq[seqId])
    
    if currMusicData[player] ~= nil then
        audio_stream_stop(currMusicData[player])
    end

    if type(sequence) == "userdata" then -- Audio Stream
        currMusicData[player] = sequence
        if player == SEQ_PLAYER_ENV then
            audio_stream_set_volume_channel(sequence, MOD_AUDIO_CHANNEL_ENV)
        elseif player == SEQ_PLAYER_LEVEL then
            audio_stream_set_volume_channel(sequence, MOD_AUDIO_CHANNEL_MUSIC)
        elseif player == SEQ_PLAYER_SFX then
            audio_stream_set_volume_channel(sequence, MOD_AUDIO_CHANNEL_SFX)
        end
        audio_stream_play(sequence, true, 1)
        return 0
    elseif type(sequence) == "number" then -- Default Sequence
        return sequence
    end
end

local function audio_stream_update()
    for player, stream in pairs(currMusicData) do
        local volume = sequence_player_get_fade_volume(player)
        local speed = 1
        if is_game_paused() then
            if gNetworkPlayers[0].currCourseNum == COURSE_NONE then
                volume = volume * 0.25
            else
                volume = 0
                speed = 0.01
            end
        end
        audio_stream_set_volume(stream, volume)
        audio_stream_set_frequency(stream, speed)
    end
end

hook_event(HOOK_ON_SEQ_LOAD, on_sequence_load)
hook_event(HOOK_UPDATE, audio_stream_update)