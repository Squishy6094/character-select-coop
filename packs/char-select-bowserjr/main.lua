-- name: [CS] Bowser Jr
-- description: Bowser Jr is playable!\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

local E_MODEL_JR = smlua_model_util_get_id("bowserjr_geo")

local TEX_JR_ICON = get_texture_info("bowserjr-icon")

local TEXT_MOD_NAME = "[CS] Bowser Jr"

local VOICETABLE_JR = {
    [CHAR_SOUND_ATTACKED] = 'jr_ouch.ogg',
    [CHAR_SOUND_COUGHING1] = 'jr_hot.ogg',
    [CHAR_SOUND_DOH] = 'jr_oh.ogg',
    [CHAR_SOUND_DROWNING] = 'jr_sad2.ogg',
    [CHAR_SOUND_DYING] = 'jr_sad2.ogg',
    [CHAR_SOUND_EEUH] = 'jr_grah.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'jr_grah2.ogg',
    [CHAR_SOUND_HAHA] = 'jr_yes.ogg',
    [CHAR_SOUND_HAHA_2] = 'jr_yes.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'jr_yeah.ogg',
    [CHAR_SOUND_HOOHOO] = 'jr_woop.ogg',
    [CHAR_SOUND_HRMM] = 'jr_waow.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'jr_ohno.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'jr_hehe.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'jr_hehe.ogg',
    [CHAR_SOUND_ON_FIRE] = 'jr_hot.ogg',
    [CHAR_SOUND_OOOF] = 'jr_ouch.ogg',
    [CHAR_SOUND_OOOF2] = 'jr_waow.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'jr_heyy.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'jr_wuh.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'jr_ha.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'jr_hehe.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'jr_yeah2.ogg',
    [CHAR_SOUND_UH2] = 'jr_oh.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'jr_sad.ogg',
    [CHAR_SOUND_WAH2] = 'jr_ha.ogg',
    [CHAR_SOUND_WHOA] = 'jr_waow.ogg',
    [CHAR_SOUND_YAHOO] = 'jr_woohoo.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'jr_wheeee.ogg', 'jr_woohoo.ogg', 'jr_grah2.ogg'},
    [CHAR_SOUND_YAH_WAH_HOO] = {'jr_ya.ogg', 'jr_ha.ogg', 'jr_wuh.ogg'},
}

--[[
local capModels = {
    normal = smlua_model_util_get_id("bowserjr_cap_geo"),
    wing = smlua_model_util_get_id("bowserjr_wing_cap_geo"),
    metal = smlua_model_util_get_id("bowserjr_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("bowserjr_metal_wing_cap_geo")
}
]]

if _G.charSelectExists then
    CT_CHAR = _G.charSelect.character_add("Bowser Jr", {"It's Junior!", "What's he up to?"}, "wibblus", {r = 255, g = 200, b = 200}, E_MODEL_JR, CT_MARIO, TEX_JR_ICON)

    --_G.charSelect.character_add_caps(E_MODEL_JR, capModels)

    -- the following must be hooked for each character added
    _G.charSelect.character_add_voice(E_MODEL_JR, VOICETABLE_JR)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_JR then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_JR then return _G.charSelect.voice.snore(m) end
    end)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end