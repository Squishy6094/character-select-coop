-- name: [CS] Uncle Grandpa
-- description: \\#ff7777\\This Mod Requires the Character Select Mod\nto use as a Library!

local E_MODEL_UNCLE_GRANDPA = smlua_model_util_get_id("uncle_grandpa_geo")

-- Model Pack name used 
local TEXT_MOD_NAME = "Uncle Grandpa"

if _G.charSelectExists then
    _G.charSelect.character_add("Uncle Grandpa", nil, "Garlicker", {r = 188, g = 97, b = 39}, E_MODEL_UNCLE_GRANDPA, CT_MARIO)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end