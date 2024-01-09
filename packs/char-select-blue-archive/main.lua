-- name: [CS] Blue Archive Pack
-- description: A Template for Character Select to build off of when making your own pack!\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

--[[
    API Documentation for Character Select can be found below:
    https://github.com/Squishy6094/character-select-coop/blob/main/API-doc.md
]]

local E_model_momoi = smlua_model_util_get_id("momoi_geo")
local E_model_midori = smlua_model_util_get_id("midori_geo")
local E_model_yuzu = smlua_model_util_get_id("yuzu_geo")
local E_model_alice = smlua_model_util_get_id("alice_geo")
local E_model_fubuki = smlua_model_util_get_id("fubuki_geo")
local E_model_spmari = smlua_model_util_get_id("spmari_geo")
local E_model_mari = smlua_model_util_get_id("mari_geo")
local E_model_kazusa = smlua_model_util_get_id("kazusa_geo")
local E_model_reisa = smlua_model_util_get_id("reisa_geo")
local E_model_kokona = smlua_model_util_get_id("kokona_geo")
local E_model_himari = smlua_model_util_get_id("himari_geo")
local E_model_izuna = smlua_model_util_get_id("izuna_geo")
local E_model_tsukuyo = smlua_model_util_get_id("tsukuyo_geo")
local E_model_michiru = smlua_model_util_get_id("michiru_geo")
local E_model_yuuka = smlua_model_util_get_id("yuuka_geo")
local E_model_hina = smlua_model_util_get_id("hina_geo")

