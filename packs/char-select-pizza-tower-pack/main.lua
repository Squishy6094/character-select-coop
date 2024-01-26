-- name: [CS] Pizizito's Pizza Tower Pack
-- description: A handful of Pizza Tower/Sugary Spire Characters in Super Mario 64!\n\nModels by: Pizizito\nHUD Icons by: KitKat\nSounds by: Tour de Pizza\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

local E_MODEL_PEPPERMAN = smlua_model_util_get_id("pepperman_geo")
local E_MODEL_VIGILANTE = smlua_model_util_get_id("vigilante_geo")
local E_MODEL_NOISE = smlua_model_util_get_id("noise_geo")
local E_MODEL_FAKE_PEPPINO = smlua_model_util_get_id("fake_peppino_geo")
local E_MODEL_GUSTAVO = smlua_model_util_get_id("gustavo_geo")
local E_MODEL_PIZZELLE = smlua_model_util_get_id("pizzelle_geo")
local E_MODEL_PIZZANO = smlua_model_util_get_id("pizzano_geo")

local TEX_PEPPERMAN = get_texture_info("pepperman-icon")
local TEX_VIGILANTE = get_texture_info("vigilante-icon")
local TEX_NOISE = get_texture_info("noise-icon")
local TEX_FAKE_PEPPINO = get_texture_info("fake-peppino-icon")
local TEX_PIZZELLE = get_texture_info("pizzelle-icon")
local TEX_PIZZANO = get_texture_info("pizzano-icon")

local VOICETABLE_PEPPERMAN = {
    [CHAR_SOUND_ATTACKED] = 'PeppermanScared.ogg',
    [CHAR_SOUND_HAHA] = 'PeppermanLaugh.ogg',
    [CHAR_SOUND_HAHA_2] = 'PeppermanLaugh.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'PeppermanLaugh.ogg',
    [CHAR_SOUND_HOOHOO] = 'sfx_jump.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'PeppermanScared.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'PeppermanSnicker.ogg',
    [CHAR_SOUND_ON_FIRE] = 'PeppermanScared.ogg',
    [CHAR_SOUND_OOOF] = 'PeppermanScared.ogg',
    [CHAR_SOUND_OOOF2] = 'PeppermanScared.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'sfx_jump.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'PeppermanLaugh.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'PeppermanSnicker.ogg',
    [CHAR_SOUND_WAH2] = 'sfx_jump.ogg',
    [CHAR_SOUND_WHOA] = 'PeppermanScared.ogg',
    [CHAR_SOUND_YAHOO] = 'PeppermanSnicker.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = 'PeppermanSnicker.ogg',
    [CHAR_SOUND_YAH_WAH_HOO] = 'sfx_jump.ogg',
}

local VOICETABLE_VIGILANTE = {
    [CHAR_SOUND_ATTACKED] = {'vigi1.ogg', 'vigi2.ogg',},
    [CHAR_SOUND_DYING] = 'vigi2.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'vigi3.ogg',
    [CHAR_SOUND_HAHA] = {'vigi1.ogg', 'vigi2.ogg', 'vigi3.ogg'},
    [CHAR_SOUND_HAHA_2] = {'vigi1.ogg', 'vigi2.ogg', 'vigi3.ogg'},
    [CHAR_SOUND_HERE_WE_GO] = {'vigi1.ogg', 'vigi2.ogg', 'vigi3.ogg'},
    [CHAR_SOUND_HOOHOO] = 'sfx_jump.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'vigi2.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'vigi3.ogg',
    [CHAR_SOUND_OOOF] = 'vigi2.ogg',
    [CHAR_SOUND_OOOF2] = 'vigi2.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'sfx_jump.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'vigi1.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'vigi3.ogg',
    [CHAR_SOUND_WAH2] = 'vigi1.ogg',
    [CHAR_SOUND_WHOA] = {'vigi1.ogg', 'vigi2.ogg',},
    [CHAR_SOUND_YAHOO] = 'vigi1.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = 'vigi3.ogg',
    [CHAR_SOUND_YAH_WAH_HOO] = 'sfx_jump.ogg',
}

local VOICETABLE_NOISE = {
    [CHAR_SOUND_ATTACKED] = 'Noise1.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'Noise3.ogg',
    [CHAR_SOUND_HAHA] = {'Noise1.ogg', 'Noise2.ogg', 'Noise3.ogg', 'Noise4.ogg', 'Noise5.ogg', 'Noise6.ogg'},
    [CHAR_SOUND_HAHA_2] = {'Noise1.ogg', 'Noise2.ogg', 'Noise3.ogg', 'Noise4.ogg', 'Noise5.ogg', 'Noise6.ogg'},
    [CHAR_SOUND_HERE_WE_GO] = 'Noise4.ogg',
    [CHAR_SOUND_HOOHOO] = 'Noise3.ogg',
    [CHAR_SOUND_ON_FIRE] = 'noisescream.ogg',
    [CHAR_SOUND_OOOF] = 'Noise1.ogg',
    [CHAR_SOUND_OOOF2] = 'Noise1.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'Noise5.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'Noise6.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'Noise2.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'Noise4.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'Noise4.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'noisescream.ogg',
    [CHAR_SOUND_WAH2] = 'Noise2.ogg',
    [CHAR_SOUND_WHOA] = 'Noise1.ogg',
    [CHAR_SOUND_YAHOO] = {'Noise1.ogg', 'Noise2.ogg', 'Noise3.ogg', 'Noise4.ogg', 'Noise5.ogg', 'Noise6.ogg'},
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'Noise1.ogg', 'Noise2.ogg', 'Noise3.ogg', 'Noise4.ogg', 'Noise5.ogg', 'Noise6.ogg'},
    [CHAR_SOUND_YAH_WAH_HOO] = {'Noise2.ogg', 'Noise5.ogg', 'Noise6.ogg'},
}

