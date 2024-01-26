-- name: [CS] Geno + Mallow
-- description: Geno and Mallow made playable with CS!\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

local E_MODEL_GENO = smlua_model_util_get_id("geno_geo")
local E_MODEL_MALLOW = smlua_model_util_get_id("mallow_geo")

local TEX_GENO_ICON = get_texture_info("geno-icon")
local TEX_MALLOW_ICON = get_texture_info("mallow-icon")

local TEXT_MOD_NAME = "[CS] Geno + Mallow"

local VOICETABLE_GENO = {
    [CHAR_SOUND_ATTACKED] = 'intensehit2.ogg',
    [CHAR_SOUND_DOH] = 'parasol1.ogg',
    [CHAR_SOUND_DROWNING] = 'runaway.ogg',
    [CHAR_SOUND_DYING] = 'runaway.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'giantshell.ogg',
    [CHAR_SOUND_HAHA] = 'heal.ogg',
    [CHAR_SOUND_HAHA_2] = 'heal.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'item.ogg',
    [CHAR_SOUND_HOOHOO] = 'jump2.ogg',
    [CHAR_SOUND_HRMM] = 'specialflower.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'headshake.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'battlestart.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'battlestart.ogg',
    [CHAR_SOUND_ON_FIRE] = 'enemy_drain.ogg',
    [CHAR_SOUND_OOOF] = 'headshake.ogg',
    [CHAR_SOUND_OOOF2] = 'giantshell.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'kick2.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'punch2.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'punch.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'geno_stargun.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'parasol1.ogg',
    [CHAR_SOUND_UH] = 'headshake.ogg',
    [CHAR_SOUND_UH2] = 'jump2.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'runaway.ogg',
    [CHAR_SOUND_WAH2] = 'punch.ogg',
    [CHAR_SOUND_WHOA] = 'headshake.ogg',
    [CHAR_SOUND_YAHOO] = 'trampoline.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'geno_stargunfinish.ogg', 'geno_transform.ogg'},
    [CHAR_SOUND_YAH_WAH_HOO] = {'jump.ogg', 'jump3.ogg'},
    [CHAR_SOUND_PRESS_START_TO_PLAY] = 'coinfrog.ogg',
}
local VOICETABLE_MALLOW = {
    [CHAR_SOUND_ATTACKED] = 'intensehit2.ogg',
    [CHAR_SOUND_DOH] = 'parasol1.ogg',
    [CHAR_SOUND_DROWNING] = 'runaway.ogg',
    [CHAR_SOUND_DYING] = 'runaway.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'mallow_thunder.ogg',
    [CHAR_SOUND_HAHA] = 'heal.ogg',
    [CHAR_SOUND_HAHA_2] = 'heal.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'item.ogg',
    [CHAR_SOUND_HOOHOO] = 'jump2.ogg',
    [CHAR_SOUND_HRMM] = 'specialflower.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'headshake.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'battlestart.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'battlestart.ogg',
    [CHAR_SOUND_ON_FIRE] = 'enemy_drain.ogg',
    [CHAR_SOUND_OOOF] = 'headshake.ogg',
    [CHAR_SOUND_OOOF2] = 'giantshell.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'kick2.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'punch2.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'punch.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'mallow_thunder.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'parasol1.ogg',
    [CHAR_SOUND_UH] = 'headshake.ogg',
    [CHAR_SOUND_UH2] = 'jump2.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'runaway.ogg',
    [CHAR_SOUND_WAH2] = 'punch.ogg',
    [CHAR_SOUND_WHOA] = 'headshake.ogg',
    [CHAR_SOUND_YAHOO] = 'trampoline.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'mallow_cymbals.ogg', 'mallow_thundershock.ogg'},
    [CHAR_SOUND_YAH_WAH_HOO] = {'jump.ogg', 'jump3.ogg'},
    [CHAR_SOUND_PRESS_START_TO_PLAY] = 'coinfrog.ogg',
}

local cap_popup_timer = 90
local cap_popup_name = "Frog Coin"

