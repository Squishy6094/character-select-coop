-- name: Coop Bowser Moveset
-- description: The King of the Koopas, playable!! \nThis mod is compatible with Character Select Coop! Using it alongside this mod will enable additional characters! \n\nCreated by: wibblus


E_MODEL_BOWSER_PLAYER = smlua_model_util_get_id('bowser_player_geo')
local E_MODEL_BOWSER_SHELL = smlua_model_util_get_id('bowser_shell_geo')

local TEX_BOWSER_ICON = get_texture_info('bowser-icon')

_G.bowsMoveset = {
    isActive = true;
    -- Allows the character to use the shell slide ability.
    FLAG_CAN_USE_SHELL = (1 << 0),
    -- Allows the character to use the fire breath ability.
    FLAG_CAN_USE_FIREBALL = (1 << 1),
    -- Enables Bowser-unique animations for the character.
    FLAG_STYLE_ANIMS = (1 << 2),
    -- Adjusts the character's pose in certain animations to suit bowser's large size. (i.e. ledge grab)
    FLAG_SIZE_ANIMS = (1 << 3),
    -- Gives the character a larger hitbox size. (37 -> 85 units radius)
    -- - This does not affect the hitbox size for level collision, only collisions with objects.
    FLAG_LARGE_HITBOX = (1 << 4),
    -- The character does not visually lose their 'cap'. Will also use their 'capless' head state in some animations.
    -- - Used by Bowser to allow his jaw to open when breathing fire, etc.
    FLAG_NO_CAPLESS = (1 << 5),
    -- Enables heavier landing sound effects for the character.
    FLAG_HEAVY_STEPS = (1 << 6),
    -- Enables the alternate sliding punch.
    FLAG_ATTACKS = (1 << 7),
    FLAG_ALL = 0xFFFF,
}
---@type integer
-- bitfield for bowser flags
gPlayerSyncTable[0].bowserState = 0

---@type boolean
-- if a player is in their shell or not
gPlayerSyncTable[0].inShellModel = false
---@type Object|nil
local currentShellObj

-- table containing shell model IDs for CS characters that supply one
-- - <character_model_id, shell_model_id>
local gBowsShellModelTable = {}
-- table containing the bowserState bitfield for CS characters that supply one
-- - <character_model_id, flags>
local gBowsFlagsTable = {}

---@param m MarioState
---@return boolean
local function has_bowser_flags(m, flags)
    return (gPlayerSyncTable[m.playerIndex].bowserState & flags ~= 0)
end

local function apply_player_bowser_flags()

end

if _G.charSelectExists then

    ---@param characterModelID ModelExtendedId|integer the model ID supplied to CS (e.g. E_MODEL_ARMATURE)
    ---@param shellModelID ModelExtendedId|integer the shell model ID retrieved using smlua_model_util_get_id()
    -- assigns a shell model for the Bowser Moveset to a CS character
    local function character_add_shell_model(characterModelID, shellModelID)
        if characterModelID == nil or shellModelID == nil then return end
        gBowsShellModelTable[characterModelID] = shellModelID
    end

    ---@param characterModelID ModelExtendedId|integer the model ID supplied to CS (e.g. E_MODEL_ARMATURE)
    ---@param flags integer bitfield of combined moveset flags (e.g. FLAG_CAN_USE_FIREBALL)
    -- assigns flags for the Bowser Moveset to a CS character
    local function character_set_bows_flags(characterModelID, flags)
        if characterModelID == nil then return end
        gBowsFlagsTable[characterModelID] = flags
    end

    -- global Bowser Moveset functions
    _G.bowsMoveset.character_add_shell_model = character_add_shell_model
    _G.bowsMoveset.character_set_bows_flags = character_set_bows_flags


    -- add the guy
    _G.charSelect.character_add("Bowser", {"The king of the koopas!", "Here to take the power stars!", "[+ Bowser Moveset!]"}, "wibblus", {r = 0, g = 140, b = 0}, E_MODEL_BOWSER_PLAYER, CT_MARIO, TEX_BOWSER_ICON, 1.25)

    -- bowser moveset functionality
    character_add_shell_model(E_MODEL_BOWSER_PLAYER, E_MODEL_BOWSER_SHELL)
    character_set_bows_flags(E_MODEL_BOWSER_PLAYER, bowsMoveset.FLAG_ALL)


    ---@param m MarioState
    -- CHARACTER SELECT
    function enable_bowser_shell_model(m)
        if m.playerIndex ~= 0 or gPlayerSyncTable[0].inShellModel then return end

        local shellId = gBowsShellModelTable[_G.charSelect.character_get_current_table().model]
        if shellId ~= nil then
            ---@param o Object
            currentShellObj = spawn_sync_object(id_bhvBowserPlayerShell, shellId, m.pos.x, m.pos.y, m.pos.z, function (o)
                o.globalPlayerIndex = network_global_index_from_local(0)
            end)
            gPlayerSyncTable[0].inShellModel = true
        end
    end

    apply_player_bowser_flags = function ()
        local flags = gBowsFlagsTable[_G.charSelect.character_get_current_table().model]
        if flags ~= nil then
            gPlayerSyncTable[0].bowserState = flags
        else
            gPlayerSyncTable[0].bowserState = 0
        end
    end

