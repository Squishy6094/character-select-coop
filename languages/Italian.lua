return {
    mod_name = "Character Select",
    
    -- Utils Failsafing
    error_version_popup = "\n\\#FFAAAA\\Character Select ha bisogno\n del' ultima versione di CoopDX per essere usato!\n\nPuoi trovare CoopDX qui:\n\\#AAAAFF\\https://sm64coopdx.com",
    error_version_message = "\\#FFAAAA\\Problema della versione di Character Select:\nVersione %d < %d",
    error_version_fix = "\\#FFAAAA\\Il modo migliore di risolvere questo problema è reinstallare SM64CoopDX dal sito ufficale o da Github!\n\\#AAAAFF\\https://sm64coopdx.com/\nhttps://github.com/coop-deluxe/sm64coopdx/",
    error_file_missing = "File Mancante '%s'",
    error_file_old = "File della vecchia versione '%s'",
    error_file_popup = "\\#FFAAAA\\Character Select sta avendo un piccolo problema\ncon i file e non carica correttamente\n\nGli errori sono stati scritti in chat!",
    error_file_issues = "\\#FFAAAA\\Problemi con dei file di Character Select: %s",
    error_file_fix = "\\#FFAAAA\\Il modo migliore di risolvere questi problemi è eliminare la cartella di Character Select e installare l'ultima versione da Github!\n\\#AAAAFF\\https://github.com/Squishy6094/character-select-coop/\\#FFAAAA\\", 
    
    -- Menu Text
    menu_version = "Versione: %s | sm64coopdx",
    menu_birthday = "%d anni con Character Select!",
    menu_unavailible = "Non è possibile utilizzare Character Select",
    menu_char_cannot_change = "Non puoi cambiare Personaggio",
    menu_char_set = 'Il Personaggio è stato cambiato in "%s" Con successo!',
    menu_char_not_found = "Personaggio non trovato!",
    menu_curr_char = "Personaggio attuale: ",
    menu_boot = "Character Select ha %d Personaggi disponibili!\nPuoi usare \\#ffff33\\/char-select \\#ffffff\\oppure \\#ffff33\\Il pulsante Z nello schermo di pausa \\#ffffff\\\nper aprire il menu!",
    menu_boot_no_chars = "Character Select è attivo!\nPuoi usare \\#ffff33\\/char-select \\#ffffff\\o \\#ffff33\\Il pulsante Z nello schermo di pausa \\#ffffff\\\nper aprire il menu!",
    menu_boot_too_many_chars = "\\#FFAAAA\\Attenzione: Avere troppi personaggi \npotrebbe essere instabile, Per una migliore esperienza \ndisattiva alcune mod di Personaggi!",
    menu_restrict_moveset = "Le mosse personalizzate sono disabilitate",
    menu_restrict_palette = "Colori personalizzati sono disabilitati",
    menu_restrict_moveset_and_palette = "Le mosse e colori personalizzati sono disabilitati",

    binds_char = "Cambia Personaggio",
    binds_costume = "Cambia Costume",
    binds_pref_char = "Imposta come Personaggio Predefinito",
    binds_exit = "Cambia Personaggio",
    binds_list = "Visualizza Lista",
    binds_grid = "Visualizza Griglia",
    binds_palette = "Cambia Palette",
    binds_category = "Cambia Categoria",
    binds_options = "Menu Opsioni",
    binds_options_scroll = "Scorri tra le Opzioni",
    binds_options_toggle = "Toggle Opzioni",
    binds_options_exit = "Esci Dall Menu Opzioni",
    binds_credits_scroll = "Scorri tra i Crediti",
    binds_credits_switch = "Cambia Pagina",
    binds_credits_exit = "Esci Dalla Pagina Dei Crediti",

    menu_error_model = "Impossibile trovare il modello del personaggio",
    menu_error_model_fix = "Per favore, verificare l'integrità della mod del Personaggio!",

    menu_help = "Comandi disponibili in Character Select:" ..
        "\n\\#ffff33\\/char-select help\\#ffffff\\ - Mostra comandi disponibili" ..
        "\n\\#ffff33\\/char-select menu\\#ffffff\\ - Apre il menu" ..
        "\n\\#ffff33\\/char-select [nome/num]\\#ffffff\\ - Cambia il personaggio" ..
        "\n\\#ff3333\\/char-select reset\\#ffffff\\ - Resetta i dati di salvattaggio",
    menu_reset_are_you_sure = "\\#ffdcdc\\Sei sicuro di volere eliminare i dati di salvataggio, incluso il Personaggio predefinito \nE le impostazioni?\n\nScrivi \\#ff3333\\/char-select reset\\#ffdcdc\\ or seleziona \\#ff3333\\Resetta Dati Di Salvattaggio\\#ffdcdc\\ per confermare.",
    menu_reset_done = "\\#ff3333\\Resed dei dati di salvataggio di Character Select!\\#ffffff\\\n\nNota: Se il problema non è stato risolto, dovresti aver' bisogno di elmiminare manualmente il file di salvattaggio nella seguente directory:\n\\#dcdcFF\\%appdata%/sm64coopdx/sav/character-select-coop.sav",

    menu_options_header = "OPZIONI",
    menu_credits_header = "CREDITI",

    -- Toggle Categories
    menu_category_menu = "Menu",
    menu_category_char = "Personaggo",
    menu_category_misc = "Varie",
    menu_category_host = "Host",
    menu_category_packs = "Pachetti",

    -- Toggles Options
    notifs = "Notifiche",
    menu_color = "Colore del Menu",
    menu_music = "Musica del Menu",
    menu_scroll_speed = "Velocità di scorrimento dell menu",
    char_voices = "Voci dei Personaggi",
    char_visuals = "Visione dei Personaggi",
    char_moveset = "Mosse Personalizzate dei Personaggi",
    restrict_movesets = "Limita Mosse Personalizzate",
    reset_save_data = "Resetta Dati Di Salvataggio",
    credits = "Crediti",

    -- Toggle Descriptions
    notif_desc1 = "Attiva la visualizzazione di",
    notif_desc2 = "Pop-ups e messaggi in Chat.",
    menu_color_desc1 = "Cambia il colore del menu.",
    menu_music_desc1 = "Cambia la musica che è",
    menu_music_desc2 = "Presente nel menu.",
    menu_scroll_speed_desc1 = "Imposta la velocità di Scorrimento",
    menu_scroll_speed_desc2 = "nel menu.",
    char_voices_desc1 = "Attiva la riproduzione delle voci dei Personaggi",
    char_voices_desc2 = "per i personaggi che lo supportano.",
    char_visuals_desc1 = "Attiva la possibilità",
    char_visuals_desc2 = "Dei Personaggi di cambiare",
    char_visuals_desc3 = "Oggetti e Texture.",
    char_moveset_desc1 = "Attiva/Disattiva le mosse personalizzate",
    char_moveset_desc2 = "ai personaggi",
    char_moveset_desc3 = "che lo supportano.",
    restrict_movesets_desc1 = "Limita l'abilitamento delle Mosse Personalizzate",
    restrict_movesets_desc2 = "(Solo per l'Host)",
    reset_save_data_desc1 = "Resetta i",
    reset_save_data_desc2 = "Dati di Salvataggio del personaggio.",
    credits_desc1 = "Grazie di aver scelto",
    credits_desc2 = "Character Select!",

    -- Toggles
    on = "Attivato",
    off = "Disattivato",
    forced_off = "Forzato Disattivato",
    host_only = "Solo per l'Host",
    api_only = "solo l'API",

    popups_only = "Solo i Pop-ups",

    auto = "Automatico",
    saved = "Salvato",
    red = "Rosso",
    orange = "Arancione",
    yellow = "Giallo",
    green = "Verde",
    blue = "Blu",
    pink = "Rosa",
    purple = "Viola",
    white = "Bianco",
    black = "Nero",

    breakroom_only = "Solo Breakroom",
    character_only = "Solo Personaggi",

    slow = "Lento",
    normal = "Normale",
    fast = "Veloce",

    local_only = "Solo Locale",

    open_credits = "Apri i Crediti",

    button = "Pulsante",

    popup_pref_applied = 'Character Select:\nApplicato il Personaggio Predefinito \n"%s"\nCon successo!',
    popup_no_chars = "Character Select:\nNessun personaggio trovato",
    popup_pref_not_found_saved = 'Character Select:\n Il tuo Personaggio predefinito\n"%s"\nNon è stato trovato.',
    popup_pref_not_found = 'Character Select:\nIl tuo Personaggio predefinito\n non è stato trovato.',
    popup_unlocked = 'Character Select: %s\nè stato sbloccato',

    cmd_desc = "Apre il menu di Character Select",
}