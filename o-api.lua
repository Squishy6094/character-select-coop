--- @class CharacterTable
--- @field public name string
--- @field public saveName string
--- @field public description table
--- @field public credit string
--- @field public color Color
--- @field public model ModelExtendedId|integer
--- @field public forceChar CharacterType
--- @field public lifeIcon TextureInfo
--- @field public camScale integer

-- localize functions to improve performance
local smlua_model_util_get_id,table_insert,type,djui_hud_measure_text = smlua_model_util_get_id,table.insert,type,djui_hud_measure_text

local characterVoices = {}
local saveNameTable = {}

local E_MODEL_ARMATURE = smlua_model_util_get_id("armature_geo")

---------
-- API --
---------

local function split_text_into_lines(text)
    local words = {}
    for word in text:gmatch("%S+") do
        table.insert(words, word)
    end

    local lines = {}
    local currentLine = ""
    for i, word in ipairs(words) do
        local measuredWidth = djui_hud_measure_text(currentLine .. " " .. word)*0.3
        if measuredWidth <= 100 then
            currentLine = currentLine .. " " .. word
        else
            table.insert(lines, currentLine)
            currentLine = word
        end
    end
    table.insert(lines, currentLine) -- add the last line

    return lines
end

local TYPE_INTEGER = "number"
local TYPE_STRING = "string"
local TYPE_TABLE = "table"
local TYPE_FUNCTION = "function"

