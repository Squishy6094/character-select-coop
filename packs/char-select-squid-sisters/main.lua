-- name: [CS] Squid Sisters
-- description: Splatoon's Callie & Marie in SM64!\nIncludes Full Color Support and Eye States! \n\nModels by: Frijoles Y Queso\n\n\\#ff7777\\This Mod Requires the Character Select Mod\nto use as a Library!

local E_MODEL_CALLIE = smlua_model_util_get_id("callie_geo")
local E_MODEL_MARIE = smlua_model_util_get_id("marie_geo")

-- Model Pack name used 
local TEXT_MOD_NAME = "Squid Sisters"

local VOICETABLE_NONE = {nil}

if _G.charSelectExists then
    _G.charSelect.character_add("Callie", {"The loud and sweet Callie from", "Inkopolis' Squid Sisters!"}, "Frijoles Y Queso", {r = 255, g = 31, b = 137}, E_MODEL_CALLIE, CT_MARIO)
    _G.charSelect.character_add("Marie", {"The smart and quiet Marie from", "Inkopolis' Squid Sisters!"}, "Frijoles Y Queso", {r = 0, g = 209, b = 138}, E_MODEL_MARIE, CT_LUIGI)

    _G.charSelect.character_add_voice(E_MODEL_CALLIE, VOICETABLE_NONE)
    _G.charSelect.character_add_voice(E_MODEL_MARIE, VOICETABLE_NONE)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_NONE then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_NONE then return _G.charSelect.voice.snore(m) end
    end)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end