local VOICETABLE_FAKE_PEPPINO = {
    [CHAR_SOUND_ATTACKED] = 'fakepepnegative1.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'fakepeppositive2.ogg',
    [CHAR_SOUND_HAHA] = {'fakepeppositive1.ogg', 'fakepeppositive2.ogg', 'fakepeppositive3.ogg'},
    [CHAR_SOUND_HAHA_2] = {'fakepeppositive1.ogg', 'fakepeppositive2.ogg', 'fakepeppositive3.ogg'},
    [CHAR_SOUND_HERE_WE_GO] = {'fakepeppositive1.ogg', 'fakepeppositive2.ogg', 'fakepeppositive3.ogg'},
    [CHAR_SOUND_HOOHOO] = 'fakepeppositive2.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'fakepepnegative2.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = {'fakepeppositive1.ogg', 'fakepeppositive2.ogg', 'fakepeppositive3.ogg'},
    [CHAR_SOUND_ON_FIRE] = 'fakepepscream.ogg',
    [CHAR_SOUND_OOOF] = 'fakepepnegative1.ogg',
    [CHAR_SOUND_OOOF2] = 'fakepepnegative1.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'sfx_jump.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'fakepepnegitive2.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = {'fakepeppositive1.ogg', 'fakepeppositive2.ogg', 'fakepeppositive3.ogg'},
    [CHAR_SOUND_WAAAOOOW] = 'fakepepscream.ogg',
    [CHAR_SOUND_WAH2] = 'sfx_jump.ogg',
    [CHAR_SOUND_WHOA] = 'fakepepnegative2.ogg',
    [CHAR_SOUND_YAHOO] = 'fakepeppositive1.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'fakepeppositive1.ogg', 'fakepeppositive2.ogg', 'fakepeppositive3.ogg'},
    [CHAR_SOUND_YAH_WAH_HOO] = 'sfx_jump.ogg',
}

local VOICETABLE_PIZZELLE = {
    [CHAR_SOUND_HOOHOO] = 'sfx_jump.ogg',
    [CHAR_SOUND_ON_FIRE] = 'pizzellefireass.ogg', -- Literally her only sfx
    [CHAR_SOUND_PUNCH_HOO] = 'sfx_jump.ogg',
    [CHAR_SOUND_WAH2] = 'sfx_jump.ogg',
    [CHAR_SOUND_YAHOO] = 'sfx_jump.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = 'sfx_jump.ogg',
    [CHAR_SOUND_YAH_WAH_HOO] = 'sfx_jump.ogg',
}

local TEXT_MOD_NAME = "Pizizito's Pizza Tower Pack"

if _G.charSelectExists then
    _G.charSelect.character_add("Pepperman", {"The Perfect Pepper of Pizza Tower's", "First Floor"}, "Pizizito", {r = 225, g = 47, b = 0}, E_MODEL_PEPPERMAN, CT_WARIO, TEX_PEPPERMAN)
    _G.charSelect.character_add("Vigilante", {"The Lone Sherrif of Pizza Tower's", "Second Floor"}, "Pizizito", {r = 176, g = 48, b = 0}, E_MODEL_VIGILANTE, CT_MARIO, TEX_VIGILANTE)
    _G.charSelect.character_add("The Noise", {"The Mischievous Gremlin and", "Entertainment of Pizza Tower's", "Third Floor"}, "Pizizito", {r = 216, g = 136, b = 24}, E_MODEL_NOISE, CT_TOAD, TEX_NOISE)
    _G.charSelect.character_add("Fake Peppino", {"roolF htruoF", "s'rewoT azziP fo enolC onippeP ehT"}, "Pizizito", {r = 253, g = 167, b = 134}, E_MODEL_FAKE_PEPPINO, CT_WALUIGI, TEX_FAKE_PEPPINO)
    _G.charSelect.character_add("Gustavo", nil, "Pizizito", {r = 176, g = 48, b = 0}, E_MODEL_GUSTAVO, CT_MARIO, nil)
    _G.charSelect.character_add("Pizzelle", {"A Candy Maker Looting", "The Sugary Spire"}, "Pizizito", {r = 255, g = 255, b = 255}, E_MODEL_PIZZELLE, CT_TOAD, TEX_PIZZELLE)
    _G.charSelect.character_add("Pizzano", {"An immature, eccentric, and", "occasionally rather violent", "TV network host of", "The Sugary Spire"}, "Pizizito", {r = 75, g = 160, b = 253}, E_MODEL_PIZZANO, CT_WARIO, TEX_PIZZANO)

    _G.charSelect.character_add_voice(E_MODEL_PEPPERMAN, VOICETABLE_PEPPERMAN)
    _G.charSelect.character_add_voice(E_MODEL_VIGILANTE, VOICETABLE_VIGILANTE)
    _G.charSelect.character_add_voice(E_MODEL_NOISE, VOICETABLE_NOISE)
    _G.charSelect.character_add_voice(E_MODEL_FAKE_PEPPINO, VOICETABLE_FAKE_PEPPINO)
    _G.charSelect.character_add_voice(E_MODEL_PIZZELLE, VOICETABLE_PIZZELLE)
    -- _G.charSelect.character_add_voice(E_MODEL_PIZZANO, VOICETABLE_PIZZANO)
    -- Pizzano is practically just wario, and I can't find any voiceclips kekekekeke
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_PEPPERMAN then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_VIGILANTE then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_NOISE then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_FAKE_PEPPINO then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_PIZZELLE then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_PEPPERMAN then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_VIGILANTE then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_NOISE then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_FAKE_PEPPINO then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_PIZZELLE then return _G.charSelect.voice.snore(m) end
    end)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end