---@param name string|nil Underscores turn into Spaces
---@param description table|string|nil {"string"}
---@param credit string|nil
---@param color Color|string|nil {r, g, b}
---@param modelInfo ModelExtendedId|integer|nil Use smlua_model_util_get_id()
---@param forceChar CharacterType|nil CT_MARIO, CT_LUIGI, CT_TOAD, CT_WALUIGI, CT_WARIO
---@param lifeIcon TextureInfo|nil Use get_texture_info()
---@param camScale integer|nil Zooms the camera based on a multiplier (Default 1.0)
---@return integer
local function character_add(name, description, credit, color, modelInfo, forceChar, lifeIcon, camScale)
    if type(description) == TYPE_STRING then
        description = split_text_into_lines(description)
    end
    if type(color) == TYPE_STRING then
        color = {r = tonumber(color:sub(1,2), 16), g = tonumber(color:sub(3,4), 16), b = tonumber(color:sub(5,6), 16) }
    end
    table_insert(characterTable, {
        name = type(name) == TYPE_STRING and name or "Untitled",
        saveName = type(name) == TYPE_STRING and string_space_to_underscore(name) or "Untitled",
        description = type(description) == TYPE_TABLE and description or {"No description has been provided"},
        credit = type(credit) == TYPE_STRING and credit or "Unknown",
        color = type(color) == TYPE_TABLE and color or {r = 255, g = 255, b = 255},
        model = (modelInfo and modelInfo ~= E_MODEL_ERROR_MODEL) and modelInfo or E_MODEL_ARMATURE,
        forceChar = type(forceChar) == TYPE_INTEGER and forceChar or CT_MARIO,
        lifeIcon = type(lifeIcon) == TYPE_TABLE and lifeIcon or nil,
        starIcon = gTextures.star,
        camScale = type(camScale) == TYPE_INTEGER and camScale or 1,
        healthTexture = nil,
    })
    saveNameTable[#characterTable] = characterTable[#characterTable].saveName
    return #characterTable
end

---@param charNum integer Use _G.charSelect.character_get_number_from_string() or _G.charSelect.character_add()'s return value
---@param name string|nil Underscores turn into Spaces
---@param description table|string|nil {"string"}
---@param credit string|nil
---@param color Color|nil {r, g, b}
---@param modelInfo ModelExtendedId|integer|nil Use smlua_model_util_get_id()
---@param forceChar CharacterType|nil CT_MARIO, CT_LUIGI, CT_TOAD, CT_WALUIGI, CT_WARIO
---@param lifeIcon TextureInfo|nil Use get_texture_info()
---@param camScale integer|nil Zooms the camera based on a multiplier (Default 1.0)
local function character_edit(charNum, name, description, credit, color, modelInfo, forceChar, lifeIcon, camScale)
    if tonumber(charNum) == nil or charNum > #characterTable or charNum < 0 then return end
    if type(description) == TYPE_STRING then
        description = split_text_into_lines(description)
    end
    if type(color) == TYPE_STRING then
        color = {r = tonumber(color:sub(1,2), 16), g = tonumber(color:sub(3,4), 16), b = tonumber(color:sub(5,6), 16) }
    end
    local tableCache = characterTable[charNum]
    characterTable[charNum] = characterTable[charNum] and {
        name = type(name) == TYPE_STRING and name or tableCache.name,
        saveName = saveNameTable[charNum],
        description = type(description) == TYPE_TABLE and description or tableCache.description,
        credit = type(credit) == TYPE_STRING and credit or tableCache.credit,
        color = type(color) == TYPE_TABLE and color or tableCache.color,
        model = (modelInfo and modelInfo ~= E_MODEL_ERROR_MODEL) and modelInfo or tableCache.model,
        forceChar = type(forceChar) == TYPE_INTEGER and forceChar or tableCache.forceChar,
        lifeIcon = type(lifeIcon) == TYPE_TABLE and lifeIcon or tableCache.lifeIcon,
        starIcon = tableCache.starIcon, -- Done to prevent it getting lost in the sauce
        camScale = type(camScale) == TYPE_INTEGER and camScale or tableCache.camScale,
        healthTexture = tableCache.healthTexture,
    } or nil
end

---@param modelInfo ModelExtendedId|integer
---@param clips table
local function character_add_voice(modelInfo, clips)
    characterVoices[modelInfo] = type(clips) == TYPE_TABLE and clips or nil
end

---@param modelInfo ModelExtendedId|integer
---@param caps table
local function character_add_caps(modelInfo, caps)
    characterCaps[modelInfo] = type(caps) == TYPE_TABLE and caps or nil
end

---@param charNum ModelExtendedId|integer
---@param healthTexture table|nil
local function character_add_health_meter(charNum, healthTexture)
    characterTable[charNum].healthTexture = type(healthTexture) == TYPE_TABLE and healthTexture or nil
    return false
end

---@param modelInfo ModelExtendedId|integer
---@param starModel ModelExtendedId|integer 
---@param starIcon TextureInfo|nil Use get_texture_info()
local function character_add_celebration_star(modelInfo, starModel, starIcon)
    characterCelebrationStar[modelInfo] = starModel
    for i = 2, #characterTable do
        if characterTable[i].model == modelInfo then
            characterTable[i].starIcon = type(starIcon) == TYPE_TABLE and starIcon or gTextures.star
            return
        end
    end
    return false
end

---@param modelInfo ModelExtendedId|integer
---@param paletteTable table 
local function character_add_palette_preset(modelInfo, paletteTable)
    local paletteTableOut = {}
    local defaultColors = characterColorPresets[E_MODEL_MARIO]
    for i = 0, 6 do
        local color = paletteTable[i]
        paletteTableOut[i] = {r = 0, g = 0, b = 0}
        if type(color) == TYPE_STRING then
            paletteTableOut[i].r = tonumber(color:sub(1,2), 16) and tonumber(color:sub(1,2), 16) or defaultColors[i].r
            paletteTableOut[i].g = tonumber(color:sub(3,4), 16) and tonumber(color:sub(3,4), 16) or defaultColors[i].g
            paletteTableOut[i].b = tonumber(color:sub(5,6), 16) and tonumber(color:sub(5,6), 16) or defaultColors[i].b
        end
        if type(color) == TYPE_TABLE then
            paletteTableOut[i].r = (type(color) == TYPE_TABLE and color.r ~= nil) and color.r or defaultColors[i].r
            paletteTableOut[i].g = (type(color) == TYPE_TABLE and color.g ~= nil) and color.g or defaultColors[i].g
            paletteTableOut[i].b = (type(color) == TYPE_TABLE and color.b ~= nil) and color.b or defaultColors[i].b
        end
    end
    characterColorPresets[modelInfo] = paletteTableOut
end

---@param tablePos integer|nil
---@return CharacterTable
local function character_get_current_table(tablePos)
    tablePos = tablePos and tablePos or currChar
    return characterTable[tablePos]
end

local function character_get_current_number()
    return currChar
end

---@param charNum integer|nil
local function character_set_current_number(charNum)
    if type(charNum) ~= TYPE_INTEGER or charNum == nil then return end
    currChar = charNum
end

---@param name string
local function character_get_number_from_string(name)
    if type(name) ~= TYPE_STRING then return nil end
    for i = 2, #characterTable do
        if characterTable[i].name == name or characterTable[i].name == string_space_to_underscore(name) then
            return i
        end
    end
    return nil
end

---@param m MarioState
local function character_get_voice(m)
    return characterVoices[gPlayerSyncTable[m.playerIndex].modelId]
end

---@return string
local function version_get()
    return MOD_VERSION
end

---@return boolean
local function is_menu_open()
    return menuAndTransition
end

---@param bool boolean|nil Sets if the menu is open
local function set_menu_open(bool)
    if bool == nil then bool = true end
    menu = bool
end

---@return table
local function get_menu_color()
    return update_menu_color()
end

---@param func function
local function hook_allow_menu_open(func)
    if type(func) ~= TYPE_FUNCTION then return end
    table_insert(allowMenu, func)
end

---@param func function
local function hook_render_in_menu(func)
    if type(func) ~= TYPE_FUNCTION then return end
    table_insert(renderInMenuTable, func)
end

---@return boolean
local function is_options_open()
    return options
end

---@param bool boolean
local function restrict_palettes(bool)
    if bool == nil then bool = true end
    stopPalettes = bool
end

local controller = {
    buttonDown = 0,
    buttonPressed = 0,
    extStickX = 0,
    extStickY = 0,
    rawStickX = 0,
    rawStickY = 0,
    stickMag = 0,
    stickX = 0,
    stickY = 0
}

---@param tableNum integer
local function get_options_status(tableNum)
    if type(tableNum) ~= TYPE_INTEGER then return nil end
    return optionTable[tableNum].toggle
end

_G.charSelectExists = true
_G.charSelect = {
    -- Character Functions --
    character_add = character_add,
    character_edit = character_edit,
    character_add_voice = character_add_voice,
    character_add_caps = character_add_caps,
    character_add_celebration_star = character_add_celebration_star,
    character_add_health_meter = character_add_health_meter,
    character_add_palette_preset = character_add_palette_preset,
    character_get_current_table = character_get_current_table,
    character_get_current_number = character_get_current_number,
    character_set_current_number = character_set_current_number,
    character_get_number_from_string = character_get_number_from_string,
    character_get_voice = character_get_voice,
    character_get_life_icon = life_icon_from_local_index, -- Function located in n-hud.lua
    character_get_star_icon = star_icon_from_local_index, -- Function located in n-hud.lua

    -- Menu Functions --
    header_set_texture = header_set_texture, -- Function located in main.lua
    version_get = version_get,
    is_menu_open = is_menu_open,
    set_menu_open = set_menu_open,
    is_options_open = is_options_open,
    get_menu_color = get_menu_color,
    get_options_status = get_options_status,
    restrict_palettes = restrict_palettes,

    -- Tables --
    optionTableRef = optionTableRef,
    controller = controller,

    -- Custom Hooks --
    hook_allow_menu_open = hook_allow_menu_open,
    hook_render_in_menu = hook_render_in_menu,
}