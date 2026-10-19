-- Library for Making sure HUD elements don't overlap each other
-- Made by: Squishy6094

-- Renders Debugging HUD
local HUD_DODGE_HITBOXES_RENDER = false
-- Make Default HUD Elements spaced based on thier max value
local HUD_DODGE_SAFE_DEFAULT = false

djui_hud_set_resolution(RESOLUTION_N64)
local hitboxMarginX = 2
local hitboxMarginY = 4
local screenMarginLeft = djui_hud_get_screen_width()*0.5
local screenMarginTop = djui_hud_get_screen_height()*0.5
local screenSegments = 3

local prevHitboxList = {}
local hitboxList = {}
local debugFindList = {}
local isRenderBehind = true
local queueInModInternal = false
local queueInMod = 0
local queueInModGroup = 0

-- Shared so all instances of hud dodge know what's being used in hud dodge
local prev_hud_dodge_queue_in_mod = hud_dodge_queue_in_mod
_G.hud_dodge_queue_in_mod = function(value)
    queueInMod = value
    queueInModInternal = false
    if prev_hud_dodge_queue_in_mod then
        prev_hud_dodge_queue_in_mod(value)
    end
end
_G.hudDodgeDebugRendering = false

-- Utils

local function ceil_power(x)
    local p = 1
    while p < x do p = p * 2 end
    return p
end

local function table_get_common_entry(list)
    local entryCount = {}
    for _, entry in pairs(list) do
        if not entryCount[entry] then
            entryCount[entry] = 0
        end
        entryCount[entry] = entryCount[entry] + 1
    end

    local maxCount = 0
    local maxEntry = nil
    for entry, count in pairs(entryCount) do
        if count > maxCount then
            maxCount = count
            maxEntry = entry
        end
    end
    return maxEntry or 0
end

local function rects_overlap(x1, y1, w1, h1, x2, y2, w2, h2)
    return x1 <= x2 + w2 and
           x1 + w1 >= x2 and
           y1 <= y2 + h2 and
           y1 + h1 >= y2
end

local function add_hitbox(x, y, w, h, inMod)
    if _G.hudDodgeDebugRendering then return end
    inMod = inMod or 0
    if queueInMod > 0 then
        if queueInModInternal then
            inMod = queueInModGroup
        else
            inMod = -1
        end
        queueInMod = queueInMod - 1
    end

    local overlap = false
    for _, hitbox in pairs(hitboxList) do
        if rects_overlap(x, y, w, h, hitbox.x + 1, hitbox.y + 1, hitbox.w - 2, hitbox.h - 2) then
            overlap = true
            break
        end
    end

    if not overlap then
        table.insert(hitboxList, {
            x = x,
            y = y,
            w = w,
            h = h,
            inMod = inMod,
            behind = isRenderBehind,
        })
    end
end

