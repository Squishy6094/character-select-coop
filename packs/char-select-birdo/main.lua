-- name: [CS] Birdo Model
-- description: Birdo made playable using CS :] \n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!



local E_MODEL_BIRDO = smlua_model_util_get_id("birdo_geo")

local TEX_BIRDO = get_texture_info("Birdo_icon")

local TEXT_MOD_NAME = "[CS] Birdo"

local VOICETABLE_BIRDO = {
    [CHAR_SOUND_YAH_WAH_HOO] = '[YAHWAHHOO]wow-.ogg',
    [CHAR_SOUND_HOOHOO] = '[HOOHOO]woow.ogg',
    [CHAR_SOUND_YAHOO] = '[YAHOO]yaho.ogg',
    [CHAR_SOUND_UH] = '[UH]ahrg.ogg',
    [CHAR_SOUND_HRMM] = '[HRMM]oww.ogg',
    [CHAR_SOUND_WAH2] = '[WAH2]wha!.ogg',
    [CHAR_SOUND_WHOA] = '[WHOA]wow-.ogg',
    [CHAR_SOUND_EEUH] = '[EEUH]-ya.ogg',
    [CHAR_SOUND_ATTACKED] = '[ATTACKED]oow.ogg',
    [CHAR_SOUND_OOOF] = '[OOF]owoo.ogg',
    [CHAR_SOUND_OOOF2] = '[OOF2]owno.ogg',
    [CHAR_SOUND_HERE_WE_GO] = '[HEREWEGO]happycry.ogg',
    [CHAR_SOUND_YAWNING] = '[YAWNING]cry.ogg',
    [CHAR_SOUND_WAAAOOOW] = '[WAAAOOOW]owowowowo.ogg',
    [CHAR_SOUND_HAHA] = '[HAHA]wwa.ogg',
    [CHAR_SOUND_HAHA_2] = '[HAHA2]waah.ogg',
    [CHAR_SOUND_UH2] = '[UH2]no!.ogg',
    [CHAR_SOUND_UH2_2] = '[UH2_2]noo.ogg',
    [CHAR_SOUND_ON_FIRE] = '[ONFIRE]owowOW.ogg',
    [CHAR_SOUND_DYING] = '[DYING]nooooooo.ogg',
    [CHAR_SOUND_PANTING_COLD] = '[PANTINGCOLD]owa.ogg',
    [CHAR_SOUND_PANTING] = '[PANTING]oowrr.ogg',
    [CHAR_SOUND_COUGHING1] = '[COUGHING]oooh.ogg',
    [CHAR_SOUND_COUGHING2] = '[COUGHING2]ouch.ogg',
    [CHAR_SOUND_COUGHING3] = '[COUGHING3]ooooh.ogg',
    [CHAR_SOUND_PUNCH_YAH] = '[PUNCH]yaa.ogg',
    [CHAR_SOUND_PUNCH_HOO] = '[PUNCHHOO]oh-.ogg',
    [CHAR_SOUND_MAMA_MIA] = '[MAMAMIA]sadcry.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = '[GORUNDOUND]hm.ogg',
    [CHAR_SOUND_DROWNING] = '[DROWNING]drowning.ogg',
    [CHAR_SOUND_PUNCH_WAH] = '[PUNCH]wha.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = '[YIPEE]wihee.ogg',
    [CHAR_SOUND_DOH] = '[DOH]meh.ogg',
    [CHAR_SOUND_GAME_OVER] = '[GAMEOVER]ohnooo.ogg',
    [CHAR_SOUND_HELLO] = '[HELLO]hellohappy.ogg',
    [CHAR_SOUND_PRESS_START_TO_PLAY] = '[PRESSSTART]wooowhohoho.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = '[TWIRLBOUNCE]-yaaay.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = '[SOLONGHEYBOWSER]ya-ya-yaa.ogg',
    [CHAR_SOUND_IMA_TIRED] = '[IMATIRED]hmmm.ogg',
    [CHAR_SOUND_LETS_A_GO] = '[LETSAGO]letsgo.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = '[OKEYDOKEY]kipo.ogg',
}

if _G.charSelectExists then
    CT_CHAR = _G.charSelect.character_add("Birdo", {"Your favorite transgender dino!", "I recommend using the Yoshi moveset mod! :]"}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_BIRDO, CT_MARIO, TEX_BIRDO)

    -- the following must be hooked for each character added
    _G.charSelect.character_add_voice(E_MODEL_BIRDO, VOICETABLE_BIRDO)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_BIRDO then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_BIRDO then return _G.charSelect.voice.snore(m) end
    end)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end
