-- name: [CS] Unstoppable Force
-- description: mari and rufus from the hit classic game mari's pizzaworld

--[[
    API Documentation for Character Select can be found below:
    https://github.com/Squishy6094/character-select-coop/blob/main/API-doc.md

    Use this if you're curious on how anything here works >v<
]]

local E_MODEL_MARI = smlua_model_util_get_id("mari_geo")
local E_MODEL_RUFUS = smlua_model_util_get_id("rufus_geo")

local MARI_ICON = get_texture_info("mari-icon")
local RUFUS_ICON = get_texture_info("rufus-icon")

local TEXT_MOD_NAME = "[CS] Mari's Pizzaworld pack"

local VOICETABLE_MARI = {
    [CHAR_SOUND_ATTACKED] = 'mariAttacked.ogg',
    [CHAR_SOUND_DOH] = 'mariDoh.ogg',
    [CHAR_SOUND_DROWNING] = 'mariAttacked.ogg',
    [CHAR_SOUND_DYING] = 'mariDying.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'mariGroundPound.ogg',
    [CHAR_SOUND_HAHA] = 'mariHaha.ogg',
    [CHAR_SOUND_HAHA_2] = 'mariHaha.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'mariLetsago.ogg',
    [CHAR_SOUND_HOOHOO] = 'mariHoohoo.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'mariMamamia.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'mariOkidoki.ogg',
    [CHAR_SOUND_ON_FIRE] = 'mariAAAAAAA.ogg',
    [CHAR_SOUND_OOOF] = 'mariOw1.ogg',
    [CHAR_SOUND_OOOF2] = 'mariOw2.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'mariPunch3.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'mariPunch2.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'mariPunch1.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'mariByebye.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'mariSpin.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'mariWoah.ogg',
    [CHAR_SOUND_WAH2] = 'mariWahthing.ogg',
    [CHAR_SOUND_WHOA] = 'mariWoah.ogg',
    [CHAR_SOUND_YAHOO] = 'mariYahoo.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = 'mariDeahaah.ogg',
    [CHAR_SOUND_YAH_WAH_HOO] = 'mariWah2.ogg',
    [CHAR_SOUND_YAWNING] = 'mariYawn.ogg',
}
local VOICETABLE_RUFUS = {
    [CHAR_SOUND_ATTACKED] = 'rufusAttacked.ogg',
    [CHAR_SOUND_DOH] = 'rufusDoh.ogg',
    [CHAR_SOUND_DROWNING] = 'rufusAttacked.ogg',
    [CHAR_SOUND_DYING] = 'rufusDying.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'rufusGroundPound.ogg',
    [CHAR_SOUND_HAHA] = 'rufusHaha.ogg',
    [CHAR_SOUND_HAHA_2] = 'rufusHaha.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'rufusLetsago.ogg',
    [CHAR_SOUND_HOOHOO] = 'rufusHoohoo.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'rufusMamamia.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'rufusOkidoki.ogg',
    [CHAR_SOUND_ON_FIRE] = 'rufusAAAAAAA.ogg',
    [CHAR_SOUND_OOOF] = 'rufusOw1.ogg',
    [CHAR_SOUND_OOOF2] = 'rufusOw2.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'rufusPunch3.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'rufusPunch2.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'rufusPunch1.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'rufusByebye.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'rufusSpin.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'rufusWoah.ogg',
    [CHAR_SOUND_WAH2] = 'rufusWahthing.ogg',
    [CHAR_SOUND_WHOA] = 'rufusWoah.ogg',
    [CHAR_SOUND_YAHOO] = 'rufusYahoo.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = 'rufusDeahaah.ogg',
    [CHAR_SOUND_YAH_WAH_HOO] = 'rufusWah2.ogg',
    [CHAR_SOUND_YAWNING] = 'rufusYawn.ogg',
}


local CapMari = {
    normal = smlua_model_util_get_id("mari_cap_normal_geo"),
    wing = smlua_model_util_get_id("mari_cap_wing_geo"),
    metal = smlua_model_util_get_id("mari_cap_metal_geo"),
    metalWing = smlua_model_util_get_id("mari_cap_wing_geo"),
}

local CapRufus = {
    normal = smlua_model_util_get_id("rufus_cap_normal_geo"),
    wing = smlua_model_util_get_id("rufus_cap_wing_geo"),
    metal = smlua_model_util_get_id("rufus_cap_metal_geo"),
    metalWing = smlua_model_util_get_id("rufus_cap_wing_geo"),
}

_G.charSelect.character_add_caps(E_MODEL_MARI, CapMari)
_G.charSelect.character_add_caps(E_MODEL_RUFUS, CapRufus)

if _G.charSelectExists then
    CT_CHAR = _G.charSelect.character_add("Mari", {"scary cursed smw bootleg oooo", "Character from FNF Mario Mix", "by Misfire", "Character model by Tyluge"}, "Tyluge", {r = 255, g = 80, b = 80}, E_MODEL_MARI, CT_MARIO, MARI_ICON)
    CT_CHAR = _G.charSelect.character_add("Rufus", {"walrus luigi man", "Character from FNF Mario Mix", "by Misfire", "Character model by Tyluge"}, "Tyluge", {r = 0, g = 204, b = 0}, E_MODEL_RUFUS, CT_LUIGI, RUFUS_ICON)
    -- the following must be hooked for each character added
    _G.charSelect.character_add_voice(E_MODEL_MARI, VOICETABLE_MARI)
    _G.charSelect.character_add_voice(E_MODEL_RUFUS, VOICETABLE_RUFUS)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_MARI then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_RUFUS then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_MARI then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_RUFUS then return _G.charSelect.voice.snore(m) end
    end)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end