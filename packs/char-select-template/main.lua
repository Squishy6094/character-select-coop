-- name: [CS] Model Pack Template
-- description: Character Select Template made to show to basics of making a Model Pack

--[[
    API Documentation for Character Select can be found below:
    https://github.com/Squishy6094/character-select-coop/blob/main/API-doc.md
]]

local E_MODEL_CUSTOM_MODEL = smlua_model_util_get_id("custom_model_geo")

local TEXT_MOD_NAME = "Character Template"

if _G.charSelectExists then
    _G.charSelect.character_add("Custom Model Name", {"Custom Model Description", "Custom Model Description"}, "Custom Model Creator", {r = 255, g = 200, b = 200}, E_MODEL_CUSTOM_MODEL, CT_MARIO)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end