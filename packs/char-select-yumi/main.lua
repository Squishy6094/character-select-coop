-- name: [CS] Yumi Martinez 
-- description: A girl from New York. I wonder what\nshe's doing here?\n\nModels by: Frijoles Y Queso\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

local E_MODEL_YUMI = smlua_model_util_get_id("yumi_geo")

-- Model Pack name used 
local TEXT_MOD_NAME = "Yumi Martinez"

local VOICETABLE_YUMI = {
    [CHAR_SOUND_ATTACKED] = 'YumiHurtHard.ogg',
    [CHAR_SOUND_DROWNING] = 'YumiDrown.ogg',
    [CHAR_SOUND_DYING] = 'YumiDrown.ogg',
    [CHAR_SOUND_EEUH] = 'YumiPickUp.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'YumiWin.ogg',
    [CHAR_SOUND_IMA_TIRED] = 'YumiTired.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'YumiLetsGo.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'YumiMamaMia.ogg',
    [CHAR_SOUND_ON_FIRE] = 'YumiBurn.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'YumiSoLong.ogg',
    [CHAR_SOUND_UH] = 'YumiHurt.ogg',
    [CHAR_SOUND_UH2] = 'YumiHurtHard.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'YumiScreamFall.ogg',
    [CHAR_SOUND_WHOA] = 'YumiPickUp.ogg',
}

if _G.charSelectExists then
    _G.charSelect.character_add("Yumi", {"A girl from New York.", "I wonder what she's doing here?"}, "frijoles.z64", {r = 90, g = 90, b = 220}, E_MODEL_YUMI, CT_LUIGI)

    _G.charSelect.character_add_voice(E_MODEL_YUMI, VOICETABLE_YUMI)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_YUMI then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_YUMI then return _G.charSelect.voice.snore(m) end
    end)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end