else

    gPlayerSyncTable[0].bowserState = bowsMoveset.FLAG_ALL

    -- command activation
    hook_chat_command('bowser', " : Toggle the Bowser moveset", function (msg)
        gPlayerSyncTable[0].bowserState = bowsMoveset.FLAG_ALL - gPlayerSyncTable[0].bowserState
        return true
    end)

    -- setting to bowser player model + shell ; STANDALONE
    ---@param obj Object
    ---@param model integer
    hook_event(HOOK_OBJECT_SET_MODEL, function(obj, model)
        if get_id_from_behavior(obj.behavior) ~= id_bhvMario then return end

        -- set to bowser model only if you aren't already set or in shell
        if gPlayerSyncTable[network_local_index_from_global(obj.globalPlayerIndex)].bowserState ~= 0 and
        model == E_MODEL_MARIO then
            return obj_set_model_extended(obj, E_MODEL_BOWSER_PLAYER)
        end
    end)

    ---@param m MarioState
    -- STANDALONE
    function enable_bowser_shell_model(m)
        if m.playerIndex ~= 0 or gPlayerSyncTable[0].inShellModel then return end

        ---@param o Object
        currentShellObj = spawn_sync_object(id_bhvBowserPlayerShell, E_MODEL_BOWSER_SHELL, m.pos.x, m.pos.y, m.pos.z, function (o)
            o.globalPlayerIndex = network_global_index_from_local(0)
        end)
        gPlayerSyncTable[0].inShellModel = true
    end

end

---@param m MarioState
function disable_bowser_shell_model(m)
    if m.playerIndex ~= 0 or currentShellObj == nil then return end

    obj_mark_for_deletion(currentShellObj)
    -- visibility usually resets on update but just in case:
    m.marioObj.header.gfx.node.flags = m.marioObj.header.gfx.node.flags & ~GRAPH_RENDER_INVISIBLE
    gPlayerSyncTable[0].inShellModel = false
    currentShellObj = nil
end

-- hooked functions

---@param m MarioState
local function before_mario_update(m)
    if gPlayerSyncTable[m.playerIndex].bowserState == nil then gPlayerSyncTable[m.playerIndex].bowserState = 0 end

    -- default mario hitbox is 160 height
    if has_bowser_flags(m, bowsMoveset.FLAG_LARGE_HITBOX) then
        if m.action & ACT_FLAG_SHORT_HITBOX ~= 0 then
            m.marioObj.hitboxHeight = 80
        else
            m.marioObj.hitboxHeight = 180
        end
    end
end
hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)

---@param m MarioState
local function on_mario_update(m)
    -- closeup camera clips into bowser's model
    if m.playerIndex == 0 and m.area.camera.cutscene == CUTSCENE_DANCE_CLOSEUP then
        m.area.camera.cutscene = CUTSCENE_DANCE_DEFAULT
    end

    -- victory grahhh
    if m.action == ACT_EXIT_LAND_SAVE_DIALOG and m.actionState == 3
    and has_bowser_flags(m, bowsMoveset.FLAG_STYLE_ANIMS) and m.marioObj.header.gfx.animInfo.animFrame == 10 then
        play_bowser_character_sound(m, BOWS_SOUND_SCREECH, 1.0)
    end

    if gPlayerSyncTable[m.playerIndex].inShellModel then
        m.marioObj.header.gfx.node.flags = m.marioObj.header.gfx.node.flags | GRAPH_RENDER_INVISIBLE

        if m.action ~= ACT_SHELL_SLIDE and m.action ~= ACT_JUMP_KICK then
            disable_bowser_shell_model(m)
        end
    elseif currentShellObj ~= nil then -- failsafe if the shell object lingers
        disable_bowser_shell_model(m)
    end

    if has_bowser_flags(m, bowsMoveset.FLAG_NO_CAPLESS) then
        if m.flags & MARIO_NORMAL_CAP == 0 then
            m.marioBodyState.capState = 0
        end
        if m.action == ACT_BREATHE_FIRE then
            m.marioBodyState.capState = 1 --'capless' head
        end
    end

    -- no foot scale with the custom punch3 animation
    if has_bowser_flags(m, bowsMoveset.FLAG_STYLE_ANIMS) and (m.action == ACT_PUNCHING or m.action == ACT_MOVE_PUNCHING) and m.actionArg >= 6 then
        m.marioBodyState.punchState = 0
    end
