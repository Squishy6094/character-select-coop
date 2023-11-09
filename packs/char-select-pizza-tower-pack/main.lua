-- name: [CS] Pizizito's Pizza Tower Pack
-- description: \\#ff7777\\This Mod Requires the Character Select Mod\nto use as a Library!

local E_MODEL_PEPPERMAN = smlua_model_util_get_id("pepperman_geo")
local E_MODEL_VIGILANTE = smlua_model_util_get_id("vigilante_geo")
local E_MODEL_NOISE = smlua_model_util_get_id("noise_geo")
local E_MODEL_PIZZELLE = smlua_model_util_get_id("pizzelle_geo")

local TEXT_MOD_NAME = "Pizizito's Pizza Tower Pack"

if _G.charSelectExists then
    _G.charSelect.character_add("Pepperman", {"The Perfect Pepper of Pizza Tower's", "First Floor"}, "Pizizito", {r = 225, g = 47, b = 0}, E_MODEL_PEPPERMAN, CT_WARIO)
    _G.charSelect.character_add("Vigilante", {"The Lone Sherrif of Pizza Tower's", "Second Floor"}, "Pizizito", {r = 176, g = 48, b = 0}, E_MODEL_VIGILANTE, CT_MARIO)
    _G.charSelect.character_add("The Noise", {"The Mischievous Gremlin and", "Entertainment of Pizza Tower's", "Third Floor"}, "Pizizito", {r = 216, g = 136, b = 24}, E_MODEL_NOISE, CT_LUIGI)
    _G.charSelect.character_add("Pizzelle", {"A Candy Maker and Looter of", "The Sugary Spire"}, "Pizizito", {r = 255, g = 255, b = 255}, E_MODEL_PIZZELLE, CT_TOAD)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end