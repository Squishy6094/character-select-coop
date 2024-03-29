-- name: [CS] Model Pack Template
-- description: A Template for Character Select to build off of when making your own pack!\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

--[[
    API Documentation for Character Select can be found below:
    https://github.com/Squishy6094/character-select-coop/blob/main/API-doc.md

    Use this if you're curious on how anything here works >v<
]]

local E_MODEL_CUSTOM_MODEL = smlua_model_util_get_id("custom_model_geo")

local TEX_CUSTOM_ICON = get_texture_info("exclamation-icon")

local TEXT_MOD_NAME = "Character Template"

local VOICETABLE_CHAR = {
    [CHAR_SOUND_ATTACKED] = 'NES-Hit.ogg',
    [CHAR_SOUND_DOH] = 'NES-Bump.ogg',
    [CHAR_SOUND_DROWNING] = 'NES-Die.ogg',
    [CHAR_SOUND_DYING] = 'NES-Die.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'NES-Squish.ogg',
    [CHAR_SOUND_HAHA] = 'NES-1up.ogg',
    [CHAR_SOUND_HAHA_2] = 'NES-1up.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'NES-Flagpole.ogg',
    [CHAR_SOUND_HOOHOO] = 'NES-Jump.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'NES-Warp.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'NES-1up.ogg',
    [CHAR_SOUND_ON_FIRE] = 'NES-Enemy_Fire.ogg',
    [CHAR_SOUND_OOOF] = 'NES-Hit.ogg',
    [CHAR_SOUND_OOOF2] = 'NES-Hit.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'NES-Kick.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'NES-Thwomp.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'NES-Thwomp.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'NES-Bowser_Die.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'NES-Item.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'NES-Vine.ogg',
    [CHAR_SOUND_WAH2] = 'NES-Kick.ogg',
    [CHAR_SOUND_WHOA] = 'NES-Item.ogg',
    [CHAR_SOUND_YAHOO] = 'NES-Jump.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = 'NES-Jump.ogg',
    [CHAR_SOUND_YAH_WAH_HOO] = 'NES-Big_Jump.ogg',
    [CHAR_SOUND_YAWNING] = 'NES-Pause.ogg',
}


local CAPTABLE_CHAR = {
    normal = smlua_model_util_get_id("custom_model_cap_normal_geo"),
    wing = smlua_model_util_get_id("custom_model_cap_wing_geo"),
    metal = smlua_model_util_get_id("custom_model_cap_metal_geo"),
    metalWing = smlua_model_util_get_id("custom_model_cap_wing_geo"),
}

if _G.charSelectExists then
    CT_CHAR = _G.charSelect.character_add("Custom Model Name", {"Custom Model Description", "Custom Model Description"}, "Custom Model Creator", {r = 255, g = 200, b = 200}, E_MODEL_CUSTOM_MODEL, CT_MARIO, TEX_CUSTOM_ICON)
    _G.charSelect.character_add_caps(E_MODEL_CUSTOM_MODEL, CAPTABLE_CHAR)

    -- the following must be hooked for each character added
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