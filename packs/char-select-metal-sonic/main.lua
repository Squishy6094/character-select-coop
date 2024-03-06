-- name: [CS] Metal Sonic
-- description: He MAY know everything you're going to do.

local E_MODEL_WARIOPLIER_METAL = smlua_model_util_get_id("warioplier_metal_geo")

local TEXT_MOD_NAME = "[CS] Metal Sonic"

local VOICETABLE_BLANK = {
    [CHAR_SOUND_ATTACKED] = 'metal.ogg',
    [CHAR_SOUND_DROWNING] = 'metal.ogg',
    [CHAR_SOUND_DYING] = 'metal.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'metal.ogg',
    [CHAR_SOUND_HAHA] = 'metal.ogg',
    [CHAR_SOUND_HAHA_2] = 'metal.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'metal.ogg',
    [CHAR_SOUND_HOOHOO] = 'metal.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'metal.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'metal.ogg',
    [CHAR_SOUND_ON_FIRE] = 'metal.ogg',
    [CHAR_SOUND_OOOF] = 'metal.ogg',
    [CHAR_SOUND_OOOF2] = 'metal.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'metal.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'metal.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'metal.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'metal.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'metal.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'metal.ogg',
    [CHAR_SOUND_WAH2] = 'metal.ogg',
    [CHAR_SOUND_WHOA] = 'metal.ogg',
    [CHAR_SOUND_YAHOO] = 'metal.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'metal.ogg', 'metal.ogg', 'metal.ogg'},
    [CHAR_SOUND_YAH_WAH_HOO] = {'metal.ogg', 'metal.ogg', 'metal.ogg'},
}

if _G.charSelectExists then
    CT_CHAR = _G.charSelect.character_add("Metal Sonic", {"I get it! You're synchronizing yourself with Metal!"}, "Warioplier", {r = 0, g = 0, b = 255}, E_MODEL_WARIOPLIER_METAL, CT_MARIO, gTextures.mario_head)

    _G.charSelect.character_add_voice(E_MODEL_WARIOPLIER_METAL, VOICETABLE_BLANK)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_BLANK then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_BLANK then return _G.charSelect.voice.snore(m) end
    end)

else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end