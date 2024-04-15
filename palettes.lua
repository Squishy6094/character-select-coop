characterColorPresets = {
    [E_MODEL_MARIO] = {
        [PANTS]  = {r = 0x00, g = 0x00, b = 0xff},
        [SHIRT]  = {r = 0xff, g = 0x00, b = 0x00},
        [GLOVES] = {r = 0xff, g = 0xff, b = 0xff},
        [SHOES]  = {r = 0x72, g = 0x1c, b = 0x0e},
        [HAIR]   = {r = 0x73, g = 0x06, b = 0x00},
        [SKIN]   = {r = 0xfe, g = 0xc1, b = 0x79},
        [CAP]    = {r = 0xff, g = 0x00, b = 0x00},
    },
    [E_MODEL_LUIGI] = {
        [PANTS]  = {r = 0x00, g = 0x00, b = 0xff},
        [SHIRT]  = {r = 0x00, g = 0x98, b = 0x00},
        [GLOVES] = {r = 0xff, g = 0xff, b = 0xff},
        [SHOES]  = {r = 0x72, g = 0x1c, b = 0x0e},
        [HAIR]   = {r = 0x73, g = 0x06, b = 0x00},
        [SKIN]   = {r = 0xfe, g = 0xc1, b = 0x79},
        [CAP]    = {r = 0x00, g = 0x98, b = 0x00},
    },
    [E_MODEL_TOAD_PLAYER] = {
        [PANTS]  = {r = 0xff, g = 0xff, b = 0xff},
        [SHIRT]  = {r = 0x4c, g = 0x2c, b = 0xd3},
        [GLOVES] = {r = 0xff, g = 0xff, b = 0xff},
        [SHOES]  = {r = 0x68, g = 0x40, b = 0x1b},
        [HAIR]   = {r = 0x73, g = 0x06, b = 0x00},
        [SKIN]   = {r = 0xfe, g = 0xd5, b = 0xa1},
        [CAP]    = {r = 0xff, g = 0x00, b = 0x00},
    },
    [E_MODEL_WALUIGI] = {
        [PANTS]  = {r = 0x16, g = 0x16, b = 0x27},
        [SHIRT]  = {r = 0x61, g = 0x26, b = 0xb0},
        [GLOVES] = {r = 0xff, g = 0xff, b = 0xff},
        [SHOES]  = {r = 0xfe, g = 0x76, b = 0x00},
        [HAIR]   = {r = 0x73, g = 0x53, b = 0x00},
        [SKIN]   = {r = 0xfe, g = 0xc1, b = 0x79},
        [CAP]    = {r = 0x61, g = 0x26, b = 0xb0},
    },
    [E_MODEL_WARIO] = {
        [PANTS]  = {r = 0x7f, g = 0x20, b = 0x7a},
        [SHIRT]  = {r = 0xe3, g = 0xa9, b = 0x01},
        [GLOVES] = {r = 0xff, g = 0xff, b = 0xff},
        [SHOES]  = {r = 0x0e, g = 0x72, b = 0x1c},
        [HAIR]   = {r = 0x73, g = 0x53, b = 0x00},
        [SKIN]   = {r = 0xfe, g = 0xc1, b = 0x79},
        [CAP]    = {r = 0xe3, g = 0xa9, b = 0x01},
    },
}

local defaultModels = {
    [CT_MARIO] = E_MODEL_MARIO,
    [CT_LUIGI] = E_MODEL_LUIGI,
    [CT_TOAD] = E_MODEL_TOAD_PLAYER,
    [CT_WALUIGI] = E_MODEL_WALUIGI,
    [CT_WARIO] = E_MODEL_WARIO
}

local network_player_color_to_palette = network_player_color_to_palette
local network_player_palette_to_color = network_player_palette_to_color

local function network_player_full_color_to_palette(networkPlayer, colorTable)
    network_player_color_to_palette(networkPlayer, SHIRT, colorTable[SHIRT])
    network_player_color_to_palette(networkPlayer, GLOVES, colorTable[GLOVES])
    network_player_color_to_palette(networkPlayer, SHOES, colorTable[SHOES])
    network_player_color_to_palette(networkPlayer, HAIR, colorTable[HAIR])
    network_player_color_to_palette(networkPlayer, SKIN, colorTable[SKIN])
    network_player_color_to_palette(networkPlayer, CAP, colorTable[CAP])
    network_player_color_to_palette(networkPlayer, PANTS, colorTable[PANTS])
end