local function reset_hitbox_list()
    local m = gMarioStates[0];
    local sW = djui_hud_get_screen_width() + 1
    local sH = djui_hud_get_screen_height()
    queueInModGroup = 0
    prevHitboxList = hitboxList
    hitboxList = {}
    debugFindList = {}

    local showHud = (not djui_hud_is_pause_menu_created() and not hud_is_hidden());
    local hudDisplayFlags = hud_get_value(HUD_DISPLAY_FLAGS)

    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_HUD)

    --[[
    if (gCurrentArea != NULL && gCurrentArea->camera != NULL && gCurrentArea->camera->mode == CAMERA_MODE_INSIDE_CANNON) {
        render_hud_cannon_reticle();
    }
    ]]

    if (hudDisplayFlags & HUD_DISPLAY_FLAG_LIVES ~= 0 and showHud) then
        add_hitbox(22, 15, 16, 16, false)
        local xW, xH = djui_hud_measure_text("*")
        add_hitbox(38, 15, xW, xH, false)
        local cW, cH = djui_hud_measure_text(tostring(HUD_DODGE_SAFE_DEFAULT and gLevelValues.maxLives or hud_get_value(HUD_DISPLAY_LIVES)))
        add_hitbox(54, 15, cW, cH, false)
    end

    -- coop hud elements
    if (showHud) then
        if (gLevelValues.hudCapTimer ~= 0) then
            local capFlags = m.flags & MARIO_SPECIAL_CAPS;
            if (capFlags ~= 0) then
                local capTimer = m.capTimer;
                if (capTimer > 0) then
                    add_hitbox(22, 35, 16, 16, false)
                    local xW, xH = djui_hud_measure_text("*")
                    add_hitbox(38, 35, xW, xH, false)
                    local cW, cH = djui_hud_measure_text(tostring(HUD_DODGE_SAFE_DEFAULT and math.ceil(0x10000 / 30) or math.ceil(m.capTimer/30)))
                    add_hitbox(54, 35, cW, cH, false)
                end
            end
        end

        
        if (m.marioObj) then
            local radarY = sH - 35
            -- Red coins radar
            if (gLevelValues.hudRedCoinsRadar ~= 0) then
                local redCoin = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvRedCoin);
                if (redCoin) then
                    add_hitbox(15, radarY - 6, 28, 28, false)
                    local cW, cH = djui_hud_measure_text(tostring(0x8000))
                    add_hitbox(47, radarY, cW, cH, false)

                    radarY = radarY - 30;
                end
            end

            -- Secrets radar
            if (gLevelValues.hudSecretsRadar ~= 0) then
                local secret = obj_get_nearest_object_with_behavior_id(m.marioObj, id_bhvHiddenStarTrigger);
                if (secret) then
                    add_hitbox(15, radarY - 6, 28, 28, false)
                    local cW, cH = djui_hud_measure_text(tostring(0x8000))
                    add_hitbox(47, radarY, cW, cH, false)

                    radarY = radarY - 30;
                end
            end
        end
    end

    if (hudDisplayFlags & HUD_DISPLAY_FLAG_COIN_COUNT ~= 0 and showHud) then
        local coinX = sW*0.5 + 8
        add_hitbox(coinX, 15, 16, 16, false)
        local xW, xH = djui_hud_measure_text("*")
        add_hitbox(coinX + 17, 15, xW, xH, false)
        local cW, cH = djui_hud_measure_text(tostring(HUD_DODGE_SAFE_DEFAULT and gLevelValues.maxCoins or hud_get_value(HUD_DISPLAY_COINS)))
        add_hitbox(coinX + 32, 15, cW, cH, false)
    end

    if (hudDisplayFlags & HUD_DISPLAY_FLAG_STAR_COUNT ~= 0 and showHud) then

        local showX = 0
        if (gHudDisplay.stars < 100) then
            showX = 1;
        end

        local x = math.ceil(sW - 78)
        add_hitbox(x, 15, 16, 16, false)
        if (showX == 1) then
            local xW, xH = djui_hud_measure_text("*")
            add_hitbox(x + 17, 15, xW, xH, false)
        end
        local cW, cH = djui_hud_measure_text(tostring(HUD_DODGE_SAFE_DEFAULT and (showX == 0 and 999 or 99) or hud_get_value(HUD_DISPLAY_STARS)))
        add_hitbox(x + 19 + showX*14, 15, cW, cH, false)
    end

    if (hudDisplayFlags & HUD_DISPLAY_FLAG_KEYS ~= 0 and showHud) then
        if gHudDisplay.keys > 0 then
            for i = 1, gHudDisplay.keys do
                add_hitbox(22 + ((i - 1) * 16), 82, 16, 16, false)
            end
        end
    end

    --[[
    -- Lazy
    if (hudDisplayFlags & HUD_DISPLAY_FLAG_CAMERA_AND_POWER ~= 0 and showHud) then
        if (hudDisplayFlags & HUD_DISPLAY_FLAG_CAMERA ~= 0 and showHud) then
            render_hud_camera_status();
        end

        if (hudDisplayFlags & HUD_DISPLAY_FLAG_POWER ~= 0 and showHud) then
            render_hud_power_meter();
        end
    end
    ]]

    if (hudDisplayFlags & HUD_DISPLAY_FLAG_TIMER ~= 0 and showHud) then
    --[[
        void render_hud_timer(void) {
            u8 *(*hudLUT)[58];
            u16 timerValFrames;
            u16 timerMins;
            u16 timerSecs;
            u16 timerFracSecs;

            timerValFrames = gHudDisplay.timer;
            timerMins = timerValFrames / (30 * 60);
            timerSecs = (timerValFrames - (timerMins * 1800)) / 30;
            
                local xW, xH = djui_hud_measure_text("*")
                add_hitbox(x = x + 17, y = 15, w = xW, h = xH, false)

            timerFracSecs = ((timerValFrames - (timerMins * 1800) - (timerSecs * 30)) & 0xFFFF) / 3;
            print_text(GFX_DIMENSIONS_RECT_FROM_RIGHT_EDGE(150), 185, "TIME");
            print_text_fmt_int(GFX_DIMENSIONS_RECT_FROM_RIGHT_EDGE(91), 185, "%0d", timerMins);
            print_text_fmt_int(GFX_DIMENSIONS_RECT_FROM_RIGHT_EDGE(71), 185, "%02d", timerSecs);
            print_text_fmt_int(GFX_DIMENSIONS_RECT_FROM_RIGHT_EDGE(37), 185, "%d", timerFracSecs);
            gSPDisplayList(gDisplayListHead++, dl_hud_img_begin);
            render_hud_tex_lut(GFX_DIMENSIONS_RECT_FROM_RIGHT_EDGE(81), 32, (*hudLUT)[GLYPH_APOSTROPHE]);
            render_hud_tex_lut(GFX_DIMENSIONS_RECT_FROM_RIGHT_EDGE(46), 32, (*hudLUT)[GLYPH_DOUBLE_QUOTE]);
            gSPDisplayList(gDisplayListHead++, dl_hud_img_end);
        }
    ]]

        local dW, dH = djui_hud_measure_text("9")
        local d2W, d2H = djui_hud_measure_text("99")
        add_hitbox(sW - 91, 39, dW, dH, false)
        add_hitbox(sW - 71, 39, d2W, d2H, false)
        add_hitbox(sW - 37, 39, dW, dH, false)
    end