--[[
local MODEL_CAPS_GENO = {
    normal = smlua_model_util_get_id("geno_cap_geo"),
    wing = smlua_model_util_get_id("geno_wing_cap_geo"),
    metal = smlua_model_util_get_id("geno_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("geno_metal_wing_cap_geo")
}
local MODEL_CAPS_MALLOW = {
    normal = smlua_model_util_get_id("mallow_cap_geo"),
    wing = smlua_model_util_get_id("mallow_wing_cap_geo"),
    metal = smlua_model_util_get_id("mallow_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("mallow_metal_wing_cap_geo")
}
]]

local MODEL_FROG_COIN = smlua_model_util_get_id("frog_coin_geo")

if _G.charSelectExists then
    id_geno = _G.charSelect.character_add("Geno", {"It's Geno!", "he was born yesterday", "(Press [Y] to toggle his gun!)"}, "wibblus", {r = 150, g = 150, b = 255}, E_MODEL_GENO, CT_MARIO, TEX_GENO_ICON)
    id_mallow = _G.charSelect.character_add("Mallow", {"It's Mallow!", "he was born today"}, "Melzinoff", {r = 255, g = 200, b = 230}, E_MODEL_MALLOW, CT_LUIGI, TEX_MALLOW_ICON)

    --_G.charSelect.character_add_caps(E_MODEL_GENO, MODEL_CAPS_GENO)
    --_G.charSelect.character_add_caps(E_MODEL_MALLOW, MODEL_CAPS_MALLOW)

    -- the following must be hooked for each character added
    _G.charSelect.character_add_voice(E_MODEL_GENO, VOICETABLE_GENO)
    _G.charSelect.character_add_voice(E_MODEL_MALLOW, VOICETABLE_MALLOW)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_GENO then return _G.charSelect.voice.sound(m, sound) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_MALLOW then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_GENO then return _G.charSelect.voice.snore(m) end
        if _G.charSelect.character_get_voice(m) == VOICETABLE_MALLOW then return _G.charSelect.voice.snore(m) end
    end)

    -- SMRPG stuff begin!!

    -- activates the "Got Item!" UI element
    ---@param m MarioState
    ---@param obj Object
    ---@param interactType InteractionType
    function on_cap_collect(m, obj, interactType)
        if m.playerIndex == 0 and (interactType & INTERACT_CAP) ~= 0 then
            local char_number = _G.charSelect.character_get_current_model_number()
            -- should only occur if playing as Geno or Mallow
            if char_number == id_geno then
                cap_popup_timer = 0
                if get_id_from_behavior(obj.behavior) == id_bhvWingCap then cap_popup_name = "Wing Cap"
                elseif get_id_from_behavior(obj.behavior) == id_bhvMetalCap then cap_popup_name = "Metal Cap"
                elseif get_id_from_behavior(obj.behavior) == id_bhvVanishCap then cap_popup_name = "Vanish Cap"
                elseif get_id_from_behavior(obj.behavior) == id_bhvNormalCap and (m.flags & 1) ~= 0 then cap_popup_name = "Geno's Cap"
                    -- check if character has their hat (flags bit-1) to ensure the interaction only triggers while picking up the hat (snowman's land issue)
                else cap_popup_timer = 90
                end
            elseif char_number == id_mallow then
                cap_popup_timer = 0
                if get_id_from_behavior(obj.behavior) == id_bhvWingCap then cap_popup_name = "Wing Pants"
                elseif get_id_from_behavior(obj.behavior) == id_bhvMetalCap then cap_popup_name = "Metal Pants"
                elseif get_id_from_behavior(obj.behavior) == id_bhvVanishCap then cap_popup_name = "Vanish Pants"
                elseif get_id_from_behavior(obj.behavior) == id_bhvNormalCap and (m.flags & 1) ~= 0 then cap_popup_name = "Frog Coin"
                else cap_popup_timer = 90
                end
            end
        end
    end
    hook_event(HOOK_ON_INTERACT, on_cap_collect)

    function display_cap_text()
        local text = "Got a \"" .. cap_popup_name .. "\"!"

        djui_hud_set_resolution(RESOLUTION_DJUI)
        djui_hud_set_font(FONT_NORMAL)

        -- centered horizontally, lower end of the screen
        local x = djui_hud_get_screen_width() / 2 - djui_hud_measure_text(text)
        local y = djui_hud_get_screen_height() - 192

        -- write each character to the screen each frame
        text = string.sub(text, 0, min(cap_popup_timer * 1.5, string.len(text)))

        djui_hud_set_color(80, 80, 240, 255)
        djui_hud_print_text(text, x + 2, y + 2, 2)
        djui_hud_set_color(255, 255, 255, 255)
        djui_hud_print_text(text, x, y, 2)
    end

    function on_hud_render()
        if cap_popup_timer < 90 then
            display_cap_text()
            -- timer
            cap_popup_timer = cap_popup_timer + 1
        end
    end
    hook_event(HOOK_ON_HUD_RENDER, on_hud_render)

    ---@param obj Object
    function on_obj_set_model(obj, modelID)
        -- mallow normal cap -> frog coin handling
        if obj_has_behavior_id(obj, id_bhvNormalCap) ~= 0 and _G.charSelect.character_get_current_model_number() == id_mallow then
            if MODEL_FROG_COIN ~= nil and obj_has_model_extended(obj, MODEL_FROG_COIN) == 0 then
                obj_set_model_extended(obj, MODEL_FROG_COIN)
            end
            return
        end
    end
    hook_event(HOOK_OBJECT_SET_MODEL, on_obj_set_model)

    ---@param m MarioState
    function on_update(m)
        -- local player
        if m.playerIndex == 0 then
            if gPlayerSyncTable[0].geno_gun_mode == nil then
                if _G.charSelect.character_get_current_model_number() == id_geno then gPlayerSyncTable[0].geno_gun_mode = false end
                return
            end

            if _G.charSelect.character_get_current_model_number() == id_geno then
                if (m.controller.buttonPressed & Y_BUTTON) ~= 0 and m.action == ACT_IDLE then
                    gPlayerSyncTable[0].geno_gun_mode = not gPlayerSyncTable[0].geno_gun_mode
                    set_mario_action(m, ACT_TRIPLE_JUMP_LAND, 0)
                end
            else
                -- skip this code if the player is not geno
                gPlayerSyncTable[0].geno_gun_mode = nil
            end
        end
        -- set gun hand
        if gPlayerSyncTable[m.playerIndex].geno_gun_mode and m.marioBodyState.handState == 0 then
            m.marioBodyState.handState = 2
        end
    end
    hook_event(HOOK_MARIO_UPDATE, on_update)

else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end