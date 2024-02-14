-- name: [CS] Wapeach
-- description: The long forgotten Wapeach is now playable! \n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!


local E_MODEL_WAPEACH = smlua_model_util_get_id("wapeach_geo")

local TEX_WAPEACH = get_texture_info("wapeach_icon")

local TEXT_MOD_NAME = "[CS] WAPEACH"

local VOICETABLE_WAPEACH = {
    [CHAR_SOUND_YAH_WAH_HOO] = {'jumpyah1.ogg', 'jumpyah2.ogg', 'jumpyah3.ogg', 'jumpyah4.ogg', 'jumpyah5.ogg', 'jumpyah6.ogg'},
    [CHAR_SOUND_HOOHOO] = 'hoohoo.ogg',
    [CHAR_SOUND_YAHOO] = 'yahoo.ogg',
    [CHAR_SOUND_UH] = 'uh.ogg',
    [CHAR_SOUND_HRMM] = 'hrmm.ogg',
    [CHAR_SOUND_WAH2] = 'wah2.ogg',
    [CHAR_SOUND_WHOA] = 'whoa.ogg',
    [CHAR_SOUND_EEUH] = 'eeuh.ogg',
    [CHAR_SOUND_ATTACKED] = 'attacked.ogg',
    [CHAR_SOUND_OOOF] = 'ooof.ogg',
    [CHAR_SOUND_OOOF2] = 'ooof2.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'here_we_go.ogg',
    [CHAR_SOUND_YAWNING] = 'yawning.ogg',
    [CHAR_SOUND_SNORING1] = {'snoring1.ogg', 'snoring4.ogg'},
    [CHAR_SOUND_SNORING2] = 'snoring2.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'waaaooow.ogg',
    [CHAR_SOUND_HAHA] = 'haha.ogg',
    [CHAR_SOUND_HAHA_2] = 'haha_2.ogg',
    [CHAR_SOUND_UH2] = 'uh2.ogg',
    [CHAR_SOUND_UH2_2] = 'uh2_2.ogg',
    [CHAR_SOUND_ON_FIRE] = 'on_fire.ogg',
    [CHAR_SOUND_DYING] = 'dying.ogg',
    [CHAR_SOUND_PANTING_COLD] = {'panting_cold1.ogg', 'panting_cold2.ogg', 'panting_cold3.ogg'},
    [CHAR_SOUND_PANTING] = {'panting1.ogg', 'panting2.ogg'},
    [CHAR_SOUND_COUGHING1] = 'coughing1.ogg',
    [CHAR_SOUND_COUGHING2] = 'coughing2.ogg',
    [CHAR_SOUND_COUGHING3] = 'coughing3.ogg',
    [CHAR_SOUND_PUNCH_YAH] = {'punch_yah.ogg', 'punch_yah2.ogg'},
    [CHAR_SOUND_PUNCH_HOO] = 'punch_hoo.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'mama_mia.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'ground_pound_wah.ogg',
    [CHAR_SOUND_DROWNING] = 'drowning.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'punch_wah.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'yahoo.ogg', 'waha.ogg'},
    [CHAR_SOUND_DOH] = 'doh.ogg',
    [CHAR_SOUND_GAME_OVER] = 'game_over.ogg',
    [CHAR_SOUND_HELLO] = 'hello.ogg',
    [CHAR_SOUND_PRESS_START_TO_PLAY] = 'press_start_to_play.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'twirl_bounce.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'so_longa_bowser.ogg',
    [CHAR_SOUND_IMA_TIRED] = 'ima_tired.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'lets_a_go.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'okey_dokey.ogg',
}

local capWapeach = {
    normal = smlua_model_util_get_id("wapeach_cap_geo"),
    wing = smlua_model_util_get_id("wapeach_wing_cap_geo"),
    metal = smlua_model_util_get_id("wapeach_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("wapeach_metal_wing_cap_geo")
}
_G.charSelect.character_add_caps(E_MODEL_WAPEACH, capWapeach)

if _G.charSelectExists then
    id_wapeach = _G.charSelect.character_add("Wapeach", {"Voiced by SodaVampyr!", "Press [Y] to pull out her axe!"}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_WAPEACH, CT_MARIO, TEX_WAPEACH)

    -- the following must be hooked for each character added
    _G.charSelect.character_add_voice(E_MODEL_WAPEACH, VOICETABLE_WAPEACH)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_WAPEACH then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_WAPEACH then return _G.charSelect.voice.snore(m) end
    end)

---@param m MarioState
    function on_update(m)
        -- local player
        if m.playerIndex == 0 then
            if gPlayerSyncTable[0].wapeach_axe_mode == nil then
                if _G.charSelect.character_get_current_model_number() == id_wapeach then gPlayerSyncTable[0].wapeach_axe_mode = false end
                return
            end

            if _G.charSelect.character_get_current_model_number() == id_wapeach then
                if (m.controller.buttonPressed & Y_BUTTON) ~= 0 and m.action == ACT_IDLE then
                    gPlayerSyncTable[0].wapeach_axe_mode = not gPlayerSyncTable[0].wapeach_axe_mode
                    set_mario_action(m, ACT_TRIPLE_JUMP_LAND, 0)
                end
            else
                -- skip this code if the player is not wapeach
                gPlayerSyncTable[0].wapeach_axe_mode = nil
            end
        end
        -- set axe hand
        if gPlayerSyncTable[m.playerIndex].wapeach_axe_mode and m.marioBodyState.handState == 0 then
            m.marioBodyState.handState = 2
        end
    end
    hook_event(HOOK_MARIO_UPDATE, on_update)


else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end