end

local og_djui_hud_render_rect = djui_hud_render_rect
local og_djui_hud_print_text = djui_hud_print_text
local og_djui_hud_render_texture = djui_hud_render_texture
local og_djui_hud_render_texture_tile = djui_hud_render_texture_tile
local og_hud_render_power_meter = hud_render_power_meter
local og_hud_render_power_meter_interpolated = hud_render_power_meter_interpolated

_G.djui_hud_render_rect = function (x, y, w, h)
    local sW = djui_hud_get_screen_width()
    local sH = djui_hud_get_screen_height()
    if (w/sW) < 0.9 and (h/sH) < 0.9 then
        add_hitbox(x, y, w, h)
    end
    og_djui_hud_render_rect(x, y, w, h)
end

_G.djui_hud_print_text = function (message, x, y, scaleX, scaleY)
    scaleY = scaleY or scaleX
    local msgW, msgH = djui_hud_measure_text(message)
    add_hitbox(x, y, msgW*scaleX, msgH*scaleY)
    og_djui_hud_print_text(message, x, y, scaleX, scaleY)
end

_G.djui_hud_render_texture = function (tex, x, y, w, h)
    add_hitbox(x, y, w*tex.width, h*tex.height)
    og_djui_hud_render_texture(tex, x, y, w, h)
end

_G.djui_hud_render_texture_tile = function (tex, x, y, w, h, tX, tY, tW, tH)
    add_hitbox(x, y, tex.width*(tW/tex.width), tex.height*(tH/tex.height))
    og_djui_hud_render_texture_tile(tex, x, y, w, h, tX, tY, tW, tH)
end

_G.hud_render_power_meter = function (health, x, y, width, height)
    add_hitbox(x, y, width, height)
    og_hud_render_power_meter(health, x, y, width, height)
