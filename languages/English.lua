return {
    mod_name = "Character Select",
    
    -- Utils Failsafing
    error_version_popup = "\n\\#FFAAAA\\Character Select requires\n the latest version of CoopDX to use!\n\nYou can find CoopDX here:\n\\#AAAAFF\\https://sm64coopdx.com",
    error_version_message = "\\#FFAAAA\\Character Select Version Issue:\nVersion %d < %d",
    error_version_fix = "\\#FFAAAA\\The best way to resolve this issue is to reinstall SM64CoopDX from the Offical Site or Github Repo!\n\\#AAAAFF\\https://sm64coopdx.com/\nhttps://github.com/coop-deluxe/sm64coopdx/",
    error_file_missing = "Missing File '%s'",
    error_file_old = "Legacy File '%s'",
    error_file_popup = "\\#FFAAAA\\Character Select is having\nfile issues and cannot load!\n\nErrors have been logged in chat!",
    error_file_issues = "\\#FFAAAA\\Character Select File Issues: %s",
    error_file_fix = "\\#FFAAAA\\The best way to resolve these issues is to delete your current version of Character Select and then install the latest version from the Github Repo!\n\\#AAAAFF\\https://github.com/Squishy6094/character-select-coop/\\#FFAAAA\\", 
    
    -- Menu Text
    menu_version = "Version: %s | sm64coopdx",
    menu_birthday = "%d years of Character Select!",
    menu_unavailible = "Character Select is Unavailable",
    menu_char_cannot_change = "Character Cannot be Changed",
    menu_char_set = 'Character set to "%s" Successfully!',
    menu_char_not_found = "Character Not Found",
    menu_curr_char = "Current Character: ",
    menu_boot = "Character Select has %d characters available!\nYou can use \\#ffff33\\/char-select \\#ffffff\\or \\#ffff33\\Z Button while Paused \\#ffffff\\\nto open the menu!",
    menu_boot_no_chars = "Character Select is active!\nYou can use \\#ffff33\\/char-select \\#ffffff\\or \\#ffff33\\Z Button while Paused \\#ffffff\\\nto open the menu!",
    menu_boot_too_many_chars = "\\#FFAAAA\\Warning: Having a lot of characters\nmay be unstable, For a better experience please\ndisable a few packs!",
    menu_restrict_moveset = "Movesets are Restricted",
    menu_restrict_palette = "Palettes are Restricted",
    menu_restrict_moveset_and_palette = "Moveset and Palettes are Restricted",

    binds_char = "Change Character",
    binds_costume = "Change Costume",
    binds_pref_char = "Set Preferred Character",
    binds_exit = "Change Character",
    binds_list = "Toggle List View",
    binds_grid = "Toggle Grid View",
    binds_palette = "Toggle Palette",
    binds_category = "Change Categories",
    binds_options = "Options Menu",
    binds_options_scroll = "Scroll Options",
    binds_options_toggle = "Toggle Options",
    binds_options_exit = "Exit Options Menu",
    binds_credits_scroll = "Scroll Credits",
    binds_credits_switch = "Switch Page",
    binds_credits_exit = "Exit Credits Menu",

    menu_error_model = "Failed to find a Character Model",
    menu_error_model_fix = "Please Verify the Integrity of the Pack!",

    menu_help = "Character Select's Avalible Commands:" ..
        "\n\\#ffff33\\/char-select help\\#ffffff\\ - Returns Avalible Commands" ..
        "\n\\#ffff33\\/char-select menu\\#ffffff\\ - Opens the Menu" ..
        "\n\\#ffff33\\/char-select [name/num]\\#ffffff\\ - Switches to Character" ..
        "\n\\#ff3333\\/char-select reset\\#ffffff\\ - Resets your Save Data",
    menu_reset_are_you_sure = "\\#ffdcdc\\Are you sure you want to reset your Save Data for Character Select, including your Preferred Character\nand Settings?\n\nType \\#ff3333\\/char-select reset\\#ffdcdc\\ or toggle \\#ff3333\\Reset Save Data\\#ffdcdc\\ to confirm.",
    menu_reset_done = "\\#ff3333\\Character Select Save Data Reset!\\#ffffff\\\n\nNote: If your issue has not been resolved, you may need to manually delete your save data via the directory below:\n\\#dcdcFF\\%appdata%/sm64coopdx/sav/character-select-coop.sav",

    menu_options_header = "OPTIONS",
    menu_credits_header = "CREDITS",

    -- Toggle Categories
    menu_category_menu = "Menu",
    menu_category_char = "Character",
    menu_category_misc = "Misc",
    menu_category_host = "Host",
    menu_category_packs = "Packs",

    -- Toggles Options
    notifs = "Notifications",
    menu_color = "Menu Color",
    menu_music = "Menu Music",
    menu_scroll_speed = "Menu Scroll Speed",
    char_voices = "Character Voices",
    char_visuals = "Character Visuals",
    char_moveset = "Character Moveset",
    restrict_movesets = "Restrict Movesets",
    reset_save_data = "Reset Save Data",
    credits = "Credits",

    -- Toggle Descriptions
    notif_desc1 = "Toggles whether Pop-ups and",
    notif_desc2 = "Chat Messages display.",
    menu_color_desc1 = "Toggles the Menu Color",
    menu_music_desc1 = "Toggles which music plays",
    menu_music_desc2 = "in the menu.",
    menu_scroll_speed_desc1 = "Sets how fast you scroll",
    menu_scroll_speed_desc2 = "throughout the Menu.",
    char_voices_desc1 = "Toggle if Custom Voicelines play",
    char_voices_desc2 = "for Characters who support it.",
    char_voices_desc3 = "",
    char_visuals_desc1 = "Toggle if Characters can",
    char_visuals_desc2 = "change the apperence of",
    char_visuals_desc3 = "Objects and Textures.",
    char_moveset_desc1 = "Toggles if Custom Movesets",
    char_moveset_desc2 = "are active on compatible",
    char_moveset_desc3 = "characters.",
    restrict_movesets_desc1 = "Restricts turning on Movesets.",
    restrict_movesets_desc2 = "(Host Only)",
    reset_save_data_desc1 = "Resets Character Select's",
    reset_save_data_desc2 = "Save Data.",
    credits_desc1 = "Thank you for choosing",
    credits_desc2 = "Character Select!",

    -- Toggles
    on = "On",
    off = "Off",
    forced_off = "Forced Off",
    host_only = "Host Only",
    api_only = "API Only",

    popups_only = "Pop-ups Only",

    auto = "Auto",
    saved = "Saved",
    red = "Red",
    orange = "Orange",
    yellow = "Yellow",
    green = "Green",
    blue = "Blue",
    pink = "Pink",
    purple = "Purple",
    white = "White",
    black = "Black",

    breakroom_only = "Breakroom Only",
    character_only = "Character Only",

    slow = "Slow",
    normal = "Normal",
    fast = "Fast",

    local_only = "Local Only",

    open_credits = "Open Credits",

    button = "Button",

    popup_pref_applied = 'Character Select:\nYour Preferred Character\n"%s"\nwas applied successfully!',
    popup_no_chars = "Character Select:\nNo Characters were Found",
    popup_pref_not_found_saved = 'Character Select:\nYour Preferred Character\n"%s"\nwas not found.',
    popup_pref_not_found = 'Character Select:\nYour Preferred Character\nwas not found.',
    popup_unlocked = 'Character Select:\nUnlocked %s\nas a Playable Character!',

    cmd_desc = "Opens the Character Select Menu",
}