local TEXT_MOD_NAME = "Blue Archive Pack"
--
local VOICETABLE_momoi = {
    [CHAR_SOUND_ATTACKED] = {'momoi_hurt1.mp3', 'momoi_hurt2.mp3', 'momoi_yurusenai.mp3'},
    [CHAR_SOUND_DOH] = 'momoi_guo.mp3',
    [CHAR_SOUND_DYING] = {'momoi_mou.mp3', 'momoi_hurt3.mp3'},
    [CHAR_SOUND_EEUH] = {'momoi_ledgegetup.mp3',},
    [CHAR_SOUND_GAME_OVER] = {'momoi_kusoge.mp3',},
    [CHAR_SOUND_GROUND_POUND_WAH] = {'momoi_attack4.mp3',},
    [CHAR_SOUND_HAHA] = 'momoi_aha.mp3',
    [CHAR_SOUND_HAHA_2] = 'momoi_aha.mp3',
    --[CHAR_SOUND_HELLO] = 'silent.mp3',
    [CHAR_SOUND_HERE_WE_GO] = {'momoi_star_get.mp3',},
    [CHAR_SOUND_HOOHOO] = 'momoi_jump1.mp3',
    [CHAR_SOUND_HRMM] = 'momoi_yosh.mp3',
    [CHAR_SOUND_IMA_TIRED] = 'momoi_hmmm.mp3',
    [CHAR_SOUND_LETS_A_GO] = 'momoi_LetsGo.mp3',
    [CHAR_SOUND_MAMA_MIA] = 'momoi_kusoge.mp3',
    [CHAR_SOUND_ON_FIRE] = {'momoi_hurt1.mp3',},
    [CHAR_SOUND_OOOF] = 'momoi_eh1.mp3',
    [CHAR_SOUND_OOOF2] = 'momoi_hurt1.mp3',
    --[CHAR_SOUND_PANTING] = {'silent.mp3',},
    --[CHAR_SOUND_PANTING_COLD] = 'silent.mp3',
    --[CHAR_SOUND_PRESS_START_TO_PLAY] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_PUNCH_HOO] = {'momoi_attack7.mp3',},
    [CHAR_SOUND_PUNCH_WAH] = 'momoi_attack1.mp3',
    [CHAR_SOUND_PUNCH_YAH] = 'momoi_attack2.mp3',
    --[CHAR_SOUND_SNORING1] = 'silent.mp3',
    --[CHAR_SOUND_SNORING2] = 'silent.mp3',
    --[CHAR_SOUND_SNORING3] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_SO_LONGA_BOWSER] = {'momoi_throw_bowser1.mp3', 'momoi_throw_bowser2.mp3'},
    [CHAR_SOUND_TWIRL_BOUNCE] = {'momoi_aha.mp3'},
    [CHAR_SOUND_UH] = 'momoi_hoh.mp3',
    [CHAR_SOUND_UH2] = {'momoi_jump1.mp3',},
    [CHAR_SOUND_UH2_2] = 'momoi_guo.mp3',
    [CHAR_SOUND_WAAAOOOW] = 'momoi_falling.mp3',
    [CHAR_SOUND_WAH2] = 'momoi_attack4.mp3',
    [CHAR_SOUND_WHOA] = 'momoi_ledge_grab.mp3',
    [CHAR_SOUND_YAHOO] = {'momoi_yah.mp3',},
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'momoi_aha.mp3', 'momoi_yah.mp3'},
    [CHAR_SOUND_YAH_WAH_HOO] = {'momoi_attack2.mp3', 'momoi_attack6.mp3', 'momoi_attack5.mp3'},
    --[CHAR_SOUND_YAWNING] = 'silent.mp3',
}
local VOICETABLE_midori = {
    [CHAR_SOUND_ATTACKED] = {'midori_hurt2.mp3', 'midori_kuh.mp3', 'midori_eh.mp3'},
    [CHAR_SOUND_DOH] = 'midori_ah2.mp3',
    [CHAR_SOUND_DYING] = {'midori_kuyashi2.mp3', 'midori_hurt3.mp3'},
    [CHAR_SOUND_EEUH] = {'midori_ledgegetup.mp3',},
    --[CHAR_SOUND_GAME_OVER] = {'silent.mp3'},
    [CHAR_SOUND_GROUND_POUND_WAH] = {'midori_attack4.mp3', 'midori_attack1.mp3',},
    [CHAR_SOUND_HAHA] = 'midori_attack3.mp3',
    --[CHAR_SOUND_HAHA_2] = 'silent.mp3',
    --[CHAR_SOUND_HELLO] = 'silent.mp3',
    [CHAR_SOUND_HERE_WE_GO] = {'midori_Clear.mp3',},
    [CHAR_SOUND_HOOHOO] = 'midori_attack3.mp3',
    [CHAR_SOUND_HRMM] = 'midori_yosh.mp3',
    [CHAR_SOUND_IMA_TIRED] = 'midori_hmm2.mp3',
    [CHAR_SOUND_LETS_A_GO] = 'midori_letsgo.mp3',
    [CHAR_SOUND_MAMA_MIA] = 'midori_I lost.mp3',
    [CHAR_SOUND_ON_FIRE] = {'midori_hurt1.mp3',},
    [CHAR_SOUND_OOOF] = 'midori_ah2.mp3',
    [CHAR_SOUND_OOOF2] = 'midori_hurt2.mp3',
    [CHAR_SOUND_PANTING] = {'midori_pant.mp3',},
    --[CHAR_SOUND_PANTING_COLD] = 'silent.mp3',
    --[CHAR_SOUND_PRESS_START_TO_PLAY] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_PUNCH_HOO] = {'midori_attack1.mp3',},
    [CHAR_SOUND_PUNCH_WAH] = 'midori_attack4.mp3',
    [CHAR_SOUND_PUNCH_YAH] = 'midori_attack7.mp3',
    --[CHAR_SOUND_SNORING1] = 'silent.mp3',
    --[CHAR_SOUND_SNORING2] = 'silent.mp3',
    --[CHAR_SOUND_SNORING3] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_SO_LONGA_BOWSER] = {'midori_attack2.mp3'},
    [CHAR_SOUND_TWIRL_BOUNCE] = {'midori_attack2.mp3'},
    [CHAR_SOUND_UH] = 'midori_wah.mp3',
    [CHAR_SOUND_UH2] = {'midori_attack9.mp3',},
    [CHAR_SOUND_UH2_2] = 'midori_are.mp3',
    [CHAR_SOUND_WAAAOOOW] = 'midori_hurt1.mp3',
    [CHAR_SOUND_WAH2] = 'midori_attack4.mp3',
    [CHAR_SOUND_WHOA] = 'midori_huh.mp3',
    [CHAR_SOUND_YAHOO] = {'midori_attack3a.mp3',},
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'midori_attack3.mp3', 'midori_attack2.mp3'},
    [CHAR_SOUND_YAH_WAH_HOO] = {'midori_attack9.mp3', 'midori_attack6.mp3', 'midori_attack5.mp3'},
    --[CHAR_SOUND_YAWNING] = 'silent.mp3',
}
local VOICETABLE_yuzu = {
    [CHAR_SOUND_ATTACKED] = {'yuzu_hurt3.mp3', 'yuzu_hurt4.mp3'},
    [CHAR_SOUND_DOH] = 'yuzu_surprise.mp3', -- Bonk into walls
    [CHAR_SOUND_DYING] = {'yuzu_dead.mp3'},
    [CHAR_SOUND_EEUH] = {'yuzu_hngh.mp3',}, -- Slow Get up from ledge
    --[CHAR_SOUND_GAME_OVER] = {'silent.mp3'},
    [CHAR_SOUND_GROUND_POUND_WAH] = {'yuzu_tan.mp3'},
    --[CHAR_SOUND_HAHA] = 'silent.mp3', -- Landing after backflip
    --[CHAR_SOUND_HAHA_2] = 'silent.mp3', -- Landing on Water after a fall
    --[CHAR_SOUND_HELLO] = 'silent.mp3',
    [CHAR_SOUND_HERE_WE_GO] = {'yuzu_starget.mp3',}, -- Star Get + Obtaining Power-up
    [CHAR_SOUND_HOOHOO] = 'yuzu_jump3.mp3', -- 2nd Jump + Dive Attack
    [CHAR_SOUND_HRMM] = 'yuzu_jump2.mp3', -- Object Pick-up
    [CHAR_SOUND_IMA_TIRED] = 'yuzu_phew.mp3',
    [CHAR_SOUND_LETS_A_GO] = 'yuzu_letsgo.mp3', -- Level Select
    --[CHAR_SOUND_MAMA_MIA] = 'silent.mp3', -- Getting up after thrown out of level
    [CHAR_SOUND_ON_FIRE] = {'yuzu_hurt1.mp3',}, -- Touch Fire
    [CHAR_SOUND_OOOF] = 'yuzu_surprise.mp3',
    [CHAR_SOUND_OOOF2] = 'yuzu_hurt4.mp3', -- Landing After a Bonk + Thrown out of level
    --[CHAR_SOUND_PANTING] = {'silent.mp3',}, -- Low Health
    --[CHAR_SOUND_PANTING_COLD] = 'silent.mp3',
    --[CHAR_SOUND_PRESS_START_TO_PLAY] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_PUNCH_HOO] = {'yuzu_attack3.mp3',}, -- Kick
    [CHAR_SOUND_PUNCH_WAH] = 'yuzu_attack1.mp3', --2nd Punch
    [CHAR_SOUND_PUNCH_YAH] = 'yuzu_attack4.mp3', -- 1st Punch
    --[CHAR_SOUND_SNORING1] = 'silent.mp3',
    --[CHAR_SOUND_SNORING2] = 'silent.mp3',
    --[CHAR_SOUND_SNORING3] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_SO_LONGA_BOWSER] = {'yuzu_hah.mp3'}, --Bowser Throw
    [CHAR_SOUND_TWIRL_BOUNCE] = {'yuzu_jump2.mp3'}, -- Boing
    [CHAR_SOUND_UH] = 'yuzu_ah1.mp3', --Drop off of ledge
    [CHAR_SOUND_UH2] = {'yuzu_tan.mp3',}, -- ???
    [CHAR_SOUND_UH2_2] = 'yuzu_de.mp3', -- Landing after Long Jump
    [CHAR_SOUND_WAAAOOOW] = 'silent.mp3', -- Falling
    [CHAR_SOUND_WAH2] = 'yuzu_tan.mp3', -- Throw Object
    [CHAR_SOUND_WHOA] = 'yuzu_ah1.mp3', -- Ledge Grab
    [CHAR_SOUND_YAHOO] = {'yuzu_attack3.mp3',}, -- Long Jump
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'yuzu_hah.mp3', 'yuzu_attack3.mp3'}, -- 3rd Jump(s)
    [CHAR_SOUND_YAH_WAH_HOO] = {'yuzu_jump1.mp3', 'yuzu_attack6.mp3', 'yuzu_attack8.mp3'}, -- 1st Jump(s)
    --[CHAR_SOUND_YAWNING] = 'silent.mp3',
}
local VOICETABLE_alice = {
    [CHAR_SOUND_ATTACKED] = {'alice_damage1.mp3', 'alice_damage2.mp3'},
    [CHAR_SOUND_DOH] = 'alice_are1.mp3', -- Bonk into walls
    [CHAR_SOUND_DYING] = {'alice_dead1.mp3'},
    [CHAR_SOUND_EEUH] = {'alice_yoisho2.mp3',}, -- Slow Get up from ledge
    --[CHAR_SOUND_GAME_OVER] = {'silent.mp3'},
    [CHAR_SOUND_GROUND_POUND_WAH] = {'alice_ton.mp3'},
    [CHAR_SOUND_HAHA] = 'alice_laugh.mp3', -- Landing after backflip
    [CHAR_SOUND_HAHA_2] = 'alice_oho.mp3', -- Landing on Water after a fall
    --[CHAR_SOUND_HELLO] = 'silent.mp3',
    [CHAR_SOUND_HERE_WE_GO] = {'alice_panpakapan.mp3',}, -- Star Get + Obtaining Power-up
    [CHAR_SOUND_HOOHOO] = 'alice_jump4a.mp3', -- 2nd Jump + Dive Attack
    [CHAR_SOUND_HRMM] = 'alice_pickup.mp3', -- Object Pick-up
    [CHAR_SOUND_IMA_TIRED] = 'alice_hmm1.mp3',
    [CHAR_SOUND_LETS_A_GO] = 'alice_levelselect2.mp3', -- Level Select
    [CHAR_SOUND_MAMA_MIA] = 'alice_wontlose.mp3', -- Getting up after thrown out of level
    [CHAR_SOUND_ON_FIRE] = {'alice_damage3.mp3',}, -- Touch Fire
    [CHAR_SOUND_OOOF] = 'alice_damage2.mp3',
    [CHAR_SOUND_OOOF2] = 'alice_damage1.mp3', -- Landing After a Bonk + Thrown out of level
    --[CHAR_SOUND_PANTING] = {'silent.mp3',}, -- Low Health
    --[CHAR_SOUND_PANTING_COLD] = 'silent.mp3',
    --[CHAR_SOUND_PRESS_START_TO_PLAY] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_PUNCH_HOO] = {'alice_attack2.mp3',}, -- Kick
    [CHAR_SOUND_PUNCH_WAH] = 'alice_attack3.mp3', --2nd Punch
    [CHAR_SOUND_PUNCH_YAH] = 'alice_attack1.mp3', -- 1st Punch
    [CHAR_SOUND_SNORING1] = 'silent.mp3',
    [CHAR_SOUND_SNORING2] = 'silent.mp3',
    [CHAR_SOUND_SNORING3] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_SO_LONGA_BOWSER] = {'alice_bowserthrow2.mp3'}, --Bowser Throw
    [CHAR_SOUND_TWIRL_BOUNCE] = {'alice_oho.mp3'}, -- Boing
    [CHAR_SOUND_UH] = 'alice_ah1.mp3', --Drop off of ledge
    [CHAR_SOUND_UH2] = {'alice_kyu2.mp3',}, -- Quick Ledge Get-Up
    [CHAR_SOUND_UH2_2] = 'alice_to1.mp3', -- Landing after Long Jump
    --[CHAR_SOUND_WAAAOOOW] = 'silent.mp3', -- Falling
    [CHAR_SOUND_WAH2] = 'alice_attack2.mp3', -- Throw Object
    [CHAR_SOUND_WHOA] = 'alice_eh1.mp3', -- Ledge Grab
    [CHAR_SOUND_YAHOO] = {'alice_attack6.mp3',}, -- Long Jump
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'alice_attack7.mp3', 'alice_attack6.mp3'}, -- 3rd Jump(s)
    [CHAR_SOUND_YAH_WAH_HOO] = {'alice_jump1.mp3', 'alice_jump2.mp3', 'alice_kyu1.mp3'}, -- 1st Jump(s)
    [CHAR_SOUND_YAWNING] = 'alice_uu2.mp3',
}
local VOICETABLE_fubuki = {
    [CHAR_SOUND_ATTACKED] = {'fubuki_hurt1.mp3', 'fubuki_hurt2.mp3'},
    [CHAR_SOUND_DOH] = 'fubuki_eh2.mp3', -- Bonk into walls
    [CHAR_SOUND_DYING] = {'fubuki_donothing.mp3'},
    [CHAR_SOUND_EEUH] = {'fubuki_ledgegetup.mp3',}, -- Slow Get up from ledge
    --[CHAR_SOUND_GAME_OVER] = {'silent.mp3'},
    --[CHAR_SOUND_GROUND_POUND_WAH] = {'silent.mp3'},
    [CHAR_SOUND_HAHA] = 'fubuki_laugh.mp3', -- Landing after backflip
    [CHAR_SOUND_HAHA_2] = 'fubuki_laugh.mp3', -- Landing on Water after a fall
    --[CHAR_SOUND_HELLO] = 'silent.mp3',
    [CHAR_SOUND_HERE_WE_GO] = {'fubuki_chocodonut.mp3',}, -- Star Get + Obtaining Power-up
    [CHAR_SOUND_HOOHOO] = 'fubuki_jump2.mp3', -- 2nd Jump + Dive Attack
    [CHAR_SOUND_HRMM] = 'fubuki_pickup.mp3', -- Object Pick-up
    [CHAR_SOUND_IMA_TIRED] = 'fubuki_nemu.mp3',
    [CHAR_SOUND_LETS_A_GO] = 'fubuki_levelselect.mp3', -- Level Select
    [CHAR_SOUND_MAMA_MIA] = 'fubuki_annoying1.mp3', -- Getting up after thrown out of level
    [CHAR_SOUND_ON_FIRE] = {'fubuki_hurt1.mp3',}, -- Touch Fire
    [CHAR_SOUND_OOOF] = 'fubuki_hurt2.mp3',
    [CHAR_SOUND_OOOF2] = 'fubuki_hurt1.mp3', -- Landing After a Bonk + Thrown out of level
    --[CHAR_SOUND_PANTING] = {'silent.mp3',}, -- Low Health
    --[CHAR_SOUND_PANTING_COLD] = 'silent.mp3',
    --[CHAR_SOUND_PRESS_START_TO_PLAY] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_PUNCH_HOO] = {'fubuki_attack1.mp3',}, -- Kick
    [CHAR_SOUND_PUNCH_WAH] = 'fubuki_attack4.mp3', --2nd Punch
    [CHAR_SOUND_PUNCH_YAH] = 'fubuki_attack6.mp3', -- 1st Punch
    --[CHAR_SOUND_SNORING1] = 'silent.mp3',
    --[CHAR_SOUND_SNORING2] = 'silent.mp3',
    --[CHAR_SOUND_SNORING3] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_SO_LONGA_BOWSER] = {'fubuki_bowserthrow.mp3'}, --Bowser Throw
    [CHAR_SOUND_TWIRL_BOUNCE] = {'fubuki_laugh.mp3'}, -- Boing
    [CHAR_SOUND_UH] = 'fubuki_eh3.mp3', --Drop off of ledge
    [CHAR_SOUND_UH2] = {'fubuki_attack7.mp3',}, -- Quick Ledge Get-Up
    [CHAR_SOUND_UH2_2] = 'fubuki_te.mp3', -- Landing after Long Jump
    --[CHAR_SOUND_WAAAOOOW] = 'silent.mp3', -- Falling
    [CHAR_SOUND_WAH2] = 'fubuki_attack1.mp3', -- Throw Object
    [CHAR_SOUND_WHOA] = 'fubuki_ledgegrab.mp3', -- Ledge Grab
    [CHAR_SOUND_YAHOO] = {'fubuki_donut.mp3',}, -- Long Jump
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'fubuki_laugh.mp3',}, -- 3rd Jump(s)
    [CHAR_SOUND_YAH_WAH_HOO] = {'fubuki_jump1.mp3', 'fubuki_attack2.mp3', 'fubuki_attack4.mp3'}, -- 1st Jump(s)
    [CHAR_SOUND_YAWNING] = 'fubuki_yawn.mp3',
}
local VOICETABLE_mari = {
    [CHAR_SOUND_ATTACKED] = {'spmari_hurt3.mp3', 'spmari_hurt5.mp3' , 'spmari_hurt2.mp3'},
    [CHAR_SOUND_DOH] = 'spmari_ah.mp3', -- Bonk into walls
    [CHAR_SOUND_DYING] = {'spmari_dead.mp3'},
    [CHAR_SOUND_EEUH] = {'spmari_ledgegetup.mp3',}, -- Slow Get up from ledge
    --[CHAR_SOUND_GAME_OVER] = {'silent.mp3'},
    --[CHAR_SOUND_GROUND_POUND_WAH] = {'silent.mp3'},
    [CHAR_SOUND_HAHA] = 'spmari_laugh.mp3', -- Landing after backflip
    --[CHAR_SOUND_HAHA_2] = 'silent.mp3', -- Landing on Water after a fall
    --[CHAR_SOUND_HELLO] = 'silent.mp3',
    [CHAR_SOUND_HERE_WE_GO] = {'spmari_subarashi.mp3',}, -- Star Get + Obtaining Power-up
    [CHAR_SOUND_HOOHOO] = 'spmari_attack6.mp3', -- 2nd Jump + Dive Attack
    [CHAR_SOUND_HRMM] = 'spmari_pickup.mp3', -- Object Pick-up
    [CHAR_SOUND_IMA_TIRED] = 'spmari_pant.mp3',
    [CHAR_SOUND_LETS_A_GO] = 'spmari_levelselect.mp3', -- Level Select
    --[CHAR_SOUND_MAMA_MIA] = 'silent.mp3', -- Getting up after thrown out of level
    [CHAR_SOUND_ON_FIRE] = {'spmari_hurt1.mp3',}, -- Touch Fire
    [CHAR_SOUND_OOOF] = 'spmari_ah.mp3',
    [CHAR_SOUND_OOOF2] = 'spmari_hurt4.mp3', -- Landing After a Bonk + Thrown out of level
    --[CHAR_SOUND_PANTING] = {'silent.mp3',}, -- Low Health
    --[CHAR_SOUND_PANTING_COLD] = 'silent.mp3',
    --[CHAR_SOUND_PRESS_START_TO_PLAY] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_PUNCH_HOO] = {'spmari_attack5.mp3',}, -- Kick
    [CHAR_SOUND_PUNCH_WAH] = 'spmari_attack6.mp3', --2nd Punch
    [CHAR_SOUND_PUNCH_YAH] = 'spmari_attack1.mp3', -- 1st Punch
    --[CHAR_SOUND_SNORING1] = 'silent.mp3',
    --[CHAR_SOUND_SNORING2] = 'silent.mp3',
    --[CHAR_SOUND_SNORING3] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_SO_LONGA_BOWSER] = {'spmari_rip.mp3'}, --Bowser Throw
    [CHAR_SOUND_TWIRL_BOUNCE] = {'spmari_laugh.mp3'}, -- Boing
    [CHAR_SOUND_UH] = 'spmari_uh1.mp3', --Drop off of ledge
    [CHAR_SOUND_UH2] = {'spmari_attack7.mp3',}, -- Quick Ledge Get-Up
    [CHAR_SOUND_UH2_2] = 'spmari_attack9.mp3', -- Landing after Long Jump
    --[CHAR_SOUND_WAAAOOOW] = 'silent.mp3', -- Falling
    [CHAR_SOUND_WAH2] = 'spmari_attack5.mp3', -- Throw Object
    [CHAR_SOUND_WHOA] = 'spmari_uh1.mp3', -- Ledge Grab
    [CHAR_SOUND_YAHOO] = {'spmari_attack3.mp3',}, -- Long Jump
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'spmari_attack3.mp3',}, -- 3rd Jump(s)
    [CHAR_SOUND_YAH_WAH_HOO] = {'spmari_attack7.mp3', 'spmari_attack1.mp3', 'spmari_attack8.mp3'}, -- 1st Jump(s)
    --[CHAR_SOUND_YAWNING] = 'silent.mp3',
}
local VOICETABLE_kazusa = {
    [CHAR_SOUND_ATTACKED] = {'kazusa_dmg1.mp3', 'kazusa_dmg3.mp3'},
    [CHAR_SOUND_DOH] = 'kazusa_what.mp3', -- Bonk into walls
    [CHAR_SOUND_DYING] = {'kazusa_dead.mp3'},
    --[CHAR_SOUND_EEUH] = {'silent.mp3',}, -- Slow Get up from ledge
    --[CHAR_SOUND_GAME_OVER] = {'silent.mp3'},
    [CHAR_SOUND_GROUND_POUND_WAH] = {'kazusa_groundpound.mp3'},
    --[CHAR_SOUND_HAHA] = 'silent.mp3', -- Landing after backflip
    --[CHAR_SOUND_HAHA_2] = 'silent.mp3', -- Landing on Water after a fall
    --[CHAR_SOUND_HELLO] = 'silent.mp3',
    [CHAR_SOUND_HERE_WE_GO] = {'kazusa_sugoi.mp3',}, -- Star Get + Obtaining Power-up
    [CHAR_SOUND_HOOHOO] = 'kazusa_jump4.mp3', -- 2nd Jump + Dive Attack
    [CHAR_SOUND_HRMM] = 'kazusa_pickup.mp3', -- Object Pick-up
    --[CHAR_SOUND_IMA_TIRED] = 'silent.mp3',
    [CHAR_SOUND_LETS_A_GO] = 'kazusa_levelselect.mp3', -- Level Select
    --[CHAR_SOUND_MAMA_MIA] = 'silent.mp3', -- Getting up after thrown out of level
    [CHAR_SOUND_ON_FIRE] = {'kazusa_what.mp3',}, -- Touch Fire
    [CHAR_SOUND_OOOF] = 'kazusa_eh1.mp3', -- Grabbed by Chuckya
    [CHAR_SOUND_OOOF2] = 'kazusa_dmg2.mp3', -- Landing After a Bonk + Thrown out of level
    --[CHAR_SOUND_PANTING] = {'silent.mp3',}, -- Low Health
    --[CHAR_SOUND_PANTING_COLD] = 'silent.mp3',
    --[CHAR_SOUND_PRESS_START_TO_PLAY] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_PUNCH_HOO] = {'kazusa_ora.mp3',}, -- Kick
    [CHAR_SOUND_PUNCH_WAH] = 'kazusa_atk4.mp3', --2nd Punch
    [CHAR_SOUND_PUNCH_YAH] = 'kazusa_atk1.mp3', -- 1st Punch
    --[CHAR_SOUND_SNORING1] = 'silent.mp3',
    --[CHAR_SOUND_SNORING2] = 'silent.mp3',
    --[CHAR_SOUND_SNORING3] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_SO_LONGA_BOWSER] = {'kazusa_bowserthrow.mp3'}, --Bowser Throw
    --[CHAR_SOUND_TWIRL_BOUNCE] = {'silent.mp3'}, -- Boing
    [CHAR_SOUND_UH] = 'kazusa_eh2.mp3', --Drop off of ledge
    [CHAR_SOUND_UH2] = {'kazusa_jump2.mp3',}, -- Quick Ledge Get-Up
    --[CHAR_SOUND_UH2_2] = 'silent.mp3', -- Landing after Long Jump
    [CHAR_SOUND_WAAAOOOW] = 'kazusa_fall.mp3', -- Falling
    [CHAR_SOUND_WAH2] = 'kazusa_ora.mp3', -- Throw Object
    [CHAR_SOUND_WHOA] = 'kazusa_wah2.mp3', -- Ledge Grab
    [CHAR_SOUND_YAHOO] = {'kazusa_jump3.mp3',}, -- Long Jump
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'kazusa_jump3.mp3',}, -- 3rd Jump(s)
    [CHAR_SOUND_YAH_WAH_HOO] = {'kazusa_jump1.mp3', 'kazusa_jump5.mp3', 'kazusa_jump2.mp3'}, -- 1st Jump(s)
    --[CHAR_SOUND_YAWNING] = 'silent.mp3',
}
local VOICETABLE_reisa = {
    [CHAR_SOUND_ATTACKED] = {'reisa_dmg2.mp3', 'reisa_dmg1.mp3'},
    [CHAR_SOUND_DOH] = 'reisa_huh1.mp3', -- Bonk into walls
    [CHAR_SOUND_DYING] = {'reisa_dead.mp3'},
    --[CHAR_SOUND_EEUH] = {'silent.mp3',}, -- Slow Get up from ledge
    --[CHAR_SOUND_GAME_OVER] = {'silent.mp3'},
    [CHAR_SOUND_GROUND_POUND_WAH] = {'reisa_atk6.mp3'},
    [CHAR_SOUND_HAHA] = 'reisa_desu.mp3', -- Landing after backflip
    --[CHAR_SOUND_HAHA_2] = 'silent.mp3', -- Landing on Water after a fall
    --[CHAR_SOUND_HELLO] = 'silent.mp3',
    [CHAR_SOUND_HERE_WE_GO] = {'reisa_starget1.mp3',}, -- Star Get + Obtaining Power-up
    [CHAR_SOUND_HOOHOO] = 'reisa_jump1.mp3', -- 2nd Jump + Dive Attack
    [CHAR_SOUND_HRMM] = 'reisa_pickup.mp3', -- Object Pick-up
    --[CHAR_SOUND_IMA_TIRED] = 'silent.mp3',
    [CHAR_SOUND_LETS_A_GO] = 'reisa_levelselect.mp3', -- Level Select
    --[CHAR_SOUND_MAMA_MIA] = 'silent.mp3', -- Getting up after thrown out of level
    [CHAR_SOUND_ON_FIRE] = {'reisa_dmg3.mp3',}, -- Touch Fire
    [CHAR_SOUND_OOOF] = 'reisa_ah1.mp3',
    [CHAR_SOUND_OOOF2] = 'reisa_dmg1.mp3', -- Landing After a Bonk + Thrown out of level
    --[CHAR_SOUND_PANTING] = {'silent.mp3',}, -- Low Health
    --[CHAR_SOUND_PANTING_COLD] = 'silent.mp3',
    [CHAR_SOUND_PRESS_START_TO_PLAY] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_PUNCH_HOO] = {'reisa_atk1.mp3',}, -- Kick
    [CHAR_SOUND_PUNCH_WAH] = 'reisa_atk4.mp3', --2nd Punch
    [CHAR_SOUND_PUNCH_YAH] = 'reisa_atk2.mp3', -- 1st Punch
    --[CHAR_SOUND_SNORING1] = 'silent.mp3',
    --[CHAR_SOUND_SNORING2] = 'silent.mp3',
    --[CHAR_SOUND_SNORING3] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_SO_LONGA_BOWSER] = {'reisa_bowserthrow2.mp3', 'reisa_bowserthrow1.mp3'}, --Bowser Throw
    [CHAR_SOUND_TWIRL_BOUNCE] = {'reisa_hisatsu.mp3'}, -- Boing
    [CHAR_SOUND_UH] = 'reisa_ah1.mp3', --Drop off of ledge
    [CHAR_SOUND_UH2] = {'reisa_atk7.mp3',}, -- Quick Ledge Get-Up
    --[CHAR_SOUND_UH2_2] = 'silent.mp3', -- Landing after Long Jump
    --[CHAR_SOUND_WAAAOOOW] = 'silent.mp3', -- Falling
    [CHAR_SOUND_WAH2] = 'reisa_throw.mp3', -- Throw Object
    [CHAR_SOUND_WHOA] = 'reisa_ledgegrab.mp3', -- Ledge Grab
    [CHAR_SOUND_YAHOO] = {'reisa_longjump.mp3',}, -- Long Jump
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'reisa_jump4.mp3',}, -- 3rd Jump(s)
    [CHAR_SOUND_YAH_WAH_HOO] = {'reisa_jump3.mp3', 'reisa_jump2.mp3', 'reisa_atk5.mp3'}, -- 1st Jump(s)
    --[CHAR_SOUND_YAWNING] = 'silent.mp3',
}
local VOICETABLE_kokona = {
    [CHAR_SOUND_ATTACKED] = {'kokona_dmg4.mp3', 'kokona_dmg1.mp3'},
    [CHAR_SOUND_DOH] = 'kokona_ah2.mp3', -- Bonk into walls
    [CHAR_SOUND_DYING] = {'kokona_dead1.mp3'},
    --[CHAR_SOUND_EEUH] = {'silent.mp3',}, -- Slow Get up from ledge
    --[CHAR_SOUND_GAME_OVER] = {'silent.mp3'},
    [CHAR_SOUND_GROUND_POUND_WAH] = {'kokona_atk6.mp3'},
    [CHAR_SOUND_HAHA] = 'kokona_laugh.mp3', -- Landing after backflip
    --[CHAR_SOUND_HAHA_2] = 'silent.mp3', -- Landing on Water after a fall
    --[CHAR_SOUND_HELLO] = 'silent.mp3',
    [CHAR_SOUND_HERE_WE_GO] = {'kokona_starget1.mp3',}, -- Star Get + Obtaining Power-up
    [CHAR_SOUND_HOOHOO] = 'kokona_jump2.mp3', -- 2nd Jump + Dive Attack
    --[CHAR_SOUND_HRMM] = 'silent.mp3', -- Object Pick-up
    --[CHAR_SOUND_IMA_TIRED] = 'silent.mp3',
    [CHAR_SOUND_LETS_A_GO] = 'kokona_levelselect.mp3', -- Level Select
    [CHAR_SOUND_MAMA_MIA] = 'kokona_daijobu.mp3', -- Getting up after thrown out of level
    [CHAR_SOUND_ON_FIRE] = {'kokona_onfire.mp3',}, -- Touch Fire
    [CHAR_SOUND_OOOF] = 'kokona_eh1.mp3',
    [CHAR_SOUND_OOOF2] = 'kokona_dmg2.mp3', -- Landing After a Bonk + Thrown out of level
    --[CHAR_SOUND_PANTING] = {'silent.mp3',}, -- Low Health
    --[CHAR_SOUND_PANTING_COLD] = 'silent.mp3',
    --[CHAR_SOUND_PRESS_START_TO_PLAY] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_PUNCH_HOO] = {'kokona_atk1.mp3',}, -- Kick
    [CHAR_SOUND_PUNCH_WAH] = 'kokona_atk3.mp3', --2nd Punch
    [CHAR_SOUND_PUNCH_YAH] = 'kokona_atk2.mp3', -- 1st Punch
    --[CHAR_SOUND_SNORING1] = 'silent.mp3',
    --[CHAR_SOUND_SNORING2] = 'silent.mp3',
    --[CHAR_SOUND_SNORING3] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'kokona_atk1.mp3', --Bowser Throw
    --[CHAR_SOUND_TWIRL_BOUNCE] = {'silent.mp3'}, -- Boing
    [CHAR_SOUND_UH] = 'kokona_ah1.mp3', --Drop off of ledge + Fall off Ledge
    [CHAR_SOUND_UH2] = {'kokona_atk2.mp3',}, -- Quick Ledge Get-Up
    --[CHAR_SOUND_UH2_2] = 'silent.mp3', -- Landing after Long Jump
    --[CHAR_SOUND_WAAAOOOW] = 'silent.mp3', -- Falling
    [CHAR_SOUND_WAH2] = 'kokona_atk2.mp3', -- Throw Object
    [CHAR_SOUND_WHOA] = 'kokona_ah1.mp3', -- Ledge Grab
    [CHAR_SOUND_YAHOO] = {'kokona_atk1.mp3',}, -- Long Jump
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'kokona_atk3.mp3',}, -- 3rd Jump(s)
    [CHAR_SOUND_YAH_WAH_HOO] = {'kokona_jump7.mp3', 'kokona_atk6.mp3', 'kokona_atk5.mp3'}, -- 1st Jump(s)
    --[CHAR_SOUND_YAWNING] = 'silent.mp3',
}
local VOICETABLE_himari = {
    --[CHAR_SOUND_ATTACKED] = {'kokona_dmg4.mp3', 'kokona_dmg1.mp3'},
    [CHAR_SOUND_DOH] = 'himari_ara2.mp3', -- Bonk into walls
    --[CHAR_SOUND_DYING] = {'kokona_dead1.mp3'},
    --[CHAR_SOUND_EEUH] = {'silent.mp3',}, -- Slow Get up from ledge
    --[CHAR_SOUND_GAME_OVER] = {'silent.mp3'},
    [CHAR_SOUND_GROUND_POUND_WAH] = {'himari_atk1.mp3'},
    [CHAR_SOUND_HAHA] = 'himari_laugh.mp3', -- Landing after backflip
    --[CHAR_SOUND_HAHA_2] = 'silent.mp3', -- Landing on Water after a fall
    --[CHAR_SOUND_HELLO] = 'silent.mp3',
    [CHAR_SOUND_HERE_WE_GO] = {'himari_star.mp3',}, -- Star Get + Obtaining Power-up
    [CHAR_SOUND_HOOHOO] = 'himari_jump4.mp3', -- 2nd Jump + Dive Attack
    [CHAR_SOUND_HRMM] = 'himari_pickup.mp3', -- Object Pick-up
    --[CHAR_SOUND_IMA_TIRED] = 'silent.mp3',
    [CHAR_SOUND_LETS_A_GO] = 'himari_levelselect.mp3', -- Level Select
    --[CHAR_SOUND_MAMA_MIA] = 'kokona_daijobu.mp3', -- Getting up after thrown out of level
    --[CHAR_SOUND_ON_FIRE] = {'kokona_onfire.mp3',}, -- Touch Fire
    [CHAR_SOUND_OOOF] = 'himari_eh1.mp3', -- Grabbed by Chuckya
    --[CHAR_SOUND_OOOF2] = 'kokona_dmg2.mp3', -- Landing After a Bonk + Thrown out of level
    --[CHAR_SOUND_PANTING] = {'silent.mp3',}, -- Low Health
    --[CHAR_SOUND_PANTING_COLD] = 'silent.mp3',
    --[CHAR_SOUND_PRESS_START_TO_PLAY] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_PUNCH_HOO] = {'himari_atk5.mp3',}, -- Kick
    [CHAR_SOUND_PUNCH_WAH] = 'himari_atk4.mp3', --2nd Punch
    [CHAR_SOUND_PUNCH_YAH] = 'himari_atk7.mp3', -- 1st Punch
    --[CHAR_SOUND_SNORING1] = 'silent.mp3',
    --[CHAR_SOUND_SNORING2] = 'silent.mp3',
    --[CHAR_SOUND_SNORING3] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'himari_bowserthrow.mp3', --Bowser Throw
    --[CHAR_SOUND_TWIRL_BOUNCE] = {'silent.mp3'}, -- Boing
    [CHAR_SOUND_UH] = 'himari_huh1.mp3', --Drop off of ledge + Fall off Ledge
    [CHAR_SOUND_UH2] = {'himari_atk6.mp3',}, -- Quick Ledge Get-Up
    --[CHAR_SOUND_UH2_2] = 'silent.mp3', -- Landing after Long Jump
    --[CHAR_SOUND_WAAAOOOW] = 'silent.mp3', -- Falling
    [CHAR_SOUND_WAH2] = 'himari_atk2.mp3', -- Throw Object
    [CHAR_SOUND_WHOA] = 'himari_ara1.mp3', -- Ledge Grab
    [CHAR_SOUND_YAHOO] = {'himari_yo.mp3',}, -- Long Jump
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'himari_yo.mp3',}, -- 3rd Jump(s)
    [CHAR_SOUND_YAH_WAH_HOO] = {'himari_jump2.mp3', 'himari_jump3.mp3', 'himari_atk5.mp3'}, -- 1st Jump(s)
    --[CHAR_SOUND_YAWNING] = 'silent.mp3',
}
local VOICETABLE_izuna = {
    [CHAR_SOUND_ATTACKED] = {'izuna_dmg1.mp3', 'izuna_dmg2.mp3'},
    [CHAR_SOUND_DOH] = 'izuna_uu1.mp3', -- Bonk into walls
    [CHAR_SOUND_DYING] = {'izuna_dead1.mp3'},
    --[CHAR_SOUND_EEUH] = {'silent.mp3',}, -- Slow Get up from ledge
    --[CHAR_SOUND_GAME_OVER] = {'silent.mp3'},
    --[CHAR_SOUND_GROUND_POUND_WAH] = {'himari_atk1.mp3'},
    [CHAR_SOUND_HAHA] = 'izuna_desu.mp3', -- Landing after backflip
    --[CHAR_SOUND_HAHA_2] = 'silent.mp3', -- Landing on Water after a fall
    --[CHAR_SOUND_HELLO] = 'silent.mp3',
    [CHAR_SOUND_HERE_WE_GO] = {'izuna_star.mp3',}, -- Star Get + Obtaining Power-up
    [CHAR_SOUND_HOOHOO] = 'izuna_jump2.mp3', -- 2nd Jump + Dive Attack
    --[CHAR_SOUND_HRMM] = 'himari_pickup.mp3', -- Object Pick-up
    --[CHAR_SOUND_IMA_TIRED] = 'silent.mp3',
    [CHAR_SOUND_LETS_A_GO] = 'izuna_nin2.mp3', -- Level Select
    --[CHAR_SOUND_MAMA_MIA] = 'kokona_daijobu.mp3', -- Getting up after thrown out of level
    [CHAR_SOUND_ON_FIRE] = {'izuna_fire.mp3',}, -- Touch Fire
    [CHAR_SOUND_OOOF] = 'izuna_eh1.mp3', -- Grabbed by Chuckya
    [CHAR_SOUND_OOOF2] = 'izuna_dmg3.mp3', -- Landing After a Bonk + Thrown out of level
    --[CHAR_SOUND_PANTING] = {'silent.mp3',}, -- Low Health
    --[CHAR_SOUND_PANTING_COLD] = 'silent.mp3',
    --[CHAR_SOUND_PRESS_START_TO_PLAY] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_PUNCH_HOO] = {'izuna_atk2.mp3',}, -- Kick
    [CHAR_SOUND_PUNCH_WAH] = 'izuna_atk4.mp3', --2nd Punch
    [CHAR_SOUND_PUNCH_YAH] = 'izuna_atk3.mp3', -- 1st Punch
    --[CHAR_SOUND_SNORING1] = 'silent.mp3',
    --[CHAR_SOUND_SNORING2] = 'silent.mp3',
    --[CHAR_SOUND_SNORING3] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'izuna_atk2.mp3', --Bowser Throw
    --[CHAR_SOUND_TWIRL_BOUNCE] = {'silent.mp3'}, -- Boing
    [CHAR_SOUND_UH] = 'izuna_uu1.mp3', --Drop off of ledge + Fall off Ledge
    [CHAR_SOUND_UH2] = {'izuna_quickledge.mp3',}, -- Quick Ledge Get-Up
    --[CHAR_SOUND_UH2_2] = 'silent.mp3', -- Landing after Long Jump
    --[CHAR_SOUND_WAAAOOOW] = 'silent.mp3', -- Falling
    [CHAR_SOUND_WAH2] = 'izuna_atk1.mp3', -- Throw Object
    [CHAR_SOUND_WHOA] = 'izuna_ah1.mp3', -- Ledge Grab
    [CHAR_SOUND_YAHOO] = {'izuna_nin1.mp3',}, -- Long Jump
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'izuna_nin1.mp3', 'izuna_atk2.mp3'}, -- 3rd Jump(s)
    [CHAR_SOUND_YAH_WAH_HOO] = {'izuna_jump5.mp3', 'izuna_atk1.mp3', 'izuna_jump4.mp3'}, -- 1st Jump(s)
    --[CHAR_SOUND_YAWNING] = 'silent.mp3',
}
local VOICETABLE_tsukuyo = {
    [CHAR_SOUND_ATTACKED] = {'tsukuyo_dmg4.mp3', 'tsukuyo_dmg2.mp3', 'tsukuyo_dmg1.mp3'},
    [CHAR_SOUND_DOH] = 'tsukuyo_ah1.mp3', -- Bonk into walls
    [CHAR_SOUND_DYING] = {'tsukuyo_dead.mp3'},
    --[CHAR_SOUND_EEUH] = {'silent.mp3',}, -- Slow Get up from ledge
    --[CHAR_SOUND_GAME_OVER] = {'silent.mp3'},
    --[CHAR_SOUND_GROUND_POUND_WAH] = {'silent.mp3'},
    [CHAR_SOUND_HAHA] = 'tsukuyo_laugh.mp3', -- Landing after backflip
    --[CHAR_SOUND_HAHA_2] = 'silent.mp3', -- Landing on Water after a fall
    --[CHAR_SOUND_HELLO] = 'silent.mp3',
    [CHAR_SOUND_HERE_WE_GO] = {'tsukuyo_star.mp3',}, -- Star Get + Obtaining Power-up
    [CHAR_SOUND_HOOHOO] = 'tsukuyo_jump2.mp3', -- 2nd Jump + Dive Attack
    [CHAR_SOUND_HRMM] = 'tsukuyo_pickup.mp3', -- Object Pick-up
    --[CHAR_SOUND_IMA_TIRED] = 'silent.mp3',
    [CHAR_SOUND_LETS_A_GO] = 'tsukuyo_levelselect1.mp3', -- Level Select
    [CHAR_SOUND_MAMA_MIA] = 'tsukuyo_getup.mp3', -- Getting up after thrown out of level
    [CHAR_SOUND_ON_FIRE] = {'tsukuyo_dmg3.mp3', 'tsukuyo_ah3.mp3'}, -- Touch Fire
    [CHAR_SOUND_OOOF] = 'tsukuyo_ah4.mp3', -- Grabbed by Chuckya
    [CHAR_SOUND_OOOF2] = 'tsukuyo_dmg1.mp3', -- Landing After a Bonk + Thrown out of level
    --[CHAR_SOUND_PANTING] = {'silent.mp3',}, -- Low Health
    --[CHAR_SOUND_PANTING_COLD] = 'silent.mp3',
    --[CHAR_SOUND_PRESS_START_TO_PLAY] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_PUNCH_HOO] = {'tsukuyo_atk1.mp3',}, -- Kick
    [CHAR_SOUND_PUNCH_WAH] = 'tsukuyo_atk4.mp3', --2nd Punch
    [CHAR_SOUND_PUNCH_YAH] = 'tsukuyo_atk3.mp3', -- 1st Punch
    --[CHAR_SOUND_SNORING1] = 'silent.mp3',
    --[CHAR_SOUND_SNORING2] = 'silent.mp3',
    --[CHAR_SOUND_SNORING3] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'tsukuyo_atk1.mp3', --Bowser Throw
    --[CHAR_SOUND_TWIRL_BOUNCE] = {'silent.mp3'}, -- Boing
    [CHAR_SOUND_UH] = 'tsukuyo_ah2.mp3', --Drop off of ledge + Fall off Ledge
    [CHAR_SOUND_UH2] = {'tsukuyo_atk2.mp3',}, -- Quick Ledge Get-Up
    --[CHAR_SOUND_UH2_2] = 'silent.mp3', -- Landing after Long Jump
    --[CHAR_SOUND_WAAAOOOW] = 'silent.mp3', -- Falling
    [CHAR_SOUND_WAH2] = 'tsukuyo_throw.mp3', -- Throw Object
    [CHAR_SOUND_WHOA] = 'tsukuyo_ah4.mp3', -- Ledge Grab
    [CHAR_SOUND_YAHOO] = {'tsukuyo_nin1.mp3',}, -- Long Jump
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'tsukuyo_atk1.mp3',}, -- 3rd Jump(s)
    [CHAR_SOUND_YAH_WAH_HOO] = {'tsukuyo_atk5.mp3', 'tsukuyo_atk6.mp3', 'tsukuyo_jump1.mp3'}, -- 1st Jump(s)
    --[CHAR_SOUND_YAWNING] = 'silent.mp3',
}
local VOICETABLE_michiru = {
    [CHAR_SOUND_ATTACKED] = {'michiru_dmg1.mp3', 'michiru_hua.mp3',},
    [CHAR_SOUND_DOH] = 'michiru_eh1.mp3', -- Bonk into walls
    [CHAR_SOUND_DYING] = {'michiru_dead1.mp3', 'michiru_dead2.mp3'},
    --[CHAR_SOUND_EEUH] = {'silent.mp3',}, -- Slow Get up from ledge
    --[CHAR_SOUND_GAME_OVER] = {'silent.mp3'},
    [CHAR_SOUND_GROUND_POUND_WAH] = {'michiru_atk7.mp3'},
    [CHAR_SOUND_HAHA] = 'michiru_laugh.mp3', -- Landing after backflip
    --[CHAR_SOUND_HAHA_2] = 'silent.mp3', -- Landing on Water after a fall
    --[CHAR_SOUND_HELLO] = 'silent.mp3',
    [CHAR_SOUND_HERE_WE_GO] = {'michiru_star.mp3',}, -- Star Get + Obtaining Power-up
    [CHAR_SOUND_HOOHOO] = 'michiru_jump2.mp3', -- 2nd Jump + Dive Attack
    [CHAR_SOUND_HRMM] = 'michiru_pickup.mp3', -- Object Pick-up
    --[CHAR_SOUND_IMA_TIRED] = 'silent.mp3',
    [CHAR_SOUND_LETS_A_GO] = {'michiru_levelselect1.mp3', 'michiru_levelselect2.mp3',}, -- Level Select
    [CHAR_SOUND_MAMA_MIA] = 'michiru_getup.mp3', -- Getting up after thrown out of level
    [CHAR_SOUND_ON_FIRE] = {'michiru_fire1.mp3', 'michiru_fire2.mp3',}, -- Touch Fire
    [CHAR_SOUND_OOOF] = 'michiru_eh1.mp3', -- Grabbed by Chuckya
    [CHAR_SOUND_OOOF2] = 'michiru_dmg2.mp3', -- Landing After a Bonk + Thrown out of level
    --[CHAR_SOUND_PANTING] = {'silent.mp3',}, -- Low Health
    --[CHAR_SOUND_PANTING_COLD] = 'silent.mp3',
    --[CHAR_SOUND_PRESS_START_TO_PLAY] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_PUNCH_HOO] = {'michiru_atk4.mp3',}, -- Kick
    [CHAR_SOUND_PUNCH_WAH] = 'michiru_atk7.mp3', --2nd Punch
    [CHAR_SOUND_PUNCH_YAH] = 'michiru_atk5.mp3', -- 1st Punch
    --[CHAR_SOUND_SNORING1] = 'silent.mp3',
    --[CHAR_SOUND_SNORING2] = 'silent.mp3',
    --[CHAR_SOUND_SNORING3] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'michiru_atk2.mp3', --Bowser Throw
    [CHAR_SOUND_TWIRL_BOUNCE] = {'michiru_huhn.mp3'}, -- Boing
    [CHAR_SOUND_UH] = 'michiru_ah1.mp3', --Drop off of ledge + Fall off Ledge
    [CHAR_SOUND_UH2] = {'michiru_atk1.mp3',}, -- Quick Ledge Get-Up
    --[CHAR_SOUND_UH2_2] = 'silent.mp3', -- Landing after Long Jump
    [CHAR_SOUND_WAAAOOOW] = 'michiru_fall.mp3', -- Falling
    [CHAR_SOUND_WAH2] = 'michiru_throw.mp3', -- Throw Object
    [CHAR_SOUND_WHOA] = 'michiru_are1.mp3', -- Ledge Grab
    [CHAR_SOUND_YAHOO] = {'michiru_shuba.mp3',}, -- Long Jump
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'michiru_atk2.mp3',}, -- 3rd Jump(s)
    [CHAR_SOUND_YAH_WAH_HOO] = {'michiru_jump1.mp3', 'michiru_atk1.mp3', 'michiru_jump3.mp3'}, -- 1st Jump(s)
    --[CHAR_SOUND_YAWNING] = 'silent.mp3',
}
local VOICETABLE_hina = {
    [CHAR_SOUND_ATTACKED] = {'hina_dmg2.mp3', 'hina_dmg5.mp3'},
    [CHAR_SOUND_DOH] = 'hina_dmg3.mp3', -- Bonk into walls
    [CHAR_SOUND_DYING] = {'hina_dead1.mp3', 'hina_dead2.mp3'},
    -- [CHAR_SOUND_EEUH] = {'silent.mp3',}, -- Slow Get up from ledge
    -- [CHAR_SOUND_GAME_OVER] = {'silent.mp3'}, -- Game Over Voiceline
    [CHAR_SOUND_GROUND_POUND_WAH] = {'hina_atk3.mp3'},
    -- [CHAR_SOUND_HAHA] = 'silent.mp3', -- Landing after backflip
    -- [CHAR_SOUND_HAHA_2] = 'silent.mp3', -- Landing on Water after a fall
    -- [CHAR_SOUND_HELLO] = 'silent.mp3', -- Intro Voiceline
    [CHAR_SOUND_HERE_WE_GO] = {'hina_starget1.mp3', 'hina_starget2.mp3'}, -- Star Get + Obtaining Power-up
    [CHAR_SOUND_HOOHOO] = 'hina_atk3.mp3', -- 2nd Jump + Dive Attack
    [CHAR_SOUND_HRMM] = 'hina_grab.mp3', -- Object Pick-up
    [CHAR_SOUND_IMA_TIRED] = 'hina_sigh.mp3',
    [CHAR_SOUND_LETS_A_GO] = {'hina_levelselect.mp3'}, -- Level Select
    [CHAR_SOUND_MAMA_MIA] = {'hina_annoying1.mp3', 'hina_getup.mp3'}, -- Getting up after thrown out of level
    [CHAR_SOUND_ON_FIRE] = {'hina_what.mp3'}, -- Touch Fire
    [CHAR_SOUND_OOOF] = 'hina_dmg3.mp3', -- Grabbed by Chuckya
    [CHAR_SOUND_OOOF2] = 'hina_dmg1.mp3', -- Landing After a Bonk + Thrown out of level
    -- [CHAR_SOUND_PANTING] = {'silent.mp3',}, -- Low Health
    -- [CHAR_SOUND_PANTING_COLD] = 'silent.mp3',
    -- [CHAR_SOUND_PRESS_START_TO_PLAY] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_PUNCH_HOO] = {'hina_atk4.mp3'}, -- Kick
    [CHAR_SOUND_PUNCH_WAH] = 'hina_atk2.mp3', -- 2nd Punch
    [CHAR_SOUND_PUNCH_YAH] = 'hina_atk1.mp3', -- 1st Punch
    -- [CHAR_SOUND_SNORING1] = 'silent.mp3',
    -- [CHAR_SOUND_SNORING2] = 'silent.mp3',
    -- [CHAR_SOUND_SNORING3] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_SO_LONGA_BOWSER] = {'hina_bowserthrow1.mp3', 'hina_bowserthrow4.mp3', 'hina_nomercy.mp3'}, -- Bowser Throw
    -- [CHAR_SOUND_TWIRL_BOUNCE] = {'silent.mp3'}, -- Boing
    [CHAR_SOUND_UH] = 'hina_nn.mp3', -- Drop off of ledge + Fall off Ledge
    [CHAR_SOUND_UH2] = {'hina_atk3.mp3'}, -- Quick Ledge Get-Up
    -- [CHAR_SOUND_UH2_2] = 'silent.mp3', -- Landing after Long Jump
    -- [CHAR_SOUND_WAAAOOOW] = 'silent.mp3', -- Falling
    [CHAR_SOUND_WAH2] = 'hina_throw.mp3', -- Throw Object
    [CHAR_SOUND_WHOA] = 'hina_ledgegrab.mp3', -- Ledge Grab
    [CHAR_SOUND_YAHOO] = {'hina_atk5.mp3'}, -- Long Jump
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'hina_atk5.mp3'}, -- 3rd Jump(s)
    [CHAR_SOUND_YAH_WAH_HOO] = {'hina_atk2.mp3'} -- 1st Jump(s)
    -- [CHAR_SOUND_YAWNING] = 'silent.mp3',
}
local VOICETABLE_yuuka = {
    [CHAR_SOUND_ATTACKED] = {'yuuka_dmg4.mp3', 'yuuka_dmg2.mp3', 'yuuka_dmg3.mp3'},
    [CHAR_SOUND_DOH] = {'yuuka_hai.mp3', 'yuuka_are.mp3'}, -- Bonk into walls
    [CHAR_SOUND_DYING] = {'yuuka_dead1.mp3', 'yuuka_getup2.mp3'},
    -- [CHAR_SOUND_EEUH] = {'silent.mp3',}, -- Slow Get up from ledge
    -- [CHAR_SOUND_GAME_OVER] = {'silent.mp3'}, -- Game Over Voiceline
    [CHAR_SOUND_GROUND_POUND_WAH] = {'yuuka_atk2.mp3'},
    -- [CHAR_SOUND_HAHA] = 'silent.mp3', -- Landing after backflip
    -- [CHAR_SOUND_HAHA_2] = 'silent.mp3', -- Landing on Water after a fall
    -- [CHAR_SOUND_HELLO] = 'silent.mp3', -- Intro Voiceline
    [CHAR_SOUND_HERE_WE_GO] = {'yuuka_starget1.mp3'}, -- Star Get + Obtaining Power-up
    [CHAR_SOUND_HOOHOO] = 'yuuka_atk2.mp3', -- 2nd Jump + Dive Attack
    [CHAR_SOUND_HRMM] = 'yuuka_grab.mp3', -- Object Pick-up
    -- [CHAR_SOUND_IMA_TIRED] = 'hina_sigh.mp3',
    [CHAR_SOUND_LETS_A_GO] = {'yuuka_levelselect.mp3'}, -- Level Select
    [CHAR_SOUND_MAMA_MIA] = {'yuuka_getup1.mp3', 'yuuka_notover.mp3'}, -- Getting up after thrown out of level
    [CHAR_SOUND_ON_FIRE] = {'yuuka_dmg3.mp3', 'yuuka_dmg4.mp3'}, -- Touch Fire
    [CHAR_SOUND_OOOF] = 'yuuka_eh2.mp3', -- Grabbed by Chuckya
    [CHAR_SOUND_OOOF2] = 'yuuka_dmg1.mp3', -- Landing After a Bonk + Thrown out of level
    -- [CHAR_SOUND_PANTING] = {'silent.mp3',}, -- Low Health
    -- [CHAR_SOUND_PANTING_COLD] = 'silent.mp3',
    -- [CHAR_SOUND_PRESS_START_TO_PLAY] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_PUNCH_HOO] = {'yuuka_atk5.mp3'}, -- Kick
    [CHAR_SOUND_PUNCH_WAH] = 'yuuka_atk2.mp3', -- 2nd Punch
    [CHAR_SOUND_PUNCH_YAH] = 'yuuka_atk1.mp3', -- 1st Punch
    -- [CHAR_SOUND_SNORING1] = 'silent.mp3',
    -- [CHAR_SOUND_SNORING2] = 'silent.mp3',
    -- [CHAR_SOUND_SNORING3] = {'silent.mp3', 'silent.mp3'},
    [CHAR_SOUND_SO_LONGA_BOWSER] = {'yuuka_useless.mp3'}, -- Bowser Throw
    -- [CHAR_SOUND_TWIRL_BOUNCE] = {'silent.mp3'}, -- Boing
    [CHAR_SOUND_UH] = 'yuuka_eh1.mp3', -- Drop off of ledge + Fall off Ledge
    [CHAR_SOUND_UH2] = {'yuuka_atk1.mp3'}, -- Quick Ledge Get-Up
    -- [CHAR_SOUND_UH2_2] = 'silent.mp3', -- Landing after Long Jump
    -- [CHAR_SOUND_WAAAOOOW] = 'silent.mp3', -- Falling
    [CHAR_SOUND_WAH2] = 'yuuka_atk4.mp3', -- Throw Object
    [CHAR_SOUND_WHOA] = 'yuuka_whoa.mp3', -- Ledge Grab
    [CHAR_SOUND_YAHOO] = {'yuuka_atk3.mp3'}, -- Long Jump
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'yuuka_atk4.mp3'}, -- 3rd Jump(s)
    [CHAR_SOUND_YAH_WAH_HOO] = {'yuuka_atk1.mp3'} -- 1st Jump(s)
    -- [CHAR_SOUND_YAWNING] = 'silent.mp3',
}
--[[

    Table for Cap Models, this has been noted out due to the template not having these models.
    You can add these models in your respective actors folder like you would for any Character Model

local capModels = {
    normal = smlua_model_util_get_id("normal_cap_geo"),
    wing = smlua_model_util_get_id("wing_cap_geo"),
    metal = smlua_model_util_get_id("metal_cap_geo"),
    metalWing = smlua_model_util_get_id("metal_wing_cap_geo")
}

]]