end

_G.hud_render_power_meter_interpolated = function (health, prevX, prevY, prevWidth, prevHeight, x, y, width, height)
    add_hitbox(x, y, width, height)
    og_hud_render_power_meter_interpolated(health, prevX, prevY, prevWidth, prevHeight, x, y, width, height)
end

local function hud_render_behind()
    isRenderBehind = false
end

local function hud_render()
    djui_hud_set_resolution(RESOLUTION_N64)
    local sW = djui_hud_get_screen_width()
    local sH = djui_hud_get_screen_height()
    screenMarginLeft = sW*0.5
    screenMarginTop = sH*0.5
    _G.hudDodgeDebugRendering = true
    if HUD_DODGE_HITBOXES_RENDER then
        djui_hud_set_color(0, 0, 0, 150)
        for i = 1, screenSegments - 1 do
            djui_hud_render_rect(sW*(i/screenSegments), 0, 1, sH)
            djui_hud_render_rect(0, sH*(i/screenSegments), sW, 1)
        end
    end
    _G.hudDodgeDebugRendering = false
    
    djui_hud_set_font(FONT_SPECIAL)
    for id, hitbox in pairs(hitboxList) do
        _G.hudDodgeDebugRendering = true
        if HUD_DODGE_HITBOXES_RENDER then
            djui_hud_set_color((id)/2*255, (id + 1)/2*255, (id + 2)/2*255, 100)
            djui_hud_render_rect(hitbox.x, hitbox.y, hitbox.w, hitbox.h)
            djui_hud_set_color(0, 0, 0, 255)
            djui_hud_print_text(tostring(id), hitbox.x, hitbox.y, 0.3)
            if hitbox.inMod ~= 0 then
                local inModW, inModH = djui_hud_measure_text(tostring(hitbox.inMod))
                djui_hud_print_text(tostring(hitbox.inMod), hitbox.x + hitbox.w - inModW*0.3, hitbox.y + hitbox.h - inModH*0.3, 0.3)
            end
        end
        _G.hudDodgeDebugRendering = false

        if hitbox.inMod == 0 and hitbox.behind and hitbox.w > 8 and hitbox.h > 8 then
            if 1 == math.ceil(hitbox.x/(sW/screenSegments)) then
                screenMarginTop = math.min(screenMarginTop, math.min(hitbox.y, screenMarginTop))
            end
            if 1 == math.ceil(hitbox.y/(sH/screenSegments)) then
                screenMarginLeft = math.min(screenMarginLeft, math.min(hitbox.x, screenMarginLeft))
            end
            if screenSegments == math.ceil(hitbox.x/(sW/screenSegments)) then
                screenMarginTop = math.min(screenMarginTop, math.abs(math.max(hitbox.y + hitbox.h, sH - screenMarginTop) - sH))
            end
            if screenSegments == math.ceil(hitbox.y/(sH/screenSegments)) then
                screenMarginLeft = math.min(screenMarginLeft, math.abs(math.max(hitbox.x + hitbox.w, sW - screenMarginLeft) - sW))
            end
        end
    end

    _G.hudDodgeDebugRendering = true
    if HUD_DODGE_HITBOXES_RENDER then
        for _, hitbox in pairs(debugFindList) do
            djui_hud_set_color(255, 0, 0, 100)
            djui_hud_render_line(hitbox.x, hitbox.y, hitbox.newX, hitbox.newY, 2)
            djui_hud_set_rotation(0, 0, 0)
            djui_hud_set_color(255, 127, 0, 100)
            djui_hud_render_rect(hitbox.newX, hitbox.newY, hitbox.w, hitbox.h)
        end
    end
    _G.hudDodgeDebugRendering = false
    isRenderBehind = true
    reset_hitbox_list()
end

hook_event(HOOK_ON_MODS_LOADED, function ()
    hook_event(HOOK_ON_HUD_RENDER, hud_render)
    hook_event(HOOK_ON_HUD_RENDER_BEHIND, hud_render_behind)
end)

