-- name: [CS] Toadbert
-- description: No way, is that Toadbert from Mario and Luigi: Partners in Time?!?!

local E_MODEL_TOADBERT = smlua_model_util_get_id("toadbert_geo")
local TEX_TOADBERT = get_texture_info("toadbert-icon")

if _G.charSelectExists then
    _G.charSelect.character_add("Toadbert", {"It's the definitely cool Toad from Partners in Time", "", "\"By Boogity\"", "-Toadbert", "", "Has a tendency to say \"By Boogity\"", "Good friends with Toadiko"}, "xLuigiGamerx", {r = 0x0, g = 0x63, b = 0xff}, E_MODEL_TOADBERT, CT_TOAD, TEX_TOADBERT, 0.80)
else
    djui_popup_create("\nYou require the mod named\n\"Character Select\" by \\#009900\\Squishy\n\\#dcdcdc\\to play as Toadbert!\n\nTurn on Character Select\nthen restart the room.", 6)
end