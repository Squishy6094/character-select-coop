-- name: [CS] Paper Goombas & Koopas
-- description: Famous Goombas and Koopas from the Paper Mario  series :] \n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

local E_MODEL_GOOMBELLA = smlua_model_util_get_id("goombella_geo")
local E_MODEL_GOOMBARIO = smlua_model_util_get_id("goombario_geo")
local E_MODEL_KOOPER = smlua_model_util_get_id("kooper_geo")
local E_MODEL_KOOPS = smlua_model_util_get_id("koops_geo")
local E_MODEL_PARAKARRY = smlua_model_util_get_id("parakarry_geo")

local TEX_GOOMBELLA = get_texture_info("goombella_icon")
local TEX_GOOMBARIO = get_texture_info("goombario_icon")
local TEX_KOOPER = get_texture_info("kooper_icon")
local TEX_KOOPS = get_texture_info("koops_icon")
local TEX_PARAKARRY = get_texture_info("parakarry_icon")


local TEXT_MOD_NAME = "[CS] Paper Goombas & Koopas"

local VOICETABLE_GOOMBA = {
    [CHAR_SOUND_YAH_WAH_HOO] = 'Gyah.ogg',
    [CHAR_SOUND_HOOHOO] = 'Ghoohoo (2).ogg',
    [CHAR_SOUND_YAHOO] = 'Gyahooyipee.ogg',
    [CHAR_SOUND_UH] = 'Guh2coughing2.ogg',
    [CHAR_SOUND_HRMM] = 'Ghrm.ogg',
    [CHAR_SOUND_WAH2] = 'Gwah.ogg',
    [CHAR_SOUND_WHOA] = 'Gwhoa.ogg',
    [CHAR_SOUND_EEUH] = 'Geeuh.ogg',
    [CHAR_SOUND_ATTACKED] = 'Gattacked.ogg',
    [CHAR_SOUND_OOOF] = 'Gooof.ogg',
    [CHAR_SOUND_OOOF2] = 'Gooof2pantingcoughing3.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'Ghere we go.ogg',
    [CHAR_SOUND_YAWNING] = 'Gyawning.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'Gwaaaooow.ogg',
    [CHAR_SOUND_HAHA] = 'Ghaha.ogg',
    [CHAR_SOUND_HAHA_2] = 'Ghaha.ogg',
    [CHAR_SOUND_UH2] = 'Guh.ogg',
    [CHAR_SOUND_UH2_2] = 'Guh2_2.ogg',
    [CHAR_SOUND_ON_FIRE] = 'Gfire.ogg',
    [CHAR_SOUND_DYING] = 'Gdying.ogg',
    [CHAR_SOUND_PANTING_COLD] = 'Gooof2pantingcoughing3.ogg',
    [CHAR_SOUND_PANTING] = 'Gooof2pantingcoughing3.ogg',
    [CHAR_SOUND_COUGHING1] = 'Gcoughing.ogg',
    [CHAR_SOUND_COUGHING2] = 'Guh2coughing2.ogg',
    [CHAR_SOUND_COUGHING3] = 'Gooof2pantingcoughing3.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'Gyah (2).ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'Ghoohoo.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'Gsurprise.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'Gwah.ogg',
    [CHAR_SOUND_DROWNING] = 'Gdrowning.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'Gwah_punch.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = 'Gyahooyipee.ogg',
    [CHAR_SOUND_DOH] = 'Gdoh.ogg',
    [CHAR_SOUND_HELLO] = 'Ghello.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'Gquestion.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'Gsolongabowser.ogg',
    [CHAR_SOUND_IMA_TIRED] = 'Gimatired.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'Gletsago.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'Goki doki.ogg',
}

local VOICETABLE_KOOPA = {
    [CHAR_SOUND_YAH_WAH_HOO] = {'Kya.ogg', 'Kwah.ogg'},
    [CHAR_SOUND_HOOHOO] = 'Khoohoo.ogg',
    [CHAR_SOUND_YAHOO] = 'Kyahoo.ogg',
    [CHAR_SOUND_UH] = 'Kuh.ogg',
    [CHAR_SOUND_HRMM] = 'Khrm.ogg',
    [CHAR_SOUND_WAH2] = 'Kwah.ogg',
    [CHAR_SOUND_WHOA] = 'Kwhoa.ogg',
    [CHAR_SOUND_EEUH] = 'Keh.ogg',
    [CHAR_SOUND_ATTACKED] = 'Kdoh.ogg',
    [CHAR_SOUND_OOOF] = 'Khurt.ogg',
    [CHAR_SOUND_OOOF2] = 'Keh2.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'Ktwirl_bounce.ogg',
    [CHAR_SOUND_YAWNING] = 'Kyawning.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'Kwoaaaw.ogg',
    [CHAR_SOUND_HAHA] = 'Khaha.ogg',
    [CHAR_SOUND_HAHA_2] = 'Khaha.ogg',
    [CHAR_SOUND_UH2] = 'Kuh.ogg',
    [CHAR_SOUND_UH2_2] = 'Kuh2-2.ogg',
    [CHAR_SOUND_ON_FIRE] = 'Kfire.ogg',
    [CHAR_SOUND_DYING] = 'Kdying.ogg',
    [CHAR_SOUND_PANTING_COLD] = 'Kcoughing2.ogg',
    [CHAR_SOUND_PANTING] = 'Kcoughing2.ogg',
    [CHAR_SOUND_COUGHING1] = 'Kcoughing2.ogg',
    [CHAR_SOUND_COUGHING2] = 'Kcoughing3.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'Kyah2.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'Khoo.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'Kwoaaaw.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'Kwah2.ogg',
    [CHAR_SOUND_DROWNING] = 'Kdrowning.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'Kwah.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'Ksolonga_bowser.ogg', 'Ktwirl_bounce.ogg'},
    [CHAR_SOUND_DOH] = 'Kdoh.ogg',
    [CHAR_SOUND_HELLO] = 'Khello.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'Ktwirl_bounce.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'Ksolonga_bowser.ogg',
    [CHAR_SOUND_IMA_TIRED] = 'Khurt.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'Klets a go.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'Kokey_dokey.ogg',
}

