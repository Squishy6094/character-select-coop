-- name: [CS] Paper Partners 64
-- description: Skinpack of famous friends from the Paper Mario series! \n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

local E_MODEL_GOOMBELLA = smlua_model_util_get_id("goombella_geo")
local E_MODEL_GOOMBARIO = smlua_model_util_get_id("goombario_geo")
local E_MODEL_KOOPER = smlua_model_util_get_id("kooper_geo")
local E_MODEL_KOOPS = smlua_model_util_get_id("koops_geo")
local E_MODEL_PARAKARRY = smlua_model_util_get_id("parakarry_geo")
local E_MODEL_BOMBETTE = smlua_model_util_get_id("bombette_geo")
local E_MODEL_BOBBERY = smlua_model_util_get_id("bobbery_geo")
local E_MODEL_WATT = smlua_model_util_get_id("watt_geo")
local E_MODEL_SUSHIE = smlua_model_util_get_id("sushie_geo")
local E_MODEL_LAKILESTER = smlua_model_util_get_id("lakilester_geo")
local E_MODEL_BOW = smlua_model_util_get_id("bow_geo")

local TEX_GOOMBELLA = get_texture_info("goombella_icon")
local TEX_GOOMBARIO = get_texture_info("goombario_icon")
local TEX_KOOPER = get_texture_info("kooper_icon")
local TEX_KOOPS = get_texture_info("koops_icon")
local TEX_PARAKARRY = get_texture_info("parakarry_icon")
local TEX_BOMBETTE = get_texture_info("bombette_icon")
local TEX_BOBBERY = get_texture_info("bobbery_icon")
local TEX_WATT = get_texture_info("watt_icon")
local TEX_SUSHIE = get_texture_info("sushie_icon")
local TEX_LAKILESTER = get_texture_info("lakilester_icon")
local TEX_BOW = get_texture_info("bow_icon")


local TEXT_MOD_NAME = "[CS] Paper Partners 64"

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