local function set_hitbox_margin(x, y)
    hitboxMarginX = x
    hitboxMarginY = y
end

local function set_screen_margin(x, y)
    screenMarginLeft = x
    screenMarginTop = y
end

---@param x integer X Posistion of Hitbox
---@param y integer Y Posistion of Hitbox
---@param w integer Width of Hitbox
---@param h integer Height of Hitbox
---@param weightX integer How much the hitbox with prefer moving horozontally
---@param weightY integer How much the hitbox with prefer moving vertically
---@param ignoreRenders integer How many of the next render calls to ignore while finding open HUD space (Default 1)
local function find_open_hud_space(x, y, w, h, weightX, weightY, ignoreRenders)
    weightX = weightX or 1
    weightY = weightY or 1
    ignoreRenders = math.max(ignoreRenders) or 1
    hud_dodge_queue_in_mod(ignoreRenders)
    queueInModInternal = true
    queueInModGroup = queueInModGroup + 1

    local debugData = nil
    if HUD_DODGE_HITBOXES_RENDER then
        debugData = {
            x = x,
            y = y,
            w = w,
            h = h,
            newX = x,
            newY = y,
        }
    end

    local sW = djui_hud_get_screen_width()
    local sH = djui_hud_get_screen_height()
    x = math.clamp(x, screenMarginLeft, sW - screenMarginLeft - w)
    y = math.clamp(y, screenMarginTop, sH - screenMarginTop - h)
    local newX = x
    local newY = y

    repeat
        local overlapFound = false
        for id, hitbox in ipairs(prevHitboxList) do
            -- Avoid accounting for the next rendered and not relevent
            if hitbox.inMod < queueInModGroup and hitbox.behind == isRenderBehind and (math.ceil(x/(sW/screenSegments)) == math.ceil(hitbox.x/(sW/screenSegments)) and math.ceil(y/(sH/screenSegments)) == math.ceil(hitbox.y/(sH/screenSegments))) then
                if rects_overlap(newX, newY, w, h, hitbox.x, hitbox.y, hitbox.w, hitbox.h) then
                    newX = math.lerp(newX, x <= sW*0.5 and math.max(x, hitbox.x + hitbox.w + hitboxMarginX) or math.min(x, hitbox.x - w - hitboxMarginX), weightX)
                    newY = math.lerp(newY, y <= sH*0.5 and math.max(y, hitbox.y + hitbox.h + hitboxMarginY) or math.min(y, hitbox.y - h - hitboxMarginY), weightY)
                    overlapFound = true
                    goto skip
                end
            end
        end
        ::skip::
    until not overlapFound
    if math.abs(newX - x) >= math.abs(newY - y) then
        x = newX
    else
        y = newY
    end
    if HUD_DODGE_HITBOXES_RENDER then
        debugData.newX = x
        debugData.newY = y
        table.insert(debugFindList, debugData)
    end
    return x, y
end

-- Gets the average difference of hitbox height from thier nearest power of 2, useful for detecting different hud styles like OMM
local function find_average_hud_scale(x, y)
    local sW = djui_hud_get_screen_width()
    local sH = djui_hud_get_screen_height()
    if x then x = math.clamp(x, 1, sW) end
    if y then y = math.clamp(y, 1, sH) end
    local scaleList = {}
    for id, hitbox in ipairs(prevHitboxList) do
        if hitbox.behind == isRenderBehind and ((not x or math.ceil(x/(sW/screenSegments)) == math.ceil(hitbox.x/(sW/screenSegments))) and (not y or math.ceil(y/(sH/screenSegments)) == math.ceil(hitbox.y/(sH/screenSegments)))) then
            table.insert(scaleList, math.round((hitbox.h / ceil_power(hitbox.h)*20)))
        end
    end
    return table_get_common_entry(scaleList)/20
end

return {
    set_hitbox_margin = set_hitbox_margin,
    set_screen_margin = set_screen_margin,
    find_open_hud_space = find_open_hud_space,
    find_average_hud_scale = find_average_hud_scale,
}