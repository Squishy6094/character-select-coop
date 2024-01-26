-- name: [CS] Dry Bones Model
-- description: A Dry Bones player model!\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

--[[
    API Documentation for Character Select can be found below:
    https://github.com/Squishy6094/character-select-coop/blob/main/API-doc.md

    Use this if you're curious on how anything here works >v<
]]

local E_MODEL_CUSTOM_MODEL = smlua_model_util_get_id("drybones_geo")

local TEX_CUSTOM_ICON = get_texture_info("drybones-icon")

local TEXT_MOD_NAME = "[CS] Dry Bones"

local VOICETABLE_CHAR = {
    [CHAR_SOUND_ATTACKED] = 'db_ouch.ogg',
    [CHAR_SOUND_DOH] = 'db_gah.ogg',
    [CHAR_SOUND_DROWNING] = 'db_die.ogg',
    [CHAR_SOUND_DYING] = 'db_die.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'db_flip.ogg',
    [CHAR_SOUND_HAHA] = 'db_yay.ogg',
    [CHAR_SOUND_HAHA_2] = 'db_yay.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'db_veryyay.ogg',
    [CHAR_SOUND_HOOHOO] = 'db_yoop.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'db_yay.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'db_yay.ogg',
    [CHAR_SOUND_LETS_A_GO] = "db_letsgo.ogg",
    [CHAR_SOUND_ON_FIRE] = 'db_yell.ogg',
    [CHAR_SOUND_OOOF] = 'db_oof.ogg',
    [CHAR_SOUND_OOOF2] = 'db_oof.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'db_hit2.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'db_hit1.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'db_hit0.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'db_yay.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'db_flip.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'db_die.ogg',
    [CHAR_SOUND_WAH2] = 'db_hit1.ogg',
    [CHAR_SOUND_WHOA] = 'db_woah.ogg',
    [CHAR_SOUND_YAHOO] = 'db_zoom.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = 'db_bigjump.ogg',
    [CHAR_SOUND_YAH_WAH_HOO] = 'db_jump.ogg',
}

--[[
local capModels = {
    normal = smlua_model_util_get_id("drybones_cap_geo"),
    wing = smlua_model_util_get_id("drybones_wing_cap_geo"),
    metal = smlua_model_util_get_id("drybones_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("drybones_metal_wing_cap_geo")
}
]]

if _G.charSelectExists then
    CT_CHAR = _G.charSelect.character_add("Dry Bones", {"It's Dry Bones!", "What a lil guy!!"}, "wibblus", {r = 255, g = 200, b = 200}, E_MODEL_CUSTOM_MODEL, CT_MARIO, TEX_CUSTOM_ICON)
    
    --_G.charSelect.character_add_caps(E_MODEL_CUSTOM_MODEL, capModels)

    _G.charSelect.character_add_voice(E_MODEL_CUSTOM_MODEL, VOICETABLE_CHAR)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_CHAR then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_CHAR then return _G.charSelect.voice.snore(m) end
    end)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end