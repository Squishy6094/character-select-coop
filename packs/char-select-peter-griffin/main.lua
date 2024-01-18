-- name: [CS] Model Pack Peter Griffin
-- description: It seems today...
--[[
    API Documentation for Character Select can be found below:
    https://github.com/Squishy6094/character-select-coop/blob/main/API-doc.md
]]

local E_MODEL_PETER_MODEL = smlua_model_util_get_id("peter_geo")

local TEX_PETER_ICON = get_texture_info("peter")

local TEXT_MOD_NAME = "Peter Griffin Pack"

local VOICETABLE_PETER = {
    [CHAR_SOUND_ATTACKED] = 'attacked.ogg',
    [CHAR_SOUND_DROWNING] = 'embarassed.ogg',
    [CHAR_SOUND_DYING] = 'no.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'yup.ogg',
    [CHAR_SOUND_HAHA] = 'laugh.ogg',
    [CHAR_SOUND_HAHA_2] = 'laugh2.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'starget.ogg',
    [CHAR_SOUND_HOOHOO] = 'laugh3.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'thank.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'do.ogg',
    [CHAR_SOUND_ON_FIRE] = 'scream.ogg',
    [CHAR_SOUND_OOOF] = 'ow.ogg',
    [CHAR_SOUND_OOOF2] = 'ow.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'awesome.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'cool.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'alright.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'throw.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'wow.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'scream.ogg',
    [CHAR_SOUND_WAH2] = 'ohgod.ogg',
    [CHAR_SOUND_WHOA] = 'ohgod.ogg',
    [CHAR_SOUND_YAHOO] = 'yup.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'yup.ogg', 'laugh2.ogg', 'awesome.ogg'},
    [CHAR_SOUND_YAH_WAH_HOO] = {'alright.ogg','cool.ogg','laugh3.ogg'},
}

if _G.charSelectExists then
    _G.charSelect.character_add("Peter Griffin", {"He's the Family Guy!"}, "Trashcam", {r = 255, g = 185, b = 139}, E_MODEL_PETER_MODEL, CT_MARIO, TEX_PETER_ICON, 1.1)

    _G.charSelect.character_add_voice(E_MODEL_PETER_MODEL, VOICETABLE_PETER)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_PETER then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_PETER then return _G.charSelect.voice.snore(m) end
    end)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end