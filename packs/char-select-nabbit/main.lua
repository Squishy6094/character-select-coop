-- name: [CS] Nabbit
-- description: Nabbit is playable with CS!!\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

local E_MODEL_NABBIT = smlua_model_util_get_id("nabbit_geo")

local TEX_NABBIT_ICON = get_texture_info("nabbit-icon")

local TEXT_MOD_NAME = "[CS] Mouser"

local VOICETABLE_NABBIT = {
    [CHAR_SOUND_ATTACKED] = 'ouch.ogg',
    [CHAR_SOUND_COUGHING1] = 'gah1.ogg',
    [CHAR_SOUND_COUGHING2] = 'gah1.ogg',
    [CHAR_SOUND_COUGHING3] = 'guh.ogg',
    [CHAR_SOUND_DOH] = 'nyo.ogg',
    [CHAR_SOUND_DROWNING] = 'drowning.ogg',
    [CHAR_SOUND_DYING] = 'dying.ogg',
    [CHAR_SOUND_EEUH] = 'eeyup.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'woah.ogg',
    [CHAR_SOUND_HAHA] = 'hehehe.ogg',
    [CHAR_SOUND_HAHA_2] = 'hehehe.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'yipee_big.ogg',
    [CHAR_SOUND_HOOHOO] = 'wehe.ogg',
    [CHAR_SOUND_HRMM] = 'eeyup.ogg',
    [CHAR_SOUND_IMA_TIRED] = 'eepy.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'angy.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'letsgo.ogg',
    [CHAR_SOUND_ON_FIRE] = 'hothot.ogg',
    [CHAR_SOUND_OOOF] = 'gah0.ogg',
    [CHAR_SOUND_OOOF2] = 'gah1.ogg',
    [CHAR_SOUND_PANTING] = 'pant.ogg',
    [CHAR_SOUND_PANTING_COLD] = 'pant.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'hit2.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'hit1.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'hit0.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'letsgo.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'yipee2.ogg',
    [CHAR_SOUND_UH] = 'guh.ogg',
    [CHAR_SOUND_UH2] = 'guh.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'falling.ogg',
    [CHAR_SOUND_WAH2] = 'hit1.ogg',
    [CHAR_SOUND_WHOA] = 'woah.ogg',
    [CHAR_SOUND_YAHOO] = 'whee.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'yipee0.ogg', 'yipee1.ogg', 'yipee2.ogg'},
    [CHAR_SOUND_YAH_WAH_HOO] = {'jump0.ogg', 'jump1.ogg', 'jump2.ogg'},
}


local capModels = {
    normal = smlua_model_util_get_id("nabbit_cap_geo"),
    wing = smlua_model_util_get_id("nabbit_wing_cap_geo"),
    metal = smlua_model_util_get_id("nabbit_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("nabbit_metal_wing_cap_geo")
}


if _G.charSelectExists then
    CT_CHAR = _G.charSelect.character_add("Nabbit", {"Resident creature of the Mushroom Kingdom;", "What will they nab today..."}, "wibblus", {r = 170, g = 50, b = 200}, E_MODEL_NABBIT, CT_MARIO, TEX_NABBIT_ICON)

    _G.charSelect.character_add_caps(E_MODEL_NABBIT, capModels)

    -- the following must be hooked for each character added
    _G.charSelect.character_add_voice(E_MODEL_NABBIT, VOICETABLE_NABBIT)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_NABBIT then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_NABBIT then return _G.charSelect.voice.snore(m) end
    end)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end