local VOICETABLE_BOBOMB = {
    [CHAR_SOUND_YAH_WAH_HOO] = {'Bo_yah.ogg', 'Bo_yah2.ogg'},
    [CHAR_SOUND_HOOHOO] = 'Bo_hoohoo.ogg',
    [CHAR_SOUND_YAHOO] = 'Bo_yahoo.ogg',
    [CHAR_SOUND_UH] = 'Bo_uh.ogg',
    [CHAR_SOUND_HRMM] = 'Bo_hrmm.ogg',
    [CHAR_SOUND_WAH2] = 'Bo_wah2.ogg',
    [CHAR_SOUND_WHOA] = 'Bo_whoa.ogg',
    [CHAR_SOUND_EEUH] = 'Bo_eeuh.ogg',
    [CHAR_SOUND_ATTACKED] = 'Bo_attacked.ogg',
    [CHAR_SOUND_OOOF] = 'Bo_ooof.ogg',
    [CHAR_SOUND_OOOF2] = 'Bo_ooof2.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'Bo_herewego.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'Bo_waaaooow.ogg',
    [CHAR_SOUND_HAHA] = 'Bo_haha.ogg',
    [CHAR_SOUND_HAHA_2] = 'Bo_haha_2.ogg',
    [CHAR_SOUND_UH2] = 'Bo_uh2.ogg',
    [CHAR_SOUND_UH2_2] = 'Bo_uh2_2.ogg',
    [CHAR_SOUND_ON_FIRE] = 'Bo_onfire.ogg',
    [CHAR_SOUND_DYING] = 'Bo_dying.ogg',
    [CHAR_SOUND_PANTING_COLD] = 'Bo_panting_cold.ogg',
    [CHAR_SOUND_PANTING] = 'Bo_panting.ogg',
    [CHAR_SOUND_COUGHING1] = 'Bo_coughing.ogg',
    [CHAR_SOUND_COUGHING2] = 'Bo_coughing2.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'Bo_punch_yah.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'Bo_punch_hoo.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'Bo_mama_mia.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'Bo_groundpound.ogg',
    [CHAR_SOUND_DROWNING] = 'Bo_drowning.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'Bo_punch_wah.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'Bo_yahoo.ogg', 'Bo_waha.ogg', 'Bo_wihee.ogg'},
    [CHAR_SOUND_DOH] = 'Bo_doh.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'Bo_twirl_bounce.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'Bo_solongabowser.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'Bo_letsago.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'Bo_okey_dokey.ogg',
}
local VOICETABLE_WATT = {    
    [CHAR_SOUND_YAH_WAH_HOO] = {'W_yah.ogg', 'W_yah2.ogg', 'W_yah3.ogg', 'W_wah.ogg'},
    [CHAR_SOUND_HOOHOO] = 'W_hoohoo.ogg',
    [CHAR_SOUND_YAHOO] = 'W_whooo.ogg',
    [CHAR_SOUND_UH] = 'W_uh.ogg',
    [CHAR_SOUND_HRMM] = 'W_hrmm.ogg',
    [CHAR_SOUND_WAH2] = 'W_wah2.ogg',
    [CHAR_SOUND_WHOA] = 'W_whoa.ogg',
    [CHAR_SOUND_EEUH] = 'W_euuh.ogg',
    [CHAR_SOUND_ATTACKED] = {'W_attacked.ogg', 'W_attacked_2.ogg', 'W_attacked_3.ogg'},
    [CHAR_SOUND_OOOF] = 'W_ooof.ogg',
    [CHAR_SOUND_OOOF2] = 'W_ooof2.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'W_here_we_go.ogg',
    [CHAR_SOUND_YAWNING] = 'W_yawning.ogg',
    [CHAR_SOUND_SNORING1] = 'W_snoring_1.ogg',
    [CHAR_SOUND_SNORING2] = 'W_snoring_2.ogg',
    [CHAR_SOUND_SNORING3] = 'W_snoring_3.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'W_waaaooow.ogg',
    [CHAR_SOUND_HAHA] = 'W_haha.ogg',
    [CHAR_SOUND_HAHA_2] = 'W_haha_2.ogg',
    [CHAR_SOUND_UH2] = 'W_uh2.ogg',
    [CHAR_SOUND_UH2_2] = 'W_uh2_2.ogg',
    [CHAR_SOUND_ON_FIRE] = 'W_on_fire.ogg',
    [CHAR_SOUND_DYING] = 'W_dying.ogg',
    [CHAR_SOUND_PANTING] = {'W_panting.ogg', 'W_panting2.ogg', 'W_panting3.ogg'},
    [CHAR_SOUND_PANTING_COLD] = 'W_panting_cold.ogg',
    [CHAR_SOUND_COUGHING1] = 'W_coughing.ogg',
    [CHAR_SOUND_COUGHING2] = 'W_coughing_2.ogg',
    [CHAR_SOUND_COUGHING3] = 'W_coughing_3.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'W_punch_yah.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'W_punch_hoo.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'W_mama_mia.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'W_ground_pound_wah.ogg',
    [CHAR_SOUND_DROWNING] = 'W_drowning.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'W_punch_wah.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'W_yahoo.ogg', 'W_yahoo2.ogg', 'W_yahoo3.ogg', 'W_yahoo4.ogg'},
    [CHAR_SOUND_DOH] = 'W_doh.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'W_twirl_bounce.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'W_so_longa_bowser.ogg',
    [CHAR_SOUND_IMA_TIRED] = 'W_ima_tired.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'W_lets_a_go.ogg',
}

local VOICETABLE_SUSHIE = {
    [CHAR_SOUND_YAH_WAH_HOO] = 'bubbble1.ogg',
    [CHAR_SOUND_HOOHOO] = 'bubble2.ogg',
    [CHAR_SOUND_YAHOO] = 'SUSHIESHOT.ogg',
    [CHAR_SOUND_UH] = 'wet ladning.ogg',
    [CHAR_SOUND_HRMM] = 'bubbble1.ogg',
    [CHAR_SOUND_WAH2] = 'bubble high$.ogg',
    [CHAR_SOUND_WHOA] = 'wet ladning.ogg',
    [CHAR_SOUND_EEUH] = 'bubble2.ogg',
    [CHAR_SOUND_ATTACKED] = 'bubblerun.ogg',
    [CHAR_SOUND_OOOF] = 'wet ladning.ogg',
    [CHAR_SOUND_OOOF2] = 'bubble2.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'SUSHIESHOT.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'bubblepop2_fade.ogg',
    [CHAR_SOUND_HAHA] = 'bubble2.ogg',
    [CHAR_SOUND_HAHA_2] = 'bubblepop2_fade.ogg',
    [CHAR_SOUND_UH2] = 'bubblerun.ogg',
    [CHAR_SOUND_UH2_2] = 'bubblerun.ogg',
    [CHAR_SOUND_ON_FIRE] = 'bubblepop2.ogg',
    [CHAR_SOUND_DYING] = 'bubblepop2_fade.ogg',
    [CHAR_SOUND_PANTING] = 'sleeping1.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'bubbble1.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'SUSHIESHOT.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'bubblepop2_fade.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'SUSHIESHOT.ogg',
    [CHAR_SOUND_DROWNING] = 'bubblepop2_fade.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'bubble2.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = 'SUSHIESHOT.ogg',
    [CHAR_SOUND_DOH] = 'wet ladning.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'boing.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'SUSHIESHOT.ogg',
}

