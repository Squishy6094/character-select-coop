local function on_sequence_load(player, seqId)
    local sequence = characterTable[currChar].replaceSeq[seqId]
    if sequence then
        djui_chat_message_create("yes")
        return sequence
    end
end

hook_event(HOOK_ON_SEQ_LOAD, on_sequence_load)