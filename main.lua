-- name: Character Select
-- description:\\#ffff33\\-- Character Select Coop v1.16 --\n\n\\#dcdcdc\\A Library / API made to make adding and using Custom Characters as simple as possible!\nUse\\#ffff33\\ /char-select\\#dcdcdc\\ to get started!\n\nCreated by:\\#008800\\ Squishy6094\n\n\\#AAAAFF\\Updates can be found on\nCharacter Select's Github:\n\\#6666FF\\Squishy6094/character-select-coop
-- pausable: false
-- category: cs

if incompatibleClient then return 0 end

---@param hookEventType LuaHookedEventType
local function create_hook_wrapper(hookEventType)
    local callbacks = {}

    hook_event(hookEventType, function(...)
        for _, func in pairs(callbacks) do
            func(...)
        end
    end)

    return function(func)
        table.insert(callbacks, func)
    end
end

cs_hook_mario_update = create_hook_wrapper(HOOK_MARIO_UPDATE)

-- localize functions to improve performance - main.lua
local mod_storage_load,tonumber,mod_storage_save,djui_popup_create,tostring,djui_chat_message_create,is_game_paused,obj_get_first_with_behavior_id,djui_hud_is_pause_menu_created,camera_freeze,hud_hide,vec3f_copy,set_mario_action,set_character_animation,camera_unfreeze,hud_show,type,get_id_from_behavior,obj_has_behavior_id,network_local_index_from_global,obj_has_model_extended,obj_set_model_extended,nearest_player_to_object,math_random,djui_hud_set_resolution,djui_hud_set_font,djui_hud_get_screen_width,maxf,djui_hud_set_color,djui_hud_render_rect,djui_hud_measure_text,djui_hud_print_text,min,math_min,math_ceil,math_abs,math_sin,minf,djui_hud_set_rotation,table_insert,djui_hud_print_text_interpolated,math_max,play_sound,play_character_sound,string_lower = mod_storage_load,tonumber,mod_storage_save,djui_popup_create,tostring,djui_chat_message_create,is_game_paused,obj_get_first_with_behavior_id,djui_hud_is_pause_menu_created,camera_freeze,hud_hide,vec3f_copy,set_mario_action,set_character_animation,camera_unfreeze,hud_show,type,get_id_from_behavior,obj_has_behavior_id,network_local_index_from_global,obj_has_model_extended,obj_set_model_extended,nearest_player_to_object,math.random,djui_hud_set_resolution,djui_hud_set_font,djui_hud_get_screen_width,maxf,djui_hud_set_color,djui_hud_render_rect,djui_hud_measure_text,djui_hud_print_text,min,math.min,math.ceil,math.abs,math.sin,minf,djui_hud_set_rotation,table.insert,djui_hud_print_text_interpolated,math.max,play_sound,play_character_sound,string.lower

menu = false
menuAndTransition = false
gridMenu = false
options = false
local credits = false
local creditsAndTransition = false
currChar = CT_MARIO
local prevChar = CT_MARIO
currCharRender = CT_MARIO
currCategory = 1
local currOption = 1
local creditScroll = 0
local prevCreditScroll = creditScroll
local creditScrollRange = 0

local menuCrossFade = 7
local menuCrossFadeCap = menuCrossFade
local menuCrossFadeMath = 255 / menuCrossFade

local creditsCrossFade = 7
local creditsCrossFadeCap = creditsCrossFade
local creditsCrossFadeMath = 255 / creditsCrossFade

local TYPE_FUNCTION = "function"
local TYPE_BOOLEAN = "boolean"
local TYPE_STRING = "string"
local TYPE_INTEGER = "number"
local TYPE_TABLE = "table"

local TEX_LOGO = get_texture_info("char-select-logo")
local TEX_WALL_LEFT = get_texture_info("char-select-wall-left")
local TEX_WALL_RIGHT = get_texture_info("char-select-wall-right")
TEX_GRAFFITI_DEFAULT = get_texture_info("char-select-graffiti-default")
local TEX_BUTTON_SMALL = get_texture_info("char-select-button-small")
local TEX_BUTTON_BIG = get_texture_info("char-select-button-big")
local TEX_OVERRIDE_HEADER = nil

local SOUND_CHAR_SELECT_THEME = audio_stream_load("char-select-menu-theme.ogg")
audio_stream_set_looping(SOUND_CHAR_SELECT_THEME, true)
audio_stream_set_loop_points(SOUND_CHAR_SELECT_THEME, 0, 93.659*22050)

---@param texture TextureInfo?
function header_set_texture(texture)
    TEX_OVERRIDE_HEADER = texture
end

CS_ANIM_MENU = CHAR_ANIM_MAX + 1

local TEXT_PREF_LOAD_NAME = "Default"
local TEXT_PREF_LOAD_ALT = 1

--[[
    Note: Do NOT add characters via the characterTable below,
    We highly recommend you create your own mod and use the
    API to add characters, this ensures your pack is easy
    to use for anyone and low on file space!
]]

characterTable = {
    [CT_MARIO] = {
        saveName = "Mario_Default",
        category = "All_CoopDX",
        ogNum = CT_MARIO,
        currAlt = 1,
        hasMoveset = false,
        locked = false,
        [1] = {
            name = "Mario",
            description = "The iconic Italian plumber himself! He's quite confident and brave, always prepared to jump into action to save the Mushroom Kingdom!",
            credit = "Nintendo / Coop Team",
            color = { r = 255, g = 50,  b = 50  },
            model = E_MODEL_MARIO,
            ogModel = E_MODEL_MARIO,
            baseChar = CT_MARIO,
            lifeIcon = gTextures.mario_head,
            starIcon = gTextures.star,
            camScale = 1.0,
        },
    },
    [CT_LUIGI] = {
        saveName = "Luigi_Default",
        category = "All_CoopDX",
        ogNum = CT_LUIGI,
        currAlt = 1,
        hasMoveset = false,
        locked = false,
        [1] = {
            name = "Luigi",
            description = "The other iconic Italian plumber! He's a bit shy and scares easily, but he's willing to follow his brother Mario through any battle that may come their way!",
            credit = "Nintendo / Coop Team",
            color = { r = 50,  g = 255, b = 50  },
            model = E_MODEL_LUIGI,
            ogModel = E_MODEL_LUIGI,
            baseChar = CT_LUIGI,
            lifeIcon = gTextures.luigi_head,
            starIcon = gTextures.star,
            camScale = 1.0,
            healthTexture = {
                label = {
                    left = get_texture_info("char-select-luigi-meter-left"),
                    right = get_texture_info("char-select-luigi-meter-right"),
                }
            }
        },
    },
    [CT_TOAD] = {
        saveName = "Toad_Default",
        category = "All_CoopDX",
        ogNum = CT_TOAD,
        currAlt = 1,
        hasMoveset = false,
        locked = false,
        [1] = {
            name = "Toad",
            description = "Princess Peach's little attendant! He's an energetic little mushroom that's never afraid to follow Mario and Luigi on their adventures!",
            credit = "Nintendo / Coop Team",
            color = { r = 50,  g = 50,  b = 255 },
            model = E_MODEL_TOAD_PLAYER,
            ogModel = E_MODEL_TOAD_PLAYER,
            baseChar = CT_TOAD,
            lifeIcon = gTextures.toad_head,
            starIcon = gTextures.star,
            camScale = 0.8,
            healthTexture = {
                label = {
                    left = get_texture_info("char-select-toad-meter-left"),
                    right = get_texture_info("char-select-toad-meter-right"),
                }
            }
        },
    },
    [CT_WALUIGI] = {
        saveName = "Waluigi_Default",
        category = "All_CoopDX",
        ogNum = CT_WALUIGI,
        currAlt = 1,
        hasMoveset = false,
        locked = false,
        [1] = {
            name = "Waluigi",
            description = "The mischievous rival of Luigi! He's a narcissistic competitor that takes great taste in others getting pummeled from his success!",
            credit = "Nintendo / Coop Team",
            color = { r = 130, g = 25,  b = 130 },
            model = E_MODEL_WALUIGI,
            ogModel = E_MODEL_WALUIGI,
            baseChar = CT_WALUIGI,
            lifeIcon = gTextures.waluigi_head,
            starIcon = gTextures.star,
            camScale = 1.1,
            healthTexture = {
                label = {
                    left = get_texture_info("char-select-waluigi-meter-left"),
                    right = get_texture_info("char-select-waluigi-meter-right"),
                }
            }
        },
    },
    [CT_WARIO] = {
        saveName = "Wario_Default",
        category = "All_CoopDX",
        ogNum = CT_WARIO,
        currAlt = 1,
        hasMoveset = false,
        locked = false,
        [1] = {
            name = "Wario",
            description = "The mischievous rival of Mario! He's a greed-filled treasure hunter obsessed with money and gold coins. He's always ready for a brawl if his money is on the line!",
            credit = "Nintendo / Coop Team",
            color = { r = 255, g = 255, b = 50  },
            model = E_MODEL_WARIO,
            ogModel = E_MODEL_WARIO,
            baseChar = CT_WARIO,
            lifeIcon = gTextures.wario_head,
            starIcon = gTextures.star,
            camScale = 1.0,
            healthTexture = {
                label = {
                    left = get_texture_info("char-select-wario-meter-left"),
                    right = get_texture_info("char-select-wario-meter-right"),
                }
            }
        },
    },
}

function character_is_vanilla(charNum)
    if charNum == nil then charNum = currChar end
    return charNum < CT_MAX
end

characterCategories = {
    "All",
    "CoopDX",
}

local characterTableRender = {}

characterCaps = {}
characterCelebrationStar = {}
characterColorPresets = {}
characterAnims = {
    [E_MODEL_MARIO] = {
        anims = {[CS_ANIM_MENU] = MARIO_ANIM_CS_MENU},
        eyes = {[CS_ANIM_MENU] = MARIO_EYES_LOOK_RIGHT},
    },
    [E_MODEL_LUIGI] = {
        anims = {[CS_ANIM_MENU] = LUIGI_ANIM_CS_MENU},
        eyes = {[CS_ANIM_MENU] = MARIO_EYES_LOOK_RIGHT},
        hands = {[CS_ANIM_MENU] = MARIO_HAND_OPEN}
    },
    [E_MODEL_TOAD_PLAYER] = {
        anims = {[CS_ANIM_MENU] = TOAD_PLAYER_ANIM_CS_MENU},
        hands = {[CS_ANIM_MENU] = MARIO_HAND_OPEN}
    },
    [E_MODEL_WALUIGI] = {
        anims = {[CS_ANIM_MENU] = WALUIGI_ANIM_CS_MENU},
        eyes = {[CS_ANIM_MENU] = MARIO_EYES_LOOK_RIGHT},
    },
    [E_MODEL_WARIO] = {
        anims = {[CS_ANIM_MENU] = WARIO_ANIM_CS_MENU},
        eyes = {[CS_ANIM_MENU] = MARIO_EYES_LOOK_LEFT},
    },
}
characterMovesets = {
    [CT_MARIO] = {},
    [CT_LUIGI] = {},
    [CT_TOAD] = {},
    [CT_WALUIGI] = {},
    [CT_WARIO] = {},
}
characterUnlock = {}
characterInstrumentals = {}
characterGraffiti = {
    [CT_MARIO] = get_texture_info("char-select-graffiti-mario"),
    [CT_LUIGI] = get_texture_info("char-select-graffiti-luigi"),
    [CT_TOAD] = get_texture_info("char-select-graffiti-toad"),
    [CT_WALUIGI] = get_texture_info("char-select-graffiti-waluigi"),
    [CT_WARIO] = get_texture_info("char-select-graffiti-wario"),
}

tableRefNum = 0
local function make_table_ref_num()
    tableRefNum = tableRefNum + 1
    return tableRefNum
end

OPTION_MENU = "Menu"
OPTION_CHAR = "Character"
OPTION_MISC = "Misc"
OPTION_MOD = "Moderation"
OPTION_API = "Packs / Mods"

optionTableRef = {
    -- Menu
    openInputs = make_table_ref_num(),
    notification = make_table_ref_num(),
    menuColor = make_table_ref_num(),
    anims = make_table_ref_num(),
    inputLatency = make_table_ref_num(),
    -- Characters
    localMoveset = make_table_ref_num(),
    localVoices = make_table_ref_num(),
    -- CS
    credits = make_table_ref_num(),
    debugInfo = make_table_ref_num(),
    resetSaveData = make_table_ref_num(),
    -- Moderation
    --restrictPalettes = make_table_ref_num(),
    restrictMovesets = make_table_ref_num(),
}

