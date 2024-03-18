-- Misc Functions --

-- Add any custom function that usually takes space in other files and is rarely used

-- Localized Functions
local djui_hud_measure_text = djui_hud_measure_text

---@param str string The string given to check for a specific substring
---@param delim string The string you want to check for to split into a table
---@param maxNb integer|nil The amount of times to check for the specific substring before stopping and keeping the next substring in (if left nil then it does it as much as it can), for this mod, we will be ignoring this
---@return table result Returns a table full of the split strings
function split(str, delim, maxNb)
    -- Eliminate bad cases...
    if string.find(str, delim) == nil then
       return { str }
    end
    if maxNb == nil or maxNb < 1 then
       maxNb = 0    -- No limit
    end
    local result = {}
    local pat = "(.-)" .. delim .. "()"
    local nb = 0
    local lastPos
    for part, pos in string.gmatch(str, pat) do
       nb = nb + 1
       result[nb] = part
       lastPos = pos
       if nb == maxNb then
          break
       end
    end
    -- Handle the last field
    if nb ~= maxNb then
       result[nb + 1] = string.sub(str, lastPos)
    end
    return result
end

---@param text string
---@return table lines Lines produced
function split_text_into_lines(text)
   local words = {}
   for word in text:gmatch("%S+") do
       table.insert(words, word)
   end

   local lines = {}
   local currentLine = ""
   for i, word in ipairs(words) do
       local measuredWidth = djui_hud_measure_text(currentLine .. " " .. word)*0.3
       if measuredWidth <= 100 then
           currentLine = currentLine .. " " .. word
       else
           table.insert(lines, currentLine)
           currentLine = word
       end
   end
   table.insert(lines, currentLine) -- add the last line

   return lines
end
