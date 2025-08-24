--[[
    Custom Font Handler v1 - By Squishy6094

    This file adds custom font functionality, and does not need to be edited
    Ensure this file is loaded before anything else (make the file name start with a or !)
    Use djui_hud_add_font() to add fonts as shown in main.lua
]]

FONT_HANDLER_VERSION_MAJOR = 1
FONT_HANDLER_VERSION_MINOR = 0
FONT_HANDLER_VERSION = "v"..FONT_HANDLER_VERSION_MAJOR.."."..FONT_HANDLER_VERSION_MINOR

local djui_classic_hud_set_font = djui_hud_set_font
local djui_classic_hud_print_text = djui_hud_print_text
local djui_classic_hud_print_text_interpolated = djui_hud_print_text_interpolated
local djui_classic_hud_measure_text = djui_hud_measure_text

local customFont = false

local fontTable = {}

CUSTOM_FONT_COUNT = FONT_COUNT
local customFontType = FONT_NORMAL

local latinChars = {
    [32] = " ", [33] = "!", [34] = "\"", [35] = "#", [36] = "$", [37] = "%", [38] = "&", [39] = "'",
    [40] = "(", [41] = ")", [42] = "*", [43] = "+", [44] = ",", [45] = "-", [46] = ".", [47] = "/",
    [48] = "0", [49] = "1", [50] = "2", [51] = "3", [52] = "4", [53] = "5", [54] = "6", [55] = "7",
    [56] = "8", [57] = "9", [58] = ":", [59] = ";", [60] = "<", [61] = "=", [62] = ">", [63] = "?",
    [64] = "@", [65] = "A", [66] = "B", [67] = "C", [68] = "D", [69] = "E", [70] = "F", [71] = "G",
    [72] = "H", [73] = "I", [74] = "J", [75] = "K", [76] = "L", [77] = "M", [78] = "N", [79] = "O",
    [80] = "P", [81] = "Q", [82] = "R", [83] = "S", [84] = "T", [85] = "U", [86] = "V", [87] = "W",
    [88] = "X", [89] = "Y", [90] = "Z", [91] = "[", [92] = "\\", [93] = "]", [94] = "^", [95] = "_",
    [96] = "`", [97] = "a", [98] = "b", [99] = "c", [100] = "d", [101] = "e", [102] = "f", [103] = "g",
    [104] = "h", [105] = "i", [106] = "j", [107] = "k", [108] = "l", [109] = "m", [110] = "n", [111] = "o",
    [112] = "p", [113] = "q", [114] = "r", [115] = "s", [116] = "t", [117] = "u", [118] = "v", [119] = "w",
    [120] = "x", [121] = "y", [122] = "z", [123] = "{", [124] = "|", [125] = "}", [126] = "~",
    -- Latin-1 Supplement
    [160] = " ", [161] = "¡", [162] = "¢", [163] = "£", [164] = "¤", [165] = "¥", [166] = "¦", [167] = "§",
    [168] = "¨", [169] = "©", [170] = "ª", [171] = "«", [172] = "¬", [173] = "­", [174] = "®", [175] = "¯",
    [176] = "°", [177] = "±", [178] = "²", [179] = "³", [180] = "´", [181] = "µ", [182] = "¶", [183] = "·",
    [184] = "¸", [185] = "¹", [186] = "º", [187] = "»", [188] = "¼", [189] = "½", [190] = "¾", [191] = "¿",
    [192] = "À", [193] = "Á", [194] = "Â", [195] = "Ã", [196] = "Ä", [197] = "Å", [198] = "Æ", [199] = "Ç",
    [200] = "È", [201] = "É", [202] = "Ê", [203] = "Ë", [204] = "Ì", [205] = "Í", [206] = "Î", [207] = "Ï",
    [208] = "Ð", [209] = "Ñ", [210] = "Ò", [211] = "Ó", [212] = "Ô", [213] = "Õ", [214] = "Ö", [215] = "×",
    [216] = "Ø", [217] = "Ù", [218] = "Ú", [219] = "Û", [220] = "Ü", [221] = "Ý", [222] = "Þ", [223] = "ß",
    [224] = "à", [225] = "á", [226] = "â", [227] = "ã", [228] = "ä", [229] = "å", [230] = "æ", [231] = "ç",
    [232] = "è", [233] = "é", [234] = "ê", [235] = "ë", [236] = "ì", [237] = "í", [238] = "î", [239] = "ï",
    [240] = "ð", [241] = "ñ", [242] = "ò", [243] = "ó", [244] = "ô", [245] = "õ", [246] = "ö", [247] = "÷",
    [248] = "ø", [249] = "ù", [250] = "ú", [251] = "û", [252] = "ü", [253] = "ý", [254] = "þ", [255] = "ÿ"
}

