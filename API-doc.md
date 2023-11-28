# Character Select API Documantation
### Gives full descriptions of all API functions

## _G.charSelectExists
A Varible checking if the Mod is active, this is useful for preventing script errors when the mod isn't on.

Example: `if not _G.charSelectExists then return end`

## _G.charSelect.character_add()
A function that Adds a Character to the Character Table, has 6 inputs:

### Name:
String (Spaces replace Underscores when Displaying)

Example `"Custom Model"`

### Description:
Table containing Strings

Example `{"Custom Description", "Custom Description"}`

### Credit:
String

Example: `Custom Model Creator`

### Color:
Table containing variables r, g, and b. Colors use Decimal Format

Example: `{r = 255, g = 150, b = 150}`

### Model Info:
Model Information Recieved from `smlua_model_util_get_id()`

Example: `smlua_model_util_get_id("armature_geo")`

### Forced Character
Character Type, Inputs can be `CT_MARIO`, `CT_LUIGI`, `CT_TOAD`, `CT_WALUIGI`, `CT_WARIO`

Example: `CT_MARIO`

### Full Example:
```
_G.charSelect.character_add("Custom Model Name", {"Custom Model Description", "Custom Model Description"}, "Custom Model Creator", {r = 255, g = 200, b = 200}, E_MODEL_CUSTOM_MODEL, CT_MARIO)
```

## _G.charSelect.character_edit()
A function that Edits an Existing Character, has 7 inputs

### Original Character Number:
The Number of the Character you want to edit, this can be found using `_G.charSelect.character_get_number_from_string`

Example: `_G.charSelect.character_get_number_from_string("Custom Model")`

**All 6 other inputs are the same as [`_G.charSelect.character_add()`](https://github.com/SQUISHY6094/character-select-coop/blob/main/API-doc.md#_gcharselectcharacter_add)**

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

## _G.charSelect.is_options_open()
A function that returns the either True or False if the Menu Options is Open or not.

## _G.charSelect.get_status()
A function that returns the status of an inputted value relitive to the option table

Inputs can be the following:
```
_G.charSelect.optionTableRef.openInputs    (1)
_G.charSelect.optionTableRef.menuColor     (2)
_G.charSelect.optionTableRef.anims         (3)
_G.charSelect.optionTableRef.inputLatency  (4)
_G.charSelect.optionTableRef.localModels   (5)
_G.charSelect.optionTableRef.prefToDefault (6)
```

# Tips on API Usage
### Helpful info for common API use cases

## Storing Character Table Positions
You can store a character's placement in the character table by storing `_G.charSelect.character_get_number_from_string()` to a local variable after adding the character instead of using the function every frame. (Characters will never change positions in the table once added)

Example: `local myCharPlacement = _G.charSelect.character_get_number_from_string("Custom Model")`

This can be used to easily edit your character when necessary.

Example: `_G.charSelect.character_edit(myCharPlacement, nil, nil, nil, nil, nil, nil)`

## Unlockable Characters
A character can be "unlockable" by setting a condition and then running `_G.charSelect.character_add()` once.

Example:
```
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
