-- name: [CS] Squid Sisters
-- description: Splatoon's Callie & Marie in SM64!\nIncludes Full Color Support and Eye States! \n\nModels By: Frijoles Y Queso\n\n\\#ff7777\\This Mod Requires the Character Select Mod\nto use as a Library!

local E_MODEL_SQUISHY = smlua_model_util_get_id("squishy_geo")
local E_MODEL_ARI = smlua_model_util_get_id("ari_geo")
local E_MODEL_LIME = smlua_model_util_get_id("lime_geo")
local E_MODEL_LIME_BUT_COOL = smlua_model_util_get_id("lime_but_awesome_geo")

-- Model Pack name used 
local TEXT_MOD_NAME = "Gm_Boo Pack"

if _G.charSelectExists then
    _G.charSelect.character_add("Squishy", nil, "Trashcam", {r = 0, g = 136,b = 0}, E_MODEL_SQUISHY, CT_MARIO)
    _G.charSelect.character_add("Ari", nil, "Trashcam", nil, E_MODEL_ARI, CT_LUIGI)
    _G.charSelect.character_add("Lime", nil, "Trashcam", nil, E_MODEL_LIME, CT_LUIGI)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end

local limeCool = false
local noLoop = 0

local function lime_glasses_toggle(m)
    local limeNum = _G.charSelect.character_get_number_from_string("Lime")
    if _G.charSelect.character_get_current_model_number() ~= limeNum then return end
    if (m.controller.buttonPressed & Y_BUTTON) ~= 0 then
        limeCool = not limeCool
        noLoop = 0
    end
    if noLoop == 0 then return end
    if limeCool then
        _G.charSelect.character_edit(limeNum, nil, nil, nil, nil, E_MODEL_LIME_BUT_COOL)
        noLoop = 1
    else
        _G.charSelect.character_edit(limeNum, nil, nil, nil, nil, E_MODEL_LIME)
        noLoop = 1
    end
end

hook_event(HOOK_MARIO_UPDATE, lime_glasses_toggle)