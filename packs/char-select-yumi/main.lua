-- name: [CS] Yumi Martinez 
-- description: A girl from New York. I wonder what's she's doing here?\n\nModels by: Frijoles Y Queso\n\n\\#ff7777\\This Mod Requires the Character Select Mod\nto use as a Library!

local E_MODEL_YUMI = smlua_model_util_get_id("yumi_geo")

-- Model Pack name used 
local TEXT_MOD_NAME = "Yumi Martinez"

local VOICETABLE_YUMI = {nil} -- Mute her, her ass is NOT super mario

if _G.charSelectExists then
    _G.charSelect.character_add("Yumi", {"Bitch."}, "Frijoles Y Queso", {r = 90, g = 90, b = 220}, E_MODEL_YUMI, CT_MARIO)

    _G.charSelect.character_add_voice(E_MODEL_YUMI, VOICETABLE_YUMI)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_YUMI then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_YUMI then return _G.charSelect.voice.snore(m) end
    end)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end