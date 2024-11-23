------------------------------------------------------
-- Custom HUD Rendering by Agent X and xLuigiGamerx --
------------------------------------------------------

if incompatibleClient then return 0 end

-- localize functions to improve performance - n-hud.lua
local hud_get_value,hud_set_value,djui_hud_print_text,tostring,hud_set_flash,get_global_timer,hud_get_flash,djui_hud_get_screen_width,math_ceil,obj_get_first_with_behavior_id,get_behavior_from_id,count_objects_with_behavior,djui_hud_render_rect,djui_hud_set_resolution,djui_hud_get_screen_height,djui_hud_set_color,djui_hud_set_font,djui_hud_measure_text,djui_chat_message_create,hud_is_hidden,djui_is_playerlist_open = hud_get_value,hud_set_value,djui_hud_print_text,tostring,hud_set_flash,get_global_timer,hud_get_flash,djui_hud_get_screen_width,math.ceil,obj_get_first_with_behavior_id,get_behavior_from_id,count_objects_with_behavior,djui_hud_render_rect,djui_hud_set_resolution,djui_hud_get_screen_height,djui_hud_set_color,djui_hud_set_font,djui_hud_measure_text,djui_chat_message_create,hud_is_hidden,djui_is_playerlist_open

--[[
    Some functions we need for the hud
    Color hud code written by EmilyEmmi
    Djui box code written by xLuigiGamerx (Use outside of character select is forbidden as these functions were made for another mod I'm planning to release)
]]

local function convert_color(text)
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
local function remove_color(text, get_color)
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
local function djui_hud_render_djui(x, y, width, height, r, g, b)

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
local function djui_hud_print_text_with_color(text, x, y, scale, red, green, blue, alpha)
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
local function djui_hud_render_header_box(text, headerYOffset, tr, tg, tb, a, scale, x, y, width, height, r, g, b)
    djui_hud_set_font(FONT_MENU)
    djui_hud_render_djui(x, y, width, height, r, g, b)
    djui_hud_print_text_with_color(text, x + width / 2 - (djui_hud_measure_text((string.gsub(text, "\\(.-)\\", ""))) * scale) / 2, y + 14.5 + headerYOffset, scale, tr, tg, tb, a)
end

---------------------
-- Real HUD Stuffs --
---------------------

local sHudElements = {
    [HUD_DISPLAY_FLAG_LIVES] = true,
    [HUD_DISPLAY_FLAG_STAR_COUNT] = true,
    [HUD_DISPLAY_FLAG_CAMERA] = true
}

---Hides the specified custom hud element
---@param hudElement HUDDisplayFlag
function hud_hide_element(hudElement)
    if sHudElements[hudElement] == nil then return false end
    sHudElements[hudElement] = false
    return true
end

---Shows the specified custom hud element
---@param hudElement HUDDisplayFlag
function hud_show_element(hudElement)
    if sHudElements[hudElement] == nil then return false end
    sHudElements[hudElement] = true
    return true
end

---Gets the specified custom hud element's state
---@param hudElement HUDDisplayFlag
function hud_get_element(hudElement)
    if sHudElements[hudElement] == nil then return false end
    return sHudElements[hudElement]
end

local MATH_DIVIDE_16 = 1/16

local FONT_USER = FONT_NORMAL

local defaultNames = {
    [CT_MARIO] = "Mario",
    [CT_LUIGI] = "Luigi",
    [CT_TOAD] = "Toad",
    [CT_WALUIGI] = "Waluigi",
    [CT_WARIO] = "Wario"
}
--- @param localIndex integer
--- @return string
--- This assumes multiple characters will not have the same model,
--- Icons can only be seen by users who have the character avalible to them
function name_from_local_index(localIndex)
    for i = 1, #characterTable do
        if i == 1 and characterTable[i].saveName == gPlayerSyncTable[localIndex].saveName then
            return defaultNames[gMarioStates[localIndex].character.type]
        end
        if characterTable[i].saveName == gPlayerSyncTable[localIndex].saveName then
            return characterTable[i].name
        end
    end
    return "???"
end

local defaultMenuColors = {
    [CT_MARIO] = { r = 255, g = 50,  b = 50  },
    [CT_LUIGI] = { r = 50,  g = 255, b = 50  },
    [CT_TOAD] =  { r = 50,  g = 50,  b = 255 },
    [CT_WALUIGI] = { r = 130, g = 25,  b = 130 },
    [CT_WARIO] = { r = 255, g = 255, b = 50  }
}
--- @param localIndex integer
--- @return table
--- This assumes multiple characters will not have the same model,
--- Icons can only be seen by users who have the character avalible to them
function color_from_local_index(localIndex)
    for i = 1, #characterTable do
        if i == 1 and characterTable[i].saveName == gPlayerSyncTable[localIndex].saveName then
            return defaultMenuColors[gMarioStates[localIndex].character.type]
        end
        if characterTable[i].saveName == gPlayerSyncTable[localIndex].saveName then
            return characterTable[i].color
        end
    end
    return {r = 255, g = 255, b = 255}
end

local defaultIcons = {
    [CT_MARIO] = gTextures.mario_head,
    [CT_LUIGI] = gTextures.luigi_head,
    [CT_TOAD] = gTextures.toad_head,
    [CT_WALUIGI] = gTextures.waluigi_head,
    [CT_WARIO] = gTextures.wario_head
}
--- @param localIndex integer
--- @return TextureInfo|nil
--- This assumes multiple characters will not have the same model,
--- Icons can only be seen by users who have the character avalible to them.
--- This function can return nil. if this is the case, render `djui_hud_print_text("?", x, y, 1)`
function life_icon_from_local_index(localIndex)
    for i = 1, #characterTable do
        local char = characterTable[i]
        if char.saveName == gPlayerSyncTable[localIndex].saveName then
            return char[gPlayerSyncTable[localIndex].currAlt].lifeIcon
        end
    end
    return nil
end

--- @param localIndex integer
--- @return TextureInfo
--- This assumes multiple characters will not have the same model,
--- Icons can only be seen by users who have the character avalible to them
function star_icon_from_local_index(localIndex)
    for i = 1, #characterTable do
        local char = characterTable[i]
        if char.saveName == gPlayerSyncTable[localIndex].saveName then
            return char[gPlayerSyncTable[localIndex].currAlt].starIcon
        end
    end
    return gTextures.star
end

local pieTextureNames = {
    "one_segments",
    "two_segments",
    "three_segments",
    "four_segments",
    "five_segments",
    "six_segments",
    "seven_segments",
    "full",
}

local function render_hud_health()
	local textureTable = characterTable[currChar].healthTexture
	if textureTable then -- sets health HUD to custom textures
		if textureTable.label.left and textureTable.label.right then -- if left and right label textures exist. BOTH have to exist to be set!
			texture_override_set("texture_power_meter_left_side", textureTable.label.left)
			texture_override_set("texture_power_meter_right_side", textureTable.label.right)
		end
		
		for i = 1, 8 do
			texture_override_set("texture_power_meter_" .. pieTextureNames[i], textureTable.pie[i])
		end
	else -- resets the health HUD
		texture_override_reset("texture_power_meter_left_side")
		texture_override_reset("texture_power_meter_right_side")
		
		for i = 1, 8 do
			texture_override_reset("texture_power_meter_" .. pieTextureNames[i])
		end
	end
end

local function render_hud_mario_lives()
    hud_set_value(HUD_DISPLAY_FLAGS, hud_get_value(HUD_DISPLAY_FLAGS) & ~HUD_DISPLAY_FLAG_LIVES)

    if not hud_get_element(HUD_DISPLAY_FLAG_LIVES) then return end

    local x = 22
    local y = 15 -- SCREEN_HEIGHT - 209 - 16
    local lifeIcon = life_icon_from_local_index(0)

    if lifeIcon == nil then
        djui_hud_print_text("?", x, y, 1)
    else
        djui_hud_render_texture(lifeIcon, x, y, 1 / (lifeIcon.width * MATH_DIVIDE_16), 1 / (lifeIcon.height * MATH_DIVIDE_16))
    end
    djui_hud_print_text("@", x + 16, y, 1)
    djui_hud_print_text(tostring(hud_get_value(HUD_DISPLAY_LIVES)):gsub("-", "M"), x + 32, y, 1)
end

local function render_hud_stars()
    hud_set_value(HUD_DISPLAY_FLAGS, hud_get_value(HUD_DISPLAY_FLAGS) & ~HUD_DISPLAY_FLAG_STAR_COUNT)

    if not hud_get_element(HUD_DISPLAY_FLAG_STAR_COUNT) then return end
    if hud_get_flash ~= nil then
        -- prevent star count from flashing outside of castle
        if gNetworkPlayers[0].currCourseNum ~= COURSE_NONE then hud_set_flash(0) end

        if hud_get_flash() == 1 and (get_global_timer() & 0x08) == 0 then
            return
        end
    end

    local x = math_ceil(djui_hud_get_screen_width() - 76)
    if x % 2 ~= 0 then
        x = x - 1
    end
    local y = math_ceil(240 - 209 - 16)
    local starIcon = star_icon_from_local_index(0)

    local showX = 0
    local hudDisplayStars = hud_get_value(HUD_DISPLAY_STARS)
    if hudDisplayStars < 100 then showX = 1 end

    djui_hud_render_texture(starIcon, x, y, 1 / (starIcon.width*MATH_DIVIDE_16), 1 / (starIcon.height*MATH_DIVIDE_16))
    if showX == 1 then
        djui_hud_print_text("@", x + 16, y, 1)
    end
    djui_hud_print_text(tostring(hudDisplayStars):gsub("-", "M"), (showX * 14) + x + 16, y, 1)
end

local function render_hud_camera_status()
    if not HUD_DISPLAY_CAMERA_STATUS then return end

    hud_set_value(HUD_DISPLAY_FLAGS, hud_get_value(HUD_DISPLAY_FLAGS) & ~HUD_DISPLAY_FLAG_CAMERA)

    if not hud_get_element(HUD_DISPLAY_FLAG_CAMERA) then return end

    local x = djui_hud_get_screen_width() - 54
    local y = 205
    local cameraHudStatus = hud_get_value(HUD_DISPLAY_CAMERA_STATUS)

    if cameraHudStatus == CAM_STATUS_NONE then return end

    djui_hud_render_texture(gTextures.camera, x, y, 1, 1)

    switch(cameraHudStatus & CAM_STATUS_MODE_GROUP, {
        [CAM_STATUS_MARIO] = function()
            local lifeIcon = life_icon_from_local_index(0)
            if lifeIcon == nil then
                djui_hud_print_text("?", x + 16, y, 1)
            else
                djui_hud_render_texture(lifeIcon, x + 16, y, 1 / (lifeIcon.width * MATH_DIVIDE_16), 1 / (lifeIcon.height * MATH_DIVIDE_16))
            end
        end,
        [CAM_STATUS_LAKITU] = function()
            djui_hud_render_texture(gTextures.lakitu, x + 16, y, 1, 1)
        end,
        [CAM_STATUS_FIXED] = function()
            djui_hud_render_texture(gTextures.no_camera, x + 16, y, 1, 1)
        end
    })

    switch(cameraHudStatus & CAM_STATUS_C_MODE_GROUP, {
        [CAM_STATUS_C_DOWN] = function()
            djui_hud_render_texture(gTextures.arrow_down, x + 4, y + 16, 1, 1)
        end,
        [CAM_STATUS_C_UP] = function()
            djui_hud_render_texture(gTextures.arrow_up, x + 4, y - 8, 1, 1)
        end
    })
end

-- Act Select Hud --
local function render_act_select_hud()

    local course, starBhvCount, sVisibleStars -- Localizing variables

    course = gNetworkPlayers[0].currCourseNum
    if gServerSettings.enablePlayersInLevelDisplay == 0 or course == 0 or obj_get_first_with_behavior_id(id_bhvActSelector) == nil then return end

    starBhvCount = count_objects_with_behavior(get_behavior_from_id(id_bhvActSelectorStarType))
    sVisibleStars = starBhvCount < 7 and starBhvCount or 6

    for a = 1, sVisibleStars do
        local x = (139 - sVisibleStars * 17 + a * 34) + (djui_hud_get_screen_width() / 2) - 160 + 0.5
        for j = 1, MAX_PLAYERS - 1 do -- 0 is not needed due to the due to the fact that you are never supposed to see yourself in the act
            local np = gNetworkPlayers[j]
            if np and np.connected and np.currCourseNum == course and np.currActNum == a then
                djui_hud_render_rect(x - 4, 17, 16, 16)
                local displayHead = life_icon_from_local_index(j)
                if displayHead == nil then
                    djui_hud_print_text("?", x - 4, 17, 1)
                else
                    djui_hud_render_texture(displayHead, x - 4, 17, 1 / (displayHead.width/16), 1 / (displayHead.height * MATH_DIVIDE_16))
                end
                break
            end
        end
    end
end

function render_playerlist_and_modlist()
    -- PlayerList

    playerListWidth = 710
    playerListHeight = (16 * 32) + (16 - 1) * 4 + (32 + 16) + 32 + 32

    listMargins = 16

    local x = djui_hud_get_screen_width()/2 - playerListWidth/2
    local y = djui_hud_get_screen_height()/2 - playerListHeight/2
    djui_hud_render_header_box("\\#FF3030\\P\\#40E740\\L\\#40B0FF\\A\\#FFEF40\\Y\\#FF3030\\E\\#40E740\\R\\#40B0FF\\S", 0, 0xdc, 0xdc, 0xdc, 0xff, 1, x, y, playerListWidth, playerListHeight, 0, 0, 0)
    djui_hud_set_font(FONT_USER)
    for i = 0, #gNetworkPlayers do
        o = i > (network_player_connected_count() - 1) and i + (network_player_connected_count() - 1) or 0
        p = math.abs(i - o)
        np = gNetworkPlayers[i]
        if gNetworkPlayers[i].name ~= "" then
            v = (p % 2) ~= 0 and 16 or 32
            djui_hud_set_color(v, v, v, 128)
            entryWidth = playerListWidth - ((8 + listMargins) * 2)
            entryHeight = 32
            entryX = x + 8 + listMargins
            entryY = y + 124 + 0 + ((entryHeight + 4) * (p - 1))
            djui_hud_render_rect(entryX, entryY, entryWidth, entryHeight)
            hudTex = life_icon_from_local_index(i) or get_texture_info("texture_hud_char_question") -- Question Mark

            playerNameColor = {
                r = 127 + network_player_get_override_palette_color_channel(np, CAP, 0) / 2,
                g = 127 + network_player_get_override_palette_color_channel(np, CAP, 1) / 2,
                b = 127 + network_player_get_override_palette_color_channel(np, CAP, 2) / 2
            }

            if hudTex then
                djui_hud_set_color(255, 255, 255, 255)
                djui_hud_render_texture(hudTex, entryX, entryY, hudTex.width/8, hudTex.height/8)
                djui_hud_print_text_with_color(np.name, entryX + 40, entryY, 1, playerNameColor.r, playerNameColor.g, playerNameColor.b, 255)
            else
                djui_hud_print_text_with_color(np.name, entryX, entryY, 1, playerNameColor.r, playerNameColor.g, playerNameColor.b, 255)
            end

            local levelName = get_level_name(np.currCourseNum, np.currLevelNum, np.currAreaIndex)
            if levelName then
                djui_hud_print_text_with_color(levelName, ((entryX + entryWidth) - djui_hud_measure_text((string.gsub(levelName, "\\(.-)\\", "")))) - 126, entryY, 1, 0xdc, 0xdc, 0xdc, 255)
            end

            if np.currActNum then
                currActNum = np.currActNum == 99 and "Done" or np.currActNum ~= 0 and "# "..tostring(np.currActNum) or ""
                printedcurrActNum = currActNum
                djui_hud_print_text_with_color(printedcurrActNum, entryX + entryWidth - djui_hud_measure_text(printedcurrActNum) - 18, entryY, 1, 0xdc, 0xdc, 0xdc, 255)
            end

            if np.description then
                djui_hud_print_text_with_color(np.description, (entryX + 278) - (djui_hud_measure_text((string.gsub(np.description, "\\(.-)\\", "")))/2), entryY, 1, np.descriptionR, np.descriptionG, np.descriptionB, np.descriptionA)
            end
        end
    end

    -- ModList

    modListWidth = 280
    modListHeight = ((#gActiveMods + 1) * 32) + ((#gActiveMods + 1) - 1) * 4 + (32 + 16) + 32 + 32
    mX = djui_hud_get_screen_width()/2 + 363
    mY = djui_hud_get_screen_height()/2 - modListHeight/2

    djui_hud_render_header_box("\\#FF3030\\M\\#40E740\\O\\#40B0FF\\D\\#FFEF40\\S", 0, 0xdc, 0xdc, 0xdc, 0xff, 1, mX, mY, modListWidth, modListHeight, 0, 0, 0)
    djui_hud_set_font(FONT_USER)

    for i = 0, #gActiveMods do
        v = (i % 2) ~= 0 and 16 or 32
        djui_hud_set_color(v, v, v, 128)
        entryWidth = modListWidth - ((8 + listMargins) * 2)
        entryHeight = 32
        entryX = mX + 8 + listMargins
        entryY = mY + 124 + 0 + ((entryHeight + 4) * (i - 1))
        djui_hud_render_rect(entryX, entryY, entryWidth, entryHeight)
        djui_hud_print_text_with_color(gActiveMods[i].name, entryX, entryY, 1, 0xdc, 0xdc, 0xdc, 255)
    end
end

local function on_hud_render_behind()
    FONT_USER = djui_menu_get_font()
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_HUD)
    djui_hud_set_color(255, 255, 255, 255)

    if gNetworkPlayers[0].currActNum == 99 or gMarioStates[0].action == ACT_INTRO_CUTSCENE or hud_is_hidden() or obj_get_first_with_behavior_id(id_bhvActSelector) ~= nil then
        return
    end

    render_hud_mario_lives()
    render_hud_stars()
    render_hud_camera_status()
    render_hud_health()
end

_G.charSelect = {
    enablePlayerList = true -- Set to false to disable the playerlist
}

local function on_hud_render()
    djui_hud_set_resolution(RESOLUTION_N64)
    djui_hud_set_font(FONT_HUD)
    djui_hud_set_color(255, 255, 255, 255)

    if obj_get_first_with_behavior_id(id_bhvActSelector) ~= nil then
        render_act_select_hud()
    end

    gServerSettings.enablePlayerList = false -- Disables the original playerlist and modlist

    local enablePlayerList = charSelect.enablePlayerList -- gServerSettings.enablePlayerList but for the character select playerlist
    djui_hud_set_resolution(RESOLUTION_DJUI)

    if djui_attempting_to_open_playerlist() and enablePlayerList then
        render_playerlist_and_modlist()
    end
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, on_hud_render_behind)
hook_event(HOOK_ON_HUD_RENDER, on_hud_render)