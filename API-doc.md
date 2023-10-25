# Character Select API Documantation
### Gives full descriptions of all API functions and their use cases

## The Basics (Adding a Character)
 This section goes over the basics of adding a Model via the API, you can follow this step-by-step with the [Model Template](https://github.com/SQUISHY6094/character-select-coop/tree/main/packs/char-select-template).

 This section can be skipped if you're just looking for all of the functions.

### Defining Varibles
 These will define content we will use later for our function

 First, We'll define a model `local E_MODEL_CUSTOM_MODEL = smlua_model_util_get_id("custom_model_geo")`

 Ensure that the string in the *smlua_model_util_get_id* function matches the name of your model in the actors folder. You can add multiple of these Variable for however many characters you plan on adding by simply Copy/Pasting

### Adding the Character
 Now we get to the main bulk of the code

```
if _G.charSelectExists then
    _G.charSelect.character_add("Custom Model Name", {"Custom Model Description", "Custom Model Description"}, "Custom Model Creator", {r = 255, g = 200, b = 200}, E_MODEL_CUSTOM_MODEL, CT_MARIO)
end
```

 This code checks if our Character Select mod is Active, then adds a character if so via the function *_G.charSelect.character_add*. The function is split into multiple parts to give our character data. We'll go in-order what each of the parts do and how to use them!

#### Character Name

 The Character Name is a simple string to relate to your model. You just have to make sure that the name is in quotes to define it as a string.

 Example: `"Super Cool Guy"`

 Note that Underscores `_` will display as Spaces when displaying, this is done to be able to save the character as a preference

#### Character Description

 The Character Description is a bit more complex, as it requires the use of a table to properly wrap around the space on the right given. To start off, give your character a description such as `"This is my super cool character, He is really cool so don't steal"` Then, We'll split it into multiple lines in a table. Surround the entire text with brackets `{}` The split into multiple quotes.

 Example: `{"This is my super cool character", "He is really cool so don't steal"}`

 The Comma `,` in between the two quotes split the original quote into two lines, this is done to prevent text going outside of the space given. Although there is not real limit to how long your description can be, we recommend around *10 to 11 lines*.

 #### Character Creator

 The Character Creator refers to the person who made the model. Like the Character Name, Put the Creators Name in a string.

 Example: `"Mr.Coolguy9873"`

 #### Character Color

 The Character Color is the Color displayed on the borders when your character is selected. It uses *RBG Decimal* format for colors which can be found in any software with a color picker

 Example: `{r = 255, g = 150, b = 50}`

 #### Character Model

 The Character Model was refered to earlier under **Defining Varibles**, that variable can be pluged in here

 Example: `E_MODEL_COOL_GUY`

 #### Force Character

 Force Character is used to Force the player as a certain base-coop character while they're using your character. So if you want Waluigi's Offsets for example you would use `CT_WALUIGI`.

 ```
 All Usable Variables:
 CT_MARIO
 CT_LUIGI
 CT_PLAYER_TOAD
 CT_WALUIGI
 CT_WARIO
 nil
 ```

#### Conclusion

 So from all of this your character code should look something like this like this:

```
local E_MODEL_COOL_GUY = smlua_model_util_get_id("mr_cool_guy_geo")

if _G.charSelectExists then
    _G.charSelect.character_add("Super Cool Guy", {"This is my super cool character", "He is really cool so don't steal"}, "Mr.Coolguy9873", {r = 255, g = 150, b = 50}, E_MODEL_COOL_GUY, CT_MARIO)
end
```

If you want an error to appear when our Character Select Mod isn't on, then you can use these additions:

```
local E_MODEL_COOL_GUY = smlua_model_util_get_id("mr_cool_guy_geo")=

local TEXT_MOD_NAME = "Super Cool Guy Pack"

if _G.charSelectExists then
    _G.charSelect.character_add("Super Cool Guy", {"This is my super cool character", "He is really cool so don't steal"}, "Mr.Coolguy9873", {r = 255, g = 150, b = 50}, E_MODEL_COOL_GUY, CT_MARIO)
else
    djui_popup_create("\\#ffffdc\\\n"..TEXT_MOD_NAME.."\nRequires the Character Select Mod\nto use as a Library!\n\nPlease turn on the Character Select Mod\nand Restart the Room!", 6)
end
```

Again, the function *_G.charSelect.character_add* can be used as many times as you need for any amount of characters you need!