if incompatibleClient then return 0 end

-- localize functions to improve performance - o-api.lua
local table_insert,djui_hud_measure_text,smlua_model_util_get_id,type,tonumber = table.insert,djui_hud_measure_text,smlua_model_util_get_id,type,tonumber

---@class CharacterTable
---@field public name string
---@field public saveName string
---@field public description table
---@field public credit string
---@field public color Color
---@field public model ModelExtendedId|integer
---@field public baseChar CharacterType
---@field public lifeIcon TextureInfo
---@field public camScale integer

local TYPE_INTEGER = "number"
local TYPE_STRING = "string"
local TYPE_TABLE = "table"
local TYPE_TEX_INFO = "userdata"
local TYPE_FUNCTION = "function"

-------------------------
-- Character Functions --
-------------------------

---@header
---@forcedoc Character_Functions

---@description A function that adds a Character to the Character Table
---@added 1
---@param name string? `"Custom Model"`
---@param description string|table? `{"string"}`
---@param credit string? `"You!"`, Credit the creators
---@param color Color|string? `{r, g, b}`
---@param modelInfo ModelExtendedId|integer? Use `smlua_model_util_get_id`
---@param baseChar CharacterType? Character Type, such as `CT_MARIO`
---@param lifeIcon TextureInfo|string? Use get_texture_info
---@param camScale integer? Zooms the camera based on a multiplier (Default `1`)
---@return integer --The index of the character in the character table
local function character_add(name, description, credit, color, modelInfo, baseChar, lifeIcon, camScale)
    if type(description) == TYPE_TABLE then
        local table = description
        description = ""
        for i = 1, #table do
            description = description .. table[i] .. (i ~= #table and " " or "")
        end
    end
    if color ~= nil and type(color) == TYPE_STRING then
        color = {r = tonumber(color:sub(1,2), 16), g = tonumber(color:sub(3,4), 16), b = tonumber(color:sub(5,6), 16) }
    end
    if lifeIcon and type(lifeIcon) == TYPE_STRING then
        lifeIcon = lifeIcon:sub(1,1)
    end

    local addedModel = (modelInfo and modelInfo ~= E_MODEL_ERROR_MODEL) and modelInfo or E_MODEL_ARMATURE
    local charNum = #characterTable + 1

    if name and type(name) == TYPE_STRING and not _G["CT_"..name:upper():gsub(" ", "_")] then
        local charNum = charNum ---@type CharacterType
        define_valid_global("CT_"..name:upper():gsub(" ", "_"), charNum)
    end

    table_insert(characterTable, {
        saveName = type(name) == TYPE_STRING and string_space_to_underscore(name) or "Untitled",
        nickname = type(name) == TYPE_STRING and string_space_to_underscore(name) or "Untitled",
        currAlt = 1,
        hasMoveset = false,
        locked = LOCKED_NEVER,
        category = "All",
        ogNum = charNum,
        [1] = {
            name = type(name) == TYPE_STRING and name or "Untitled",
            description = type(description) == TYPE_STRING and description or "No description has been provided",
            credit = type(credit) == TYPE_STRING and credit or "Unknown",
            color = type(color) == TYPE_TABLE and color or {r = 255, g = 255, b = 255},
            model = addedModel,
            ogModel = addedModel,
            baseChar = baseChar and baseChar or CT_MARIO,
            lifeIcon = (type(lifeIcon) == TYPE_TABLE or type(lifeIcon) == TYPE_TEX_INFO or type(lifeIcon) == TYPE_STRING) and lifeIcon or "?",
            starIcon = gTextures.star,
            camScale = type(camScale) == TYPE_INTEGER and camScale or 1,
            healthTexture = nil,
        },
    })
    characterMovesets[charNum] = {}
    characterDialog[charNum] = {}
    return charNum
end

---@description A function that adds a Costume to an Existing Character, all inputs mimic character_edit
---@added 1.11
---@param charNum integer The number/table position of the Character you want to add a costume to
---@param name string? `"Custom Model"`
---@param description table|string? `{"string"}`
---@param credit string? `"You!"`, Credit the creators
---@param color Color|string? `{r, g, b}`
---@param modelInfo ModelExtendedId|integer? Use `smlua_model_util_get_id`
---@param baseChar CharacterType? Character Type, such as `CT_MARIO`
---@param lifeIcon TextureInfo|string? Use get_texture_info
---@param camScale integer? Zooms the camera based on a multiplier (Default `1`)
---@return integer? --The index of the costume in the character's table
local function character_add_costume(charNum, name, description, credit, color, modelInfo, baseChar, lifeIcon, camScale)
    if not tonumber(charNum) or charNum > #characterTable or charNum < 0 then return end
    if description ~= nil and type(description) == TYPE_TABLE then
        local table = description
        description = ""
        for i = 1, #table do
            description = description .. table[i] .. (i ~= #table and " " or "")
        end
    end
    if color ~= nil and type(color) == TYPE_STRING then
        color = {r = tonumber(color:sub(1,2), 16), g = tonumber(color:sub(3,4), 16), b = tonumber(color:sub(5,6), 16) }
    end
    if lifeIcon and type(lifeIcon) == TYPE_STRING then
        lifeIcon = lifeIcon:sub(1,1)
    end
    local tableCache = characterTable[charNum][1]
    local addedModel = (modelInfo and modelInfo ~= E_MODEL_ERROR_MODEL) and modelInfo or tableCache.model
    table_insert(characterTable[charNum], {
        name = type(name) == TYPE_STRING and name or tableCache.name,
        description = type(description) == TYPE_STRING and description or tableCache.description,
        credit = type(credit) == TYPE_STRING and credit or tableCache.credit,
        color = type(color) == TYPE_TABLE and color or tableCache.color,
        model = addedModel,
        ogModel = addedModel,
        baseChar = type(baseChar) == TYPE_INTEGER and baseChar or tableCache.baseChar,
        lifeIcon = (type(lifeIcon) == TYPE_TABLE or type(lifeIcon) == TYPE_TEX_INFO or type(lifeIcon) == TYPE_STRING) and lifeIcon or tableCache.lifeIcon,
        starIcon = tableCache.starIcon, -- Done to prevent it getting lost in the sauce
        camScale = type(camScale) == TYPE_INTEGER and camScale or tableCache.camScale,
        healthTexture = tableCache.healthTexture,
    })
    return #characterTable[charNum]
end

---@description A function that Edits an existing Costume
---@added 1.11
---@param charNum integer The number/table position of the Character you want to edit the costume of
---@param charAlt integer The number/table position of the Costume you want to edit, this can be found by making a variable equal
---@param name string? `"Custom Model"`
---@param description table|string? `{"string"}`
---@param credit string? `"You!"`, Credit the creators
---@param color Color|string? `{r, g, b}`
---@param modelInfo ModelExtendedId|integer? Use `smlua_model_util_get_id`
---@param baseChar CharacterType? Character Type, such as `CT_MARIO`
---@param lifeIcon TextureInfo|string? Use get_texture_info
---@param camScale integer? Zooms the camera based on a multiplier (Default `1`)
local function character_edit_costume(charNum, charAlt, name, description, credit, color, modelInfo, baseChar, lifeIcon, camScale)
    if tonumber(charNum) == nil or charNum > #characterTable or charNum < 0 then return end
    if type(description) == TYPE_TABLE then
        local table = description
        description = ""
        for i = 1, #table do
            description = description .. table[i] .. (i ~= #table and " " or "")
        end
    end
    if color ~= nil and type(color) == TYPE_STRING then
        color = {r = tonumber(color:sub(1,2), 16), g = tonumber(color:sub(3,4), 16), b = tonumber(color:sub(5,6), 16) }
    end
    if lifeIcon and type(lifeIcon) == TYPE_STRING then
        lifeIcon = lifeIcon:sub(1,1)
    end
    local tableCache = characterTable[charNum][charAlt]
    characterTable[charNum][charAlt] = characterTable[charNum][charAlt] and {
        name = type(name) == TYPE_STRING and name or tableCache.name,
        description = type(description) == TYPE_STRING and description or tableCache.description,
        credit = type(credit) == TYPE_STRING and credit or tableCache.credit,
        color = type(color) == TYPE_TABLE and color or tableCache.color,
        model = (modelInfo and modelInfo ~= E_MODEL_ERROR_MODEL) and modelInfo or tableCache.model,
        ogModel = tableCache.ogModel,
        baseChar = type(baseChar) == TYPE_INTEGER and baseChar or tableCache.baseChar,
        lifeIcon = (type(lifeIcon) == TYPE_TABLE or type(lifeIcon) == TYPE_TEX_INFO or type(lifeIcon) == TYPE_STRING) and lifeIcon or tableCache.lifeIcon,
        starIcon = tableCache.starIcon, -- Done to prevent it getting lost in the sauce
        camScale = type(camScale) == TYPE_INTEGER and camScale or tableCache.camScale,
        healthTexture = tableCache.healthTexture,
    } or nil

    if modelInfo and characterColorPresets[modelInfo] and tableCache.model and characterColorPresets[tableCache.model] and #characterColorPresets[modelInfo] == #characterColorPresets[tableCache.model] then
        characterColorPresets[modelInfo].currPalette = characterColorPresets[tableCache.model].currPalette
    end
end

---@description A function that Edits an Existing Character
---@added 1
---@param charNum integer The number/table position of the Character you want to edit
---@param name string? `"Custom Model"`
---@param description table|string? `{"string"}`
---@param credit string? `"You!"`, Credit the creators
---@param color Color|string? `{r, g, b}`
---@param modelInfo ModelExtendedId|integer? Use `smlua_model_util_get_id`
---@param baseChar CharacterType? Character Type, such as `CT_MARIO`
---@param lifeIcon TextureInfo|string? Use get_texture_info
---@param camScale integer? Zooms the camera based on a multiplier (Default `1`)
local function character_edit(charNum, name, description, credit, color, modelInfo, baseChar, lifeIcon, camScale)
    character_edit_costume(charNum, characterTable[charNum] and characterTable[charNum].currAlt or 1, name, description, credit, color, modelInfo, baseChar, lifeIcon, camScale)
end

---@description A function to set a Character's Nickname, used for Dialog Replacement
---@added 1.16
---@param charNum integer The number/table position of the Character you want to nickname
---@param nickname string The Character's new nickname
local function character_set_nickname(charNum, nickname)
    if characterTable[charNum] == nil or type(nickname) == TYPE_STRING then
        characterTable[charNum].nickname = nickname
    end
end


---@description A function to get a Character's Nickname, used for Dialog Replacement
---@added 1.16
---@param charNum integer The number/table position of the Character you want to get the nickname of
local function character_get_nickname(charNum)
    return characterTable[charNum] ~= nil and characterTable[charNum].nickname
end

---@description A function that adds a voice table to a character
---@added 1.5
---@param modelInfo ModelExtendedId|integer Model Information Received from smlua_model_util_get_id
---@param clips table A Table with your Character's Sound File Names
---@note In order for sound files to function, please run config_character_sounds in your pack
---@note 
---@note Table Example:
---@note ```lua
---@note local VOICETABLE_CHAR = {
---@note     [CHAR_SOUND_ATTACKED] = 'NES-Hit.ogg',
---@note     [CHAR_SOUND_DOH] = 'NES-Bump.ogg',
---@note     [CHAR_SOUND_DROWNING] = 'NES-Die.ogg',
---@note     [CHAR_SOUND_DYING] = 'NES-Die.ogg',
---@note     [CHAR_SOUND_GROUND_POUND_WAH] = 'NES-Squish.ogg',
---@note     [CHAR_SOUND_HAHA] = 'NES-1up.ogg',
---@note     [CHAR_SOUND_HAHA_2] = 'NES-1up.ogg',
---@note     [CHAR_SOUND_HERE_WE_GO] = 'NES-Flagpole.ogg',
---@note     [CHAR_SOUND_HOOHOO] = 'NES-Jump.ogg',
---@note     [CHAR_SOUND_MAMA_MIA] = 'NES-Warp.ogg',
---@note     [CHAR_SOUND_OKEY_DOKEY] = 'NES-1up.ogg',
---@note     [CHAR_SOUND_ON_FIRE] = 'NES-Enemy_Fire.ogg',
---@note     [CHAR_SOUND_OOOF] = 'NES-Hit.ogg',
---@note     [CHAR_SOUND_OOOF2] = 'NES-Hit.ogg',
---@note     [CHAR_SOUND_PUNCH_HOO] = 'NES-Kick.ogg',
---@note     [CHAR_SOUND_PUNCH_WAH] = 'NES-Thwomp.ogg',
---@note     [CHAR_SOUND_PUNCH_YAH] = 'NES-Thwomp.ogg',
---@note     [CHAR_SOUND_SO_LONGA_BOWSER] = 'NES-Bowser_Die.ogg',
---@note     [CHAR_SOUND_TWIRL_BOUNCE] = 'NES-Item.ogg',
---@note     [CHAR_SOUND_WAAAOOOW] = 'NES-Vine.ogg',
---@note     [CHAR_SOUND_WAH2] = 'NES-Kick.ogg',
---@note     [CHAR_SOUND_WHOA] = 'NES-Item.ogg',
---@note     [CHAR_SOUND_YAHOO] = 'NES-Jump.ogg',
---@note     [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = 'NES-Jump.ogg',
---@note     [CHAR_SOUND_YAH_WAH_HOO] = 'NES-Big_Jump.ogg',
---@note     [CHAR_SOUND_YAWNING] = 'NES-Pause.ogg',
---@note }
---@note ```
local function character_add_voice(modelInfo, clips)
    characterVoices[modelInfo] = type(clips) == TYPE_TABLE and clips or nil
end

---@description A function that adds a caps table to a character
---@added 1.6
---@param modelInfo ModelExtendedId|integer Model Information Received from smlua_model_util_get_id
---@param caps table Cap 
---@note ```lua
---@note local CAPTABLE_CHAR = {
---@note     normal = smlua_model_util_get_id("custom_model_cap_normal_geo"),
---@note     wing = smlua_model_util_get_id("custom_model_cap_wing_geo"),
---@note     metal = smlua_model_util_get_id("custom_model_cap_metal_geo"),
---@note     metalWing = smlua_model_util_get_id("custom_model_cap_wing_geo")
---@note }
---@note ```
local function character_add_caps(modelInfo, caps)
    characterCaps[modelInfo] = type(caps) == TYPE_TABLE and caps or nil
end

---@description A function that gets a model's cap table
---@added 1.13
---@param modelInfo ModelExtendedId|integer? Model Information Received from smlua_model_util_get_id
local function character_get_caps(modelInfo)
    if modelInfo == nil then modelInfo = characterTable[currChar][characterTable[currChar].currAlt].model end
    return characterCaps[modelInfo]
end

---@description A function that adds health meter textures to a costume
---@added 1.12
---@param charNum integer The number/table position of the Character you want to add a meter to
---@param charAlt integer The number/table position of the Costume you want to add a meter to
---@param healthTexture table? A Table with your Character's Health Textures (Table Shown in character_add_health_meter)
local function character_add_costume_health_meter(charNum, charAlt, healthTexture)
    if type(charNum) ~= TYPE_INTEGER or charNum == nil then return end
    if type(charAlt) ~= TYPE_INTEGER or charAlt == nil then return end
    characterTable[charNum][charAlt].healthTexture = type(healthTexture) == TYPE_TABLE and healthTexture or nil
end

---@description A function that adds health meter textures to a character
---@added 1.9
---@param charNum integer The number/table position of the Character you want to add a meter to
---@param healthTexture table? A Table with your Character's Health Textures (Table Shown Below)
---@note ```lua
---@note local HEALTH_METER_CHAR = {
---@note     label = {
---@note         left = get_texture_info("hp-back-left"),
---@note         right = get_texture_info("hp-back-right"),
---@note     },
---@note     pie = {
---@note         [1] = get_texture_info("hp-pie-1"),
---@note         [2] = get_texture_info("hp-pie-2"),
---@note         [3] = get_texture_info("hp-pie-3"),
---@note         [4] = get_texture_info("hp-pie-4"),
---@note         [5] = get_texture_info("hp-pie-5"),
---@note         [6] = get_texture_info("hp-pie-6"),
---@note         [7] = get_texture_info("hp-pie-7"),
---@note         [8] = get_texture_info("hp-pie-8"),
---@note     }
---@note }
---@note ```
local function character_add_health_meter(charNum, healthTexture)
    character_add_costume_health_meter(charNum, 1, healthTexture)
end

---@description A function that adds course textures to a costume in the Star Select
---@added 1.12
---@param charNum integer The number/table position of the Character you want to add a course textures to
---@param charAlt integer The number/table position of the Costume you want to add a course textures to
---@param courseTexture table? A Table with your Character's Health Textures (Table Shown in character_add_course)
local function character_add_costume_course_texture(charNum, charAlt, courseTexture)
    if type(charNum) ~= TYPE_INTEGER or charNum == nil then return end
    if type(charAlt) ~= TYPE_INTEGER or charAlt == nil then return end
    characterTable[charNum][charAlt].courseTexture = type(courseTexture) == TYPE_TABLE and courseTexture or nil
end

---@description A function that adds course textures to a character in the Star Select
---@added 1.12
---@param charNum integer The number/table position of the Character you want to add a course textures to
---@param courseTexture table? A Table with your Character's Health Textures (Table Shown Below)
---@note ```lua
---@note local COURSE_CHAR = {
---@note     top = get_texture_info("char-course-top"),
---@note     bottom = get_texture_info("char-course-bottom"),
---@note }
---@note ```
local function character_add_course_texture(charNum, courseTexture)
    character_add_costume_course_texture(charNum, 1, courseTexture)
end

---@description A function that adds a celebration star model to a character
---@added 1.7
---@param modelInfo ModelExtendedId|integer Model Information Received from smlua_model_util_get_id()	
---@param starModel ModelExtendedId|integer Model Information Received from smlua_model_util_get_id()	
---@param starIcon TextureInfo? Texture Information Received from get_texture_info()
local function character_add_celebration_star(modelInfo, starModel, starIcon)
    characterCelebrationStar[modelInfo] = starModel
    for i = 2, #characterTable do
        for a = 1, #characterTable[i] do 
            if characterTable[i][a].model == modelInfo then
                characterTable[i][a].starIcon = type(starIcon) == TYPE_TABLE and starIcon or gTextures.star
                return
            end
        end
    end
    return false
end

---@description A function that adds a peach model to a character for the opening letter and ending cutscene.Can also change peach's letter for the character
---@added 1.16
---@param modelInfo ModelExtendedId|integer Model Information Received from smlua_model_util_get_id()	
---@param peachmodelstart ModelExtendedId? Model Information Received from smlua_model_util_get_id()	the model used for peach in the opening if left blank will use default peach model
---@param peachmodelend ModelExtendedId? Model Information Received from smlua_model_util_get_id()	the model used for peach in the ending if left blank will use default peach model
---@param peachletterleft TextureInfo? left side of the texture to replace peach's letter texture in the intro
---@param peachletterright TextureInfo? right side of the texture to replace peach's letter texture in the intro
---@param peachlettersig TextureInfo?  texture to replace peach's letter texture in the intro
local function character_add_peach_custom(modelInfo, peachmodelstart,peachmodelend,peachletterleft,peachletterright,peachlettersig)
        characterpeachstart[modelInfo] = peachmodelstart
        characterpeachend[modelInfo] = peachmodelend
        if (peachletterleft ~= nil) and (peachletterright ~= nil) and (peachlettersig ~= nil) then
            characterpeachletter[modelInfo] = {left = peachletterleft,right = peachletterright,sig = peachlettersig}
        end
end

---@description A function that adds a peach model to a character for the opening letter and ending cutscene
---@added 1.16
---@param modelInfo ModelExtendedId|integer Model Information Received from smlua_model_util_get_id()	
---@param toad_one ModelExtendedId Model Information Received from smlua_model_util_get_id()	the model used for one of the toads in the ending if left blank said toad will use the default npc toad model
---@param toad_two ModelExtendedId? Model Information Received from smlua_model_util_get_id()	the model used for one of the toads in the ending if left blank said toad will use the default npc toad model
local function character_add_ending_toad_model(modelInfo, toad_one,toad_two)
    characterendtoad1[modelInfo] = toad_one
    if toad_two == nil then
        characterendtoad2[modelInfo] = toad_one
    else
        characterendtoad2[modelInfo] = toad_two
    end
    
end

---@description A function that adds a palette preset to a character
---@added 1.8
---@param modelInfo ModelExtendedId|integer
---@param paletteTable table
---@param paletteName string?
---@note ```lua
---@note local PALETTE_CHAR = {
---@note     [PANTS]  = {r = 0x00, g = 0x00, b = 0xff},
---@note     [SHIRT]  = {r = 0xff, g = 0x00, b = 0x00},
---@note     [GLOVES] = {r = 0xff, g = 0xff, b = 0xff},
---@note     [SHOES]  = {r = 0x72, g = 0x1c, b = 0x0e},
---@note     [HAIR]   = {r = 0x73, g = 0x06, b = 0x00},
---@note     [SKIN]   = {r = 0xfe, g = 0xc1, b = 0x79},
---@note     [CAP]    = {r = 0xff, g = 0x00, b = 0x00},
---@note }
---@note ```
---@note Strings can also be used rather than RGB tables, ex. `[PANTS] = "0000ff"`
local function character_add_palette_preset(modelInfo, paletteTable, paletteName)
    local paletteTableOut = {
        name = paletteName,
    }
    local defaultColors = characterColorPresets[E_MODEL_MARIO]
    for i = 0, 7 do
        local color = paletteTable[i]
        paletteTableOut[i] = {r = 0, g = 0, b = 0}
        if type(color) == TYPE_STRING then
            paletteTableOut[i].r = tonumber(color:sub(1,2), 16) and tonumber(color:sub(1,2), 16) or defaultColors[i].r
            paletteTableOut[i].g = tonumber(color:sub(3,4), 16) and tonumber(color:sub(3,4), 16) or defaultColors[i].g
            paletteTableOut[i].b = tonumber(color:sub(5,6), 16) and tonumber(color:sub(5,6), 16) or defaultColors[i].b
        end
        if type(color) == TYPE_TABLE then
            paletteTableOut[i].r = (type(color) == TYPE_TABLE and color.r) and color.r or defaultColors[i].r
            paletteTableOut[i].g = (type(color) == TYPE_TABLE and color.g) and color.g or defaultColors[i].g
            paletteTableOut[i].b = (type(color) == TYPE_TABLE and color.b) and color.b or defaultColors[i].b
        end
    end
    if characterColorPresets[modelInfo] == nil then
        characterColorPresets[modelInfo] = {
            currPalette = 1,
        }
    end
    table_insert(characterColorPresets[modelInfo], paletteTableOut)
end

---@description A function that adds animations to a model
---@added 1.10
---@param modelInfo ModelExtendedId|integer
---@param animTable? table
---@param eyeTable? table
---@param handTable? table
local function character_add_animations(modelInfo, animTable, eyeTable, handTable)
    characterAnims[modelInfo] = {
        anims = type(animTable) == TYPE_TABLE and animTable or nil,
        eyes = type(eyeTable) == TYPE_TABLE and eyeTable or nil,
        hands = type(handTable) == TYPE_TABLE and handTable or nil,
    }
end

---@description A function that gets any animation table from a model
---@added 1.10
---@param modelInfo ModelExtendedId|integer
local function character_get_animations(modelInfo)
    return characterAnims[modelInfo]
end

---@description A function that gets a character's full Character Select Table
---@added 1
---@param tablePos integer?
---@param charAlt integer?
---@return CharacterTable
local function character_get_current_table(tablePos, charAlt)
    tablePos = tablePos and tablePos or currChar
    charAlt = charAlt and charAlt or 1
    return characterTable[tablePos][charAlt]
end

---@description A function that gets Character Select's Entire Character Table
---@added 1.11.1
---@return table
local function character_get_full_table()
    return characterTable
end

---@description A function that gets the current character's table position in CS
---@added 1
---@param localIndex integer? The local player index you want to get the character number from, Default is `0`
---@return integer?
local function character_get_current_number(localIndex)
    if localIndex == nil or localIndex == 0 then
        return currChar
    else
        for i = 1, #characterTable do
            if characterTable[i].saveName == gCSPlayers[localIndex].saveName then
                return i
            end
        end
        return nil
    end
end

---@description A function that gets the current costumes's table position in CS
---@added 1.12
---@param localIndex integer?
---@return integer?
local function character_get_current_costume(localIndex)
    if localIndex == nil or localIndex == 0 then
        return characterTable[currChar].currAlt
    else
        for i = 1, #characterTable do
            if characterTable[i].saveName == gCSPlayers[localIndex].saveName then
                return characterTable[i].currAlt
            end
        end
        return nil
    end
end

---@description A function that sets the current character based only table position with an optional second argument for setting a specific costume
---@added 1.9
---@param charNum integer The number/table position of the Character you want the local player to become
---@param charAlt integer? The number/table position of a costume in the corresponding character's costume table to switch to. If nil will use the 1st costume
local function character_set_current_number(charNum, charAlt)
    if type(charNum) ~= TYPE_INTEGER or characterTable[charNum] == nil then return end
    if charAlt == nil then charAlt = 1 end
    charAlt = clamp(charAlt, 1, #characterTable[charNum])
    force_set_character(charNum, charAlt)
    charBeingSet = true
end

---@description A function that gets the current character's palette data
---@added 1.12
---@return table?
local function character_get_current_palette()
    local model = characterTable[currChar][characterTable[currChar].currAlt].model
    return characterColorPresets[model] ~= nil and characterColorPresets[model][gCSPlayers[0].presetPalette] or nil
end

---@description A function that gets the current character's palette number
---@added 1.12
---@param localIndex integer?
---@return integer?
local function character_get_current_palette_number(localIndex)
    if localIndex == nil then localIndex = 0 end
    return gCSPlayers[localIndex].presetPalette
end

---@description A function that searches for a character's table posision based on name
---@added 1
---@param name string
local function character_get_number_from_string(name)
    if type(name) ~= TYPE_STRING then return nil end
    for i = 2, #characterTable do
        for a = 1, #characterTable[i] do
            if characterTable[i][a].name == name or characterTable[i][a].name == string_space_to_underscore(name) then
                return i
            end
        end
    end
    return nil
end

---@description A function that gets the current character's voice table
---@added 1.5
---@param model integer|MarioState
function character_get_voice(model)
    local model = (type(model) == TYPE_INTEGER) and model or gCSPlayers[model.playerIndex].modelId
    return characterVoices[model]
end

-- Located in n-hud.lua

---@description A function that gets a persons life icon texture / string based off of local index
---@added 1.7
---@param localIndex integer
---@return TextureInfo|string
---@note This assumes multiple characters will not have the same model, Icons can only be seen by users who have the character avalible to them. This function can return nil. if this is the case, render `djui_hud_print_text("?", x, y, 1)`
---@forcedoc character_get_life_icon

---@description A function that renders a persons life icon texture / string based off of local index
---@added 1.11
---@param localIndex integer
---@param x integer
---@param y integer
---@param scale integer
---@forcedoc character_render_life_icon

---@description A function that acts as character_render_life_icon with support for interpolation
---@added 1.13
---@param localIndex integer
---@param prevX integer
---@param prevY integer
---@param prevScale integer
---@param x integer
---@param y integer
---@param scale integer
---@forcedoc character_render_life_icon_interpolated

---@description A function that gets a persons star icon texture / string based off of local index
---@added 1.8
---@param localIndex integer
---@return TextureInfo
---@note This assumes multiple characters will not have the same model, Icons can only be seen by users who have the character avalible to them
---@forcedoc character_get_star_icon

---@description A function that renders a persons star icon texture / string based off of local index
---@added 1.11
---@param localIndex integer
---@param x integer
---@param y integer
---@param scale integer
---@forcedoc character_render_star_icon

---@description A function that acts as character_render_star_icon with support for interpolation
---@added 1.13
---@param localIndex integer
---@param prevX integer
---@param prevY integer
---@param prevScale integer
---@param x integer
---@param y integer
---@param scale integer
---@forcedoc character_render_star_icon_interpolated

---@description A function that gets a persons health meter texture table (example of which is at character_add_health_meter)
---@added 1.12
---@param localIndex integer
---@return table
---@note This assumes multiple characters will not have the same model, Meters can only be seen by users who have the character avalible to them
---@forcedoc character_get_health_meter

---@description A function that renders a persons health meter texture table
---@added 1.12
---@param localIndex integer
---@param health integer
---@param x integer
---@param y integer
---@param scaleX integer
---@param scaleY integer
---@forcedoc character_render_health_meter

---@description A function that renders a persons health meter texture table, with interpolation
---@added 1.16
---@param localIndex integer
---@param health integer
---@param prevX integer
---@param prevY integer
---@param prevScaleX integer
---@param prevScaleY integer
---@param x integer
---@param y integer
---@param scaleX integer
---@param scaleY integer
---@forcedoc character_render_health_meter_interpolated

---@description A function that locks a character under an unlock condition
---@added 1.10
---@param charNum integer? The number of the Character you want to Lock
---@param unlockCondition function|boolean? The condition for if the character stays locked
---@param notify boolean? Toggles whether Character Select should notify the user when the character is unlocked
local function character_set_locked(charNum, unlockCondition, notify)
    if charNum == nil or charNum > #characterTable or charNum < CT_MAX then return end
    if unlockCondition == nil then unlockCondition = false end
    if notify == nil then notify = true end
    characterTable[charNum].locked = LOCKED_TRUE
    if currChar == charNum then
        force_set_character()
    end
    characterUnlock[charNum] = {
        check = unlockCondition,
        notif = notify,
    }
end

---@description A function that sets a character under a specific category
---@added 1.14
---@param charNum integer? The number of the Character you want to set the category for
---@param category string The Category Name (Will create a new category if category does not exist)
local function character_set_category(charNum, category)
    if category == nil then return end
    category = string_underscore_to_space(category)
    local foundCategory = false
    for i = 1, #characterCategories do
        if characterCategories[i] == category then
            foundCategory = true
        end
    end
    if not foundCategory then 
        table_insert(characterCategories, category)
    end
    characterTable[charNum].category = characterTable[charNum].category .. "_" .. category
end

---@description A function that sets a character under a specific category
---@added 1.16
---@param charNum integer The number of the Character you want to replace dislog for
---@param dialogId integer|DialogId The ID of the dialog you want to replace
---@param unused integer Unused Dialog Variable
---@param linesPerBox integer Lines of text that appear in a single dialog
---@param leftOffset integer Dialog Box Posistion relitive to the left side of the screen
---@param width integer Verticle Position on screen (Dispite Variable Name)
---@param text string Dialog to be replaced with
local function character_replace_dialog(charNum, dialogId, unused, linesPerBox, leftOffset, width, text)
    if modded == nil then modded = true end
    characterDialog[charNum][dialogId] = {
        unused = unused,
        linesPerBox = linesPerBox,
        leftOffset = leftOffset,
        width = width,
        text = text,
    }
end

---@header
---@forcedoc Menu_Functions

---@description A function that sets the big "Character Select" texture in the Character Select Menu
---@added 1.7
---@param texture TextureInfo?
---@forcedoc header_set_texture

---@description A function that returns the version string
---@added 1
---@return string --`"v1.2.3"`
local function version_get()
    return MOD_VERSION_STRING
end

---@description A function that returns the version in table format
---@added 1.11
---@return table
---@note Returns the following table (Will differ based on version)
---@note ```lua
---@note {
---@note    api = 1,
---@note    major = 2,
---@note    minor = 3,
---@note    indev = true
---@note }
---@note ```
local function version_get_full()
    return {
        api = MOD_VERSION_API,
        major = MOD_VERSION_MAJOR,
        minor = MOD_VERSION_MINOR,
        indev = MOD_VERSION_INDEV
    }
end

---@description A function that checks is the Character Select Menu is currently open
---@added 1
---@return boolean
local function is_menu_open()
    return menuAndTransition
end

---@description A function that forces they Character Select Menu state
---@added 1.8
---@param bool boolean? Sets if the menu is open
local function set_menu_open(bool)
    if bool == nil then bool = true end
    menu = bool
end

---@description A function that gets Character Select's current Menu color
---@added 1.8
---@return table
local function get_menu_color()
    return menuColor
end

---------------------------
-- HUD Element Functions --
---------------------------

---@header
---@forcedoc HUD_Element_Functions

---@description Hides the specified custom hud element
---@added 1.5
---@param hudElement HUDDisplayFlag
---@forcedoc hud_hide_element

---@description Shows the specified custom hud element
---@added 1.5
---@param hudElement HUDDisplayFlag
---@forcedoc hud_show_element

---@description Gets the specified custom hud element's state
---@added 1.5
---@param hudElement HUDDisplayFlag
---@return boolean
---@forcedoc hud_get_element

---@description A function that checks if the options menu is open inside of the CS menu
---@added 1
---@return boolean
local function is_options_open()
    return options ~= nil
end

---@description A function that adds credits to the CS Options' Credits section
---@added 1.10
---@param modName string The Name of your Character Select Mod
---@param creditee string The person you want to Credit
---@param credit string What the Person helped with
---@overload fun(modName: string, credits: string[][])
local function credit_add(modName, creditee, credit)
    local credits
    for i = 2, #creditTable do
        if modName == creditTable[i].packName then
            credits = creditTable[i]
        end
    end
    if not credits then
        credits = { packName = modName }
        table_insert(creditTable, credits)
    end

    if type(creditee) == "table" then
        for _, credit in ipairs(creditee) do
            table_insert(credits, { creditee = credit[1], credit = credit[2] })
        end
    else table_insert(credits, { creditee = creditee, credit = credit }) end
end

---@description A function that sets if palettes are restricted (Default `false` unless a mod with the incompatible `gamemode` is on)
---@added 1.8
---@param bool boolean
local function restrict_palettes(bool)
    if not network_is_server() then return end
    if bool == nil then bool = true end
    gGlobalSyncTable.charSelectRestrictPalettes = bool and 2 or 0
end

---@description A function that sets if movesets are restricted (Default `false`)
---@added 1.10
---@param bool boolean
local function restrict_movesets(bool)
    if not network_is_server() then return end
    if bool == nil then bool = true end
    gGlobalSyncTable.charSelectRestrictMovesets = bool and 2 or optionTable[optionTableRef.restrictMovesets].toggle
end

---@description A function that checks if palettes are restricted
---@added 1.15
---@return boolean
local function are_palettes_restricted()
    return gGlobalSyncTable.charSelectRestrictPalettes > 0
end

---@description A function that checks if movesets are restricted
---@added 1.15
---@return boolean
local function are_movesets_restricted()
    return gGlobalSyncTable.charSelectRestrictMovesets > 0
end

---@description A table that contains the local mario's controller before Character Select's menu cancels them
---@added 1
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

---@description A function that adds an option to the Character Select Options Menu
---@added 1.9
---@param name string The Name of the Option
---@param toggleDefault number? The default number that the option toggles to (Defaults to `0`)
---@param toggleMax number? The max number the option can be toggled to (Defaults to `1`)
---@param toggleNames table? A table of strings, each entry being for a toggle's name `{"Off", "On"}`
---@param description table? A table of strings, each entry being a new line `{"This toggle allows your", "character to feel everything."}`
---@param save boolean? Toggles whether the option retains between sessions (Defaults to `true`)
---@return number --The table position of the option added
local function add_option(name, toggleDefault, toggleMax, toggleNames, description, save)
    if save == nil then save = true end
    local saveName = string_space_to_underscore(name)
    table_insert(optionTable, {
        name = type(name) == TYPE_STRING and name or "Unknown Toggle",
        category = OPTION_API,
        toggle = nil, -- Set as nil for Failsafe to Catch
        toggleSaveName = save and saveName or nil,
        toggleDefault = type(toggleDefault) == TYPE_INTEGER and toggleDefault or 0,
        toggleMax = type(toggleMax) == TYPE_INTEGER and toggleMax or 1,
        toggleNames = type(toggleNames) == TYPE_TABLE and toggleNames or {"Off", "On"},
        description = type(description) == TYPE_TABLE and description or {""},
    })
    queueStorageFailsafe = true -- Used variable trigger to not save/load in the external mod
    return #optionTable
end

---@description A function that gets an option's data from the Character Select Options Menu
---@added 1.9
---@param tableNum integer The table position of the option
---@return table?
local function get_option(tableNum)
    if type(tableNum) ~= TYPE_INTEGER then return nil end
    return optionTable[tableNum]
end

---@description A function that gets an option's status from the Character Select Options Menu
---@added 1.9
---@param tableNum integer The table position of the option
---@return number?
---@forcedoc get_options_status

---@description A function that sets an option's status from the Character Select Options Menu
---@added 1.9
---@param tableNum integer The table position of the option
---@param toggle integer What you want to set the option to
local function set_options_status(tableNum, toggle)
    local currOption = optionTable[tableNum]
    if currOption == nil or type(toggle) ~= TYPE_INTEGER or toggle > currOption.toggleMax or toggle < 1 then return end
    optionTable[tableNum].toggle = toggle
    optionTable[tableNum].optionBeingSet = true
end

---@header
---@forcedoc Misc

---@description A function that sets the name to be replaced in Dialog, Default is `"Mario"`
---@added 1.10
---@param name string
---@note This function does *NOT* change what NPCs will refer to your character as, this function is intended for Rom-Hack ports with alternate protagonists.
---@forcedoc dialog_set_replace_name

---@description A function that sets the preset palette for a network player forcefully
---@added 1.11
---@param np NetworkPlayer
---@forcedoc update_preset_palette

---@header
---@forcedoc Tables & Variables

---@description The "Reference Sheet" or IDs for all of Character Select's Options
---@added 1
---@forcedoc optionTableRef

---@description The info for inputs from `gMarioStates[0]` before Character Select's Menu cancels inputs
---@added 1
---@forcedoc controller

---@description A table containing player info from Character Select's custom networking system
---@added 1.11.1
---@forcedoc gCSPlayers

---@description The ID for Character Select's Menu "Cutscene"
---@added 1
---@forcedoc CUTSCENE_CS_MENU

---@description The ID for Character Select's Menu Animation ID, Used in combination with character_add_animations to display a specific pose in the menu.
---@added 1.14
---@forcedoc CS_ANIM_MENU

---@header
---@forcedoc Character_Select_Hooks

---@description A function that allows you to add a condition for if the CS Menu can be opened
---@added 1
---@param func function
local function hook_allow_menu_open(func)
    if type(func) ~= TYPE_FUNCTION then return end
    table_insert(allowMenu, func)
end

---@description A function that allows you to render HUD Elements in the menu (Behind transistions such as Option and going in/out of menu)
---@added 1.5
---@param func function
local function hook_render_in_menu(func, underText)
    if type(func) ~= TYPE_FUNCTION then return end
    if underText then
        table_insert(hookTableRenderInMenu.back, func)
    else
        table_insert(hookTableRenderInMenu.front, func)
    end
end

---@description A function that runs the inputted function when the character is changed
---@added 1.15
---@param func function
---@note Function gives `currChar` and `prevChar` as function inputs
local function hook_on_character_change(func)
    if type(func) ~= TYPE_FUNCTION then return end
    table_insert(hookTableOnCharacterChange, func)
end

---@description A function that adds the necessary hooks in order for your pack to have function voicelines
---@added 1.12
---@forcedoc config_character_sounds

---@description A function that allows you to hook a function, much like `hook_event`, to a specific character number
---@added 1.10
---@param charNum integer
---@param hookEventType LuaHookedEventType|integer The hook event tied to a specific character. Supports the following hooks: `HOOK_MARIO_UPDATE`, `HOOK_BEFORE_MARIO_UPDATE`, `HOOK_BEFORE_PHYS_STEP`, `HOOK_ALLOW_PVP_ATTACK`, `HOOK_ON_PVP_ATTACK`, `HOOK_ON_INTERACT`, `HOOK_ALLOW_INTERACT`, `HOOK_ON_SET_MARIO_ACTION`, `HOOK_BEFORE_SET_MARIO_ACTION`, `HOOK_ON_DEATH`, `HOOK_ON_HUD_RENDER`, `HOOK_ON_HUD_RENDER_BEHIND`, `HOOK_ON_LEVEL_INIT`, `HOOK_ON_SYNC_VALID`, `HOOK_ON_OBJECT_RENDER`, `HOOK_ALLOW_FORCE_WATER_ACTION`, `HOOK_MARIO_OVERRIDE_FLOOR_CLASS` `
---@param func function
local function character_hook_moveset(charNum, hookEventType, func)
    if charNum > #characterTable then return end
    if type(func) ~= TYPE_FUNCTION then return end
    characterMovesets[charNum][hookEventType] = func
    characterTable[charNum].hasMoveset = true
end

---@description A function that returns the Character's moveset functions
---@added 1.14
---@param charNum integer
local function character_get_moveset(charNum)
    return characterMovesets[charNum]
end

---@description A function that returns if the character number is of a character that is included with CoopDX
---@added 1.15.1
---@param charNum integer? The character number you want to check, Default is the local character
---@note Function was made in preperation for v1.16, in which the Base Cast are individual characters rather than Costumes of each other. 
---@forcedoc character_is_vanilla

---@description A function that adds an instrument track to a specific character
---@added 1.16
---@note Original Song is `.ogg` File Format, `Mono` Channel, `G# Major Key`, `82` BPM, `93.659` Seconds Long, and is set to a sample rate of `22050`. If these requirements are not met then the song will not properly play, or incorrectly fit with the base theme.
local function character_add_menu_instrumental(charNum, loadedAudio)
    audio_stream_set_looping(loadedAudio, true)
    audio_stream_set_loop_points(loadedAudio, 0, 93.659*22050)
    characterInstrumentals[charNum] = loadedAudio
end

---@description A function that adds graffiti art to the background of the menu
---@added 1.16
---@param charNum integer
---@param texture TextureInfo
local function character_add_graffiti(charNum, texture)
    characterGraffiti[charNum] = texture
end

---@description A function that adds graffiti art to the background of the menu
---@added 1.16
---@param charNum integer
local function character_get_graffiti(charNum)
    return characterGraffiti[charNum] and characterGraffiti[charNum] or TEX_GRAFFITI_DEFAULT
end

---@description A function that runs when Character Select Resets it's save data
---@added 1.16
---@param func function
---@note Function gives `currChar` and `prevChar` as function inputs
local function hook_on_save_data_reset(func)
    if type(func) ~= TYPE_FUNCTION then return end
    table_insert(hookTableOnReset, func)
end

_G.charSelectExists = true
_G.charSelect = {
    -- Character Functions --
    character_add = character_add,
    character_add_costume = character_add_costume,
    character_edit = character_edit,
    character_edit_costume = character_edit_costume,
    character_set_nickname = character_set_nickname,
    character_get_nickname = character_get_nickname,
    character_add_voice = character_add_voice,
    character_add_caps = character_add_caps,
    character_get_caps = character_get_caps,
    character_add_celebration_star = character_add_celebration_star,
    character_add_peach_custom = character_add_peach_custom,
    character_add_ending_toad_model = character_add_ending_toad_model,
    character_add_health_meter = character_add_health_meter,
    character_add_costume_health_meter = character_add_costume_health_meter,
    character_add_course_texture = character_add_course_texture,
    character_add_costume_course_texture = character_add_costume_course_texture,
    character_add_palette_preset = character_add_palette_preset,
    character_add_animations = character_add_animations,
    character_get_animations = character_get_animations,
    character_get_current_table = character_get_current_table,
    character_get_full_table = character_get_full_table,
    character_get_current_number = character_get_current_number,
    character_get_current_model_number = character_get_current_number, -- Outdated function name, Not recommended for use
    character_get_current_costume = character_get_current_costume,
    character_set_current_number = character_set_current_number,
    character_get_current_palette = character_get_current_palette,
    character_get_current_palette_number = character_get_current_palette_number,
    character_get_number_from_string = character_get_number_from_string,
    character_get_voice = character_get_voice,
    character_get_life_icon = life_icon_from_local_index, -- Function located in n-hud.lua
    character_render_life_icon = render_life_icon_from_local_index, -- Function located in n-hud.lua
    character_render_life_icon_interpolated = render_life_icon_from_local_index_interpolated, -- Function located in n-hud.lua
    character_get_star_icon = star_icon_from_local_index, -- Function located in n-hud.lua
    character_render_star_icon = render_star_icon_from_local_index, -- Function located in n-hud.lua
    character_render_star_icon_interpolated = render_star_icon_from_local_index_interpolated, -- Function located in n-hud.lua
    character_get_health_meter = health_meter_from_local_index, -- Function located in n-hud.lua
    character_render_health_meter = render_health_meter_from_local_index, -- Function located in n-hud.lua
    character_render_health_meter_interpolated = render_health_meter_from_local_index_interpolated, -- Function located in n-hud.lua
    character_set_locked = character_set_locked,
    character_set_category = character_set_category,
    character_replace_dialog = character_replace_dialog,
    character_get_moveset = character_get_moveset,
    character_is_vanilla = character_is_vanilla, -- Function located in main.lua
    character_add_menu_instrumental = character_add_menu_instrumental,
    character_add_graffiti = character_add_graffiti,
    character_get_graffiti = character_get_graffiti,
    -- Located in voice.lua
    voice = {
        sound = custom_character_sound,
        snore = custom_character_snore,
    },

    -- Hud Element Functions --
    hud_hide_element = hud_hide_element, -- Function located in hud.lua
    hud_show_element = hud_show_element, -- Function located in hud.lua
    hud_get_element = hud_get_element, -- Function located in hud.lua

    -- Menu Functions --
    header_set_texture = header_set_texture, -- Function located in main.lua
    version_get = version_get,
    version_get_full = version_get_full,
    is_menu_open = is_menu_open,
    set_menu_open = set_menu_open,
    is_options_open = is_options_open,
    get_menu_color = get_menu_color,
    add_option = add_option,
    get_option = get_option,
    get_options_status = get_options_status,
    set_options_status = set_options_status,
    credit_add = credit_add,
    restrict_palettes = restrict_palettes,
    restrict_movesets = restrict_movesets,
    are_palettes_restricted = are_palettes_restricted,
    are_movesets_restricted = are_movesets_restricted,

    -- Misc --
    dialog_set_replace_name = dialog_set_replace_name, -- Function located in dialog.lua
    update_preset_palette = update_preset_palette, -- Function located in palettes.lua

    -- Tables & Variables --
    optionTableRef = optionTableRef,
    controller = controller,
    gCSPlayers = gCSPlayers,
    CUTSCENE_CS_MENU = CUTSCENE_CS_MENU,
    CS_ANIM_MENU = CS_ANIM_MENU,

    -- Character Select Hooks --
    hook_allow_menu_open = hook_allow_menu_open,
    hook_render_in_menu = hook_render_in_menu,
    hook_on_character_change = hook_on_character_change,
    hook_on_save_data_reset = hook_on_save_data_reset,
    config_character_sounds = config_character_sounds, -- Function located in voice.lua
    character_hook_moveset = character_hook_moveset,
}

-- Replace base functions
local obj_set_model_extended_original = obj_set_model_extended

local warnExtended = false
-- Replace obj_set_model_extended to warn for mario models
---@ignore
local function obj_set_model_extended(obj, modelInfo)
    for i = 0, MAX_PLAYERS - 1 do
        if gMarioStates[i].marioObj == obj and not warnExtended then
            log_to_console("Character Select: Mario Object cannot be changed with 'obj_set_model_extended' while Character Select is Active, please use 'character_edit'!!", CONSOLE_MESSAGE_WARNING)
            warnExtended = true
        end
    end
    return obj_set_model_extended_original(obj, modelInfo)
end

_G.obj_set_model_extended = obj_set_model_extended
