-- name: [CS] King
-- description: King by SpringShady for CS!\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

local E_MODEL_KING = smlua_model_util_get_id("king_geo")

local TEX_KING_ICON = get_texture_info("king-icon")

local TEXT_MOD_NAME = "[CS] King"

local VOICETABLE_KING = {
    [CHAR_SOUND_ATTACKED] = 'roar1.ogg',
    [CHAR_SOUND_DOH] = 'yell1.ogg',
    [CHAR_SOUND_DROWNING] = 'bowser-die.ogg',
    [CHAR_SOUND_DYING] = 'bowser-die.ogg',
    [CHAR_SOUND_EEUH] = 'inhale.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'roar0.ogg',
    [CHAR_SOUND_HAHA] = 'roar0.ogg',
    [CHAR_SOUND_HAHA_2] = 'roar0.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'roar0.ogg',
    [CHAR_SOUND_HOOHOO] = 'jump1.ogg',
    [CHAR_SOUND_HRMM] = 'inhale.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'yell1.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'bowser-laugh.ogg',
    [CHAR_SOUND_ON_FIRE] = 'yell0.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'roar0.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'jump1.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'jump0.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'yell0.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'jump1.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'yell0.ogg',
    [CHAR_SOUND_WAH2] = 'jump1.ogg',
    [CHAR_SOUND_WHOA] = 'roar1.ogg',
    [CHAR_SOUND_YAHOO] = 'yell1.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'roar0.ogg', 'roar1.ogg'},
    [CHAR_SOUND_YAH_WAH_HOO] = {'jump0.ogg', 'jump1.ogg'},
}
    
local capModels = {
    normal = smlua_model_util_get_id("king_cap_geo"),
    wing = smlua_model_util_get_id("king_wing_cap_geo"),
    metal = smlua_model_util_get_id("king_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("king_metal_wing_cap_geo")
}

_G.charSelect.character_add_caps(E_MODEL_KING, capModels)

if _G.charSelectExists then
    CT_CHAR = _G.charSelect.character_add("King", {"An evil, demonic entity from the upcoming fan-game Super Mario Ultra.", "Sent from below, ready to be the next ruler and cause havoc in SM64 Coop!", "\nCharacter by SpringShady"}, "wibblus", {r = 180, g = 0, b = 20}, E_MODEL_KING, CT_MARIO, TEX_KING_ICON)

    if _G.bowsMoveset.isActive then
        local BOWS_FLAGS_KING =
        _G.bowsMoveset.FLAG_CAN_USE_FIREBALL | _G.bowsMoveset.FLAG_STYLE_ANIMS | _G.bowsMoveset.FLAG_HEAVY_STEPS | _G.bowsMoveset.FLAG_SIZE_ANIMS | _G.bowsMoveset.FLAG_ATTACKS

        _G.bowsMoveset.character_set_bows_flags(E_MODEL_KING, BOWS_FLAGS_KING)
    end

    -- the following must be hooked for each character added
    _G.charSelect.character_add_voice(E_MODEL_KING, VOICETABLE_KING)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_KING then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_KING then return _G.charSelect.voice.snore(m) end
    end)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end