local VOICETABLE_LAKILESTER = {
    [CHAR_SOUND_YAH_WAH_HOO] = {'L_ya.ogg', 'L_yah2.ogg', 'L_yah3.ogg'},
    [CHAR_SOUND_HOOHOO] = 'L_hoohoo.ogg',
    [CHAR_SOUND_YAHOO] = 'L_yahoo (2).ogg',
    [CHAR_SOUND_UH] = 'L_uh.ogg',
    [CHAR_SOUND_HRMM] = 'L_hrmm.ogg',
    [CHAR_SOUND_WAH2] = 'L_wah2.ogg',
    [CHAR_SOUND_WHOA] = 'L_woah.ogg',
    [CHAR_SOUND_EEUH] = 'L_euuh.ogg',
    [CHAR_SOUND_ATTACKED] = 'L_attacked.ogg',
    [CHAR_SOUND_OOOF] = 'L_ooof.ogg',
    [CHAR_SOUND_OOOF2] = 'L_ooof2.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'L_here_we_go.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'L_falling2.ogg',
    [CHAR_SOUND_HAHA] = 'L_haha.ogg',
    [CHAR_SOUND_HAHA_2] = 'L_haha2.ogg',
    [CHAR_SOUND_UH2] = 'L_uh2.ogg',
    [CHAR_SOUND_UH2_2] = 'L_uh2.ogg',
    [CHAR_SOUND_ON_FIRE] = 'L_on_fire.ogg',
    [CHAR_SOUND_DYING] = 'L_dying.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'L_punch_yah.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'L_punch_hoo.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'L_mamamia.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'L_groundpound.ogg',
    [CHAR_SOUND_DROWNING] = 'L_drowning.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'L_punch_wah.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'L_yahoo.ogg', 'L_yipee2.ogg', 'L_yahoo (2).ogg', 'L_waha (2).ogg', 'L_waha.ogg'},
    [CHAR_SOUND_DOH] = 'L_doh.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'L_twirl_bounce.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'L_so_longa_bowser.ogg',
}

local VOICETABLE_BOW = {
    [CHAR_SOUND_YAH_WAH_HOO] = {'Lb_yah1.ogg', 'Lb_haha.ogg', 'Lb_eeuh.ogg', 'Lb_doh.ogg'},
    [CHAR_SOUND_HOOHOO] = 'Lb_hoohoo.ogg',
    [CHAR_SOUND_YAHOO] = 'Lb_yahoo.ogg',
    [CHAR_SOUND_UH] = 'Lb_uh.ogg',
    [CHAR_SOUND_HRMM] = 'Lb_hrmm.ogg',
    [CHAR_SOUND_WAH2] = 'Lb_wah2.ogg',
    [CHAR_SOUND_WHOA] = 'Lb_whoa.ogg',
    [CHAR_SOUND_EEUH] = 'Lb_eeuh.ogg',
    [CHAR_SOUND_ATTACKED] = 'Lb_attacked.ogg',
    [CHAR_SOUND_OOOF] = 'Lb_ooof.ogg',
    [CHAR_SOUND_OOOF2] = 'Lb_ooof2.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'Lb_here_we_go.ogg',
    [CHAR_SOUND_YAWNING] = 'Lb_yawning.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'Lb_waaaooow.ogg',
    [CHAR_SOUND_HAHA] = 'Lb_haha.ogg',
    [CHAR_SOUND_HAHA_2] = 'Lb_haha_2.ogg',
    [CHAR_SOUND_UH2] = 'Lb_uh2.ogg',
    [CHAR_SOUND_UH2_2] = 'Lb_uh2_2.ogg',
    [CHAR_SOUND_ON_FIRE] = 'Lb_on_fire.ogg',
    [CHAR_SOUND_DYING] = 'Lb_dying.ogg',
    [CHAR_SOUND_PANTING_COLD] = 'Lb_panting_cold.ogg',
    [CHAR_SOUND_PANTING] = 'Lb_panting.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'Lb_punch_yah.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'Lb_punch_hoo.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'Lb_mama_mia.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'Lb_ground_pound_wah.ogg',
    [CHAR_SOUND_DROWNING] = 'Lb_drowning.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'Lb_punch_wah.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'Lb_yahoo.ogg', 'Lb_yahoo2.ogg', 'Lb_yahoo3.ogg', 'Lb_yahoo4.ogg', 'Lb_yahoo5.ogg', 'Lb_waha.ogg', 'Lb_yipee.ogg'}, 
    [CHAR_SOUND_DOH] = 'Lb_doh.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'Lb_twirl_bounce.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'Lb_so_longa_bowser.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'Lb_lets_a_go.ogg',
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

