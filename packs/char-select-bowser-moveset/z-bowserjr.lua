local E_MODEL_JR = smlua_model_util_get_id("bowserjr_geo")

local TEX_JR_ICON = get_texture_info("bowserjr-icon")

local VOICETABLE_JR = {
    [CHAR_SOUND_ATTACKED] = 'jr_ouch.ogg',
    [CHAR_SOUND_COUGHING1] = 'jr_hot.ogg',
    [CHAR_SOUND_DOH] = 'jr_oh.ogg',
    [CHAR_SOUND_DROWNING] = 'jr_sad2.ogg',
    [CHAR_SOUND_DYING] = 'jr_sad2.ogg',
    [CHAR_SOUND_EEUH] = 'jr_grah.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'jr_grah2.ogg',
    [CHAR_SOUND_HAHA] = 'jr_yes.ogg',
    [CHAR_SOUND_HAHA_2] = 'jr_yes.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'jr_yeah.ogg',
    [CHAR_SOUND_HOOHOO] = 'jr_woop.ogg',
    [CHAR_SOUND_HRMM] = 'jr_waow.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'jr_ohno.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'jr_hehe.ogg',
    [CHAR_SOUND_LETS_A_GO] = 'jr_letsgo.ogg',
    [CHAR_SOUND_ON_FIRE] = 'jr_hot.ogg',
    [CHAR_SOUND_OOOF] = 'jr_ouch.ogg',
    [CHAR_SOUND_OOOF2] = 'jr_waow.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'jr_heyy.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'jr_wuh.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'jr_ha.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'jr_hehe.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'jr_yeah2.ogg',
    [CHAR_SOUND_UH2] = 'jr_oh.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'jr_sad.ogg',
    [CHAR_SOUND_WAH2] = 'jr_ha.ogg',
    [CHAR_SOUND_WHOA] = 'jr_waow.ogg',
    [CHAR_SOUND_YAHOO] = 'jr_woohoo.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = {'jr_wheeee.ogg', 'jr_woohoo.ogg', 'jr_grah2.ogg'},
    [CHAR_SOUND_YAH_WAH_HOO] = {'jr_ya.ogg', 'jr_ha.ogg', 'jr_wuh.ogg'},
}

if _G.charSelectExists then
    _G.charSelect.character_add("Bowser Jr", {"It's Junior!", "Here to bring some chaos!"}, "wibblus", {r = 0, g = 255, b = 50}, E_MODEL_JR, CT_MARIO, TEX_JR_ICON)


    ---- BOWSER MOVESET:

    -- Retrieves the custom shell model for this character. Check template_shell.blend for how to set up a shell model properly.
    local E_MODEL_JR_SHELL = smlua_model_util_get_id("bowserjr_shell_geo")

    -- This is a bitfield of flags that decide which parts of the Bowser Moveset this character will have.
    -- Insert each flag you want to be set, separated by '|' symbols.
    local BOWS_FLAGS_JR =
    _G.bowsMoveset.FLAG_CAN_USE_FIREBALL | _G.bowsMoveset.FLAG_CAN_USE_SHELL | _G.bowsMoveset.FLAG_NO_CAPLESS |
    _G.bowsMoveset.FLAG_STYLE_ANIMS

    -- Flag Options: (sorry the ids are so long pshgkjdf)

    -- _G.bowsMoveset.FLAG_CAN_USE_SHELL
    --- Allows the character to use the shell slide ability.

    -- _G.bowsMoveset.FLAG_CAN_USE_FIREBALL
    --- Allows the character to use the fire breath ability.

    -- _G.bowsMoveset.FLAG_STYLE_ANIMS
    --- Enables Bowser-unique animations for the character.

    -- _G.bowsMoveset.FLAG_SIZE_ANIMS
    --- Adjusts the character's pose in certain animations to suit bowser's large size. (i.e. ledge grab)

    -- _G.bowsMoveset.FLAG_LARGE_HITBOX
    --- Gives the character a larger hitbox size. (37 -> 85 units radius)
    --- This does not affect the hitbox size for level collision, only collisions with objects.

    -- _G.bowsMoveset.FLAG_NO_CAPLESS
    --- The character does not visually lose their 'cap'. Will also use their 'capless' head state in some animations.
    --- Used by Bowser to allow his jaw to open when breathing fire, etc.

    -- _G.bowsMoveset.FLAG_HEAVY_STEPS
    --- Enables heavier landing sound effects for the character.

    -- _G.bowsMoveset.FLAG_ATTACKS
    --- Enables the alternate sliding punch.

    -- _G.bowsMoveset.FLAG_ALL
    --- Shorthand to set all flags.

    if bowsMoveset.isActive then
        -- This function sets up your custom shell model. Feel free to remove this if you aren't using a shell model.
        -- parameters: [your character model], [your shell model]
        _G.bowsMoveset.character_add_shell_model(E_MODEL_JR, E_MODEL_JR_SHELL)
        -- This function sets up the flags for your character.
        -- parameters: [your character model], [your flag bitfield]
        _G.bowsMoveset.character_set_bows_flags(E_MODEL_JR, BOWS_FLAGS_JR)
    end
    ----

    -- the following must be hooked for each character added
    _G.charSelect.character_add_voice(E_MODEL_JR, VOICETABLE_JR)
    hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_JR then return _G.charSelect.voice.sound(m, sound) end
    end)
    hook_event(HOOK_MARIO_UPDATE, function (m)
        if _G.charSelect.character_get_voice(m) == VOICETABLE_JR then return _G.charSelect.voice.snore(m) end
    end)
end