optionTable = {
    [optionTableRef.openInputs] = {
        name = "Menu Bind",
        category = OPTION_MENU,
        toggle = tonumber(mod_storage_load("MenuInput")),
        toggleSaveName = "MenuInput",
        toggleDefault = 1,
        toggleMax = 2,
        toggleNames = {"None", "Z (Pause Menu)", ommActive and "D-pad Down + R" or "D-pad Down"},
        description = {"Sets a Bind to Open the Menu", "rather than using the command."}
    },
    [optionTableRef.notification] = {
        name = "Notifications",
        category = OPTION_MENU,
        toggle = tonumber(mod_storage_load("notifs")),
        toggleSaveName = "notifs",
        toggleDefault = 1,
        toggleMax = 2,
        toggleNames = {"Off", "On", "Pop-ups Only"},
        description = {"Toggles whether Pop-ups and", "Chat Messages display"}
    },
    [optionTableRef.menuColor] = {
        name = "Menu Color",
        category = OPTION_MENU,
        toggle = tonumber(mod_storage_load("MenuColor")),
        toggleSaveName = "MenuColor",
        toggleDefault = 0,
        toggleMax = 10,
        toggleNames = {"Auto", "Saved", "Red", "Orange", "Yellow", "Green", "Blue", "Pink", "Purple", "White", "Black"},
        description = {"Toggles the Menu Color"}
    },
    [optionTableRef.anims] = {
        name = "Menu Anims",
        category = OPTION_MENU,
        toggle = tonumber(mod_storage_load("Anims")),
        toggleSaveName = "Anims",
        toggleDefault = 1,
        toggleMax = 1,
        toggleNames = {"Off", "On"},
        description = {"Toggles Animations In-Menu,", "Turning these off may", "Save Performance"}
    },
    [optionTableRef.inputLatency] = {
        name = "Scroll Speed",
        category = OPTION_MENU,
        toggle = tonumber(mod_storage_load("Latency")),
        toggleSaveName = "Latency",
        toggleDefault = 1,
        toggleMax = 2,
        toggleNames = {"Slow", "Normal", "Fast"},
        description = {"Sets how fast you scroll", "throughout the Menu"}
    },
    [optionTableRef.localMoveset] = {
        name = "Character Moveset",
        category = OPTION_CHAR,
        toggle = tonumber(mod_storage_load("localMoveset")),
        toggleSaveName = "localMoveset",
        toggleDefault = 1,
        toggleMax = 1,
        description = {"Toggles if Custom Movesets", "are active on compatible", "characters"},
        lock = function ()
            if gGlobalSyncTable.charSelectRestrictMovesets ~= 0 then
                return "Forced Off"
            end
        end,
    },
    [optionTableRef.localVoices] = {
        name = "Character Voices",
        category = OPTION_CHAR,
        toggle = tonumber(mod_storage_load("localVoices")),
        toggleSaveName = "localVoices",
        toggleDefault = 1,
        toggleMax = 1,
        description = {"Toggle if Custom Voicelines play", "for Characters who support it"}
    },
    [optionTableRef.credits] = {
        name = "Credits",
        category = OPTION_MISC,
        toggle = 0,
        toggleDefault = 0,
        toggleMax = 1,
        toggleNames = {"", ""},
        description = {"Thank you for choosing", "Character Select!"}
    },
    [optionTableRef.debugInfo] = {
        name = "Developer Mode",
        category = OPTION_MISC,
        toggle = tonumber(mod_storage_load("debuginfo")),
        toggleSaveName = "debuginfo",
        toggleDefault = 0,
        toggleMax = 1,
        description = {"Replaces the Character", "Description with Character", "Debugging Information,", "And shows hidden console logs."}
    },
    [optionTableRef.resetSaveData] = {
        name = "Reset Save Data",
        category = OPTION_MISC,
        toggle = 0,
        toggleDefault = 0,
        toggleMax = 1,
        toggleNames = {"", ""},
        description = {"Resets Character Select's", "Save Data"}
    },
    [optionTableRef.restrictMovesets] = {
        name = "Restrict Movesets",
        category = OPTION_MOD,
        toggle = 0,
        toggleDefault = 1,
        toggleMax = 1,
        description = {"Restricts turning on", "movesets", "(Host Only)"},
        lock = function ()
            if gGlobalSyncTable.charSelectRestrictMovesets < 2 then
                if not network_is_server() then
                    return "Host Only"
                end
            else
                return "API Only"
            end
        end,
    },
}

local prevCategory = 0
local gridYOffset = 0
local function update_character_render_table(forceUpdate)
    if not forceUpdate and prevCategory == currCategory then return end
    prevCategory = currCategory
    gridYOffset = -100
    local ogNum = currChar
    local insertNum = 0
    --currChar = 1
    currCharRender = 1
    local category = characterCategories[currCategory]
    if category == nil then return false end
    characterTableRender = {}
    for i = 0, #characterTable do
        local charCategories = string_split(characterTable[i].category, "_")
        if not characterTable[i].locked then
            for c = 1, #charCategories do
                if category == charCategories[c] then
                    characterTableRender[insertNum] = characterTable[i]
                    characterTableRender[insertNum].UIOffset = 0
                    if ogNum == i then
                        currChar = ogNum
                        currCharRender = insertNum
                    end
                    insertNum = insertNum + 1
                end
            end
        end
    end
    if #characterTableRender > 1 then
        currChar = (characterTableRender[currCharRender] and characterTableRender[currCharRender].ogNum or characterTableRender[1].ogNum)
        return true
    else
        return false
    end
end

function force_set_character(charNum, charAlt)
    if not charAlt then charAlt = 1 end
    currCategory = 1
    currChar = charNum
    characterTable[currChar].currAlt = charAlt
    currCharRender = charNum
    charBeingSet = true
    update_character_render_table()
end

---@description A function that gets an option's status from the Character Select Options Menu
---@param tableNum integer The table position of the option
---@return number?
function get_options_status(tableNum)
    if type(tableNum) ~= TYPE_INTEGER then return nil end
    return optionTable[tableNum].toggle
end

function dev_mode_log_to_console(message, level)
    if get_options_status(optionTableRef.debugInfo) == 0 then return end
    log_to_console(message, level and level or CONSOLE_MESSAGE_WARNING)
end

creditTable = {
    {
        packName = "Character Select Coop",
        {creditTo = "Squishy6094",     creditFor = "Creator"},
        {creditTo = "Sprsn64",         creditFor = "Logo Design"},
        {creditTo = "JerThePear",      creditFor = "Menu Poses"},
        {creditTo = "Trashcam",        creditFor = "Menu Music"},
        {creditTo = "AngelicMiracles", creditFor = "Concepts / CoopDX"},
        {creditTo = "AgentX",          creditFor = "Contributer / CoopDX"},
        {creditTo = "xLuigiGamerx",    creditFor = "Contributer"},
        {creditTo = "Wibblus",         creditFor = "Contributer"},
        {creditTo = "SuperKirbyLover", creditFor = "Contributer"},
    }
}

local defaultOptionCount = #optionTable

local latencyValueTable = {12, 6, 3}

local menuColorTable = {
    { r = 255, g = 50,  b = 50  },
    { r = 255, g = 100, b = 50  },
    { r = 255, g = 255, b = 50  },
    { r = 50,  g = 255, b = 50  },
    { r = 50,  g = 50,  b = 255 },
    { r = 251, g = 148, b = 220 },
    { r = 130, g = 25,  b = 130 },
    { r = 255, g = 255, b = 255 },
    { r = 50,  g = 50,  b = 50  }
}

---@param m MarioState
local function nullify_inputs(m)
    local c = m.controller
    _G.charSelect.controller = {
        buttonDown = c.buttonDown,
        buttonPressed = c.buttonPressed & ~_G.charSelect.controller.buttonDown,
        extStickX = c.extStickX,
        extStickY = c.extStickY,
        rawStickX = c.rawStickX,
        rawStickY = c.rawStickY,
        stickMag = c.stickMag,
        stickX = c.stickX,
        stickY = c.stickY
    }
    c.buttonDown = 0
    c.buttonPressed = 0
    c.extStickX = 0
    c.extStickY = 0
    c.rawStickX = 0
    c.rawStickY = 0
    c.stickMag = 0
    c.stickX = 0
    c.stickY = 0
end

local prefCharColor = {r = 255, g = 50, b = 50}

