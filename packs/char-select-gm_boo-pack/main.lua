-- name: [CS] Gm_Boo3volved Pack
-- description: \\#ff7777\\This Mod Requires the Character Select Mod\nto use as a Library!

local E_MODEL_SQUISHY = smlua_model_util_get_id("squishy_geo")
local E_MODEL_ARI = smlua_model_util_get_id("ari_geo")
local E_MODEL_LIME = smlua_model_util_get_id("lime_geo")
local E_MODEL_LIME_BUT_COOL = smlua_model_util_get_id("lime_but_awesome_geo")
local E_MODEL_ELBY = smlua_model_util_get_id("elby_geo")
local E_MODEL_ARCHIE = smlua_model_util_get_id("archie_geo")

-- Model Pack name used 
local TEXT_MOD_NAME = "Gm_Boo3volved Pack"

if _G.charSelectExists then
    _G.charSelect.character_add("Squishy", nil, "Trashcam", {r = 0, g = 136,b = 0}, E_MODEL_SQUISHY, CT_MARIO)
    _G.charSelect.character_add("Ari", nil, "Trashcam", nil, E_MODEL_ARI, CT_LUIGI)
    _G.charSelect.character_add("Lime", {"Press D-pad Up to Equip Shades"}, "Trashcam", nil, E_MODEL_LIME, CT_LUIGI)
    _G.charSelect.character_add("Elby", nil, "Trashcam", nil, E_MODEL_ELBY, CT_LUIGI)
    _G.charSelect.character_add("Archie", nil, "Trashcam", nil, E_MODEL_ARCHIE, CT_LUIGI)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end

local limeNum = _G.charSelect.character_get_number_from_string("Lime")
local limeCoolToggle = false
local noLoop = 1

local function lime_glasses_toggle(m)
    if _G.charSelect.character_get_current_model_number() ~= limeNum then return end
    if (m.controller.buttonPressed & U_JPAD) ~= 0 then
        limeCoolToggle = not limeCoolToggle
        noLoop = 0
    end
    if noLoop ~= 0 then return end
    if limeCoolToggle then
        _G.charSelect.character_edit(limeNum, "Lime but Cool", nil, nil, nil, E_MODEL_LIME_BUT_COOL, nil)
        noLoop = 1
    else
        _G.charSelect.character_edit(limeNum, "Lime", nil, nil, nil, E_MODEL_LIME, nil)
        noLoop = 1
    end
end

hook_event(HOOK_MARIO_UPDATE, lime_glasses_toggle)