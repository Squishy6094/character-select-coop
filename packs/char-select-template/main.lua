-- name: [CS] Model Pack Template
-- description: Character Select Template made to show to basics of making a Model Pack

-- Custom Model(s) Used, Duplicate Variable and Add Character Function if you need more Models
-- We use Yuyake's Armature Model as an Example
local E_MODEL_CUSTOM_MODEL = smlua_model_util_get_id("custom_model_geo")

-- Model Pack name used 
local TEXT_MOD_NAME = "Character Template"

if _G.charSelectExists then

-- Function to Add Character   |    Model Name     |        Description        |        Credit         |   Model Color (RGB 0-255)  |    Model Variable   | Forced Character
    _G.charSelect.character_add("Custom Model Name", "Custom Model Description", "Custom Model Creator", {r = 255, g = 200, b = 200}, E_MODEL_CUSTOM_MODEL, CT_MARIO)

else

-- Error if the Library is not found, You can ignore this :3
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)

end

--[[
    Notes:
    Function to Add Character can be used as many times as you need!

    Underscores ( _ ) will be turned into spaces as a result of the save system
    
    You can use a Color Picker to get your RGB (decimal format) Color.
    The Color is used for the Menu and can be left as nil.

    The Model Varible is referenced at the Top of the script and defines your model
    Ensure that the smlua_model_util_get_id() function uses you model name from the actors folder

    Forced Character is used to make the Character play like one of the base coop players
    This is used if you want your Character to play a certain way (Or just needs Waluigi's Offsets) 

    Any and All inputs can be left as nil, Altough it won't be too polished
]]