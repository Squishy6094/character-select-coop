--[[
local s1 = 0.5
local s2 = 0.25
local x1 = 24
local y1 = 39
local y2 = y1 + 9
local y3 = y2 + 18
local y4 = y3 + 9
]]
show_info = 0

local kingActions = {
    -- king
    [ACT_KING_BOUNCE] = "King - Bubble Bounce",
    [ACT_KING_BOUNCE_JUMP] = "King - Bubble Bounce Jump",
    [ACT_KING_BOUNCE_LAND] = "King - Bubble Bounce Land",
    [ACT_KING_AIRCHARGE] = "King - Air-Dash Charge",
    [ACT_KING_GRNDCHARGE] = "King - Ground-dash Charge",
    [ACT_KING_ROLL] = "King - Rolling",
    [ACT_KING_AIRROLL] = "King - Air-Rolling",
    [ACT_KING_JUMP] = "King - Jumping",
    [ACT_KING_DOUBLE_JUMP] = "King - Double Jumping",
    [ACT_KING_WALK] = "King - Walking",
    [ACT_KING_WATER_RUN] = "King - Water Run",
    [ACT_KING_HIT_WALL] = "King - Hit Wall",

    -- old
    [ACT_OLD_BOUNCE] = "Old - Bubble Bounce",
    [ACT_OLD_ROLLDASH] = "Old - Roll-Dash Charge",

    -- all
    [ACT_CHAR_SELECT] = "All - Character Select",
    [ACT_MEMER_FLYING] = "All - Flying",
    [ACT_MEMER_FLIGHT_IDLE] = "All - Flight Idle",
    [ACT_MEMER_FLIGHT_SKID] = "All - Flight Skid",
    [ACT_MEMER_FLIGHT_CHARGE] = "All - Fly-Dash Charge",
    [ACT_MEMER_SWIMMING] = "All - Swimming",
    [ACT_MEMER_WATER_IDLE] = "All - Swim Idle",
    [ACT_MEMER_WATER_SKID] = "All - Swim Skid",
    [ACT_MEMER_WATER_CHARGE] = "All - Swim-Dash Charge",
    [ACT_MEMER_WATER_THROW] = "All - Swim Throw",
}

local kingCharName = {
    [0] = {
        name = "None",
        subName = "Literally Nobody",
    },
    [1] = {
        name = "King",
        subName = "The Memer",
    },
    [2] = {
        name = "Old",
        subName = "King from v2",
    },
    [3] = {
        name = "Maximum",
        subName = "this isnt technically a character, i just use it so the character select cant go over the highest character slot",
    }
}

local TEXT_DEBUG_HEADER = "Debu-king Info"
local TEXT_TM = "TM"
local TEXT_ACTION = "Action"
local TEXT_ACTION_STRING = ""
local TEXT_CHAR_SELECT_FOUND = "Character Select Active"

function hud_show()
    local m = gMarioStates[0]

    djui_hud_set_resolution(RESOLUTION_N64)

    djui_hud_set_color(0, 0, 0, 150)
    djui_hud_render_rect(25, 40, 65, 50)

    -- name --
    djui_hud_set_font(FONT_NORMAL)
    djui_hud_set_color(255, 255, 255, 255)
    local debugHeaderSizeHalf = djui_hud_measure_text(TEXT_DEBUG_HEADER)*0.15
    djui_hud_print_text(TEXT_DEBUG_HEADER, 55 - debugHeaderSizeHalf, 42, 0.3)
    djui_hud_set_font(FONT_TINY)
    djui_hud_print_text(TEXT_TM, 55 + debugHeaderSizeHalf, 42, 0.3)
    djui_hud_set_font(FONT_NORMAL)
    djui_hud_print_text(kingCharName[king].name, 27, 52, 0.3)
    djui_hud_set_font(FONT_TINY)
    djui_hud_print_text(kingCharName[king].subName, 27, 60, 0.4)

    -- action --

    djui_hud_set_font(FONT_NORMAL)
    djui_hud_print_text(TEXT_ACTION, 27, 67, 0.3)

    if kingActions[m.action] ~= nil then
        if kingActions[m.action] == "King - Ground-dash Charge" then
            if m.actionArg == 0 then
                TEXT_ACTION_STRING = 'King - Run-dash Charge'
            else
                TEXT_ACTION_STRING = 'King - Roll-dash Charge'
            end
        else
            TEXT_ACTION_STRING = tostring(kingActions[m.action])
        end
    else
        if m.marioObj ~= nil then
            TEXT_ACTION_STRING = "Vanilla - who cares"
        else
            TEXT_ACTION_STRING = 'None'
        end
    end

    djui_hud_set_font(FONT_TINY)
    djui_hud_print_text(TEXT_ACTION_STRING, 27, 75, 0.4)
    if _G.charSelectExists then
        djui_hud_print_text(TEXT_CHAR_SELECT_FOUND, 27, 83, 0.4)
    end
end

function on_hud_render()
    if show_info == 1 then
        hud_show()
    end
end

hook_event(HOOK_ON_HUD_RENDER_BEHIND, on_hud_render)