local HudAnimTimer = 0

local function convert_unicode_table_to_string_table(input)
    local output = {}
    for i = 1, #input do
        local letter = input[i]
        if letter ~= nil and latinChars[letter.id] ~= nil then
            output[latinChars[letter.id]] = letter
        end
    end
    return output
end

local function string_to_table(str)
    local charArray = {};
    local iStart = 0;
    local strLen = str:len();
    local function bit(b)
        return 2 ^ (b - 1);
    end
    local function hasbit(w, b)
        return w % (b + b) >= b
    end
    local checkMultiByte = function(i)
        if (iStart ~= 0) then
            charArray[#charArray + 1] = str:sub(iStart, i - 1)
            iStart = 0
        end
    end
    for i = 1, strLen do
        local b = str:byte(i)
        local multiStart = hasbit(b, bit(7)) and hasbit(b, bit(8))
        local multiTrail = not hasbit(b, bit(7)) and hasbit(b, bit(8))
        if (multiStart) then
            checkMultiByte(i)
            iStart = i
        elseif (not multiTrail) then
            checkMultiByte(i)
            charArray[#charArray + 1] = str:sub(i, i)
        end
    end
    return charArray
end

---@param texture TextureInfo
---@param info table
---@param spacing integer
---@param offset integer
---@param backup string
---@param scale integer
---@return DjuiFontType
function djui_hud_add_font(texture, info, spacing, offset, backup, scale)
    if texture == nil then return FONT_NORMAL end
    if info == nil then return FONT_NORMAL end
    if spacing == nil then spacing = 1 end
    if offset == nil then offset = 0 end
    if backup == nil then backup = "x" end
    if scale == nil then scale = 1 end
    if info[1] ~= nil and info[1].id ~= nil then
        info = convert_unicode_table_to_string_table(info)
    end
    CUSTOM_FONT_COUNT = CUSTOM_FONT_COUNT + 1
    fontTable[CUSTOM_FONT_COUNT] = {
        spritesheet = texture,
        spacing = spacing,
        offset = offset,
        info = info,
        backup = backup,
        scale = scale,
    }
    return CUSTOM_FONT_COUNT
end

---@param fontType DjuiFontType
---@return nil
function djui_hud_set_font(fontType)
    if fontType > FONT_COUNT then
        customFont = true
        customFontType = fontType
    else
        customFont = false
        djui_classic_hud_set_font(fontType)
    end
end

local textShake = 0
function djui_hud_effect_shake(intensity)
    textShake = math.ceil(intensity*100)*0.01
end

local textWaveX = 0
local textWaveY = 0
local textWaveSpeed = 0
function djui_hud_effect_wave(x, y, speed)
    textWaveX = x
    textWaveY = y
    textWaveSpeed = speed
end

---@param message string
---@param x number
---@param y number
---@param scale number
---@return nil
function djui_hud_print_text(message, x, y, scale)
    if customFont then
        if message == nil or message == "" then return end
        local message = string_to_table(message)
        local currFont = fontTable[customFontType]
        y = y + currFont.offset
        scale = scale*currFont.scale
        for i = 1, #message do
            local letter = message[i]
            if letter and letter ~= " " then
                if currFont.info[letter] == nil then
                    letter = currFont.backup
                end
                local scaleWidth = scale*(currFont.info[letter].height/currFont.info[letter].width)
                djui_hud_render_texture_tile(currFont.spritesheet,
                x + (currFont.info[letter].xoffset*scale) + math.random(-textShake*100, textShake*100)*0.01 + math.sin((HudAnimTimer+i*2)*textWaveSpeed*0.1)*textWaveX,
                y + (currFont.info[letter].yoffset*scale) + math.random(-textShake*100, textShake*100)*0.01 + math.cos((HudAnimTimer+i*2)*textWaveSpeed*0.1)*textWaveY,
                scaleWidth, scale, currFont.info[letter].x,
                currFont.info[letter].y,
                currFont.info[letter].width,
                currFont.info[letter].height)
            else
                letter = currFont.backup
            end
            x = x + (currFont.info[letter].width + currFont.spacing)*scale
        end
    else
        djui_classic_hud_print_text(message, x, y, scale)
    end
end

---@param message string
---@param prevX number
---@param prevY number
---@param prevScale number
---@param x number
---@param y number
---@param scale number
---@return nil
-- Custom Fonts do not currently support Interpolation due to lack of RESOLUTION_N64 support
function djui_hud_print_text_interpolated(message, prevX, prevY, prevScale, x, y, scale)
    if customFont then
        djui_hud_print_text(message, x, y, scale)
    else
        djui_classic_hud_print_text_interpolated(message, prevX, prevY, prevScale, x, y, scale)
    end
end

---@param message string
---@return number
function djui_hud_measure_text(message)
    if customFont then
        --[[
        if message == nil or message == "" then return 0 end
        local currFont = fontTable[customFontType]
        local output = 0
        for i = 1, #message do
            local letter = message:sub(i,i)
            if currFont.info[letter] == nil or letter == " " then
                letter = currFont.backup
            end
            output = output + (currFont.info[letter].width + (i ~= #message and currFont.spacing or 0))*currFont.scale
        end
        return output
        ]]
        if message == nil or message == "" then return end
        local message = string_to_table(message)
        local currFont = fontTable[customFontType]
        local scale = 1
        local x = 0
        for i = 1, #message do
            local letter = message[i]
            if letter and letter ~= " " then
                if currFont.info[letter] == nil then
                    letter = currFont.backup
                end
            else
                letter = currFont.backup
            end
            x = x + (currFont.info[letter].width + currFont.spacing)*scale
        end
        return x
    else
        return djui_classic_hud_measure_text(message)
    end
end

local function hud_update()
    -- Reset Values Every Frame
    textShake = 0
    textWaveX = 0
    textWaveY = 0
    textWaveSpeed = 0

    -- Update Basic Anim Timer
    HudAnimTimer = HudAnimTimer + 1
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, hud_update)

-- Adding custom fonts here to prevent main.lua clutter

local fontdataBrick = {
    { id=32,   x=0,   y=0,   width=0, height=0,   xoffset=0,   yoffset=0,  xadvance=23, page=0, chnl=15},
    { id=33,   x=224, y=161, width=26, height=64, xoffset=-3, yoffset=2, xadvance=21, page=0, chnl=15},
    { id=34,   x=142, y=465, width=26, height=32, xoffset=-3, yoffset=11, xadvance=20, page=0, chnl=15},
    { id=35,   x=369, y=411, width=49, height=51, xoffset=-3, yoffset=8, xadvance=43, page=0, chnl=15},
    { id=36,   x=35,  y=161, width=40, height=65, xoffset=-3, yoffset=1, xadvance=34, page=0, chnl=15},
    { id=37,   x=173, y=227, width=31, height=63, xoffset=-3, yoffset=3, xadvance=25, page=0, chnl=15},
    { id=38,   x=358, y=92,  width=44, height=66, xoffset=-3, yoffset=0, xadvance=38, page=0, chnl=15},
    { id=39,   x=494, y=376, width=17, height=22, xoffset=-4, yoffset=8, xadvance=11, page=0, chnl=15},
    { id=40,   x=169, y=0,   width=34, height=81, xoffset=-3, yoffset=-1, xadvance=28, page=0, chnl=15},
    { id=41,   x=204, y=0,   width=31, height=81, xoffset=-4, yoffset=-1, xadvance=24, page=0, chnl=15},
    { id=42,   x=229, y=465, width=21, height=26, xoffset=-3, yoffset=10, xadvance=15, page=0, chnl=15},
    { id=43,   x=202, y=465, width=26, height=29, xoffset=-3, yoffset=23, xadvance=20, page=0, chnl=15},
    { id=44,   x=494, y=352, width=17, height=23, xoffset=-4, yoffset=46, xadvance=11, page=0, chnl=15},
    { id=45,   x=323, y=465, width=31, height=17, xoffset=-3, yoffset=27, xadvance=25, page=0, chnl=15},
    { id=46,   x=302, y=465, width=20, height=19, xoffset=-3, yoffset=47, xadvance=14, page=0, chnl=15},
    { id=47,   x=0,   y=161, width=34, height=65, xoffset=-3, yoffset=2, xadvance=28, page=0, chnl=15},
    { id=48,   x=282, y=161, width=45, height=63, xoffset=-6, yoffset=3, xadvance=37, page=0, chnl=15},
    { id=49,   x=205, y=227, width=28, height=62, xoffset=-4, yoffset=2, xadvance=21, page=0, chnl=15},
    { id=50,   x=402, y=291, width=45, height=58, xoffset=-3, yoffset=8, xadvance=38, page=0, chnl=15},
    { id=51,   x=455, y=227, width=57, height=51, xoffset=-3, yoffset=9, xadvance=50, page=0, chnl=15},
    { id=52,   x=403, y=92,  width=37, height=65, xoffset=-3, yoffset=1, xadvance=32, page=0, chnl=15},
    { id=53,   x=137, y=352, width=56, height=57, xoffset=-3, yoffset=9, xadvance=51, page=0, chnl=15},
    { id=54,   x=448, y=291, width=48, height=58, xoffset=-3, yoffset=8, xadvance=42, page=0, chnl=15},
    { id=55,   x=0,   y=291, width=45, height=60, xoffset=-4, yoffset=6, xadvance=39, page=0, chnl=15},
    { id=56,   x=234, y=227, width=48, height=62, xoffset=-3, yoffset=4, xadvance=42, page=0, chnl=15},
    { id=57,   x=441, y=92,  width=45, height=65, xoffset=-3, yoffset=1, xadvance=39, page=0, chnl=15},
    { id=58,   x=487, y=92,  width=21, height=46, xoffset=3, yoffset=31, xadvance=28, page=0, chnl=15},
    { id=59,   x=106, y=352, width=30, height=58, xoffset=-5, yoffset=30, xadvance=28, page=0, chnl=15},
    { id=61,   x=102, y=465, width=39, height=34, xoffset=-3, yoffset=16, xadvance=34, page=0, chnl=15},
    { id=63,   x=251, y=161, width=30, height=64, xoffset=-3, yoffset=2, xadvance=25, page=0, chnl=15},
    { id=64,   x=314, y=411, width=54, height=51, xoffset=-3, yoffset=15, xadvance=48, page=0, chnl=15},
    { id=65,   x=145, y=92,  width=48, height=67, xoffset=-7, yoffset=5, xadvance=36, page=0, chnl=15},
    { id=66,   x=316, y=291, width=50, height=59, xoffset=-4, yoffset=7, xadvance=44, page=0, chnl=15},
    { id=67,   x=369, y=227, width=39, height=62, xoffset=-9, yoffset=5, xadvance=22, page=0, chnl=15},
    { id=68,   x=54,  y=411, width=53, height=53, xoffset=-7, yoffset=14, xadvance=40, page=0, chnl=15},
    { id=69,   x=51,  y=465, width=50, height=44, xoffset=-3, yoffset=16, xadvance=45, page=0, chnl=15},
    { id=70,   x=400, y=352, width=50, height=56, xoffset=-9, yoffset=9, xadvance=33, page=0, chnl=15},
    { id=71,   x=138, y=291, width=49, height=60, xoffset=-3, yoffset=6, xadvance=43, page=0, chnl=15},
    { id=72,   x=150, y=161, width=38, height=64, xoffset=-8, yoffset=8, xadvance=22, page=0, chnl=15},
    { id=73,   x=276, y=92,  width=34, height=66, xoffset=-8, yoffset=0, xadvance=20, page=0, chnl=15},
    { id=74,   x=409, y=227, width=45, height=62, xoffset=-5, yoffset=10, xadvance=32, page=0, chnl=15},
    { id=75,   x=250, y=352, width=55, height=57, xoffset=-9, yoffset=9, xadvance=39, page=0, chnl=15},
    { id=76,   x=0,   y=227, width=40, height=63, xoffset=-3, yoffset=3, xadvance=35, page=0, chnl=15},
    { id=77,   x=41,  y=227, width=44, height=63, xoffset=-8, yoffset=6, xadvance=29, page=0, chnl=15},
    { id=78,   x=188, y=291, width=41, height=60, xoffset=-9, yoffset=6, xadvance=24, page=0, chnl=15},
    { id=79,   x=86,  y=227, width=34, height=63, xoffset=-3, yoffset=5, xadvance=29, page=0, chnl=15},
    { id=80,   x=211, y=411, width=52, height=52, xoffset=-5, yoffset=14, xadvance=40, page=0, chnl=15},
    { id=81,   x=53,  y=352, width=52, height=58, xoffset=-9, yoffset=8, xadvance=36, page=0, chnl=15},
    { id=82,   x=264, y=411, width=49, height=52, xoffset=-5, yoffset=14, xadvance=37, page=0, chnl=15},
    { id=83,   x=455, y=0,   width=49, height=71, xoffset=-7, yoffset=3, xadvance=31, page=0, chnl=15},
    { id=84,   x=311, y=92,  width=46, height=66, xoffset=-5, yoffset=0, xadvance=32, page=0, chnl=15},
    { id=85,   x=189, y=161, width=34, height=64, xoffset=-6, yoffset=2, xadvance=20, page=0, chnl=15},
    { id=86,   x=367, y=291, width=34, height=59, xoffset=-2, yoffset=7, xadvance=24, page=0, chnl=15},
    { id=87,   x=121, y=227, width=51, height=63, xoffset=-4, yoffset=9, xadvance=38, page=0, chnl=15},
    { id=88,   x=48,  y=92,  width=47, height=68, xoffset=-10, yoffset=-2, xadvance=27, page=0, chnl=15},
    { id=89,   x=280, y=0,   width=43, height=80, xoffset=-5, yoffset=3, xadvance=29, page=0, chnl=15},
    { id=90,   x=451, y=352, width=42, height=56, xoffset=-10, yoffset=10, xadvance=29, page=0, chnl=15},
    { id=91,   x=108, y=0,   width=30, height=82, xoffset=1, yoffset=5, xadvance=32, page=0, chnl=15},
    { id=93,   x=139, y=0,   width=29, height=82, xoffset=1, yoffset=5, xadvance=32, page=0, chnl=15},
    { id=94,   x=169, y=465, width=32, height=31, xoffset=-3, yoffset=7, xadvance=26, page=0, chnl=15},
    { id=95,   x=251, y=465, width=50, height=19, xoffset=-3, yoffset=47, xadvance=44, page=0, chnl=15},
    { id=97,   x=96,  y=92,  width=48, height=67, xoffset=-7, yoffset=5, xadvance=36, page=0, chnl=15},
    { id=98,   x=230, y=291, width=50, height=59, xoffset=-4, yoffset=7, xadvance=44, page=0, chnl=15},
    { id=99,   x=283, y=227, width=39, height=62, xoffset=-9, yoffset=5, xadvance=22, page=0, chnl=15},
    { id=100,  x=0,   y=411, width=53, height=53, xoffset=-7, yoffset=14, xadvance=40, page=0, chnl=15},
    { id=101,  x=0,   y=465, width=50, height=44, xoffset=-3, yoffset=16, xadvance=45, page=0, chnl=15},
    { id=102,  x=306, y=352, width=50, height=56, xoffset=-9, yoffset=9, xadvance=33, page=0, chnl=15},
    { id=103,  x=46,  y=291, width=49, height=60, xoffset=-3, yoffset=6, xadvance=43, page=0, chnl=15},
    { id=104,  x=76,  y=161, width=38, height=64, xoffset=-8, yoffset=8, xadvance=22, page=0, chnl=15},
    { id=105,  x=194, y=92,  width=34, height=66, xoffset=-8, yoffset=0, xadvance=20, page=0, chnl=15},
    { id=106,  x=323, y=227, width=45, height=62, xoffset=-5, yoffset=10, xadvance=32, page=0, chnl=15},
    { id=107,  x=194, y=352, width=55, height=57, xoffset=-9, yoffset=9, xadvance=39, page=0, chnl=15},
    { id=108,  x=328, y=161, width=40, height=63, xoffset=-3, yoffset=3, xadvance=35, page=0, chnl=15},
    { id=109,  x=369, y=161, width=44, height=63, xoffset=-8, yoffset=6, xadvance=29, page=0, chnl=15},
    { id=110,  x=96,  y=291, width=41, height=60, xoffset=-9, yoffset=6, xadvance=24, page=0, chnl=15},
    { id=111,  x=414, y=161, width=34, height=63, xoffset=-3, yoffset=5, xadvance=29, page=0, chnl=15},
    { id=112,  x=108, y=411, width=52, height=52, xoffset=-5, yoffset=14, xadvance=40, page=0, chnl=15},
    { id=113,  x=0,   y=352, width=52, height=58, xoffset=-9, yoffset=8, xadvance=36, page=0, chnl=15},
    { id=114,  x=161, y=411, width=49, height=52, xoffset=-5, yoffset=14, xadvance=37, page=0, chnl=15},
    { id=115,  x=405, y=0,   width=49, height=71, xoffset=-7, yoffset=3, xadvance=31, page=0, chnl=15},
    { id=116,  x=229, y=92,  width=46, height=66, xoffset=-5, yoffset=0, xadvance=32, page=0, chnl=15},
    { id=117,  x=115, y=161, width=34, height=64, xoffset=-6, yoffset=2, xadvance=20, page=0, chnl=15},
    { id=118,  x=281, y=291, width=34, height=59, xoffset=-2, yoffset=7, xadvance=24, page=0, chnl=15},
    { id=119,  x=449, y=161, width=51, height=63, xoffset=-4, yoffset=9, xadvance=38, page=0, chnl=15},
    { id=120,  x=0,   y=92, width=47, height=68, xoffset=-10, yoffset=-2, xadvance=27, page=0, chnl=15},
    { id=121,  x=236, y=0, width=43, height=80, xoffset=-5, yoffset=3, xadvance=29, page=0, chnl=15},
    { id=122,  x=357, y=352, width=42, height=56, xoffset=-10, yoffset=10, xadvance=29, page=0, chnl=15},
    { id=123,  x=18,  y=0, width=44, height=84, xoffset=3, yoffset=5, xadvance=52, page=0, chnl=15},
    { id=124,  x=0,   y=0, width=17, height=91, xoffset=5, yoffset=4, xadvance=28, page=0, chnl=15},
    { id=125,  x=63,  y=0, width=44, height=84, xoffset=5, yoffset=5, xadvance=52, page=0, chnl=15},
    { id=8470, x=324, y=0, width=80, height=74, xoffset=-2, yoffset=4, xadvance=77, page=0, chnl=15},
}

FONT_BRICK = djui_hud_add_font(get_texture_info("char-select-font-brick"), fontdataBrick, -10, 0, "x", 1)