local capBombette = {
    normal = smlua_model_util_get_id("bombette_cap_geo"),
    wing = smlua_model_util_get_id("bombette_wing_cap_geo"),
    metal = smlua_model_util_get_id("bombette_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("bombette_metal_wing_cap_geo")
}
local capBobbery = {
    normal = smlua_model_util_get_id("bobbery_cap_geo"),
    wing = smlua_model_util_get_id("bobbery_wing_cap_geo"),
    metal = smlua_model_util_get_id("bobbery_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("bobbery_metal_wing_cap_geo")
}
local capWatt = {
    normal = smlua_model_util_get_id("watts_cap_geo"),
    wing = smlua_model_util_get_id("watts_wing_cap_geo"),
    metal = smlua_model_util_get_id("watts_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("watts_metal_wing_cap_geo")
}

local capSushie = {
    normal = smlua_model_util_get_id("sushies_cap_geo"),
    wing = smlua_model_util_get_id("sushies_wing_cap_geo"),
    metal = smlua_model_util_get_id("sushies_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("sushies_metal_wing_cap_geo")
}

local capLakilester = {
    normal = smlua_model_util_get_id("lakilester_cap_geo"),
    wing = smlua_model_util_get_id("lakilester_wing_cap_geo"),
    metal = smlua_model_util_get_id("lakilester_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("lakilester_metal_wing_cap_geo")
}

local capBow = {
    normal = smlua_model_util_get_id("bow_cap_geo"),
    wing = smlua_model_util_get_id("bow_wing_cap_geo"),
    metal = smlua_model_util_get_id("bow_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("bow_metal_wing_cap_geo")
}

_G.charSelect.character_add_caps(E_MODEL_GOOMBELLA, capGoombella)
_G.charSelect.character_add_caps(E_MODEL_GOOMBARIO, capGoombario)
_G.charSelect.character_add_caps(E_MODEL_KOOPER, capKooper)
_G.charSelect.character_add_caps(E_MODEL_KOOPS, capKoops)
_G.charSelect.character_add_caps(E_MODEL_PARAKARRY, capParakarry)
_G.charSelect.character_add_caps(E_MODEL_BOMBETTE, capBombette)
_G.charSelect.character_add_caps(E_MODEL_BOBBERY, capBobbery)
_G.charSelect.character_add_caps(E_MODEL_WATT, capWatt)
_G.charSelect.character_add_caps(E_MODEL_SUSHIE, capSushie)
_G.charSelect.character_add_caps(E_MODEL_LAKILESTER, capLakilester)
_G.charSelect.character_add_caps(E_MODEL_BOW, capBow)

if _G.charSelectExists then
    _G.charSelect.character_add("Goombella", {"Goombella is an archeologist!", "A Clever young adventurer who admires Mario.", "GU GOOMBAS FOREVER"}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_GOOMBELLA, CT_TOAD, TEX_GOOMBELLA)
    _G.charSelect.character_add("Goombario", {"Goombario is a clever young adventurer", "who admires Mario.", "Like most Goombas, he has a hard head", "and a fighting spirit."}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_GOOMBARIO, CT_TOAD, TEX_GOOMBARIO)
   _G.charSelect.character_add("Kooper", {"This adventure-loving Koopa wants", "to be an archaeologist.", "This is Mario's good buddy Kooper", "from Paper Mario"}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_KOOPER, CT_LUIGI, TEX_KOOPER)
	_G.charSelect.character_add("Koops", {"Koops is a timid Koopa who wants to be tougher.", "Kicking some shell never felt so good."}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_KOOPS, CT_LUIGI, TEX_KOOPS)
	_G.charSelect.character_add("Parakarry", {"He's Parakarry, a Paratroopa.", "He's well known for being the slowest mailman around."}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_PARAKARRY, CT_LUIGI, TEX_PARAKARRY)
     _G.charSelect.character_add("Bombette", {"Hot-headed Bombette was once jailed", "in Koopa Bros. Fortress.", "That pink is adorable!"}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_BOMBETTE, CT_MARIO, TEX_BOMBETTE)
     _G.charSelect.character_add("Admiral Bobbery", {"Admiral Bobbery is a salty old Bob-omb sailor.", "who was once married to the lovely Scarlette.", "The workers at the docks say he’s some kind of legend."}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_BOBBERY, CT_MARIO, TEX_BOBBERY)
    _G.charSelect.character_add("Watt", {"The captive of Big Lantern Ghost in Shy Guy's Toy Box,", "she can shed light on your adventure."}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_WATT, CT_MARIO, TEX_WATT)
    _G.charSelect.character_add("Sushie", {"Sushie's a kindly Cheep Cheep ", "who worries about everyone.", "She loves romantic stories and cries at the drop of a fin."}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_SUSHIE, CT_MARIO, TEX_SUSHIE)
   _G.charSelect.character_add("Lakilester", {"Even though it says Lakilester on his cloud riding license,", "the green-haired Spiny-tosser calls himself Spike."}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_LAKILESTER, CT_MARIO, TEX_LAKILESTER)
   _G.charSelect.character_add("Lady Bow", {"Bow is a princess of a Boo,", "who has a castle in Forever Forest.", "As the head Boo of Boo's Mansion,", "she always knows how to get her way."}, "Melzinoff", {r = 255, g = 200, b = 200}, E_MODEL_BOW, CT_MARIO, TEX_BOW)



	_G.charSelect.character_add_voice(E_MODEL_GOOMBELLA, VOICETABLE_GOOMBA)
	_G.charSelect.character_add_voice(E_MODEL_GOOMBARIO, VOICETABLE_GOOMBA)
	_G.charSelect.character_add_voice(E_MODEL_KOOPER, VOICETABLE_KOOPA)
	_G.charSelect.character_add_voice(E_MODEL_KOOPS, VOICETABLE_KOOPA)
	_G.charSelect.character_add_voice(E_MODEL_PARAKARRY, VOICETABLE_KOOPA)
	_G.charSelect.character_add_voice(E_MODEL_BOMBETTE, VOICETABLE_BOBOMB)
	_G.charSelect.character_add_voice(E_MODEL_BOBBERY, VOICETABLE_BOBOMB)
	_G.charSelect.character_add_voice(E_MODEL_WATT, VOICETABLE_WATT)
 	_G.charSelect.character_add_voice(E_MODEL_SUSHIE, VOICETABLE_SUSHIE)
	_G.charSelect.character_add_voice(E_MODEL_LAKILESTER, VOICETABLE_LAKILESTER)
	_G.charSelect.character_add_voice(E_MODEL_BOW, VOICETABLE_BOW)
	
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_GOOMBA then return _G.charSelect.voice.sound(m, sound) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_GOOMBA then return _G.charSelect.voice.sound(m, sound) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_KOOPA then return _G.charSelect.voice.sound(m, sound) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_KOOPA then return _G.charSelect.voice.sound(m, sound) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_KOOPA then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_BOBOMB then return _G.charSelect.voice.sound(m, sound) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_BOBOMB then return _G.charSelect.voice.sound(m, sound) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_WATT then return _G.charSelect.voice.sound(m, sound) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_SUSHIE then return _G.charSelect.voice.sound(m, sound) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_LAKILESTER then return _G.charSelect.voice.sound(m, sound) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_BOW then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_GOOMBA then return _G.charSelect.voice.snore(m) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_GOOMBA then return _G.charSelect.voice.snore(m) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_KOOPA then return _G.charSelect.voice.snore(m) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_KOOPA then return _G.charSelect.voice.snore(m) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_KOOPA then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_BOBOMB then return _G.charSelect.voice.snore(m) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_BOBOMB then return _G.charSelect.voice.snore(m) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_WATT then return _G.charSelect.voice.snore(m) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_SUSHIE then return _G.charSelect.voice.snore(m) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_LAKILESTER then return _G.charSelect.voice.snore(m) end
	if _G.charSelect.character_get_voice(m) == VOICETABLE_BOW then return _G.charSelect.voice.snore(m) end
    end)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end
