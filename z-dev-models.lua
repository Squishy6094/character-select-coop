----------------------
-- Developer Models --
----------------------

--[[
    These models are added as a little treat for the amazing CoopDX Developers ^v^

    Although the API is in use here, you SHOULD NOT use this to add your own characters!!!
    Please refer to the Character Select API Docs on information for properly making a pack!

    https://github.com/Squishy6094/character-select-coop/blob/main/API-doc.md

    You are free to delete this file in wanted
]]

local ID = tonumber(network_discord_id_from_local_index(0))

local E_MODEL_SQUISHY = smlua_model_util_get_id("squishy_geo")
local E_MODEL_GORDAN = smlua_model_util_get_id("gordan_geo")
local E_MODEL_YUYAKE = smlua_model_util_get_id("yuyake_geo")

if ID == 678794043018182675 then
    _G.charSelect.character_add("Squishy", {"Silly Bone-Brim Codering Person >v<","Creator of Character Select"}, "Trashcam", {r = 0, g = 136, b = 0}, E_MODEL_SQUISHY, CT_MARIO)
end

if ID == 490613035237507091 then
    _G.charSelect.character_add("Agent X", {"Gordon Freeman, in the flesh", "or, rather, in the hazard suit.", "Creator of CoopDX"}, "CosmicMan08", {r = 250, g = 115, b = 7}, E_MODEL_GORDAN, CT_MARIO)
end

if ID == 397891541160558593 then
    _G.charSelect.character_add("Yuyake", {"A lion warrior who joined", "the military to fight off", "against the conquerer known", "as Kaizer. Lives in the", "flying islands known as", "Sky Archipelago."}, "AngelicMiracles", {r = 232, g = 54, b = 30}, E_MODEL_YUYAKE, CT_MARIO)
end