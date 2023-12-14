-- name: [CS] Pizizito's Pizza Tower Pack
-- description: A handful of Pizza Tower/Sugary Spire Characters in Super Mario 64!\n\nModels by: Pizizito\n\n\\#ff7777\\This Mod Requires the Character Select Mod\nto use as a Library!

local E_MODEL_PEPPERMAN = smlua_model_util_get_id("pepperman_geo")
local E_MODEL_VIGILANTE = smlua_model_util_get_id("vigilante_geo")
local E_MODEL_NOISE = smlua_model_util_get_id("noise_geo")
local E_MODEL_FAKE_PEPPINO = smlua_model_util_get_id("fake_peppino_geo")
local E_MODEL_PIZZELLE = smlua_model_util_get_id("pizzelle_geo")
local E_MODEL_PIZZANO = smlua_model_util_get_id("pizzano_geo")

local TEX_PEPPERMAN = get_texture_info("pepperman-icon")
local TEX_VIGILANTE = get_texture_info("vigilante-icon")
local TEX_NOISE = get_texture_info("noise-icon")
local TEX_FAKE_PEPPINO = get_texture_info("fake-peppino-icon")
local TEX_PIZZELLE = get_texture_info("pizzelle-icon")
local TEX_PIZZANO = get_texture_info("pizzano-icon")

--[[
local VOICETABLE_PEPPERMAN = {
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

local TEXT_MOD_NAME = "Pizizito's Pizza Tower Pack"

if _G.charSelectExists then
    _G.charSelect.character_add("Pepperman", {"The Perfect Pepper of Pizza Tower's", "First Floor"}, "Pizizito / KitKat", {r = 225, g = 47, b = 0}, E_MODEL_PEPPERMAN, CT_WARIO, TEX_PEPPERMAN)
    _G.charSelect.character_add("Vigilante", {"The Lone Sherrif of Pizza Tower's", "Second Floor"}, "Pizizito", {r = 176, g = 48, b = 0}, E_MODEL_VIGILANTE, CT_MARIO, TEX_VIGILANTE)
    _G.charSelect.character_add("The Noise", {"The Mischievous Gremlin and", "Entertainment of Pizza Tower's", "Third Floor"}, "Pizizito", {r = 216, g = 136, b = 24}, E_MODEL_NOISE, CT_TOAD, TEX_NOISE)
    _G.charSelect.character_add("Fake Peppino", {"roolF htruoF", "s'rewoT azziP fo enolC onippeP ehT"}, "Pizizito", {r = 253, g = 167, b = 134}, E_MODEL_FAKE_PEPPINO, CT_WALUIGI, TEX_FAKE_PEPPINO)
    _G.charSelect.character_add("Pizzelle", {"A Candy Maker Looting", "The Sugary Spire"}, "Pizizito", {r = 255, g = 255, b = 255}, E_MODEL_PIZZELLE, CT_TOAD, TEX_PIZZELLE)
    _G.charSelect.character_add("Pizzano", {"An immature, eccentric, and", "occasionally rather violent", "TV network host of", "The Sugary Spire"}, "Pizizito", {r = 75, g = 160, b = 253}, E_MODEL_PIZZANO, CT_WARIO, TEX_PIZZANO)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end