-- name: [CS] Squid Sisters
-- description: Splatoon's Callie & Marie in SM64!\nIncludes Full Color Support and Eye States! \n\nModels By: Frijoles Y Queso\n\n\\#ff7777\\This Mod Requires the Character Select Mod\nto use as a Library!

local E_MODEL_CALLIE = smlua_model_util_get_id("callie_geo")
local E_MODEL_MARIE = smlua_model_util_get_id("marie_geo")

-- Model Pack name used 
local TEXT_MOD_NAME = "Squid Sisters"

if _G.charSelectExists then
    _G.charSelect.character_add("Callie", {"The loud and sweet Callie from", "Inkopolis' Squid Sisters!"}, "Frijoles Y Queso", {r = 255, g = 31, b = 137}, E_MODEL_CALLIE, CT_MARIO)
    _G.charSelect.character_add("Marie", {"The smart and quiet Marie from", "Inkopolis' Squid Sisters!"}, "Frijoles Y Queso", {r = 0, g = 209, b = 138}, E_MODEL_MARIE, CT_LUIGI)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end