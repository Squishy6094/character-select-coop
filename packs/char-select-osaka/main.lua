-- name: [CS] Osaka
-- description: honestly quite daiohs


local E_MODEL_OSAKA = smlua_model_util_get_id("osaka_geo")


local TEXT_MOD_NAME = "osakapack"

local TEX_OSAKA = get_texture_info("osaka-icon")


if _G.charSelectExists then
    	_G.charSelect.character_add("Osaka", {"daihoh"}, "Nokia, azumadeline", {r = 255, g = 0, b = 0}, E_MODEL_OSAKA, CT_MARIO, TEX_OSAKA)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end