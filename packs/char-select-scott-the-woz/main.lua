-- name: [CS] Scott the Woz
-- description: Hey all, Scott Here!\n\n\\#ff7777\\This Pack requires Character Select\nto use as a Library!

local E_MODEL_SCOTT = smlua_model_util_get_id("scott_geo")

local TEXT_MOD_NAME = "Scott the Woz"

if _G.charSelectExists then
    scottPos = _G.charSelect.character_add("Scott the Woz", {"Hey all, Scott Here!"}, "ArcyThePuppet", {r = 0, g = 0, b = 255}, E_MODEL_SCOTT, CT_MARIO, nil)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end

local djui_hud_render_rect, djui_hud_get_screen_width, djui_hud_get_screen_height, djui_hud_set_resolution,
djui_hud_set_color, math_min, math_max, char_select_model_num, char_select_menu_open = djui_hud_render_rect,
djui_hud_get_screen_width, djui_hud_get_screen_height, djui_hud_set_resolution, djui_hud_set_color, math.min,
math.max, _G.charSelect.character_get_current_model_number, _G.charSelect.is_menu_open

local borderTransparency = 0
local borderSpeed = 20
local function hud_render() -- Render Blue Border
    if char_select_model_num() == scottPos and not char_select_menu_open() then
        borderTransparency = math_min(255, borderTransparency + borderSpeed)
    else
        borderTransparency = math_max(0, borderTransparency - borderSpeed)
    end
    
    djui_hud_set_resolution(RESOLUTION_DJUI)
    djui_hud_set_color(0, 0, 255, borderTransparency)
    local width = djui_hud_get_screen_width()
    local height = djui_hud_get_screen_height()
    local borderThickness = 13
    djui_hud_render_rect(0, 0, borderThickness, height)
    djui_hud_render_rect(borderThickness, 0, width, borderThickness)
    djui_hud_render_rect(width - borderThickness, borderThickness, borderThickness, height - borderThickness*2)
    djui_hud_render_rect(borderThickness, height - borderThickness, width, borderThickness)
end

if _G.charSelectExists then
    hook_event(HOOK_ON_HUD_RENDER, hud_render)
end