local capGoombella = {
    normal = smlua_model_util_get_id("goombellas_cap_geo"),
    wing = smlua_model_util_get_id("goombellas_wing_cap_geo"),
    metal = smlua_model_util_get_id("goombellas_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("goombellas_metal_wing_cap_geo")
}

local capGoombario = {
    normal = smlua_model_util_get_id("goombarios_cap_geo"),
    wing = smlua_model_util_get_id("goombarios_wing_cap_geo"),
    metal = smlua_model_util_get_id("goombarios_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("goombarios_metal_wing_cap_geo")
}

local capKooper = {
    normal = smlua_model_util_get_id("koopers_cap_geo"),
    wing = smlua_model_util_get_id("koopers_wing_cap_geo"),
    metal = smlua_model_util_get_id("koopers_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("koopers_metal_wing_cap_geo")
}

local capKoops = {
    normal = smlua_model_util_get_id("koops_cap_geo"),
    wing = smlua_model_util_get_id("koopss_wing_cap_geo"),
    metal = smlua_model_util_get_id("koopss_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("koopss_metal_wing_cap_geo")
}

local capParakarry = {
    normal = smlua_model_util_get_id("parakarrys_cap_geo"),
    wing = smlua_model_util_get_id("parakarrys_wing_cap_geo"),
    metal = smlua_model_util_get_id("parakarrys_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("parakarrys_metal_wing_cap_geo")
}

if _G.charSelectExists then
    _G.charSelect.character_add("Goombella", {"Goombella is an archeologist!", "A Clever young adventurer who admires Mario.", "GU GOOMBAS FOREVER"}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_GOOMBELLA, CT_TOAD, TEX_GOOMBELLA)
    _G.charSelect.character_add("Goombario", {"Goombario is a clever young adventurer", "who admires Mario.", "Like most Goombas, he has a hard head", "and a fighting spirit."}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_GOOMBARIO, CT_TOAD, TEX_GOOMBARIO)
   _G.charSelect.character_add("Kooper", {"This adventure-loving Koopa wants", "to be an archaeologist.", "This is Mario's good buddy Kooper", "from Paper Mario"}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_KOOPER, CT_LUIGI, TEX_KOOPER)
	_G.charSelect.character_add("Koops", {"Koops is a timid Koopa who wants to be tougher.", "Kicking some shell never felt so good."}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_KOOPS, CT_LUIGI, TEX_KOOPS)
	_G.charSelect.character_add("Parakarry", {"He's Parakarry, a Paratroopa.", "He's well known for being the slowest mailman around."}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_PARAKARRY, CT_LUIGI, TEX_PARAKARRY)

    _G.charSelect.character_add_caps(E_MODEL_GOOMBELLA, capGoombella)
    _G.charSelect.character_add_caps(E_MODEL_GOOMBARIO, capGoombario)
    _G.charSelect.character_add_caps(E_MODEL_KOOPER, capKooper)
    _G.charSelect.character_add_caps(E_MODEL_KOOPS, capKoops)
    _G.charSelect.character_add_caps(E_MODEL_PARAKARRY, capParakarry)

	_G.charSelect.character_add_voice(E_MODEL_GOOMBELLA, VOICETABLE_GOOMBA)
	_G.charSelect.character_add_voice(E_MODEL_GOOMBARIO, VOICETABLE_GOOMBA)
	_G.charSelect.character_add_voice(E_MODEL_KOOPER, VOICETABLE_KOOPA)
	_G.charSelect.character_add_voice(E_MODEL_KOOPS, VOICETABLE_KOOPA)
	_G.charSelect.character_add_voice(E_MODEL_PARAKARRY, VOICETABLE_KOOPA)

    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_GOOMBA then return _G.charSelect.voice.sound(m, sound) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_GOOMBA then return _G.charSelect.voice.sound(m, sound) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_KOOPA then return _G.charSelect.voice.sound(m, sound) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_KOOPA then return _G.charSelect.voice.sound(m, sound) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_KOOPA then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_GOOMBA then return _G.charSelect.voice.snore(m) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_GOOMBA then return _G.charSelect.voice.snore(m) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_KOOPA then return _G.charSelect.voice.snore(m) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_KOOPA then return _G.charSelect.voice.snore(m) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_KOOPA then return _G.charSelect.voice.snore(m) end
    end)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end
