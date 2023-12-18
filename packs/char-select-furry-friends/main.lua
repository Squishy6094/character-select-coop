-- name: [CS] Furry Friends
-- description: Models of project owner Yuyake\nand his friends.\n\nModels by: AngelicMiracles\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

local E_MODEL_LION = smlua_model_util_get_id("yuyake_geo")
local E_MODEL_ANGEL = smlua_model_util_get_id("yuyake_angel_geo")
local E_MODEL_WOLFGIRL = smlua_model_util_get_id("brianna_geo")
local E_MODEL_DOLPHFOX = smlua_model_util_get_id("veph_geo")
local E_MODEL_HUSKY = smlua_model_util_get_id("dirk_geo")
local E_MODEL_WOLFBOY = smlua_model_util_get_id("bradley_geo")
local E_MODEL_BABENOOK = smlua_model_util_get_id("mina_geo")
local E_MODEL_PBEAR = smlua_model_util_get_id("kuma_geo")
local E_MODEL_TOONNOOK = smlua_model_util_get_id("skipper_geo")

local TEXT_MOD_NAME = "Furry Friends [Unreleased Build]"

if _G.charSelectExists then
    _G.charSelect.character_add("Yuyake", {" A lion warrior who joined", "the military to fight off", "against the conquerer known", "as Kaizer. Lives in the", "flying islands known as", "Sky Archipelago."}, "AngelicMiracles", {r = 232, g = 54, b = 30}, E_MODEL_LION, CT_MARIO)
    _G.charSelect.character_add("Angel Yuyake", {" Yuyake's true final form", "that shifts colors depending", "on his emotions."}, "AngelicMiracles", {r = 46, g = 220, b = 225}, E_MODEL_ANGEL, CT_MARIO)
    _G.charSelect.character_add("Brianna", {" A wolf woman who is a", "military commander leading", "the mission on defeating.", "Kaizer."}, "AngelicMiracles", {r = 18, g = 184, b = 71}, E_MODEL_WOLFGIRL, CT_LUIGI)
    _G.charSelect.character_add("Veph", {" A dolphin-fox who hangs", "around with Sonic and co."}, "AngelicMiracles", {r = 242, g = 36, b = 74}, E_MODEL_DOLPHFOX, CT_MARIO)
    _G.charSelect.character_add("Dirk", {"A husky with the abilities of ice!"}, "AngelicMiracles", {r = 51, g = 38, b = 135}, E_MODEL_HUSKY, CT_MARIO)
    _G.charSelect.character_add("Bradly", {"A wolf man with a sword."}, "AngelicMiracles", {r = 8, g = 104, b = 163}, E_MODEL_WOLFBOY, CT_MARIO)
    _G.charSelect.character_add("Mina", {"A female tanuki! She's energetic!"}, "AngelicMiracles", {r = 82, g = 7, b = 22}, E_MODEL_BABENOOK, CT_LUIGI)
    _G.charSelect.character_add("Kuma", {"A polar bear who lives in the", "snowy mountains! Loves to make sugar crystals!"} , "AngelicMiracles", {r = 199, g = 18, b = 96}, E_MODEL_PBEAR, CT_WARIO)
    _G.charSelect.character_add("Skipper", {"A toon tanuki who can fly and", "transform into statues, just like", "Mario does in a Tanooki suit!"}, "AngelicMiracles", {r = 214, g = 15, b = 35}, E_MODEL_TOONNOOK, CT_MARIO)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)        
end