if _G.charSelectExists then
    CT_CHAR = _G.charSelect.character_add("Momoi", {"Gamer"}, "HerosLight", {r = 255, g = 119, b = 160}, E_model_momoi, CT_MARIO, nil)
	CT_CHAR = _G.charSelect.character_add("Midori", {"Gamer"}, "HerosLight", {r = 130, g = 255, b = 106}, E_model_midori, CT_MARIO, nil)
	CT_CHAR = _G.charSelect.character_add("Yuzu", {"Gamer"}, "HerosLight", {r = 233, g = 123, b = 116}, E_model_yuzu, CT_MARIO, nil)
	CT_CHAR = _G.charSelect.character_add("Alice/Aris", {"Gamer"}, "HerosLight", {r = 132, g = 150, b = 162}, E_model_alice, CT_MARIO, nil)
	CT_CHAR = _G.charSelect.character_add("Fubuki", {"Sleepy Brat"}, "HerosLight", {r = 122, g = 159, b = 255}, E_model_fubuki, CT_MARIO, nil)
	CT_CHAR = _G.charSelect.character_add("Mari", {"is a cat"}, "HerosLight", {r = 252, g = 202, b = 165}, E_model_mari, CT_MARIO, nil)
	CT_CHAR = _G.charSelect.character_add("Mari [Sportswear]", {"is a fox"}, "HerosLight", {r = 252, g = 202, b = 165}, E_model_spmari, CT_MARIO, nil)
	CT_CHAR = _G.charSelect.character_add("Kazusa", {"Doesn't like cats [She is a cat]"}, "HerosLight", {r = 63, g = 63, b = 93}, E_model_kazusa, CT_MARIO, nil)
	CT_CHAR = _G.charSelect.character_add("Reisa", {"The Superstar"}, "HerosLight", {r = 229, g = 238, b = 252}, E_model_reisa, CT_MARIO, nil)
	CT_CHAR = _G.charSelect.character_add("Kokona", {"11"}, "HerosLight", {r = 199, g = 197, b = 196}, E_model_kokona, CT_MARIO, nil)
	CT_CHAR = _G.charSelect.character_add("Himari", {"Tensai Bishoujo Hacka"}, "HerosLight", {r = 255, g = 255, b = 255}, E_model_himari, CT_MARIO, nil)
	CT_CHAR = _G.charSelect.character_add("Izuna", {"Nin-nin"}, "HerosLight", {r = 240, g = 38, b = 118}, E_model_izuna, CT_MARIO, nil)
	CT_CHAR = _G.charSelect.character_add("Tsukuyo", {"Very Tall"}, "HerosLight", {r = 148, g = 130, b = 216}, E_model_tsukuyo, CT_MARIO, nil)
	CT_CHAR = _G.charSelect.character_add("Michiru", {"Shubabababa"}, "HerosLight", {r = 203, g = 198, b = 193}, E_model_michiru, CT_MARIO, nil)
	CT_CHAR = _G.charSelect.character_add("Hina", {"I can't think of something to put here"}, "HerosLight", {r = 255, g = 255, b = 255}, E_model_hina, CT_MARIO, nil)
	CT_CHAR = _G.charSelect.character_add("Yuuka", {"100kg"}, "HerosLight", {r = 87, g = 84, b = 132}, E_model_yuuka, CT_MARIO, nil)
    -- the following must be hooked for each character added

    --All Voices
    _G.charSelect.character_add_voice(E_model_momoi, VOICETABLE_momoi)
    _G.charSelect.character_add_voice(E_model_midori, VOICETABLE_midori)
    _G.charSelect.character_add_voice(E_model_yuzu, VOICETABLE_yuzu)
    _G.charSelect.character_add_voice(E_model_alice, VOICETABLE_alice)
    _G.charSelect.character_add_voice(E_model_fubuki, VOICETABLE_fubuki)
    _G.charSelect.character_add_voice(E_model_mari, VOICETABLE_mari)
    _G.charSelect.character_add_voice(E_model_spmari, VOICETABLE_mari)
    _G.charSelect.character_add_voice(E_model_kazusa, VOICETABLE_kazusa)
    _G.charSelect.character_add_voice(E_model_reisa, VOICETABLE_reisa)
    _G.charSelect.character_add_voice(E_model_kokona, VOICETABLE_kokona)
    _G.charSelect.character_add_voice(E_model_himari, VOICETABLE_himari)
    _G.charSelect.character_add_voice(E_model_izuna, VOICETABLE_izuna)
    _G.charSelect.character_add_voice(E_model_tsukuyo, VOICETABLE_tsukuyo)
    _G.charSelect.character_add_voice(E_model_michiru, VOICETABLE_michiru)
	_G.charSelect.character_add_voice(E_model_hina, VOICETABLE_hina)
	_G.charSelect.character_add_voice(E_model_yuuka, VOICETABLE_yuuka)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_momoi then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_midori then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_yuzu then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_alice then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_fubuki then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_mari then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_kazusa then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_reisa then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_kokona then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_himari then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_izuna then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_tsukuyo then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_michiru then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_hina then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_yuuka then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_momoi then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_midori then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_yuzu then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_alice then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_fubuki then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_mari then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_kazusa then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_reisa then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_kokona then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_himari then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_izuna then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_tsukuyo then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_michiru then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_hina then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_yuuka then return _G.charSelect.voice.snore(m) end
    end)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end