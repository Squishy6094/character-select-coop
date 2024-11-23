--[[
    Some functions we need for the hud
    Color hud code written by EmilyEmmi
    Djui box code written by xLuigiGamerx (Use outside of character select is forbidden as these functions were made for another mod I'm planning to release)
]]

function convert_color(text)
    if text:sub(2, 2) ~= "#" then
        return nil
    end
    text = text:sub(3, -2)
    local rstring = text:sub(1, 2) or "ff"
    local gstring = text:sub(3, 4) or "ff"
    local bstring = text:sub(5, 6) or "ff"
    local astring = text:sub(7, 8) or "ff"
    local r = tonumber("0x" .. rstring) or 255
    local g = tonumber("0x" .. gstring) or 255
    local b = tonumber("0x" .. bstring) or 255
    local a = tonumber("0x" .. astring) or 255
    return r, g, b, a
end

-- removes color string
function remove_color(text, get_color)
    local start = text:find("\\")
    local next = 1
    while (next ~= nil) and (start ~= nil) do
        start = text:find("\\")
        if start ~= nil then
            next = text:find("\\", start + 1)
            if next == nil then
                next = text:len() + 1
            end

            if get_color then
                local color = text:sub(start, next)
                local render = text:sub(1, start - 1)
                text = text:sub(next + 1)
                return text, color, render
            else
                text = text:sub(1, start - 1) .. text:sub(next + 1)
            end
        end
    end
    return text
end

---@param x integer X Offset
---@param y integer Y Offset
---@param width integer Width
---@param height integer Height
---@param r integer Red Value: Must be between 0-255 (Default: 0)
---@param g integer Green Value: Must be between 0-255 (Default: 0)
---@param b integer Blue Value: Must be between 0-255 (Default: 0)
function djui_hud_render_djui(x, y, width, height, r, g, b)

    red = 0 or r
    green = 0 or g
    blue = 0 or b

    djui_hud_set_color(red, green, blue, 200)
    djui_hud_render_rect(x, y, width, height)

    djui_hud_set_color(red, green, blue, 140)
    djui_hud_render_rect(x + 8, y + 8, width - 16, height - 16)

end

---@param text string
---@param x integer
---@param y integer
---@param scale integer
---@param red integer
---@param green integer
---@param blue integer
---@param alpha integer
function djui_hud_print_text_with_color(text, x, y, scale, red, green, blue, alpha)
    djui_hud_set_color(red or 255, green or 255, blue or 255, alpha or 255)
    local space = 0
    local color = ""
    text, color, render = remove_color(text, true)
    while render ~= nil do
        local r, g, b, a = convert_color(color)
        if alpha then a = alpha end
        djui_hud_print_text(render, x + space, y, scale);
        if r then djui_hud_set_color(r, g, b, a) end
        space = space + djui_hud_measure_text(render) * scale
        text, color, render = remove_color(text, true)
    end
    djui_hud_print_text(text, x + space, y, scale);
end

---@param text string Message
---@param headerYOffset integer A y offset for the header
---@param a integer Text Alpha Value
---@param scale integer Scale
---@param x integer X Offset
---@param y integer Y Offset
---@param width integer Width
---@param height integer Height
---@param r integer Red Value: Must be between 0-255 (Default: 0)
---@param g integer Green Value: Must be between 0-255 (Default: 0)
---@param b integer Blue Value: Must be between 0-255 (Default: 0)
function djui_hud_render_header_box(text, headerYOffset, tr, tg, tb, a, scale, x, y, width, height, r, g, b)
    djui_hud_set_font(FONT_MENU)
    djui_hud_render_djui(x, y, width, height, r, g, b)
    djui_hud_print_text_with_color(text, x + width / 2 - (djui_hud_measure_text((string.gsub(text, "\\(.-)\\", ""))) * scale) / 2, y + 14.5 + headerYOffset, scale, tr, tg, tb, a)
end
