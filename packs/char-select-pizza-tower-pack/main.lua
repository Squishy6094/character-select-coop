-- name: [CS] Pizizito's Pizza Tower Pack
-- description: A handful of Pizza Tower/Sugary Spire Characters in Super Mario 64!\n\nModels by: Pizizito\n\n\\#ff7777\\This Mod Requires the Character Select Mod\nto use as a Library!

local E_MODEL_PEPPERMAN = smlua_model_util_get_id("pepperman_geo")
local E_MODEL_VIGILANTE = smlua_model_util_get_id("vigilante_geo")
local E_MODEL_NOISE = smlua_model_util_get_id("noise_geo")
local E_MODEL_FAKE_PEPPINO = smlua_model_util_get_id("fake_peppino_geo")
local E_MODEL_PIZZELLE = smlua_model_util_get_id("pizzelle_geo")
local E_MODEL_PIZZANO = smlua_model_util_get_id("pizzano_geo")

local TEX_PEPPERMAN = get_texture_info("pepperman-icon")
local TEX_FAKE_PEPPINO = get_texture_info("fake-peppino-icon")

local TEXT_MOD_NAME = "Pizizito's Pizza Tower Pack"

if _G.charSelectExists then
    _G.charSelect.character_add("Pepperman", {"The Perfect Pepper of Pizza Tower's", "First Floor"}, "Pizizito / KitKat", {r = 225, g = 47, b = 0}, E_MODEL_PEPPERMAN, CT_WARIO, TEX_PEPPERMAN)
    _G.charSelect.character_add("Vigilante", {"The Lone Sherrif of Pizza Tower's", "Second Floor"}, "Pizizito", {r = 176, g = 48, b = 0}, E_MODEL_VIGILANTE, CT_MARIO)
    _G.charSelect.character_add("The Noise", {"The Mischievous Gremlin and", "Entertainment of Pizza Tower's", "Third Floor"}, "Pizizito", {r = 216, g = 136, b = 24}, E_MODEL_NOISE, CT_TOAD)
    _G.charSelect.character_add("Fake Peppino", {"roolF htruoF", "s'rewoT azziP fo enolC onippeP ehT"}, "Pizizito", {r = 253, g = 167, b = 134}, E_MODEL_FAKE_PEPPINO, CT_WALUIGI, TEX_FAKE_PEPPINO)
    _G.charSelect.character_add("Pizzelle", {"A Candy Maker Looting", "The Sugary Spire"}, "Pizizito", {r = 255, g = 255, b = 255}, E_MODEL_PIZZELLE, CT_TOAD)
    _G.charSelect.character_add("Pizzano", {"An immature, eccentric, and", "occasionally rather violent", "TV network host of", "The Sugary Spire"}, "Pizizito", {r = 75, g = 160, b = 253}, E_MODEL_PIZZANO, CT_WARIO)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end