local function network_player_full_palette_to_color(networkPlayer, out)
    network_player_palette_to_color(networkPlayer, SHIRT, out[SHIRT])
    network_player_palette_to_color(networkPlayer, GLOVES, out[GLOVES])
    network_player_palette_to_color(networkPlayer, SHOES, out[SHOES])
    network_player_palette_to_color(networkPlayer, HAIR, out[HAIR])
    network_player_palette_to_color(networkPlayer, SKIN, out[SKIN])
    network_player_palette_to_color(networkPlayer, CAP, out[CAP])
    network_player_palette_to_color(networkPlayer, PANTS, out[PANTS])
end

local prevChar = currChar
local connectedIndex = 0
local updatePaletteTimer = 0

local networkPlayerColors = {}
local prevPresetPalette = {}
local prevModel = {}

local function mario_update(m)
    local np = gNetworkPlayers[m.playerIndex]
    local p = gPlayerSyncTable[m.playerIndex]
    
    if m.playerIndex == 0 and not p.isUpdating then
        p.isUpdating = true

        for i = 1, MAX_PLAYERS - 1 do
            prevPresetPalette[i] = gPlayerSyncTable[i].presetPalette
            prevModel[i] = gPlayerSyncTable[i].modelId and gPlayerSyncTable[i].modelId or defaultModels[gMarioStates[i].character.type]
        end
    end

    if networkPlayerColors[m.playerIndex] == nil and np.connected then
        networkPlayerColors[m.playerIndex] = {
            [SHIRT] = {r = 0, g = 0, b = 0},
            [GLOVES] = {r = 0, g = 0, b = 0},
            [SHOES] = {r = 0, g = 0, b = 0},
            [HAIR] = {r = 0, g = 0, b = 0},
            [SKIN] = {r = 0, g = 0, b = 0},
            [CAP] = {r = 0, g = 0, b = 0},
            [PANTS] = {r = 0, g = 0, b = 0},
        }
        network_player_full_palette_to_color(np, networkPlayerColors[m.playerIndex])
    end

    if np.connected then
        local modelId = p.modelId and p.modelId or defaultModels[m.character.type]
        if p.presetPalette == nil or characterColorPresets[modelId] == nil then
            if p.presetPalette == nil then
                prevPresetPalette[m.playerIndex] = false
            end
            p.presetPalette = false
        end

        if prevPresetPalette[m.playerIndex] ~= p.presetPalette or prevModel[m.playerIndex] ~= modelId then
            if p.presetPalette and characterColorPresets[modelId] then 
                network_player_full_palette_to_color(np, networkPlayerColors[m.playerIndex])
                network_player_full_color_to_palette(np, characterColorPresets[modelId])
            else
                network_player_full_color_to_palette(np, networkPlayerColors[m.playerIndex])
            end
        end
        prevPresetPalette[m.playerIndex] = p.presetPalette
        prevModel[m.playerIndex] = modelId
    else
        if p.isUpdating then
            p.isUpdating = false
        end
    end

    if m.playerIndex == 0 and menuAndTransition or prevChar ~= currChar then
        if optionTable[optionTableRef.autoPalette].toggle > 0 and optionTable[optionTableRef.localModels].toggle > 0 and prevChar ~= currChar and not gamemodeActive then
            p.presetPalette = true
            prevChar = currChar
        end
        if optionTable[optionTableRef.localModels].toggle == 0 then
            p.presetPalette = false
        end
    end

    if connectedIndex ~= 0 and gPlayerSyncTable[connectedIndex].isUpdating then
        connectedIndex = 0
        local networkString = ""
        for i = 0, 6 do -- Goes through all palette parts
            local playerPart = networkPlayerColors[0][i]
            networkString = networkString..tostring(playerPart.r).." "..tostring(playerPart.g).." "..tostring(playerPart.b).." "
        end
        local data = {
            index = network_global_index_from_local(0),
            colorString = networkString
        }
        network_send(true, data)
    end
end

local function on_connect(m)
    connectedIndex = m.playerIndex
end

local MATH_DIVIDE_3 = 1/3

local function on_packet_receive(data)
    local dataIndex = network_local_index_from_global(data.index)
    local colorTable = string_split(data.colorString)
    for i = 1, #colorTable do -- Goes through all palettes
        local playerPart = math.floor((i-1)*MATH_DIVIDE_3)
        if i%3 == 1 then
            networkPlayerColors[dataIndex][playerPart].r = tonumber(colorTable[i])
        end
        if i%3 == 2 then
            networkPlayerColors[dataIndex][playerPart].g = tonumber(colorTable[i])
        end
        if i%3 == 0 then
            networkPlayerColors[dataIndex][playerPart].b = tonumber(colorTable[i])
        end
    end
end

hook_event(HOOK_MARIO_UPDATE, mario_update)
hook_event(HOOK_ON_PLAYER_CONNECTED, on_connect)
hook_event(HOOK_ON_PACKET_RECEIVE, on_packet_receive)