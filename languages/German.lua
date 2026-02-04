return {
    mod_name = "Charakterauswahl",
    
    -- Utils Failsafing
    error_version_popup = "\n\\#FFAAAA\\Charakterauswahl benötigt\n die neueste Version von CoopDX!\n\nDu findest CoopDX hier:\n\\#AAAAFF\\https://sm64coopdx.com",
    error_version_message = "\\#FFAAAA\\Charakterauswahl Versionsproblem:\nVersion %d < %d",
    error_version_fix = "\\#FFAAAA\\Am besten behebst du dieses Problem, indem du SM64CoopDX von der offiziellen Website oder dem Github-Repo neu installierst!\n\\#AAAAFF\\https://sm64coopdx.com/\nhttps://github.com/coop-deluxe/sm64coopdx/",
    error_file_missing = "Fehlende Datei '%s'",
    error_file_old = "Veraltete Datei '%s'",
    error_file_popup = "\\#FFAAAA\\Charakterauswahl hat\nDateiprobleme und kann nicht geladen werden!\n\nFehler wurden im Chat protokolliert!",
    error_file_issues = "\\#FFAAAA\\Charakterauswahl Dateiprobleme: %s",
    error_file_fix = "\\#FFAAAA\\Am besten behebst du diese Probleme, indem du deine aktuelle Version von Charakterauswahl löschst und anschließend die neueste Version vom Github-Repo installierst!\n\\#AAAAFF\\https://github.com/Squishy6094/character-select-coop/\\#FFAAAA\\", 
    
    -- Menu Text
    menu_version = "Version: %s | sm64coopdx",
    menu_birthday = "%d Jahre Charakterauswahl!",
    menu_unavailible = "Charakterauswahl ist nicht verfügbar",
    menu_char_cannot_change = "Charakter kann nicht gewechselt werden",
    menu_char_set = 'Charakter erfolgreich auf "%s" gesetzt!',
    menu_char_not_found = "Charakter nicht gefunden",
    menu_curr_char = "Aktueller Charakter: ",
    menu_boot = "Charakterauswahl hat %d verfügbare Charaktere!\nDu kannst \\#ffff33\\/char-select \\#ffffff\\oder \\#ffff33\\Z-Taste im Pausenmenü \\#ffffff\\\nbenutzen, um das Menü zu öffnen!",
    menu_boot_no_chars = "Charakterauswahl ist aktiv!\nDu kannst \\#ffff33\\/char-select \\#ffffff\\oder \\#ffff33\\Z-Taste im Pausenmenü \\#ffffff\\\nbenutzen, um das Menü zu öffnen!",
    menu_boot_too_many_chars = "\\#FFAAAA\\Warnung: Zu viele Charaktere\nkönnen instabil sein. Für ein besseres Erlebnis\ndeaktiviere bitte einige Packs!",
    menu_restrict_moveset = "Movesets sind eingeschränkt",
    menu_restrict_palette = "Paletten sind eingeschränkt",
    menu_restrict_moveset_and_palette = "Moveset und Paletten sind eingeschränkt",

    binds_char = "Charakter wechseln",
    binds_costume = "Kostüm wechseln",
    binds_pref_char = "Bevorzugten Charakter festlegen",
    binds_exit = "Charakter wechseln",
    binds_list = "Listenansicht umschalten",
    binds_grid = "Rasteransicht umschalten",
    binds_palette = "Palette umschalten",
    binds_category = "Kategorien wechseln",
    binds_options = "Optionsmenü",
    binds_options_scroll = "Optionen scrollen",
    binds_options_toggle = "Option umschalten",
    binds_options_exit = "Optionsmenü verlassen",
    binds_credits_scroll = "Credits scrollen",
    binds_credits_switch = "Seite wechseln",
    binds_credits_exit = "Credits-Menü verlassen",

    menu_error_model = "Charaktermodell konnte nicht gefunden werden",
    menu_error_model_fix = "Bitte überprüfe die Integrität des Packs!",

    menu_help = "Verfügbare Befehle für Charakterauswahl:" ..
        "\n\\#ffff33\\/char-select help\\#ffffff\\ - Zeigt verfügbare Befehle" ..
        "\n\\#ffff33\\/char-select menu\\#ffffff\\ - Öffnet das Menü" ..
        "\n\\#ffff33\\/char-select [name/num]\\#ffffff\\ - Wechselt zum Charakter" ..
        "\n\\#ff3333\\/char-select reset\\#ffffff\\ - Setzt deine Speicherdaten zurück",
    menu_reset_are_you_sure = "\\#ffdcdc\\Bist du sicher, dass du deine Speicherdaten für Charakterauswahl zurücksetzen möchtest, einschließlich deines bevorzugten Charakters\nund deiner Einstellungen?\n\nGib \\#ff3333\\/char-select reset\\#ffdcdc\\ ein oder aktiviere \\#ff3333\\Speicherdaten zurücksetzen\\#ffdcdc\\ zur Bestätigung.",
    menu_reset_done = "\\#ff3333\\Charakterauswahl-Speicherdaten zurückgesetzt!\\#ffffff\\\n\nHinweis: Falls dein Problem weiterhin besteht, musst du deine Speicherdaten eventuell manuell im folgenden Verzeichnis löschen:\n\\#dcdcFF\\%appdata%/sm64coopdx/sav/character-select-coop.sav",

    menu_options_header = "OPTIONEN",
    menu_credits_header = "CREDITS",

    -- Toggle Categories
    menu_category_menu = "Menü",
    menu_category_char = "Charakter",
    menu_category_misc = "Verschiedenes",
    menu_category_host = "Host",
    menu_category_packs = "Packs",

    -- Toggles Options
    notifs = "Benachrichtigungen",
    menu_color = "Menüfarbe",
    menu_music = "Menümusik",
    menu_scroll_speed = "Menü-Scrollgeschwindigkeit",
    char_voices = "Charakterstimmen",
    char_visuals = "Charakter-Grafiken",
    char_moveset = "Charakter-Moveset",
    restrict_movesets = "Movesets einschränken",
    reset_save_data = "Speicherdaten zurücksetzen",
    credits = "Credits",

    -- Toggle Descriptions
    notif_desc1 = "Schaltet um, ob Pop-ups und",
    notif_desc2 = "Chatnachrichten angezeigt werden.",
    menu_color_desc1 = "Schaltet die Menüfarbe um",
    menu_music_desc1 = "Schaltet, welche Musik",
    menu_music_desc2 = "im Menü abgespielt wird.",
    menu_scroll_speed_desc1 = "Legt fest, wie schnell du",
    menu_scroll_speed_desc2 = "durch das Menü scrollst.",
    char_voices_desc1 = "Schaltet um, ob eigene Sprachzeilen",
    char_voices_desc2 = "für unterstützte Charaktere",
    char_voices_desc3 = "abgespielt werden.",
    char_visuals_desc1 = "Schaltet um, ob Charaktere das",
    char_visuals_desc2 = "Aussehen von Objekten und",
    char_visuals_desc3 = "Texturen verändern können.",
    char_moveset_desc1 = "Schaltet um, ob benutzerdefinierte",
    char_moveset_desc2 = "Movesets für kompatible Charaktere",
    char_moveset_desc3 = "aktiv sind.",
    restrict_movesets_desc1 = "Verhindert das Aktivieren von Movesets.",
    restrict_movesets_desc2 = "(Nur Host)",
    reset_save_data_desc1 = "Setzt die Speicherdaten von",
    reset_save_data_desc2 = "Charakterauswahl zurück.",
    credits_desc1 = "Danke, dass du dich für",
    credits_desc2 = "Charakterauswahl entschieden hast!",

    -- Toggles
    on = "An",
    off = "Aus",
    forced_off = "Erzwungen aus",
    host_only = "Nur Host",
    api_only = "Nur API",

    popups_only = "Nur Pop-ups",

    auto = "Auto",
    saved = "Gespeichert",
    red = "Rot",
    orange = "Orange",
    yellow = "Gelb",
    green = "Grün",
    blue = "Blau",
    pink = "Pink",
    purple = "Lila",
    white = "Weiß",
    black = "Schwarz",

    breakroom_only = "Nur Breakroom",
    character_only = "Nur Charakter",

    slow = "Langsam",
    normal = "Normal",
    fast = "Schnell",

    local_only = "Nur lokal",

    open_credits = "Credits öffnen",

    button = "Taste",

    popup_pref_applied = 'Charakterauswahl:\nDein bevorzugter Charakter\n"%s"\nwurde erfolgreich angewendet!',
    popup_no_chars = "Charakterauswahl:\nKeine Charaktere gefunden",
    popup_pref_not_found_saved = 'Charakterauswahl:\nDein bevorzugter Charakter\n"%s"\nwurde nicht gefunden.',
    popup_pref_not_found = 'Charakterauswahl:\nDein bevorzugter Charakter\nwurde nicht gefunden.',
    popup_unlocked = 'Charakterauswahl:\n%s wurde als spielbarer Charakter\nfreigeschaltet!',

    cmd_desc = "Öffnet das Charakterauswahl-Menü",
}