local function load_preferred_char()
    local savedChar = mod_storage_load("PrefChar")
    local savedAlt = tonumber(mod_storage_load("PrefAlt"))
    local savedPalette = tonumber(mod_storage_load("PrefPalette"))
    if savedChar == nil or savedChar == "" then
        mod_storage_save("PrefChar", "Default")
        savedChar = "Default"
    end
    if savedAlt == nil then
        mod_storage_save("PrefAlt", "1")
        savedAlt = 1
    end
    if savedPalette == nil then
        local paletteSave = 1
        mod_storage_save("PrefAlt", tostring(paletteSave))
        savedPalette = paletteSave
    end
    if savedChar ~= "Default" then
        for i = CT_MAX, #characterTable do
            local char = characterTable[i]
            if char.saveName == savedChar and not char.locked then
                currChar = i
                currCharRender = i
                if savedAlt > 0 and savedAlt <= #char then
                    char.currAlt = savedAlt
                end
                savedAlt = math.clamp(savedAlt, 1, #characterTable[currChar])
                local model = characterTable[currChar][savedAlt].model
                if characterColorPresets[model] ~= nil then
                    gCSPlayers[0].presetPalette = savedPalette
                    characterColorPresets[model].currPalette = savedPalette
                end
                if optionTable[optionTableRef.notification].toggle > 0 then
                    djui_popup_create('Character Select:\nYour Preferred Character\n"' .. string_underscore_to_space(char[char.currAlt].name) .. '"\nwas applied successfully!', 4)
                end
                break
            end
        end
    end

    if savedChar == "Default" or currChar == CT_MARIO then
        currChar = gMarioStates[0].character.type
        local model = characterTable[currChar][1].model
        gCSPlayers[0].presetPalette = 0
        characterColorPresets[model].currPalette = 0
    end

    local savedCharColors = mod_storage_load("PrefCharColor")
    if savedCharColors ~= nil and savedCharColors ~= "" then
        local savedCharColorsTable = string_split(savedCharColors, "_")
        prefCharColor = {
            r = tonumber(savedCharColorsTable[1]),
            g = tonumber(savedCharColorsTable[2]),
            b = tonumber(savedCharColorsTable[3])
        }
    else
        mod_storage_save("PrefCharColor", "255_50_50")
    end

    if #characterTable < CT_MAX then
        if optionTable[optionTableRef.notification].toggle > 0 then
            djui_popup_create("Character Select:\nNo Characters were Found", 2)
        end
    end
    TEXT_PREF_LOAD_NAME = savedChar
    TEXT_PREF_LOAD_ALT = savedAlt
    update_character_render_table()
end

local function mod_storage_save_pref_char(charTable)
    if character_is_vanilla(charTable.ogNum) then
        mod_storage_save("PrefChar", "Default")
    else
        mod_storage_save("PrefChar", charTable.saveName)
    end
    mod_storage_save("PrefAlt", tostring(charTable.currAlt))
    mod_storage_save("PrefPalette", tostring(gCSPlayers[0].presetPalette))
    mod_storage_save("PrefCharColor", tostring(charTable[charTable.currAlt].color.r) .. "_" .. tostring(charTable[charTable.currAlt].color.g) .. "_" .. tostring(charTable[charTable.currAlt].color.b))
    TEXT_PREF_LOAD_NAME = charTable.saveName
    TEXT_PREF_LOAD_ALT = charTable.currAlt
    prefCharColor = charTable[charTable.currAlt].color
end

function failsafe_options()
    for i = 1, #optionTable do
        if optionTable[i].toggle == nil or optionTable[i].toggle == "" then
            local load = optionTable[i].toggleSaveName and mod_storage_load(optionTable[i].toggleSaveName) or nil
            if load == "" then
                load = nil
            end
            optionTable[i].toggle = load and tonumber(load) or optionTable[i].toggleDefault
        end
        if optionTable[i].toggleNames == nil then
            optionTable[i].toggleNames = {"Off", "On"}
        end
    end
    if optionTable[optionTableRef.openInputs].toggle == 2 and ommActive then
        djui_popup_create('Character Select:\nYour Open bind has changed to:\nD-pad Down + R\nDue to OMM Rebirth being active!', 4)
    end
end

local promptedAreYouSure = false

local function reset_options(wasChatTriggered)
    if not promptedAreYouSure then
        djui_chat_message_create("\\#ffdcdc\\Are you sure you want to reset your Save Data for Character Select, including your Preferred Character\nand Settings?\n" .. (wasChatTriggered and "Type \\#ff3333\\/char-select reset\\#ffdcdc\\ to confirm." or "Press the \\#ff3333\\" .. optionTable[optionTableRef.resetSaveData].name .. "\\#ffdcdc\\ Option again to confirm." ))
        promptedAreYouSure = true
    else
        djui_chat_message_create("\\#ff3333\\Character Select Save Data Reset!")
        djui_chat_message_create("Note: If your issue has not been resolved, you may need to manually delete your save data via the directory below:\n\\#dcdcFF\\%appdata%/sm64coopdx/sav/character-select-coop.sav")
        for i = 1, #optionTable do
            optionTable[i].toggle = optionTable[i].toggleDefault
            if optionTable[i].toggleSaveName ~= nil then
                mod_storage_save(optionTable[i].toggleSaveName, tostring(optionTable[i].toggle))
            end
            if optionTable[i].toggleNames == nil then
                optionTable[i].toggleNames = { "Off", "On" }
            end
        end
        currChar = 1
        for i = 0, #characterTable do
            characterTable[i].currAlt = 1
        end
        mod_storage_save_pref_char(characterTable[1])
        promptedAreYouSure = false
    end
end

local function boot_note()
    if #characterTable >= CT_MAX then
        djui_chat_message_create("Character Select has " .. (#characterTable - 1) .. " character" .. (#characterTable > 2 and "s" or "") .." available!\nYou can use \\#ffff33\\/char-select \\#ffffff\\to open the menu!")
        if #characterTable > 32 and network_is_server() then
            djui_chat_message_create("\\#FFAAAA\\Warning: Having more than 32 Characters\nmay be unstable, For a better experience please\ndisable a few packs!")
        end
    else
        djui_chat_message_create("Character Select is active!\nYou can use \\#ffff33\\/char-select \\#ffffff\\to open the menu!")
    end
end

local function menu_is_allowed(m)
    if m == nil then m = gMarioStates[0] end
    -- API Check
    for _, func in pairs(allowMenu) do
        if not func() then
            return false
        end
    end

    -- C-up Failsafe (Camera Softlocks)
    if m.action == ACT_FIRST_PERSON or (m.prevAction == ACT_FIRST_PERSON and is_game_paused()) then
        return false
    elseif m.prevAction == ACT_FIRST_PERSON and not is_game_paused() then
        m.prevAction = ACT_WALKING
    end

    -- Cutscene Check
    if gNetworkPlayers[0].currActNum == 99 then return false end
    if m.action == ACT_INTRO_CUTSCENE then return false end
    if obj_get_first_with_behavior_id(id_bhvActSelector) ~= nil then return false end

    return true
end

hookTableOnCharacterChange = {
    [1] = function (prevChar, currChar)
        -- Check for Non-Vanilla Actions when switching Characters
        local m = gMarioStates[0]
        if is_mario_in_vanilla_action(m) or m.health < 256 then return end
        if m.action & ACT_FLAG_RIDING_SHELL ~= 0 then
            set_mario_action(m, ACT_RIDING_SHELL_FALL, 0)
        elseif m.action & ACT_FLAG_ALLOW_FIRST_PERSON ~= 0 then
            set_mario_action(m, ACT_IDLE, 0)
        elseif m.action & ACT_GROUP_MOVING ~= 0 or m.action & ACT_FLAG_MOVING ~= 0 then
            set_mario_action(m, ACT_WALKING, 0)
        elseif m.action & ACT_GROUP_SUBMERGED ~= 0 or m.action & ACT_FLAG_SWIMMING ~= 0 then
            -- Need to fix upwarping
            set_mario_action(m, ACT_WATER_IDLE, 0)
        else
            set_mario_action(m, ACT_FREEFALL, 0)
        end
    end
}

local function on_character_change(prevChar, currChar)
    for i = 1, #hookTableOnCharacterChange do
        hookTableOnCharacterChange[i](prevChar, currChar)
    end
end

-------------------
-- Model Handler --
-------------------

local stallFrame = 0
local stallComplete = 3

CUTSCENE_CS_MENU = 0xFA

local MATH_PI = math.pi

local prevBaseCharFrame = gNetworkPlayers[0].modelIndex
local prevBasePalette = {
    [PANTS]  = network_player_get_palette_color(gNetworkPlayers[0], PANTS),
    [SHIRT]  = network_player_get_palette_color(gNetworkPlayers[0], SHIRT),
    [GLOVES] = network_player_get_palette_color(gNetworkPlayers[0], GLOVES),
    [SHOES]  = network_player_get_palette_color(gNetworkPlayers[0], SHOES),
    [HAIR]   = network_player_get_palette_color(gNetworkPlayers[0], HAIR),
    [SKIN]   = network_player_get_palette_color(gNetworkPlayers[0], SKIN),
    [CAP]    = network_player_get_palette_color(gNetworkPlayers[0], CAP),
    [EMBLEM] = network_player_get_palette_color(gNetworkPlayers[0], EMBLEM),
}
local camAngle = 0
local eyeState = MARIO_EYES_OPEN
local worldColor = {
    lighting = {r = 255, g = 255, b = 255},
    skybox = {r = 255, g = 255, b = 255},
    fog = {r = 255, g = 255, b = 255},
    vertex = {r = 255, g = 255, b = 255},
    ambient = {r = 255, g = 255, b = 255}
}
local menuOffsetX = 0
local menuOffsetY = 0 
---@param m MarioState
local function mario_update(m)
    local np = gNetworkPlayers[m.playerIndex]
    local p = gCSPlayers[m.playerIndex]
    if stallFrame == stallComplete - 1 or queueStorageFailsafe then
        failsafe_options()
        if not queueStorageFailsafe then
            load_preferred_char()
            if optionTable[optionTableRef.notification].toggle == 1 then
                boot_note()
            end
        end
        queueStorageFailsafe = false
    end

    if network_is_server() and gGlobalSyncTable.charSelectRestrictMovesets < 2 then
        gGlobalSyncTable.charSelectRestrictMovesets = optionTable[optionTableRef.restrictMovesets].toggle
    end

    if stallFrame < stallComplete then
        stallFrame = stallFrame + 1
    end

    if m.playerIndex == 0 and stallFrame > 1 then
        if djui_hud_is_pause_menu_created() then     
            if prevBaseCharFrame ~= np.modelIndex then
                force_set_character(np.modelIndex)
                p.presetPalette = 0
            end

            if gCSPlayers[0].presetPalette ~= 0 then
                for i = PANTS, EMBLEM do
                    local prevColor = prevBasePalette[i]
                    local currColor = network_player_get_palette_color(np, i)
                    if prevColor.r ~= currColor.r or prevColor.g ~= currColor.g or prevColor.b ~= currColor.b then
                        local model = characterTable[currChar][characterTable[currChar].currAlt].model
                        gCSPlayers[0].presetPalette = 0
                        characterColorPresets[model].currPalette = 0
                        prevColor.r = currColor.r
                        prevColor.g = currColor.g
                        prevColor.b = currColor.b
                    end
                end
            end
        end
        prevBaseCharFrame = np.modelIndex

        local charTable = characterTable[currChar]
        p.saveName = charTable.saveName
        p.currAlt = charTable.currAlt
    
        p.modelId = charTable[charTable.currAlt].model
        if charTable[charTable.currAlt].baseChar ~= nil then
            p.baseChar = charTable[charTable.currAlt].baseChar
        end
        p.modelEditOffset = charTable[charTable.currAlt].model - charTable[charTable.currAlt].ogModel
        m.marioObj.hookRender = 1

        if menu and m.action == ACT_SLEEPING then
            set_mario_action(m, ACT_WAKING_UP, m.actionArg)
        end

        if menuAndTransition then
            audio_stream_play(SOUND_CHAR_SELECT_THEME, false, 1)
            for i = 0, #characterTable do
                if characterInstrumentals[i] ~= nil then
                    audio_stream_play(characterInstrumentals[i], false, 1)
                    audio_stream_set_volume(characterInstrumentals[i], i == currChar and 1 or 0)
                end
            end
            play_secondary_music(0, 0, 0, 50)
            camera_freeze()
            hud_hide()
            djui_hud_set_resolution(RESOLUTION_N64)
            local widthScale = djui_hud_get_screen_width()/320
            set_override_fov(45/widthScale)
            if m.area.camera.cutscene == 0 then
                m.area.camera.cutscene = CUTSCENE_CS_MENU
            end
            local camScale = charTable[charTable.currAlt].camScale*widthScale
            local camAngle = m.faceAngle.y + 0x800
            local focusPos = {
                x = m.pos.x + sins(camAngle - 0x4000)*(175/widthScale - menuOffsetX)*camScale*widthScale,
                y = m.pos.y + 120/widthScale * camScale - menuOffsetY,
                z = m.pos.z + coss(camAngle - 0x4000)*(175/widthScale - menuOffsetX)*camScale*widthScale,
            }
            vec3f_copy(gLakituState.focus, focusPos)
            m.marioBodyState.eyeState = MARIO_EYES_OPEN
            gLakituState.pos.x = m.pos.x + sins(camAngle) * 450 * camScale
            gLakituState.pos.y = m.pos.y + 10
            gLakituState.pos.z = m.pos.z + coss(camAngle) * 450 * camScale
            p.inMenu = true

            set_lighting_color(0, (menuColor.r*0.33 + 255*0.66) * worldColor.lighting.r/255)
            set_lighting_color(1, (menuColor.g*0.33 + 255*0.66) * worldColor.lighting.g/255)
            set_lighting_color(2, (menuColor.b*0.33 + 255*0.66) * worldColor.lighting.b/255)
            set_lighting_color_ambient(0, (menuColor.r*0.33 + 255*0.66) * worldColor.ambient.r/127)
            set_lighting_color_ambient(1, (menuColor.g*0.33 + 255*0.66) * worldColor.ambient.g/127)
            set_lighting_color_ambient(2, (menuColor.b*0.33 + 255*0.66) * worldColor.ambient.b/127)
            set_skybox_color(0, menuColor.r * worldColor.lighting.r/255)
            set_skybox_color(1, menuColor.g * worldColor.lighting.g/255)
            set_skybox_color(2, menuColor.b * worldColor.lighting.b/255)
            set_fog_color(0, menuColor.r * worldColor.lighting.r/255)
            set_fog_color(1, menuColor.g * worldColor.lighting.g/255)
            set_fog_color(2, menuColor.b * worldColor.lighting.b/255)
            set_vertex_color(0, menuColor.r * worldColor.lighting.r/255)
            set_vertex_color(1, menuColor.g * worldColor.lighting.g/255)
            set_vertex_color(2, menuColor.b * worldColor.lighting.b/255)
        else
            if p.inMenu then
                audio_stream_pause(SOUND_CHAR_SELECT_THEME)
                for i = 0, #characterTable do
                    if characterInstrumentals[i] ~= nil then
                        audio_stream_pause(characterInstrumentals[i])
                    end
                end
                stop_secondary_music(50)
                camera_unfreeze()
                hud_show()
                set_override_fov(0)
                if m.area.camera.cutscene == CUTSCENE_CS_MENU then
                    m.area.camera.cutscene = CUTSCENE_STOP
                end
                set_lighting_color(0, worldColor.lighting.r)
                set_lighting_color(1, worldColor.lighting.g)
                set_lighting_color(2, worldColor.lighting.b)
                set_lighting_color_ambient(0, worldColor.ambient.r)
                set_lighting_color_ambient(1, worldColor.ambient.g)
                set_lighting_color_ambient(2, worldColor.ambient.b)
                set_skybox_color(0, worldColor.skybox.r)
                set_skybox_color(1, worldColor.skybox.g)
                set_skybox_color(2, worldColor.skybox.b)
                set_fog_color(0, worldColor.fog.r)
                set_fog_color(1, worldColor.fog.g)
                set_fog_color(2, worldColor.fog.b)
                set_vertex_color(0, worldColor.vertex.r)
                set_vertex_color(1, worldColor.vertex.g)
                set_vertex_color(2, worldColor.vertex.b)
                p.inMenu = false
            end

            worldColor.lighting.r = get_lighting_color(0)
            worldColor.lighting.g = get_lighting_color(1)
            worldColor.lighting.b = get_lighting_color(2)
            worldColor.ambient.r = get_lighting_color_ambient(0)
            worldColor.ambient.g = get_lighting_color_ambient(1)
            worldColor.ambient.b = get_lighting_color_ambient(2)
            worldColor.skybox.r = get_skybox_color(0)
            worldColor.skybox.g = get_skybox_color(1)
            worldColor.skybox.b = get_skybox_color(2)
            worldColor.fog.r = get_fog_color(0)
            worldColor.fog.g = get_fog_color(1)
            worldColor.fog.b = get_fog_color(2)
            worldColor.vertex.r = get_vertex_color(0)
            worldColor.vertex.g = get_vertex_color(1)
            worldColor.vertex.b = get_vertex_color(2)
        end

        -- Check for Locked Chars
        for i = CT_MAX, #characterTable do
            local char = characterTable[i]
            if char.locked then
                local unlock = characterUnlock[i].check
                local notif = characterUnlock[i].notif
                if type(unlock) == TYPE_FUNCTION then
                    if unlock() then
                        char.locked = false
                    end
                elseif type(unlock) == TYPE_BOOLEAN then
                    char.locked = unlock
                end
                if not char.locked then -- Character was unlocked
                    update_character_render_table(true)
                    if stallFrame == stallComplete and notif then
                        if optionTable[optionTableRef.notification].toggle > 0 then
                            djui_popup_create('Character Select:\nUnlocked '..tostring(char[1].name)..'\nas a Playable Character!', 3)
                        end
                    end
                end
            end
        end

        --Open Credits
        if optionTable[optionTableRef.credits].toggle > 0 then
            credits = true
            optionTable[optionTableRef.credits].toggle = 0
        end

        --Reset Save Data Check
        if optionTable[optionTableRef.resetSaveData].toggle > 0 then
            reset_options(false)
            optionTable[optionTableRef.resetSaveData].toggle = 0
        end
        charBeingSet = false
        for i = 1, #optionTable do
            optionTable[i].optionBeingSet = false
        end

        p.movesetToggle = optionTable[optionTableRef.localMoveset].toggle ~= 0
        if prevChar ~= currChar then
            on_character_change(prevChar, currChar)
            prevChar = currChar
        end
    end

    if p.inMenu and m.action & ACT_FLAG_ALLOW_FIRST_PERSON ~= 0 then
        m.action = ACT_IDLE
        m.actionArg = 0
        m.actionState = 0xFFFF

        -- reset menu anim on character change, starts them at frame 0 and prevents lua anim issues
        if p.prevModelId ~= p.modelId then
            p.prevModelId = p.modelId
            m.marioObj.header.gfx.animInfo.animID = -1
        end
        set_character_animation(m, (characterAnims[p.modelId] and characterAnims[p.modelId].anims and characterAnims[p.modelId].anims[CS_ANIM_MENU]) and CS_ANIM_MENU or CHAR_ANIM_FIRST_PERSON)

        m.marioObj.header.gfx.angle.y = m.faceAngle.y
    elseif m.actionState == 0xFFFF and m.action == ACT_IDLE then
        -- snap back to normal idle when out of the menu
        m.actionState = 0
    end

    np.overrideModelIndex = p.baseChar ~= nil and p.baseChar or CT_MARIO

    -- Character Animations
    if characterAnims[p.modelId] then
        local animID = characterAnims[p.modelId].anims and characterAnims[p.modelId].anims[m.marioObj.header.gfx.animInfo.animID]
        if animID then
            smlua_anim_util_set_animation(m.marioObj, animID)
        end
        local eyeState = characterAnims[p.modelId].eyes and characterAnims[p.modelId].eyes[m.marioObj.header.gfx.animInfo.animID]
        if eyeState then
            m.marioBodyState.eyeState = eyeState
        end
        local handState = characterAnims[p.modelId].hands and characterAnims[p.modelId].hands[m.marioObj.header.gfx.animInfo.animID]
        if handState then
            m.marioBodyState.handState = handState
        end
    end
end

local sCapBhvs = {
    [id_bhvWingCap] = true,
    [id_bhvVanishCap] = true,
    [id_bhvMetalCap] = true
}

---@param o Object
---@param model integer
local BowserKey = false
local function on_star_or_key_grab(m, o, type)
    if type == INTERACT_STAR_OR_KEY then
        if get_id_from_behavior(o.behavior) == id_bhvBowserKey then
            BowserKey = true
        else
            BowserKey = false
        end
    end
end

function set_model(o, model)
    -- Player Models
    if obj_has_behavior_id(o, id_bhvMario) ~= 0 then
        local i = network_local_index_from_global(o.globalPlayerIndex)
        local prevModelData = obj_get_model_id_extended(o)
        local localModelData = nil
        for c = 0, #characterTable do
            if gCSPlayers[i].saveName == characterTable[c].saveName then
                if gCSPlayers[i].currAlt <= #characterTable[c] then
                    localModelData = characterTable[c][gCSPlayers[i].currAlt].ogModel + gCSPlayers[i].modelEditOffset
                    break
                end
            end
        end
        if localModelData ~= nil then
            if obj_has_model_extended(o, localModelData) == 0 then
                obj_set_model_extended(o, localModelData)
            end
        else
            -- Original/Backup
            if gCSPlayers[i].modelId ~= nil and obj_has_model_extended(o, gCSPlayers[i].modelId) == 0 then
                obj_set_model_extended(o, gCSPlayers[i].modelId)
            end
        end
        return
    end

    -- Star Models
    if obj_has_behavior_id(o, id_bhvCelebrationStar) ~= 0 and o.parentObj ~= nil then
        local i = network_local_index_from_global(o.parentObj.globalPlayerIndex)
        local starModel = characterCelebrationStar[gCSPlayers[i].modelId]
        if gCSPlayers[i].modelId ~= nil and starModel ~= nil and obj_has_model_extended(o, starModel) == 0 and not BowserKey then
            obj_set_model_extended(o, starModel)
        end
        return
    end

    if sCapBhvs[get_id_from_behavior(o.behavior)] then
        local playerToObj = nearest_player_to_object(o.parentObj)
        o.globalPlayerIndex = playerToObj and playerToObj.globalPlayerIndex or 0
    end
    local i = network_local_index_from_global(o.globalPlayerIndex)

    local c = gMarioStates[i].character
    if model == c.capModelId or
       model == c.capWingModelId or
       model == c.capMetalModelId or
       model == c.capMetalWingModelId then
        local capModels = characterCaps[gCSPlayers[i].modelId]
        if capModels ~= nil then
            local capModel = E_MODEL_NONE
            if model == c.capModelId then
                capModel = capModels.normal
            elseif model == c.capWingModelId then
                capModel = capModels.wing
            elseif model == c.capMetalModelId then
                capModel = capModels.metal
            elseif model == c.capMetalWingModelId then
                capModel = capModels.metalWing
            end
            if capModel ~= E_MODEL_NONE and capModel ~= E_MODEL_ERROR_MODEL and capModel ~= nil then
                obj_set_model_extended(o, capModel)
            end
        end
    end
end

--hook_event(HOOK_MARIO_UPDATE, mario_update)
cs_hook_mario_update(mario_update)
hook_event(HOOK_ON_INTERACT, on_star_or_key_grab)
hook_event(HOOK_OBJECT_SET_MODEL, set_model)

------------------
-- Menu Handler --
------------------

local function button_to_analog(controller, negInput, posInput)
    local num = 0
    num = num - (controller.buttonDown & negInput ~= 0 and 127 or 0)
    num = num + (controller.buttonDown & posInput ~= 0 and 127 or 0)
    return num
end

local TEX_CAUTION_TAPE = get_texture_info("char-select-caution-tape")
-- Renders caution tape from xy1 to xy2, tape extends based on dist (0 - 1)
local function djui_hud_render_caution_tape(x1, y1, x2, y2, dist, scale)
    if not scale then scale = 0.5 end
    local totalDist = math.sqrt((y2 - y1)^2 + (x2 - x1)^2) * dist
    local angle = angle_from_2d_points(x1, y1, x2, y2)
    djui_hud_set_rotation(angle, 0, 0.5)
    local texWidth = TEX_CAUTION_TAPE.width*scale
    local texHeight = TEX_CAUTION_TAPE.height*scale
    local tapeSegments = totalDist/texWidth
    local tapeRemainder = tapeSegments
    while tapeRemainder > 1 do
        tapeRemainder = tapeRemainder - 1
    end
    for i = 0, math.floor(tapeSegments) do
        local remainder = i == math.floor(tapeSegments) and tapeRemainder or 1
        djui_hud_render_texture_tile(TEX_CAUTION_TAPE,
        x1 + texWidth*coss(angle)*i,
        y1 - texWidth*sins(angle)*i,
        TEX_CAUTION_TAPE.height/TEX_CAUTION_TAPE.width*scale, 1*scale, 0, 0, TEX_CAUTION_TAPE.width*remainder, TEX_CAUTION_TAPE.height)
    end
    djui_hud_set_rotation(0, 0, 0)
end

local buttonAnimTimer = 0
local buttonScroll = 0
local buttonScrollCap = 30

local optionAnimTimer = -200
local optionAnimTimerCap = optionAnimTimer

local inputStallTimerButton = 0
local inputStallTimerDirectional = 0
local inputStallToDirectional = 12
local inputStallToButton = 10

--Basic Menu Text
local TEXT_OPTIONS_HEADER = "Menu Options"
local TEXT_OPTIONS_HEADER_API = "API Options"
local yearsOfCS = get_date_and_time().year - 123 -- Zero years as of 2023
local TEXT_VERSION = "Version: " .. MOD_VERSION_STRING .. " | sm64coopdx" .. (seasonalEvent == SEASON_EVENT_BIRTHDAY and (" | " .. tostring(yearsOfCS) .. " year" .. (yearsOfCS > 1 and "s" or "") .. " of Character Select!") or "")
local TEXT_RATIO_UNSUPPORTED = "Your Current Aspect-Ratio isn't Supported!"
local TEXT_DESCRIPTION = "Character Description:"
local TEXT_PREF_SAVE = "Preferred Char (A)"
local TEXT_PREF_PALETTE = "Toggle Palette (Y)"
local TEXT_MOVESET_INFO = "Moveset Info (Z)"
local TEXT_PAUSE_Z_OPEN = "Z Button - Character Select"
local TEXT_PAUSE_UNAVAILABLE = "Character Select is Unavailable"
local TEXT_PAUSE_CURR_CHAR = "Current Character: "
local TEXT_MOVESET_RESTRICTED = "Movesets are Restricted"
local TEXT_PALETTE_RESTRICTED = "Palettes are Restricted"
local TEXT_MOVESET_AND_PALETTE_RESTRICTED = "Moveset and Palettes are Restricted"
local TEXT_CHAR_LOCKED = "Locked"
-- Easter Egg if you get lucky loading the mod
-- Referencing the original sm64ex DynOS options by PeachyPeach >v<
if math_random(100) == 64 then
    TEXT_PAUSE_Z_OPEN = "Z - DynOS"
    TEXT_PAUSE_CURR_CHAR = "Model: "
end

--Debug Text
local TEXT_DEBUGGING = "Character Debug"
local TEXT_DESCRIPTION_SHORT = "Description:"
local TEXT_LIFE_ICON = "Life Icon:"
local TEXT_STAR_ICON = "Star Icon:"
local TEXT_FORCED_CHAR = "Base: "
local TEXT_TABLE_POS = "Table Position: "
local TEXT_PALETTE = "Palette: "
local baseCharStrings = {
    [CT_MARIO] = "CT_MARIO",
    [CT_LUIGI] = "CT_LUIGI",
    [CT_TOAD] = "CT_TOAD",
    [CT_WALUIGI] = "CT_WALUIGI",
    [CT_WARIO] = "CT_WARIO"
}

--Options Text
local TEXT_OPTIONS_OPEN = "Press START to open Options"
local TEXT_MENU_CLOSE = "Press B to Exit Menu"
local TEXT_OPTIONS_SELECT = "A - Select | B - Exit  "
local TEXT_LOCAL_MODEL_OFF = "Locally Display Models is Off"
local TEXT_LOCAL_MODEL_OFF_OPTIONS = "You can turn it back on in the Options Menu"
local TEXT_LOCAL_MODEL_ERROR = "Failed to find a Character Model"
local TEXT_LOCAL_MODEL_ERROR_FIX = "Please Verify the Integrity of the Pack!"

--Credit Text
local TEXT_CREDITS_HEADER = "Credits"

local MATH_DIVIDE_320 = 1/320
local MATH_DIVIDE_64 = 1/64
local MATH_DIVIDE_32 = 1/32
local MATH_DIVIDE_30 = 1/30
local MATH_DIVIDE_16 = 1/16

local targetMenuColor = {r = 0 , g = 0, b = 0}
menuColor = targetMenuColor
local menuColorHalf = menuColor
local transSpeed = 0.1
local prevBindText = ""
local bindText = 1
local bindTextTimerLoop = 150
local bindTextTimer = 0
local bindTextOpacity = -255
function update_menu_color()
    if optionTable[optionTableRef.menuColor].toggle == nil then return end
    if optionTable[optionTableRef.menuColor].toggle > 1 then
        targetMenuColor = menuColorTable[optionTable[optionTableRef.menuColor].toggle - 1]
    elseif optionTable[optionTableRef.menuColor].toggle == 1 then
        optionTable[optionTableRef.menuColor].toggleNames[2] = string_underscore_to_space(TEXT_PREF_LOAD_NAME) .. ((TEXT_PREF_LOAD_ALT ~= 1 and currChar ~= 1) and " ("..TEXT_PREF_LOAD_ALT..")" or "") .. " (Pref)"
        targetMenuColor = prefCharColor
    elseif characterTable[currChar] ~= nil then
        local char = characterTable[currChar]
        targetMenuColor = char[char.currAlt].color
    end
    if optionTable[optionTableRef.anims].toggle > 0 then
        menuColor.r = math.lerp(menuColor.r, targetMenuColor.r, transSpeed)
        menuColor.g = math.lerp(menuColor.g, targetMenuColor.g, transSpeed)
        menuColor.b = math.lerp(menuColor.b, targetMenuColor.b, transSpeed)
    else
        menuColor.r = targetMenuColor.r
        menuColor.g = targetMenuColor.g
        menuColor.b = targetMenuColor.b
    end
    menuColorHalf = {
        r = menuColor.r * 0.5 + 127,
        g = menuColor.g * 0.5 + 127,
        b = menuColor.b * 0.5 + 127
    }
    return menuColor
end

local TEX_TRIANGLE = get_texture_info("char-select-triangle")
local function djui_hud_render_triangle(x, y, width, height)
    djui_hud_render_texture(TEX_TRIANGLE, x, y, width*MATH_DIVIDE_64, height*MATH_DIVIDE_32)
end

local function ease_in_out_back(x)
    local c1 = 1.70158;
    local c2 = c1 * 1.525;

    return x < 0.5 and ((2 * x)^2 * ((c2 + 1) * 2 * x - c2)) / 2 or ((2 * x - 2)^2 * ((c2 + 1) * (x * 2 - 2) + c2) + 2) / 2;
end

local TEX_GEAR_BIG = get_texture_info("char-select-gear-big")

local buttonAltAnim = 0
local menuOpacity = 245
local gridButtonsPerRow = 5
local paletteXOffset = 0
local paletteTrans = 0
local menuText = {}
local function on_hud_render()
    local FONT_USER = djui_menu_get_font()
    djui_hud_set_font(FONT_ALIASED)
    djui_hud_set_resolution(RESOLUTION_DJUI)
    local djuiWidth = djui_hud_get_screen_width()
    local djuiHeight = djui_hud_get_screen_height()
    djui_hud_set_resolution(RESOLUTION_N64)
    local width = math.max(djuiWidth * (240/djuiHeight), 320) -- Get accurate, unrounded width
    local height = 240
    local widthHalf = width * 0.5
    local heightHalf = height * 0.5
    local widthScale = math.max(width, 320) * MATH_DIVIDE_320

    if stallFrame == stallComplete then
        update_menu_color()
        if not menu_is_allowed() then
            menu = false
        end
    end

    if menuAndTransition then
        if characterTable[currChar][characterTable[currChar].currAlt].model == E_MODEL_ARMATURE then
            djui_hud_set_color(0, 0, 0, 200)
            djui_hud_render_rect(0, 0, width, height)
            djui_hud_set_color(255, 255, 255, 255)
            djui_hud_print_text(TEXT_LOCAL_MODEL_ERROR, widthHalf - djui_hud_measure_text(TEXT_LOCAL_MODEL_ERROR) * 0.15 * widthScale, heightHalf, 0.3 * widthScale)
            djui_hud_print_text(TEXT_LOCAL_MODEL_ERROR_FIX, widthHalf - djui_hud_measure_text(TEXT_LOCAL_MODEL_ERROR_FIX) * 0.1 * widthScale, heightHalf + 10 * widthScale, 0.2 * widthScale)
        end

        local x = 135 * widthScale * 0.8

        --[[
        -- Render All Black Squares Behind Below API
        djui_hud_set_color(menuColorHalf.r * 0.1, menuColorHalf.g * 0.1, menuColorHalf.b * 0.1, menuOpacity)
        -- Description
        djui_hud_render_rect(width - x + 2, 2 + 46, x - 4, height - 4 - 46)
        -- Buttons
        djui_hud_render_rect(2, 2 + 46, x - 4, height - 4 - 46)
        -- Header
        djui_hud_render_rect(2, 2, width - 4, 46)
        ]]

        -- API Rendering (Below Text)
        if #hookTableRenderInMenu.back > 0 then
            for i = 1, #hookTableRenderInMenu.back do
                hookTableRenderInMenu.back[i]()
            end
        end

        --[[
        --Character Description
        djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
        djui_hud_render_rect(width - x, 50, 2, height - 50)
        djui_hud_render_rect(width - x, height - 2, x, 2)
        djui_hud_render_rect(width - 2, 50, 2, height - 50)
        djui_hud_set_color(menuColorHalf.r, menuColorHalf.g, menuColorHalf.b, 255)
        djui_hud_set_font(FONT_ALIASED)
        local character = characterTable[currChar]
        local TEXT_SAVE_NAME = "Save Name: " .. character.saveName
        local TEXT_MOVESET = "Has Moveset: "..(character.hasMoveset and "Yes" or "No")
        local TEXT_ALT = "Alt: " .. character.currAlt .. "/" .. #character
        character = characterTable[currChar][character.currAlt]
        local paletteCount = characterColorPresets[gCSPlayers[0].modelId] ~= nil and #characterColorPresets[gCSPlayers[0].modelId] or 0
        local currPaletteTable = characterColorPresets[gCSPlayers[0].modelId] and characterColorPresets[gCSPlayers[0].modelId] or {currPalette = 0}
        if optionTable[optionTableRef.debugInfo].toggle == 0 then
            -- Actual Description --
            local TEXT_NAME = string_underscore_to_space(character.name)
            local TEXT_CREDIT = "Credit: " .. character.credit
            local TEXT_DESCRIPTION_TABLE = character.description
            local TEXT_PREF_LOAD_NAME = string_underscore_to_space(TEXT_PREF_LOAD_NAME) .. ((TEXT_PREF_LOAD_ALT ~= 1 and TEXT_PREF_LOAD_NAME ~= "Default" and currChar ~= 1) and " ("..TEXT_PREF_LOAD_ALT..")" or "")

            local textX = x * 0.5
            djui_hud_print_text(TEXT_NAME, width - textX - djui_hud_measure_text(TEXT_NAME) * 0.3, 55, 0.6)
            djui_hud_set_font(FONT_TINY)
            local creditScale = 0.6 
            creditScale = math_min(creditScale, 100/djui_hud_measure_text(TEXT_CREDIT))
            djui_hud_print_text(TEXT_CREDIT, width - textX - djui_hud_measure_text(TEXT_CREDIT) * creditScale *0.5, 74, creditScale)
            djui_hud_set_font(FONT_ALIASED)
            djui_hud_print_text(TEXT_DESCRIPTION, width - textX - djui_hud_measure_text(TEXT_DESCRIPTION) * 0.2, 85, 0.4)
            if widthScale < 1.65 then
                for i = 1, #TEXT_DESCRIPTION_TABLE do
                    djui_hud_print_text(TEXT_DESCRIPTION_TABLE[i], width - textX - djui_hud_measure_text(TEXT_DESCRIPTION_TABLE[i]) * 0.15, 90 + i * 9, 0.3)
                end
            else
                for i = 1, math_ceil(#TEXT_DESCRIPTION_TABLE*0.5) do
                    local tablePos = (i * 2) - 1
                    if TEXT_DESCRIPTION_TABLE[tablePos] and TEXT_DESCRIPTION_TABLE[tablePos + 1] then
                        local TEXT_STRING = TEXT_DESCRIPTION_TABLE[tablePos] .. " " .. TEXT_DESCRIPTION_TABLE[tablePos + 1]
                        djui_hud_print_text(TEXT_STRING, width - textX - djui_hud_measure_text(TEXT_STRING) * 0.15, 90 + i * 9, 0.3)
                    elseif TEXT_DESCRIPTION_TABLE[tablePos] then
                        local TEXT_STRING = TEXT_DESCRIPTION_TABLE[tablePos]
                        djui_hud_print_text(TEXT_STRING, width - textX - djui_hud_measure_text(TEXT_STRING) * 0.15, 90 + i * 9, 0.3)
                    end
                end
            end

            menuText = {
                TEXT_PREF_SAVE .. " - " .. TEXT_PREF_LOAD_NAME
            }
            local modelId = gCSPlayers[0].modelId
            local TEXT_PRESET_TOGGLE = ((currPaletteTable[currPaletteTable.currPalette] ~= nil and currPaletteTable[currPaletteTable.currPalette].name ~= nil) and (currPaletteTable[currPaletteTable.currPalette].name .. " - ") or "") .. ((paletteCount > 1 and "("..currPaletteTable.currPalette.."/"..paletteCount..")" or (currPaletteTable.currPalette > 0 and "On" or "Off")) or "Off")
            if characterColorPresets[modelId] and gGlobalSyncTable.charSelectRestrictPalettes == 0 then
                table_insert(menuText, TEXT_PREF_PALETTE .. " - " .. TEXT_PRESET_TOGGLE)
            elseif gGlobalSyncTable.charSelectRestrictPalettes > 0 then
                table_insert(menuText, TEXT_PALETTE_RESTRICTED)
            end
            if #menuText > 1 then
                bindTextTimer = (bindTextTimer + 1)%(bindTextTimerLoop)
            end
            if bindTextTimer == 0 then
                bindText = bindText + 1
                bindTextOpacity = -254
            end
            if bindText > #menuText or not menuText[bindText] then
                bindText = 1
            end
            if menuText[bindText] ~= prevBindText and bindTextOpacity == -255 then
                bindTextOpacity = -254
            end
            if bindTextOpacity > -255 and bindTextOpacity < 255 then
                bindTextOpacity = math.min(bindTextOpacity + 25, 255)
                if bindTextOpacity == 255 then
                    bindTextOpacity = -255
                    prevBindText = menuText[bindText]
                end
            end
            --local bindTextOpacity = math.clamp(math.abs(math.sin(bindTextTimer*MATH_PI/bindTextTimerLoop)), 0, 0.2) * 5 * 255
            local fadeOut = math_abs(math.clamp(bindTextOpacity, -255, 0))
            local fadeIn = math_abs(math.clamp(bindTextOpacity, 0, 255))
            local bindTextScale = math.min((x - 10)/(djui_hud_measure_text(menuText[bindText]) * 0.3), 1)*0.3
            local prevBindTextScale = math.min((x - 10)/(djui_hud_measure_text(prevBindText) * 0.3), 1)*0.3
            djui_hud_set_color(menuColorHalf.r, menuColorHalf.g, menuColorHalf.b, fadeOut)
            djui_hud_print_text(prevBindText, width - textX - djui_hud_measure_text(prevBindText) * prevBindTextScale*0.5, height - 15, prevBindTextScale)
            djui_hud_set_color(menuColorHalf.r, menuColorHalf.g, menuColorHalf.b, fadeIn)
            djui_hud_print_text(menuText[bindText], width - textX - djui_hud_measure_text(menuText[bindText]) * bindTextScale*0.5, height - 15, bindTextScale)
            djui_hud_set_color(menuColorHalf.r, menuColorHalf.g, menuColorHalf.b, 255)
        else
            -- Debugging Info --
            local TEXT_NAME = "Name: " .. character.name
            local TEXT_CREDIT = "Credit: " .. character.credit
            local TEXT_DESCRIPTION_TABLE = character.description
            local TEXT_COLOR = "Color: R-" .. character.color.r ..", G-" ..character.color.g ..", B-"..character.color.b
            local TEX_LIFE_ICON = character.lifeIcon
            local TEX_STAR_ICON = character.starIcon
            local TEXT_SCALE = "Camera Scale: " .. character.camScale
            local TEXT_PRESET = "Preset Palette: ("..currPaletteTable.currPalette.."/"..paletteCount..")"
            local TEXT_PREF = "Preferred: " .. TEXT_PREF_LOAD_NAME .. " ("..TEXT_PREF_LOAD_ALT..")"
            local TEXT_PREF_COLOR = "Pref Color: R-" .. prefCharColor.r .. ", G-" .. prefCharColor.g .. ", B-" .. prefCharColor.b

            local textX = x * 0.5
            djui_hud_print_text(TEXT_DEBUGGING, width - textX - djui_hud_measure_text(TEXT_DEBUGGING) * 0.3, 55, 0.6)
            djui_hud_set_font(FONT_TINY)
            local y = 72
            djui_hud_print_text(TEXT_NAME, width - x + 8, y, 0.5)
            y = y + 7
            djui_hud_print_text(TEXT_SAVE_NAME, width - x + 8, y, 0.5)
            y = y + 7
            djui_hud_print_text(TEXT_ALT, width - x + 8, y, 0.5)
            y = y + 7
            djui_hud_print_text(TEXT_CREDIT, width - x + 8, y, 0.5)
            y = y + 7
            if TEXT_DESCRIPTION_TABLE[1] ~= "No description has been provided" then
                djui_hud_print_text(TEXT_DESCRIPTION_SHORT, width - x + 8, y, 0.5)
                y = y + 2
                local removeLine = 0
                for i = 1, #TEXT_DESCRIPTION_TABLE do
                    if TEXT_DESCRIPTION_TABLE[i] ~= "" then
                        djui_hud_set_font(FONT_ALIASED)
                        local TEXT_DESCRIPTION_LINE = TEXT_DESCRIPTION_TABLE[i]
                        if (djui_hud_measure_text(TEXT_DESCRIPTION_TABLE[i]) * 0.3 > 100) then
                            TEXT_DESCRIPTION_LINE = "(!) " .. TEXT_DESCRIPTION_LINE
                        else
                            TEXT_DESCRIPTION_LINE = "    " .. TEXT_DESCRIPTION_LINE
                        end
                        djui_hud_set_font(FONT_TINY)
                        djui_hud_print_text(TEXT_DESCRIPTION_LINE, width - x + 5, y + (i-removeLine) * 5, 0.4)
                    else
                        removeLine = removeLine + 1
                    end
                end
                local descriptionOffset = (#TEXT_DESCRIPTION_TABLE - removeLine) * 5
                y = y + 5 + descriptionOffset
            end
            djui_hud_set_color(character.color.r, character.color.g, character.color.b, 255)
            djui_hud_print_text(TEXT_COLOR, width - x + 8, y, 0.5)
            djui_hud_set_color(menuColorHalf.r, menuColorHalf.g, menuColorHalf.b, 255)
            y = y + 7
            if type(TEX_LIFE_ICON) ~= TYPE_STRING then
                djui_hud_print_text(TEXT_LIFE_ICON .. "    (" .. TEX_LIFE_ICON.width .. "x" .. TEX_LIFE_ICON.height .. ")", width - x + 8, y, 0.5)
                djui_hud_set_color(255, 255, 255, 255)
                djui_hud_render_texture(TEX_LIFE_ICON, width - x + 33, y + 1, 0.4 / (TEX_LIFE_ICON.width * MATH_DIVIDE_16), 0.4 / (TEX_LIFE_ICON.height * MATH_DIVIDE_16))
            else
                djui_hud_print_text(TEXT_LIFE_ICON .. "    (FONT_HUD)", width - x + 8, y, 0.5)
                djui_hud_set_font(FONT_HUD)
                djui_hud_set_color(255, 255, 255, 255)
                djui_hud_print_text(TEX_LIFE_ICON, width - x + 33, y + 1, 0.4)
                djui_hud_set_font(FONT_TINY)
            end
            y = y + 7
            djui_hud_set_color(menuColorHalf.r, menuColorHalf.g, menuColorHalf.b, 255)
            djui_hud_print_text(TEXT_STAR_ICON .. "    (" .. TEX_STAR_ICON.width .. "x" .. TEX_STAR_ICON.height .. ")", width - x + 8, y, 0.5)
            djui_hud_set_color(255, 255, 255, 255)
            djui_hud_render_texture(TEX_STAR_ICON, width - x + 35, y + 1, 0.4 / (TEX_STAR_ICON.width * MATH_DIVIDE_16), 0.4 / (TEX_STAR_ICON.height * MATH_DIVIDE_16))
            y = y + 7
            djui_hud_set_color(menuColorHalf.r, menuColorHalf.g, menuColorHalf.b, 255)
            djui_hud_print_text(TEXT_FORCED_CHAR .. baseCharStrings[character.baseChar], width - x + 8, y, 0.5)
            y = y + 7
            djui_hud_print_text(TEXT_TABLE_POS .. currChar, width - x + 8, y, 0.5)
            y = y + 7
            djui_hud_print_text(TEXT_SCALE, width - x + 8, y, 0.5)
            local modelId = gCSPlayers[0].modelId
            y = y + 7
            if characterColorPresets[modelId] ~= nil then
                djui_hud_print_text(TEXT_PALETTE, width - x + 8, y, 0.5)
                local x = x - djui_hud_measure_text(TEXT_PALETTE)*0.5
                local currPalette = currPaletteTable.currPalette > 0 and currPaletteTable.currPalette or 1
                local paletteTable = currPaletteTable[currPalette]
                for i = 0, #paletteTable do
                    djui_hud_set_color(menuColorHalf.r, menuColorHalf.g, menuColorHalf.b, 255)
                    djui_hud_render_rect(width - x + 6.5 + (6.5 * i), y + 1.5, 6, 6)
                    djui_hud_set_color(paletteTable[i].r, paletteTable[i].g, paletteTable[i].b, 255)
                    djui_hud_render_rect(width - x + 7 + (6.5 * i), y + 2, 5, 5)
                end
                y = y + 7
                djui_hud_set_color(menuColorHalf.r, menuColorHalf.g, menuColorHalf.b, 255)
            end
            djui_hud_print_text(TEXT_MOVESET, width - x + 8, y, 0.5)
            y = y + 7
            djui_hud_print_text(TEXT_PRESET, width - x + 8, height - 29, 0.5)
            djui_hud_print_text(TEXT_PREF, width - x + 8, height - 22, 0.5)
            djui_hud_set_color(prefCharColor.r, prefCharColor.g, prefCharColor.b, 255)
            djui_hud_print_text(TEXT_PREF_COLOR, width - x + 8, height - 15, 0.5)
            djui_hud_set_color(menuColorHalf.r, menuColorHalf.g, menuColorHalf.b, 255)
        end
        ]]

        --Unsupported Res Warning
        if width < 319 or width > 575 then
            djui_hud_print_text(TEXT_RATIO_UNSUPPORTED, 5, 39, 0.5)
        end

        -- API Rendering (Above Text)
        djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
        if #hookTableRenderInMenu.front > 0 then
            for i = 1, #hookTableRenderInMenu.front do
                hookTableRenderInMenu.front[i]()
            end
        end
        djui_hud_set_resolution(RESOLUTION_N64)

        djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
        djui_hud_render_rect(width * 0.5 - 50 * widthScale, height - 2, 100 * widthScale, 2)

        -- Make Random Elements based on Character Name
        math.randomseed(hash(characterTable[currChar].saveName))

        -- Palette Selection
        local palettes = characterColorPresets[characterTableRender[currChar][characterTableRender[currChar].currAlt].model]
        if palettes then
            paletteXOffset = lerp(paletteXOffset, palettes.currPalette*17, 0.1)
            paletteTrans = math.max(paletteTrans - 6, 0)
            local bottomTapeAngle = angle_from_2d_points(-10, height - 50, width + 10, height - 35)
            for i = 0, #palettes do
                local x = width*0.85 - 8 - paletteXOffset + coss(bottomTapeAngle)*17*i
                local y = height*0.8 - 10 + math.abs(math.cos((get_global_timer() + i*15)*0.05)) - sins(bottomTapeAngle)*17*(i - paletteXOffset/17)
                local paletteShirt = nil
                local palettePants = nil
                if i == 0 then
                    paletteShirt = network_player_get_palette_color(gNetworkPlayers[0], SHIRT)
                    palettePants = network_player_get_palette_color(gNetworkPlayers[0], PANTS)
                else
                    paletteShirt = palettes[i][SHIRT]
                    palettePants = palettes[i][PANTS]
                end
                if paletteShirt and palettePants then
                    djui_hud_set_color(paletteShirt.r, paletteShirt.g, paletteShirt.b, math.min(paletteTrans, 255))
                    djui_hud_render_rect(x, y, 8, 16)
                    djui_hud_set_color(palettePants.r, palettePants.g, palettePants.b, math.min(paletteTrans, 255))
                    djui_hud_render_rect(x + 8, y, 8, 16)
                end
            end
        end
    
        -- Render Background Wall
        local playerShirt = network_player_get_override_palette_color(gNetworkPlayers[0], SHIRT)
        local playerPants = network_player_get_override_palette_color(gNetworkPlayers[0], PANTS)
        --djui_hud_set_rotation(angle_from_2d_points(width*0.7, -10, width*0.7 - 25, height - 35) + 0x4000, 1, 0)
        local wallWidth = TEX_WALL_LEFT.width
        local wallHeight = TEX_WALL_LEFT.height
        local wallScale = 0.6 * widthScale
        local wallCutoff = ((width * 0.7 - 5) - (width * 0.35 - wallWidth * wallScale * 0.5 - menuOffsetX)) / wallScale
        local x = width*0.35 - wallWidth*wallScale*0.5 - menuOffsetX
        local y = height*0.42 - wallHeight*wallScale*0.5 - menuOffsetY
        djui_hud_set_color(playerShirt.r, playerShirt.g, playerShirt.b, 255)
        djui_hud_render_texture_tile(TEX_WALL_LEFT, x, y, wallHeight/wallCutoff*wallScale, wallScale, 0, 0, wallCutoff, wallHeight)
        djui_hud_set_color(playerPants.r, playerPants.g, playerPants.b, 255)
        djui_hud_render_texture_tile(TEX_WALL_RIGHT, x, y, wallHeight/wallCutoff*wallScale, wallScale, 0, 0, wallCutoff, wallHeight)
        djui_hud_set_rotation(math.random(0, 0x2000) - 0x1000, 0.5, 0.5)
        djui_hud_set_color(255, 255, 255, 150)
        local graffiti = characterGraffiti[currChar] or TEX_GRAFFITI_DEFAULT
        local graffitiWidthScale = 120/graffiti.width 
        local graffitiHeightScale = 120/graffiti.width 
        djui_hud_render_texture(graffiti, width*0.35 - graffiti.width*0.5*graffitiWidthScale - menuOffsetX, height*0.5 - graffiti.height*0.5*graffitiHeightScale - menuOffsetY, graffitiWidthScale, graffitiHeightScale)
        djui_hud_set_rotation(0, 0, 0)

        if not options then
            if not gridMenu then
                -- Render Character List
                local currRow = (currCharRender - 1)
                gridYOffset = lerp(gridYOffset, currRow*31, 0.1)
                for i = 0, #characterTableRender do
                    local row = (i - 1)
                    local charName = characterTableRender[i][characterTableRender[i].currAlt].name
                    local charColor = characterTableRender[i][characterTableRender[i].currAlt].color
                    if i == currCharRender then
                        local blinkAnim = math.abs(math.sin(get_global_timer()*0.1))*0.5
                        djui_hud_set_color(255 + (charColor.r - 255)*blinkAnim, 255 + (charColor.g - 255)*blinkAnim, 255 + (charColor.b - 255)*blinkAnim, 255)
                    else
                        djui_hud_set_color(charColor.r, charColor.g, charColor.b, 255)
                    end
                    local x = width*0.5 - 64 + math.abs(row - gridYOffset/31)^2.5 + math.sin((get_global_timer() + i*15)*0.05) - characterTableRender[i].UIOffset - menuOffsetX*0.5
                    local y = height*0.5 - 31*0.5 + row*31 - gridYOffset + math.cos((get_global_timer() + i*15)*0.05) - menuOffsetY*0.5
                    djui_hud_render_texture(TEX_BUTTON_BIG, x, y, 1, 1)
                    local textScale = math.min(75/djui_hud_measure_text(charName), 0.7)
                    x = x + 8
                    y = y + 8 + 2/textScale
                    djui_hud_set_font(FONT_RECOLOR_HUD)
                    djui_hud_set_color(0, 0, 0, 255)
                    djui_hud_print_text(charName, x + 40 - djui_hud_measure_text(charName)*textScale*0.5 - textScale*1.5, y, textScale)
                    djui_hud_print_text(charName, x + 40 - djui_hud_measure_text(charName)*textScale*0.5, y - textScale*1.5, textScale)
                    djui_hud_print_text(charName, x + 40 - djui_hud_measure_text(charName)*textScale*0.5 + textScale*1.5, y, textScale)
                    djui_hud_print_text(charName, x + 40 - djui_hud_measure_text(charName)*textScale*0.5, y + textScale*1.5, textScale)
                    djui_hud_set_color(charColor.r*0.5 + 127, charColor.g*0.5 + 127, charColor.b*0.5 + 127, 255)
                    djui_hud_print_text(charName, x + 40 - djui_hud_measure_text(charName)*textScale*0.5, y, textScale)

                    characterTableRender[i].UIOffset = lerp(characterTableRender[i].UIOffset, currCharRender == i and 15 or 0, 0.1)
                end
            else
                -- Render Character Grid
                local currRow = math.floor((currCharRender)/gridButtonsPerRow)
                gridYOffset = lerp(gridYOffset, currRow*35, 0.1)
                for i = 0, #characterTableRender do
                    local row = math.floor(i/gridButtonsPerRow)
                    local column = i%gridButtonsPerRow
                    local charIcon = characterTableRender[i][characterTableRender[i].currAlt].lifeIcon
                    local charColor = characterTableRender[i][characterTableRender[i].currAlt].color
                    if i == currCharRender then
                        local blinkAnim = math.abs(math.sin(get_global_timer()*0.1))*0.5
                        djui_hud_set_color(255 + (charColor.r - 255)*blinkAnim, 255 + (charColor.g - 255)*blinkAnim, 255 + (charColor.b - 255)*blinkAnim, 255)
                    else
                        djui_hud_set_color(charColor.r, charColor.g, charColor.b, 255)
                    end
                    local x = width*0.3 - gridButtonsPerRow*35*0.5 + 35*column - math.abs(row - gridYOffset/35)^2*3 + math.sin((get_global_timer() + i*10)*0.1) - menuOffsetX*0.5
                    local y = height*0.5 - 35*0.5 + row*35 - gridYOffset + math.cos((get_global_timer() + i*10)*0.1) - characterTableRender[i].UIOffset*0.5 - menuOffsetY*0.5
                    djui_hud_render_texture(TEX_BUTTON_SMALL, x, y, 1, 1)
                    x = x + 8
                    y = y + 8
                    djui_hud_set_color(255, 255, 255, 255)
                    if type(charIcon) == TYPE_STRING then
                        djui_hud_set_font(FONT_RECOLOR_HUD)
                        djui_hud_set_color(charColor.r, charColor.g, charColor.b, 255)
                        djui_hud_print_text(charIcon, x, y, 1)
                    else
                        djui_hud_render_texture(charIcon, x, y, 1 / (charIcon.width * MATH_DIVIDE_16), 1 / (charIcon.height * MATH_DIVIDE_16))
                    end

                    characterTableRender[i].UIOffset = lerp(characterTableRender[i].UIOffset, currCharRender == i and 15 or 0, 0.1)
                end
            end
        else
            -- Render Options Menu
            djui_hud_set_color(0, 30, 0, 200)
            djui_hud_render_rect(0, 0, width*0.7 - 10, height)
            djui_hud_set_color(menuColorHalf.r, menuColorHalf.g, menuColorHalf.b, 255)
            djui_hud_set_rotation(math.floor(get_global_timer()/40)*0x1000 + ease_in_out_back(math.min((get_global_timer()%40)/30, 1))*0x1000, 0.5, 0.5)
            djui_hud_render_texture(TEX_GEAR_BIG, -32, height*0.6-16, 1.5, 1.5)

            local optionConsoleText = {
                "______  ___  _  __  ____   ______",
                "\\   \\ \\/ / \\| |/  \\/ __/  /) () (\\",
                " | D \\  /| \\\\ | () \\__ \\  \\______/",
                "/___//_/ |_|\\_|\\__/____/    (__)",
                "Dynamic Operating System - Version " .. MOD_VERSION_STRING,
                "(C) Toadstool Technologies 1996",
                "",
            }

            table_insert(optionConsoleText, "===| " .. optionTable[currOption].category .. " Options |===")
            table_insert(optionConsoleText, "================================")
            for i = currOption - 3, currOption + 3 do
                if optionTable[i] == nil then
                    if i == 0 then
                        table_insert(optionConsoleText, "^^^")
                    elseif i == #optionTable + 1 then
                        table_insert(optionConsoleText, "vvv")
                    else
                        table_insert(optionConsoleText, "")
                    end
                else
                    local dotString = " "
                    while 32 - #optionTable[i].name > #dotString do
                        dotString = dotString .. "."
                    end
                    dotString = dotString .. " "
                    table_insert(optionConsoleText, (i == currOption and ">" or " ") .. optionTable[i].name .. dotString .. optionTable[i].toggleNames[optionTable[i].toggle + 1])
                end
            end
            table_insert(optionConsoleText, "================================")

            local option = optionTable[currOption]
            table_insert(optionConsoleText, "")
            table_insert(optionConsoleText, "> charselect option " .. string_lower(string_space_to_underscore(option.name)) .. " " .. string_lower(string_space_to_underscore(option.toggleNames[(option.toggle + 1)%(option.toggleMax + 1) + 1])) .. (math.floor(get_global_timer()/15)%2 == 0 and "|" or ""))

            djui_hud_set_color(255, 255, 255, 255)
            djui_hud_set_font(FONT_SPECIAL)
            for i = 1, #optionConsoleText do
                djui_hud_print_monospace_text(optionConsoleText[i], 2, 40 + i*7, 0.22, i <= 4 and 11 or 16)
            end
        end


        -- Render Background Bottom
        djui_hud_set_rotation(angle_from_2d_points(-10, height - 50, width + 10, height - 35), 0, 0)
        djui_hud_set_color(0, 0, 0, 255)
        djui_hud_render_rect(-10, height - 50, width*1.5, 100)
        djui_hud_set_rotation(0, 0, 0)

        -- Render Character Description
        djui_hud_set_font(FONT_TINY)
        djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
        local credit = characterTable[currChar][characterTable[currChar].currAlt].credit
        local desc = characterTable[currChar][characterTable[currChar].currAlt].description
        local descRender = desc .. " - " .. desc
        while djui_hud_measure_text(descRender)*0.8 < width do
            descRender = descRender .. " - " .. desc
        end
        descRender = descRender .. " - " .. desc
        djui_hud_print_text("Creator: " .. credit, 5 + menuOffsetX*0.2, height - 30 + menuOffsetY*0.2, 0.8)
        djui_hud_print_text(descRender, 5 - get_global_timer()%djui_hud_measure_text(desc .. " - ")*0.8 + menuOffsetX*0.15, height - 17 + menuOffsetY*0.15, 0.8)

        -- Render Character Name
        djui_hud_set_font(FONT_BRICK)
        local charName = characterTable[currChar][characterTable[currChar].currAlt].name
        local nameScale = math.min(80/djui_hud_measure_text(charName), 0.8)
        local nameScaleCapped = math.max(nameScale, 0.3)
        djui_hud_set_color(menuColor.r*0.5, menuColor.g*0.5, menuColor.b*0.5, 255)
        djui_hud_render_rect(width*0.7 - 5, 30 - 35*nameScaleCapped, width*0.5, 70*nameScaleCapped)
        djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
        djui_hud_render_caution_tape(width*0.7 - 5, 27 - 32*nameScaleCapped + (math.random(0, 4) - 2), width + 5, 27 - 32*nameScaleCapped + (math.random(0, 4) - 2), 1, 0.4) -- Top Tape
        djui_hud_render_caution_tape(width*0.7 - 5, 27 + 32*nameScaleCapped + (math.random(0, 4) - 2), width + 5, 27 + 32*nameScaleCapped + (math.random(0, 4) - 2), 1, 0.4) -- Bottom Tape
        djui_hud_set_color(menuColorHalf.r, menuColorHalf.g, menuColorHalf.b, 255)
        djui_hud_print_text(charName, width*0.85 - djui_hud_measure_text(charName)*0.5*nameScale - 2 + menuOffsetX*0.3, 30 - 32*nameScale + menuOffsetY*0.3, nameScale)

        -- Render Header BG
        djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
        djui_hud_set_rotation(0x1000, 0.5, 0.5)
        djui_hud_set_color(0, 0, 0, 255)
        djui_hud_render_rect(-150, -50, 300, 100)

        -- Render Tape
        djui_hud_set_color(menuColor.r, menuColor.g, menuColor.b, 255)
        djui_hud_render_caution_tape(-10, 50, 160, -10, 1) -- Top Tape
        djui_hud_render_caution_tape(width*0.7 - 2, -10, width*0.7 - 10, height - 35, 1, 0.6) -- Side Tape
        djui_hud_render_caution_tape(-10, height - 50, width + 10, height - 35, 1) -- Bottom Tape

        -- Render Header
        djui_hud_set_rotation(0, 0, 0)
        djui_hud_set_color(menuColorHalf.r, menuColorHalf.g, menuColorHalf.b, 255)
        djui_hud_render_texture(TEX_LOGO, menuOffsetX*0.1, menuOffsetY*0.1, 0.25, 0.25)

        -- Anim logic
        if options then
            if optionTable[optionTableRef.anims].toggle > 0 then
                if optionAnimTimer < -1 then
                    optionAnimTimer = optionAnimTimer * 0.9
                end
            else
                optionAnimTimer = -1
            end
        else
            if optionTable[optionTableRef.anims].toggle > 0 then
                if optionAnimTimer > optionAnimTimerCap then
                    optionAnimTimer = optionAnimTimer * 1.3
                end
            else
                optionAnimTimer = optionAnimTimerCap
            end
        end
        optionAnimTimer = maxf(optionAnimTimer, -200)
    else
        options = false
        optionAnimTimer = optionAnimTimerCap
        credits = false
        creditsCrossFade = 0
        bindTextTimer = 0
    end

    -- Fade in/out of menu
    if optionTable[optionTableRef.anims].toggle == 1 then
        if menu and menuCrossFade > -menuCrossFadeCap then
            menuCrossFade = menuCrossFade - 1
            if menuCrossFade == 0 then menuCrossFade = menuCrossFade - 1 end
        end
        if not menu and menuCrossFade < menuCrossFadeCap then
            menuCrossFade = menuCrossFade + 1
            if menuCrossFade == 0 then menuCrossFade = menuCrossFade + 1 end
        end
        if menuCrossFade < 0 then
            menuAndTransition = true
        else
            menuAndTransition = false
        end
    else
        if menu then
            menuCrossFade = -menuCrossFadeCap
        else
            menuCrossFade = menuCrossFadeCap
        end
        menuAndTransition = menu
    end

    -- Info / Z Open Bind on Pause Menu
    if is_game_paused() and not djui_hud_is_pause_menu_created() and gMarioStates[0].action ~= ACT_EXIT_LAND_SAVE_DIALOG then
        local currCharY = 0
        djui_hud_set_resolution(RESOLUTION_DJUI)
        djui_hud_set_font(FONT_USER)
        if optionTable[optionTableRef.openInputs].toggle == 1 then
            currCharY = 27
            local text = menu_is_allowed() and TEXT_PAUSE_Z_OPEN or TEXT_PAUSE_UNAVAILABLE
            width = djui_hud_get_screen_width() - djui_hud_measure_text(text)
            djui_hud_set_color(255, 255, 255, 255)
            djui_hud_print_text(text, width - 20, 16, 1)
        end

        local character = characterTable[currChar][characterTable[currChar].currAlt]
        local charName = string_underscore_to_space(character.name)
        local TEXT_PAUSE_CURR_CHAR_WITH_NAME = TEXT_PAUSE_CURR_CHAR .. charName
        width = djui_hud_get_screen_width() - djui_hud_measure_text(TEXT_PAUSE_CURR_CHAR_WITH_NAME)
        local charColor = character.color
        djui_hud_set_color(255, 255, 255, 255)
        djui_hud_print_text(TEXT_PAUSE_CURR_CHAR, width - 20, 16 + currCharY, 1)
        djui_hud_set_color(charColor.r, charColor.g, charColor.b, 255)
        djui_hud_print_text(charName, djui_hud_get_screen_width() - djui_hud_measure_text(charName) - 20, 16 + currCharY, 1)

        local text = nil
        if gGlobalSyncTable.charSelectRestrictMovesets > 0 and gGlobalSyncTable.charSelectRestrictPalettes > 0 then
            text = TEXT_MOVESET_AND_PALETTE_RESTRICTED
        elseif gGlobalSyncTable.charSelectRestrictMovesets > 0 then
            text = TEXT_MOVESET_RESTRICTED
        elseif gGlobalSyncTable.charSelectRestrictPalettes > 0 then
            text = TEXT_PALETTE_RESTRICTED
        end
        if text ~= nil then
            width = djui_hud_get_screen_width() - djui_hud_measure_text(text)
            djui_hud_set_color(255, 255, 255, 255)
            currCharY = currCharY + 27
            djui_hud_print_text(text, width - 20, 16 + currCharY, 1)
        end
    end

    -- Cross Fade to Menu
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_color(0, 0, 0, (math_abs(menuCrossFade)) * -menuCrossFadeMath)
    djui_hud_render_rect(0, 0, width, height)

    -- Fix RNG
    math.randomseed(get_global_timer())
end

local FUNC_INDEX_MISC = 0
local FUNC_INDEX_HOROZONTAL = 1
local FUNC_INDEX_VERTICAL = 2
local FUNC_INDEX_CATEGORY = 3
local FUNC_INDEX_PREFERENCE = 4
local FUNC_INDEX_PALETTE = 5
local FUNC_INDEX_GRID = 6

local menuInputCooldowns = {}
function run_func_with_condition_and_cooldown(funcIndex, condition, func, cooldown)
    if menuInputCooldowns[funcIndex] == nil then
        menuInputCooldowns[funcIndex] = 0
    end
    if not condition then return end
    local cooldown = cooldown and cooldown or latencyValueTable[optionTable[optionTableRef.inputLatency].toggle + 1]
    if menuInputCooldowns[funcIndex] == 0 then
        func()
        menuInputCooldowns[funcIndex] = cooldown
    end
end

local prevMouseScroll = 0
local mouseScroll = 0
---@param m MarioState
local function before_mario_update(m)
    if m.playerIndex ~= 0 then return end
    if stallFrame < stallComplete then return end
    local controller = m.controller
    local character = characterTable[currChar]
    for index, num in pairs(menuInputCooldowns) do
        if num and num > 0 then
            menuInputCooldowns[index] = num - 1
        end
    end
    if inputStallTimerButton > 0 then inputStallTimerButton = inputStallTimerButton - 1 end
    if inputStallTimerDirectional > 0 then inputStallTimerDirectional = inputStallTimerDirectional - 1 end

    if menu and inputStallToDirectional ~= latencyValueTable[optionTable[optionTableRef.inputLatency].toggle + 1] then
        inputStallToDirectional = latencyValueTable[optionTable[optionTableRef.inputLatency].toggle + 1]
    end

    -- Menu Inputs
    if is_game_paused() and m.action ~= ACT_EXIT_LAND_SAVE_DIALOG and (controller.buttonPressed & Z_TRIG) ~= 0 and optionTable[optionTableRef.openInputs].toggle == 1 then
        menu = true
    end
    if not menu and (controller.buttonDown & D_JPAD) ~= 0 and m.action ~= ACT_EXIT_LAND_SAVE_DIALOG and optionTable[optionTableRef.openInputs].toggle == 2 then
        if (controller.buttonDown & R_TRIG) ~= 0 or not ommActive then
            menu = true
        end
        inputStallTimerDirectional = inputStallToDirectional
    end

    if not menu_is_allowed(m) then
        menu = false
        return
    end

    mouseScroll = mouseScroll - djui_hud_get_mouse_scroll_y()

    local cameraToObject = m.marioObj.header.gfx.cameraToObject
    if menuAndTransition and not options then
        run_func_with_condition_and_cooldown(FUNC_INDEX_GRID,
            (controller.buttonPressed & X_BUTTON) ~= 0,
            function ()
                gridMenu = not gridMenu
                play_sound(SOUND_MENU_CLICK_CHANGE_VIEW, cameraToObject)
            end
        )
        if menu then
            -- Category Switching
            run_func_with_condition_and_cooldown(FUNC_INDEX_CATEGORY,
                (controller.buttonPressed & L_TRIG) ~= 0,
                function ()
                    currCategory = currCategory - 1
                    update_character_render_table()
                    play_sound(SOUND_MENU_CAMERA_TURN, cameraToObject)
                end
            )

            run_func_with_condition_and_cooldown(FUNC_INDEX_CATEGORY,
                (controller.buttonPressed & R_TRIG) ~= 0,
                function ()
                    currCategory = currCategory + 1
                    update_character_render_table()
                    play_sound(SOUND_MENU_CAMERA_TURN, cameraToObject)
                end
            )
            if not gridMenu then
                -- Character Switcher
                run_func_with_condition_and_cooldown(FUNC_INDEX_VERTICAL,
                    (controller.buttonPressed & D_JPAD) ~= 0 or controller.stickY < -45 --[[or prevMouseScroll < mouseScroll]],
                    function ()
                        currCharRender = currCharRender + 1
                        play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
                        prevMouseScroll = mouseScroll
                    end
                )

                run_func_with_condition_and_cooldown(FUNC_INDEX_VERTICAL,
                    (controller.buttonPressed & U_JPAD) ~= 0 or controller.stickY > 45 --[[or prevMouseScroll > mouseScroll]],
                    function ()
                        currCharRender = currCharRender - 1
                        play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
                        prevMouseScroll = mouseScroll
                    end
                )

                -- Alt switcher
                if #characterTable[currChar] > 1 then
                    run_func_with_condition_and_cooldown(FUNC_INDEX_HOROZONTAL,
                        (controller.buttonPressed & R_JPAD) ~= 0 or controller.stickX > 60,
                        function ()
                            character.currAlt = character.currAlt + 1
                            play_sound(SOUND_MENU_CLICK_CHANGE_VIEW, cameraToObject)
                        end
                    )

                    run_func_with_condition_and_cooldown(FUNC_INDEX_HOROZONTAL,
                        (controller.buttonPressed & L_JPAD) ~= 0 or controller.stickX < -60,
                        function ()
                            character.currAlt = character.currAlt - 1
                            play_sound(SOUND_MENU_CLICK_CHANGE_VIEW, cameraToObject)
                        end
                    )
                end
            else
                -- Grid Controls
                run_func_with_condition_and_cooldown(FUNC_INDEX_VERTICAL,
                    (controller.buttonPressed & D_JPAD) ~= 0 or controller.stickY < -45 --[[or prevMouseScroll < mouseScroll]],
                    function ()
                        currCharRender = currCharRender + 5
                        play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
                    end
                )

                run_func_with_condition_and_cooldown(FUNC_INDEX_VERTICAL,
                    (controller.buttonPressed & U_JPAD) ~= 0 or controller.stickY > 45 --[[or prevMouseScroll > mouseScroll]],
                    function ()
                        currCharRender = currCharRender - 5
                        play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
                    end
                )

                run_func_with_condition_and_cooldown(FUNC_INDEX_HOROZONTAL,
                    (controller.buttonPressed & R_JPAD) ~= 0 or controller.stickX > 60,
                    function ()
                        currCharRender = currCharRender + 1
                        play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
                    end
                )

                run_func_with_condition_and_cooldown(FUNC_INDEX_HOROZONTAL,
                    (controller.buttonPressed & L_JPAD) ~= 0 or controller.stickX < -60,
                    function ()
                        currCharRender = currCharRender - 1
                        play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
                    end
                )
            end

            run_func_with_condition_and_cooldown(FUNC_INDEX_PREFERENCE,
                (controller.buttonPressed & A_BUTTON) ~= 0,
                function ()
                    if characterTable[currChar] ~= nil then
                        mod_storage_save_pref_char(characterTable[currChar])
                        play_sound(SOUND_MENU_CLICK_FILE_SELECT, cameraToObject)
                    else
                        play_sound(SOUND_MENU_CAMERA_BUZZ, cameraToObject)
                    end
                end
            )

            run_func_with_condition_and_cooldown(FUNC_INDEX_PALETTE,
                (controller.buttonPressed & Y_BUTTON) ~= 0,
                function ()
                    local currPaletteTable = characterColorPresets[gCSPlayers[0].modelId] and characterColorPresets[gCSPlayers[0].modelId] or {currPalette = 0}
                    if currPaletteTable and gGlobalSyncTable.charSelectRestrictPalettes == 0 then
                        play_sound(SOUND_MENU_CLICK_FILE_SELECT, cameraToObject)
                        currPaletteTable.currPalette = currPaletteTable.currPalette + 1
                    else
                        play_sound(SOUND_MENU_CAMERA_BUZZ, cameraToObject)
                    end
                    paletteTrans = 1000
                    currPaletteTable.currPalette = num_wrap(currPaletteTable.currPalette, 0, #currPaletteTable)
                end
            )

            run_func_with_condition_and_cooldown(FUNC_INDEX_MISC,
                (controller.buttonPressed & B_BUTTON) ~= 0,
                function ()
                    menu = false
                end
            )

            run_func_with_condition_and_cooldown(FUNC_INDEX_MISC,
                (controller.buttonPressed & START_BUTTON) ~= 0,
                function ()
                    options = true
                end
            )
        end

        -- Handles Camera Posistioning
        camAngle = m.faceAngle.y + 0x800
        eyeState = MARIO_EYES_OPEN

        nullify_inputs(m)
        if is_game_paused() then
            controller.buttonPressed = START_BUTTON
        end
    end

    if options and not creditsAndTransition then
        run_func_with_condition_and_cooldown(FUNC_INDEX_VERTICAL,
            (controller.buttonPressed & D_JPAD) ~= 0 or controller.stickY < -60,
            function ()
                currOption = currOption + 1
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
            end
        )

        run_func_with_condition_and_cooldown(FUNC_INDEX_VERTICAL,
            (controller.buttonPressed & U_JPAD) ~= 0 or controller.stickY > 60,
            function ()
                currOption = currOption - 1
                play_sound(SOUND_MENU_MESSAGE_NEXT_PAGE, cameraToObject)
            end
        )

        run_func_with_condition_and_cooldown(FUNC_INDEX_MISC,
            (controller.buttonPressed & A_BUTTON) ~= 0 and not optionTable[currOption].optionBeingSet and (optionTable[currOption].lock == nil or optionTable[currOption].lock() == nil),
            function ()
                optionTable[currOption].toggle = optionTable[currOption].toggle + 1
                if optionTable[currOption].toggle > optionTable[currOption].toggleMax then optionTable[currOption].toggle = 0 end
                if optionTable[currOption].toggleSaveName ~= nil then
                    mod_storage_save(optionTable[currOption].toggleSaveName, tostring(optionTable[currOption].toggle))
                end
                play_sound(SOUND_MENU_CHANGE_SELECT, cameraToObject)
            end
        )

        run_func_with_condition_and_cooldown(FUNC_INDEX_MISC,
            (controller.buttonPressed & B_BUTTON) ~= 0,
            function ()
                options = false
            end
        )
        if currOption > #optionTable then currOption = 1 end
        if currOption < 1 then currOption = #optionTable end
        nullify_inputs(m)
    end

    if creditsAndTransition then
        if (controller.buttonDown & U_JPAD) ~= 0 then
            creditScroll = creditScroll - 1.5
        elseif (controller.buttonDown & D_JPAD) ~= 0 then
            creditScroll = creditScroll + 1.5
        elseif math.abs(controller.stickY) > 30 then
            creditScroll = creditScroll + controller.stickY*-0.03
        end

        if inputStallTimerButton == 0 then
            if (controller.buttonPressed & A_BUTTON) ~= 0 or (controller.buttonPressed & B_BUTTON) ~= 0 or (controller.buttonPressed & START_BUTTON) ~= 0 then
                credits = false
            end
        end
        nullify_inputs(m)
        if creditScroll < 0 then creditScroll = 0 end
        if creditScroll > creditScrollRange then creditScroll = creditScrollRange end
    else
        creditScroll = 0
    end

    -- Checks
    currCharRender = num_wrap(currCharRender, 0, #characterTableRender)
    currChar = characterTableRender[currCharRender].ogNum
    
    character.currAlt = num_wrap(character.currAlt, 1, #character)
    currCategory = num_wrap(currCategory, 1, #characterCategories)
    update_character_render_table()

    -- Yo Melee called
    local menuOffsetXRaw = (m.controller.extStickX ~= 0 and m.controller.extStickX or button_to_analog(charSelect.controller, L_CBUTTONS, R_CBUTTONS))*0.2
    local menuOffsetYRaw = (m.controller.extStickY ~= 0 and -m.controller.extStickY or button_to_analog(charSelect.controller, U_CBUTTONS, D_CBUTTONS))*0.2
    menuOffsetX = lerp(menuOffsetX, menuOffsetXRaw, 0.2)
    menuOffsetY = lerp(menuOffsetY, menuOffsetYRaw, 0.2)
end

hook_event(HOOK_BEFORE_MARIO_UPDATE, before_mario_update)
hook_event(HOOK_ON_HUD_RENDER, on_hud_render)

--------------
-- Commands --
--------------

promptedAreYouSure = false

local function chat_command(msg)
    msg = string_lower(msg)

    -- Open Menu Check
    if (msg == "" or msg == "menu") then
        if menu_is_allowed(gMarioStates[0]) then
            menu = not menu
            return true
        else
            djui_chat_message_create(TEXT_PAUSE_UNAVAILABLE)
            return true
        end
    end

    -- Help Prompt Check
    if msg == "?" or msg == "help" then
        djui_chat_message_create("Character Select's Avalible Commands:" ..
        "\n\\#ffff33\\/char-select help\\#ffffff\\ - Returns Avalible Commands" ..
        "\n\\#ffff33\\/char-select menu\\#ffffff\\ - Opens the Menu" ..
        "\n\\#ffff33\\/char-select [name/num]\\#ffffff\\ - Switches to Character" ..
        "\n\\#ff3333\\/char-select reset\\#ffffff\\ - Resets your Save Data")
        return true
    end

    -- Reset Save Data Check
    if msg == "reset" or (msg == "confirm" and promptedAreYouSure) then
        reset_options(true)
        return true
    end

    -- Stop Character checks if API disallows it 
    if not menu_is_allowed() or charBeingSet then
        djui_chat_message_create("Character Cannot be Changed")
        return true
    end

    -- Name Check
    for i = 0, #characterTable do
        if not characterTable[i].locked then
            local saveName = string_underscore_to_space(string_lower(characterTable[i].saveName))
            for a = 1, #characterTable[i] do
                if msg == string_lower(characterTable[i][a].name) or msg == saveName then
                    force_set_character(i, msg ~= saveName and a or 1)
                    djui_chat_message_create('Character set to "' .. characterTable[i][characterTable[i].currAlt].name .. '" Successfully!')
                    return true
                end
            end
        end
    end

    -- Number Check
    msgSplit = string_split(msg)
    if tonumber(msgSplit[1]) then
        local charNum = tonumber(msgSplit[1])
        local altNum = tonumber(msgSplit[2])
        altNum = altNum and altNum or 1
        if charNum > 0 and charNum <= #characterTable and not characterTable[charNum].locked then
            force_set_character(currChar, altNum)
            djui_chat_message_create('Character set to "' .. characterTable[charNum][altNum].name .. '" Successfully!')
            return true
        end
    end
    djui_chat_message_create("Character Not Found")
    return true
end

hook_chat_command("char-select", "- Opens the Character Select Menu", chat_command)

--[[
local function mod_menu_open_cs()
    local m = gMarioStates[0]
    if menu_is_allowed(m) then
        gMarioStates[0].controller.buttonPressed = START_BUTTON
        menu = true
    else
        play_sound(SOUND_MENU_CAMERA_BUZZ, m.pos)
    end
end
hook_mod_menu_button("Open Menu", mod_menu_open_cs)
]]
