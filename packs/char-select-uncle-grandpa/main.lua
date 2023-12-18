-- name: [CS] Uncle Grandpa
-- description: Good Morning!\n\nUncle Grandpa in Super Mario 64,\nStylized to look 2D and Includes Eye States!\n\nModel by: Garlicker\nImporting by: Dj Khaled/Wahooo, Fbell & LuigiGamer\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

local E_MODEL_UNCLE_GRANDPA = smlua_model_util_get_id("uncle_grandpa_geo")

local TEX_UNCLE_GRANDPA = get_texture_info("uncle-grandpa-icon")

-- Model Pack name used 
local TEXT_MOD_NAME = "Uncle Grandpa"

if _G.charSelectExists then
    _G.charSelect.character_add("Uncle Grandpa", {"Good Morning!"}, "Garlicker", {r = 188, g = 97, b = 39}, E_MODEL_UNCLE_GRANDPA, CT_MARIO, TEX_UNCLE_GRANDPA)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end