---------------------------------------------
-- you can use these for any mods you want --
------- just make sure to give credit -------
---------------------------------------------
------ and always check if king ~= nil ------
---- before any further use, or it could ----
--------------- cause errors ----------------
---------------------------------------------
----------- - king the memer  |^| -----------

-- note: when CHECKING or USING one of these globals, do NOT include _G.              if king == 2 then
--       if you are SETTING or REPLACING the value of these globals, DO include _G.       _G.king = 1
--       this is because changing a global value doesn't actually change it GLOBALLY      djui_chat_message_create(tostring(kingCharName[2].name) ... "is unavailable at the moment")
--       so you need to RE-set the global value with _G.                              end


-- 'king' is a usable global along with each character name (K_CHAR_KING for example), although you can still use integers
-- all of the memers' actions are usable in other mods too
-- 0 = Off
-- 1 = King
-- 2 = Old King
-- 3 = Max

-- this is a list of each character's name and sub-name. the sub-name is like the 'The Hedgehog' in Sonic's name for example
_G.kingCharName = { -- example: djui_hud_print_text(tostring(kingCharName[king].name), 0, 0, 2)
    [K_CHAR_NONE] = {
        name = "None",
        subName = "Literally Nobody",
    },
    [K_CHAR_KING] = {
        name = "King",
        subName = "The Memer",
    },
    [K_CHAR_OLD] = {
        name = "Old",
        subName = "King from v2",
    },
    [K_CHAR_MAX] = {
        name = "Maximum",
        subName = "this isnt technically a character, i just use it so the character select cant go over the highest character slot",
    }
}


--------------
-- EXAMPLE: --
--------------

-- function king_stuff_update(m)
--     if m.playerIndex == 0 then
--         if king == nil then
--             return
--         end
--
--         if king > 0 then -- you can use 'kingCharName' if your mod has a character naming system and you want king to be supported
--             charName = kingCharName[king].name
--         else
--             charName = "Mario"
--         end
--
--         if king > 1 then -- you can change/disable characters with 'king'. this code disables every character apart from king himself.
--             _G.king = 1  -- this could be useful for mods that change characters drastically (sm64kart for example). if only king is there, then you only have to support one character.
--         end              -- and if you wanted to ban king characters entirely, you could have 'king = 0'.
--
--         _G.kingSpeed = 4 -- kingSpeed changes king's "speed mode". it can be used to make king less powerful if, for example, he makes your hard level feel piss easy
--                          -- 1 - default   4 - very slow   (doesnt work for old king)
--     end
-- end
--
-- hook_event(HOOK_MARIO_UPDATE, king_stuff_update)