end
hook_event(HOOK_MARIO_UPDATE, on_mario_update)


---@param m MarioState
---@param nextAction integer
local function before_set_mario_action(m, nextAction)
    -- default mario hitbox is 37 radius
    m.marioObj.hitboxRadius = 37.0
    if has_bowser_flags(m, bowsMoveset.FLAG_LARGE_HITBOX) and m.heldObj == nil then
        m.marioObj.hitboxRadius = 85.0
    end

    if m.playerIndex ~= 0 then return end

    -- setup bowsFlags for selected CS character ; done in this hook for slight performance boost vs mario update babey
    apply_player_bowser_flags()

    if gPlayerSyncTable[0].bowserState ~= 0 then
        if (nextAction == ACT_PUNCHING or nextAction == ACT_MOVE_PUNCHING) then
            if has_bowser_flags(m, bowsMoveset.FLAG_CAN_USE_FIREBALL) and m.controller.buttonDown & Z_TRIG ~= 0 then
                return ACT_BREATHE_FIRE
            elseif has_bowser_flags(m, bowsMoveset.FLAG_ATTACKS) then
                m.forwardVel = math.min(m.forwardVel + 17.0, 28.0)
                return ACT_MOVE_PUNCHING
            end
        end
        if nextAction == ACT_SLIDE_KICK and has_bowser_flags(m, bowsMoveset.FLAG_CAN_USE_SHELL) then
            return ACT_SHELL_SLIDE
        end
    end
end
hook_event(HOOK_BEFORE_SET_MARIO_ACTION, before_set_mario_action)

local heavyLandActs = {
    [ACT_LONG_JUMP_LAND] = true,
    [ACT_DIVE_SLIDE] = true,
    [ACT_GROUND_POUND_LAND] = true,
    [ACT_TRIPLE_JUMP_LAND] = true,
    [ACT_BACKFLIP_LAND] = true,
    [ACT_AIR_HIT_WALL] = true,
    [ACT_BACKWARD_AIR_KB] = true,
}

---@param m MarioState
local function on_set_mario_action(m)
    if has_bowser_flags(m, bowsMoveset.FLAG_HEAVY_STEPS) then
        local act = m.action & ACT_ID_MASK
        -- forced heavy land sound
        if heavyLandActs[m.action] ~= nil then
            play_sound(SOUND_OBJ_BOWSER_WALK, m.marioObj.header.gfx.cameraToObject)
        elseif act >= 0x066 and act <= 0x07A then -- landing actions
            -- heavy land vs mid-heavy land based on fall distance
            if m.peakHeight - m.pos.y >= 800 then
                play_sound(SOUND_OBJ_BOWSER_WALK, m.marioObj.header.gfx.cameraToObject)
            else
                play_sound(SOUND_OBJ_POUNDING1, m.marioObj.header.gfx.cameraToObject)
            end
        end
    end
end
hook_event(HOOK_ON_SET_MARIO_ACTION, on_set_mario_action)

---@param m MarioState
---@param obj Object
local function allow_interact(m, obj, interactType)
    -- prevent from damaging yourself with fireballs
    if interactType == INTERACT_FLAME and obj.globalPlayerIndex == m.marioObj.globalPlayerIndex
    and obj_has_behavior_id(obj, id_bhvBowserPlayerFireball) ~= 0 then
        return false
    end
end


---@param m MarioState
hook_event(HOOK_ON_PLAYER_CONNECTED, function (m)
    if m.playerIndex == 0 and network_is_server() then
        hook_event(HOOK_ALLOW_INTERACT, allow_interact)
    end
end)
hook_event(HOOK_JOINED_GAME, function (m)
    hook_event(HOOK_ALLOW_INTERACT, allow_interact)
end)

--[[ TODO: this stuff
---@param gfxNode GraphNodeObject
local function mirror_mario_render(gfxNode)
    
end
hook_event(HOOK_MIRROR_MARIO_RENDER, mirror_mario_render)
]]
