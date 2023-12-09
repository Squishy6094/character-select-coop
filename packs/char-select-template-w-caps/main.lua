-- name: [CS] Model w/ Caps Template
-- description: A Template for Character Select to build off of when making your own pack!\n\n\\#ff7777\\This Mod Requires the Character Select Mod\nto use as a Library!

--[[
    API Documentation for Character Select can be found below:
    https://github.com/Squishy6094/character-select-coop/blob/main/API-doc.md
]]

local E_MODEL_CUSTOM_MODEL = smlua_model_util_get_id("custom_model_geo")

local TEXT_MOD_NAME = "Character Template"

local capModels = {
    normal = smlua_model_util_get_id("normal_cap_geo"),
    wing = smlua_model_util_get_id("wing_cap_geo"),
    metal = smlua_model_util_get_id("metal_cap_geo"),
    metalWing = smlua_model_util_get_id("metal_wing_cap_geo")
}

if _G.charSelectExists then
    _G.charSelect.character_add("Custom Model Name", {"Custom Model Description", "Custom Model Description"}, "Custom Model Creator", {r = 255, g = 200, b = 200}, {E_MODEL_CUSTOM_MODEL, capModels}, CT_MARIO)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end