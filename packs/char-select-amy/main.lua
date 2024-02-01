-- name: [CS] Classic Amy
-- description: Classic Amy CS pack by flipflop bell! (The icon is from Sonic Origins) \n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

--[[
    API Documentation for Character Select can be found below:
    https://github.com/Squishy6094/character-select-coop/blob/main/API-doc.md

    Use this if you're curious on how anything here works >v<
]]

local E_MODEL_AMY = smlua_model_util_get_id("amy_geo")

local TEX_ICON_AMY = get_texture_info("amy-icon")

local TEXT_MOD_NAME = "Classic Amy"

local VOICETABLE_AMY = {nil}
--[[
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

]]
--[[

    Table for Cap Models, this has been noted out due to the template not having these models.
    You can add these models in your respective actors folder like you would for any Character Model

local capModels = {
    normal = smlua_model_util_get_id("normal_cap_geo"),
    wing = smlua_model_util_get_id("wing_cap_geo"),
    metal = smlua_model_util_get_id("metal_cap_geo"),
    metalWing = smlua_model_util_get_id("metal_wing_cap_geo")
}

]]

if _G.charSelectExists then
    --CT_CHAR = _G.charSelect.character_add("Custom Model Name", {"Custom Model Description", "Custom Model Description"}, "Custom Model Creator", {r = 255, g = 200, b = 200}, E_MODEL_CUSTOM_MODEL, CT_MARIO, TEX_CUSTOM_ICON)
    CT_CHAR = _G.charSelect.character_add("Classic Amy", {"It's the superior Amy, Classic Amy > Modern Amy", "The icon is from Sonic Origins"}, "flipflop bell", {r = 0xff, g = 0x96, b = 0xc8}, E_MODEL_AMY, CT_MARIO, TEX_ICON_AMY)

    -- the following must be hooked for each character added
    _G.charSelect.character_add_voice(E_MODEL_AMY, VOICETABLE_AMY)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_AMY then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_AMY then return _G.charSelect.voice.snore(m) end
    end)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end