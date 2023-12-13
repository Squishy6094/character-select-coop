function string_underscore_to_space(string)
    local s = ''
    for i = 1, #string do
        local c = string:sub(i,i)
        if c ~= '_' then
            s = s .. c
        else
            s = s .. " "
        end
    end
    return s
end

function string_space_to_underscore(string)
    local s = ''
    for i = 1, #string do
        local c = string:sub(i,i)
        if c ~= ' ' then
            s = s .. c
        else
            s = s .. "_"
        end
    end
    return s
end

-- Globals
modVersion = "1.5 (In-Dev)"

allowMenu = {}

menuColorTable = {
    {r = 255, g = 50,  b = 50 },
    {r = 255, g = 100, b = 50 },
    {r = 255, g = 255, b = 50 },
    {r = 50,  g = 255, b = 50 },
    {r = 100,  g = 100,  b = 255},
    {r = 251, g = 148, b = 220},
    {r = 130, g = 25,  b = 130},
    {r = 255, g = 255, b = 255},
    {r = 50,  g = 50,  b = 50 },
}
