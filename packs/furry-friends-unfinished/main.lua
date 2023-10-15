-- name: [CS] Furry Friends [Unreleased Build]
-- description: A character swap mod using the Character Select's API.

local E_MODEL_LION = smlua_model_util_get_id("yuyake_geo")
local E_MODEL_ANGEL = smlua_model_util_get_id("yuyake_angel_geo")
local E_MODEL_WOLFGIRL = smlua_model_util_get_id("brianna_geo")
local E_MODEL_DOLPHFOX = smlua_model_util_get_id("veph_geo")
local E_MODEL_HUSKY = smlua_model_util_get_id("dirk_geo")
local E_MODEL_LIZARD = smlua_model_util_get_id("flare_geo")
local E_MODEL_FALCON = smlua_model_util_get_id("ryder_geo")
local E_MODEL_WOLFBOY = smlua_model_util_get_id("bradley_geo")
local E_MODEL_BABENOOK = smlua_model_util_get_id("mina_geo")
local E_MODEL_PBEAR = smlua_model_util_get_id("kuma_geo")
local E_MODEL_TOONNOOK = smlua_model_util_get_id("skipper_geo")

if _G.charSelectExists then
    _G.charSelect.character_add("Yuyake", nil, "AngelicMiracles", nil, E_MODEL_LION, CT_MARIO)
    _G.charSelect.character_add("Angel Yuyake", nil, "AngelicMiracles", nil, E_MODEL_ANGEL, CT_MARIO)
    _G.charSelect.character_add("Brianna", nil, "AngelicMiracles", nil, E_MODEL_WOLFGIRL, CT_MARIO)
    _G.charSelect.character_add("Veph", nil, "AngelicMiracles", nil, E_MODEL_DOLPHFOX, CT_MARIO)
    _G.charSelect.character_add("Dirk", nil, "AngelicMiracles", nil, E_MODEL_HUSKY, CT_MARIO)
    _G.charSelect.character_add("Flare", nil, "AngelicMiracles", nil, E_MODEL_LIZARD, CT_MARIO)
    _G.charSelect.character_add("Ryder", nil, "AngelicMiracles", nil, E_MODEL_FALCON, CT_MARIO)
    _G.charSelect.character_add("Bradly", nil, "AngelicMiracles", nil, E_MODEL_WOLFBOY, CT_MARIO)
    _G.charSelect.character_add("Mina", nil, "AngelicMiracles", nil, E_MODEL_BABENOOK, CT_MARIO)
    _G.charSelect.character_add("Kuma", nil, "AngelicMiracles", nil, E_MODEL_PBEAR, CT_WARIO)
    _G.charSelect.character_add("Skipper", nil, "AngelicMiracles", nil, E_MODEL_TOONNOOK, CT_MARIO)
end