# Character Select API Documentation
### Gives full descriptions of all API functions
We highly recommend messing around with our [Character Select Template](https://github.com/Squishy6094/character-select-coop/raw/main/packs/char-select-template.zip) or [Character Select Template with Voice](https://github.com/Squishy6094/character-select-coop/raw/main/packs/char-select-template-w-voice.zip) while first reading this doc to get a handle on everything here. And DO NOT modify/add any content within the Character Select mod itself, please use the API and an individual mod when adding characters.

#### Note: Some functionalities here are in Development and not featured in version 1.0!

## _G.charSelectExists
A variable checking if the Mod is active, this is useful for preventing script errors when the mod isn't on.

Example: `if not _G.charSelectExists then return end`

## _G.charSelect.character_add()
A function that Adds a Character to the Character Table, has 6 inputs:

### Name:
String (Spaces replace Underscores when Displaying)

Example `"Custom Model"`

### Description:
Table containing Strings (Recommended 30-33 letters per string)

Example `{"Custom Description", "Custom Description"}`

### Credit:
String

Example: `Custom Model Creator`

### Color:
Table containing variables r, g, and b. Colors use Decimal Format

Example: `{r = 255, g = 150, b = 150}`

### Model Info:
Model Information Received from `smlua_model_util_get_id()`

Example: `smlua_model_util_get_id("armature_geo")`

Alternatively, Models can also have Cap Models via use of a Table

Example: `{smlua_model_util_get_id("armature_geo"), capModels}`

```lua
local capModels = {
    normal = smlua_model_util_get_id("armature_normal_cap_geo"),
    wing = smlua_model_util_get_id("armature_wing_cap_geo"),
    metal = smlua_model_util_get_id("armature_metal_cap_geo"),
    metalWing = smlua_model_util_get_id("armature_metal_wing_cap_geo")
}
```

### Forced Character
Character Type, Inputs can be `CT_MARIO`, `CT_LUIGI`, `CT_TOAD`, `CT_WALUIGI`, `CT_WARIO`

Example: `CT_MARIO`

### Life Icon
Texture Information Recieved from `get_texture_info()`

Example: `get_texture_info("armature_icon")`

### Full Example:
```lua
_G.charSelect.character_add("Custom Model", {"Custom Model Description", "Custom Model Description"}, "Custom Model Creator", {r = 255, g = 200, b = 200}, E_MODEL_CUSTOM_MODEL, CT_MARIO, get_texture_info("custom-icon"))
```

Note that any of these fields can be left as `nil`, and Character Select will fill in the field for you.

## _G.charSelect.character_add_voice()
A function that adds a voice to a character, has 2 inputs

### Model Info:
Model Information Received from `smlua_model_util_get_id()`

Example: `smlua_model_util_get_id("armature_geo")`

### Sound Clip Table:
A table with you're character's sound file names

Table Example:
```lua
local VOICETABLE_CHAR = {
    [CHAR_SOUND_ATTACKED] = 'NES-Hit.ogg',
    [CHAR_SOUND_DOH] = 'NES-Bump.ogg',
    [CHAR_SOUND_DROWNING] = 'NES-Die.ogg',
    [CHAR_SOUND_DYING] = 'NES-Die.ogg',
    [CHAR_SOUND_GROUND_POUND_WAH] = 'NES-Squish.ogg',
    [CHAR_SOUND_HAHA] = 'NES-1up.ogg',
    [CHAR_SOUND_HAHA_2] = 'NES-1up.ogg',
    [CHAR_SOUND_HERE_WE_GO] = 'NES-Flagpole.ogg',
    [CHAR_SOUND_HOOHOO] = 'NES-Jump.ogg',
    [CHAR_SOUND_MAMA_MIA] = 'NES-Warp.ogg',
    [CHAR_SOUND_OKEY_DOKEY] = 'NES-1up.ogg',
    [CHAR_SOUND_ON_FIRE] = 'NES-Enemy_Fire.ogg',
    [CHAR_SOUND_OOOF] = 'NES-Hit.ogg',
    [CHAR_SOUND_OOOF2] = 'NES-Hit.ogg',
    [CHAR_SOUND_PUNCH_HOO] = 'NES-Kick.ogg',
    [CHAR_SOUND_PUNCH_WAH] = 'NES-Thwomp.ogg',
    [CHAR_SOUND_PUNCH_YAH] = 'NES-Thwomp.ogg',
    [CHAR_SOUND_SO_LONGA_BOWSER] = 'NES-Bowser_Die.ogg',
    [CHAR_SOUND_TWIRL_BOUNCE] = 'NES-Item.ogg',
    [CHAR_SOUND_WAAAOOOW] = 'NES-Vine.ogg',
    [CHAR_SOUND_WAH2] = 'NES-Kick.ogg',
    [CHAR_SOUND_WHOA] = 'NES-Item.ogg',
    [CHAR_SOUND_YAHOO] = 'NES-Jump.ogg',
    [CHAR_SOUND_YAHOO_WAHA_YIPPEE] = 'NES-Jump.ogg',
    [CHAR_SOUND_YAH_WAH_HOO] = 'NES-Big_Jump.ogg',
    [CHAR_SOUND_YAWNING] = 'NES-Pause.ogg',
}
```
Refer to [sm64ex-coop's CharacterSound Constants](https://github.com/djoslin0/sm64ex-coop/blob/coop/docs/lua/constants.md#enum-charactersound) for all replaceable sounds

Input Example:
`VOICETABLE_CHAR`

### Required Code:
In order for voice clips to work functionally, you require the following code in your script:
```lua
hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
    if _G.charSelect.character_get_voice(m) == VOICETABLE_CHAR then return _G.charSelect.voice.sound(m, sound) end
end)
hook_event(HOOK_MARIO_UPDATE, function (m)
    if _G.charSelect.character_get_voice(m) == VOICETABLE_CHAR then return _G.charSelect.voice.snore(m) end
end)
```

Copy the `if` statements for each character with a voice

Example:
```lua
hook_event(HOOK_CHARACTER_SOUND, function (m, sound)
    if _G.charSelect.character_get_voice(m) == VOICETABLE_CHAR then return _G.charSelect.voice.sound(m, sound) end
    if _G.charSelect.character_get_voice(m) == VOICETABLE_UNLOCKABLE_CHAR then return _G.charSelect.voice.sound(m, sound) end
end)
hook_event(HOOK_MARIO_UPDATE, function (m)
    if _G.charSelect.character_get_voice(m) == VOICETABLE_CHAR then return _G.charSelect.voice.snore(m) end
    if _G.charSelect.character_get_voice(m) == VOICETABLE_UNLOCKABLE_CHAR then return _G.charSelect.voice.snore(m) end
end)
```

Examples of these can be found in [Character Select Template with Voice](https://github.com/Squishy6094/character-select-coop/raw/main/packs/char-select-template-w-voice.zip)

## _G.charSelect.character_edit()
A function that Edits an Existing Character, has 7 inputs

### Original Character Number:
The Number of the Character you want to edit, this can be found using `_G.charSelect.character_get_number_from_string()`

Example: `_G.charSelect.character_get_number_from_string("Custom Model")`

**All 6 other inputs are the same as [`_G.charSelect.character_add()`](/API-doc.md#_gcharselectcharacter_add)**

## _G.charSelect.character_get_current_name()
A function that returns the Current Character's Name String

## _G.charSelect.character_get_current_model_number
A function that returns the Current Character's Number in the Character Table

## _G.charSelect.character_get_number_from_string()
A function that returns a character's number in the table based off the inputted name string, has 1 input

### Character Name:
Character's Name String

Example: `"Custom Model"`

## _G.charSelect.version_get()
A function that returns the current version of the mod in a string format

## _G.charSelect.is_menu_open()
A function that returns the either True or False if the Menu is Open or not.

## _G.charSelect.stop_menu_open()
A function that prevents the menu from being opened via boolean

## _G.charSelect.is_options_open()
A function that returns the either True or False if the Menu Options is Open or not.

## _G.charSelect.get_status()
A function that returns the status of an inputted value relative to the option table

Inputs can be the following:
```
_G.charSelect.optionTableRef.openInputs    (1)
_G.charSelect.optionTableRef.menuColor     (2)
_G.charSelect.optionTableRef.anims         (3)
_G.charSelect.optionTableRef.inputLatency  (4)
_G.charSelect.optionTableRef.localModels   (5)
_G.charSelect.optionTableRef.prefToDefault (6)
```

## _G.charSelect.character_get_voice()
Returns the current character's Voicetable, Primarily when hooking a character's voice

## _G.charSelect.voice
Both `_G.charSelect.voice.sound()` and `_G.charSelect.voice.snore()` are used to hook sound functionalities into other mods, allowing Character Select to access sounds from Packs. Both functions have no real use case outside of doing this.

# Tips on API Usage
### Helpful info for common API use cases

## Storing Character Table Positions
You can store a character's placement in the character table by storing `_G.charSelect.character_get_number_from_string()` to a local variable after adding the character instead of using the function every frame. (Characters will never change positions in the table once added)

Examples: `local myCharPlacement = _G.charSelect.character_get_number_from_string("Custom Model")` or `myCharPlacement = _G.charSelect.character_add(nil, nil, nil, nil, nil, nil)`

This can be used to easily edit your character when necessary.

Example: `_G.charSelect.character_edit(myCharPlacement, nil, nil, nil, nil, nil, nil)`

## Unlockable Characters
A character can be "unlockable" by setting a condition and then running [`_G.charSelect.character_add()`](/API-doc.md#_gcharselectcharacter_add) once.

Example:
```lua
local unlockedCharacter = false
local unlockableCharPlacement = 0

local function mario_update()
    if unlockedCharacter == true and unlockableCharPlacement == 0 then
        _G.charSelect.character_add("Unlockable", nil, nil, nil, nil, nil)
        unlockableCharPlacement = _G.charSelect.character_get_number_from_string("Unlockable")
    end
end
```
This function doesn't loop due to the `unlockableCharPlacement` being set, thus only running once. (Character locations will never be under `2`)

## Muted Character Voice
A character can have a muted voice by having their input table be `nil`, This can be hooked as usual causing no voicelines to play

Example: `VOICETABLE_CHAR = {nil}`
