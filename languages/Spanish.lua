return {
    mod_name = "Character Select",
    
    -- Utils Failsafing
    error_version_popup = "\n\\#FFAAAA\\Character Select necesita\n la ultima versión de CoopDX para funcionar!\n\nPuedes encontrar CoopDX aqui:\n\\#AAAAFF\\https://sm64coopdx.com",
    error_version_message = "\\#FFAAAA\\Character Select tiene un Problema con la Versión:\nVersión %d < %d",
    error_version_fix = "\\#FFAAAA\\La mejor forma de arreglar el Problema es Reinstalar SM64CoopDX desde el Sitio Oficial o del Repositorio en Github!\n\\#AAAAFF\\https://sm64coopdx.com/\nhttps://github.com/coop-deluxe/sm64coopdx/",
    error_file_missing = "Archivo Ausente '%s'",
    error_file_old = "Archivo Antiguo '%s'",
    error_file_popup = "\\#FFAAAA\\Character Select tiene\narchivos problematicos y no puede iniciar!\n\nLos Errores se han Registrado en el Chat!",
    error_file_issues = "\\#FFAAAA\\Character Select Problemas de Archivo: %s",
    error_file_fix = "\\#FFAAAA\\La mejor forma de arreglar el Problema es borrar tu versión de Character Select actual e instalar la ultima versión desde el Repositorio en Github!\n\\#AAAAFF\\https://github.com/Squishy6094/character-select-coop/\\#FFAAAA\\", 
    
    -- Menu Text
    menu_version = "Versión: %s | sm64coopdx",
    menu_birthday = "%d años de Character Select!",
    menu_unavailable = "Character Select no esta Disponible",
    menu_char_cannot_change = "No se puede Cambiar el Personaje",
    menu_char_set = 'Personaje cambiado a "%s" Exitosamente!',
    menu_char_not_found = "Personaje No Encontrado",
    menu_curr_char = "Personaje Actual: ",
    menu_boot = "Character Select tiene %d personajes disponibles!\nPuedes usar \\#ffff33\\/char-select \\#ffffff\\o el \\#ffff33\\Botón Z al Pausar \\#ffffff\\\npara abrir el menú!",
    menu_boot_no_chars = "Character Select esta activo!\nPuedes usar \\#ffff33\\/char-select \\#ffffff\\o el \\#ffff33\\Botón Z al Pausar \\#ffffff\\\npara abrir el menú!",
    menu_boot_too_many_chars = "\\#FFAAAA\\Aviso: Tener muchos personajes\npuede ser inestable, Para una experiencia mejor\ndesactiva algunos paquetes!",
    menu_restrict_moveset = "Los Movesets estan Restringidos",
    menu_restrict_palette = "Las Paletas de Color estan Restringidas",
    menu_restrict_moveset_and_palette = "Los Movesets y Las Paletas de Color estan Restringidas ",

    binds_char = "Cambiar Personaje",
    binds_costume = "Cambiar Disfraz",
    binds_pref_char = "Establecer Personaje Preferido",
    binds_exit = "Cambiar Personaje",
    binds_list = "Activa/Desactiva Vista de Lista",
    binds_grid = "Activa/Desactiva Vista de Cuadrícula",
    binds_palette = "Activa/Desactiva la Paleta de Color",
    binds_category = "Cambiar Categorías",
    binds_options = "Menú de Opciones",
    binds_options_scroll = "Opciones de Desplazamiento",
    binds_options_toggle = "Alternar Opciones",
    binds_options_exit = "Salir del Menú de Opciones",
    binds_credits_scroll = "Desplazar por los Créditos",
    binds_credits_switch = "Cambiar Página",
    binds_credits_exit = "Salir del Menú de Créditos",

    menu_error_model = "No se pudo encontrar un Modelo de Personaje",
    menu_error_model_fix = "Porfavor Verifica la Integridad del Paquete!",

    menu_help = "Comandos Disponibles de Character Select:" ..
        "\n\\#ffff33\\/char-select help\\#ffffff\\ - Muestra los Comandos Disponibles" ..
        "\n\\#ffff33\\/char-select menu\\#ffffff\\ - Abre el Menú" ..
        "\n\\#ffff33\\/char-select [name/num]\\#ffffff\\ - Cambia el Personaje" ..
        "\n\\#ff3333\\/char-select reset\\#ffffff\\ - Resetea tus Datos de Guardado",
    menu_reset_are_you_sure = "\\#ffdcdc\\Estas seguro/a que quieres borrar tus Datos de Guardado de Character Select, Incluyendo tu Personaje Preferido\ny las Opciones?\n\nEscribe \\#ff3333\\/char-select reset\\#ffdcdc\\ o Activa \\#ff3333\\Resetear Datos de Guardado\\#ffdcdc\\ para confirmar.",
    menu_reset_done = "\\#ff3333\\Los Datos de Guardado de Character Select se han Reseteado!\\#ffffff\\\n\nNota: Si el problema no se ha arreglado, tendras que borrar tus datos de guardado manualmente en el directorio siguiente:\n\\#dcdcFF\\%appdata%/sm64coopdx/sav/character-select-coop.sav",

    menu_options_header = "OPCIONES",
    menu_credits_header = "CRÉDITOS",

    -- Toggle Categories
    menu_category_menu = "Menú",
    menu_category_char = "Personaje",
    menu_category_misc = "Misc",
    menu_category_host = "Anfitrión",
    menu_category_packs = "Paquetes",

    -- Toggles Options
    notifs = "Notificaciones",
    menu_color = "Color del Menú",
    menu_music = "Música del Menú",
    menu_scroll_speed = "Velocidad de Desplazamiento",
    char_voices = "Voces de los Personajes",
    char_visuals = "Visuales de los Personajes",
    char_moveset = "Movesets de los Personajes",
    restrict_movesets = "Restringir Movesets",
    reset_save_data = "Resetear Datos de Guardado",
    credits = "Créditos",

    -- Toggle Descriptions
    notif_desc1 = "Activa/Desactiva si se muestran las",
    notif_desc2 = "ventanas emergentes y los mensajes de chat.",
    menu_color_desc1 = "Activa/Desactiva el color del Menú.",
    menu_music_desc1 = "Activa/Desactiva que cancion",
    menu_music_desc2 = "se reproduce en el Menú.",
    menu_scroll_speed_desc1 = "Cambia lo rápido que puedes",
    menu_scroll_speed_desc2 = "desplazarte por el Menú.",
    char_voices_desc1 = "Activa/Desactiva si las lineas de voz se",
    char_voices_desc2 = "activan para los personajes compatibles.",
    char_visuals_desc1 = "Activa/Desactiva si los",
    char_visuals_desc2 = "Personajes pueden cambiar la",
    char_visuals_desc3 = "apariencia de Objetos y Texturas.",
    char_moveset_desc1 = "Activa/Desactiva si los Movesets",
    char_moveset_desc2 = "Customizados se activan para",
    char_moveset_desc3 = "los personajes compatibles.",
    restrict_movesets_desc1 = "Restringe activar los Movesets.",
    restrict_movesets_desc2 = "(Solo el Anfitrión)",
    reset_save_data_desc1 = "Resetea los datos de",
    reset_save_data_desc2 = "Character Select.",
    credits_desc1 = "Gracias por elegir",
    credits_desc2 = "Character Select!",

    -- Toggles
    on = "On",
    off = "Off",
    forced_off = "Off forzado",
    host_only = "Solo el Anfitrión",
    api_only = "Solo la API",

    popups_only = "Solo ventanas emergentes",

    auto = "Auto",
    saved = "Guardado",
    red = "Rojo",
    orange = "Naranja",
    yellow = "Amarillo",
    green = "Verde",
    blue = "Azul",
    pink = "Rosa",
    purple = "Morado",
    white = "Blanco",
    black = "Negro",

    breakroom_only = "Solo en sala de Descanso",
    character_only = "Solo el Personaje",

    slow = "Lento",
    normal = "Normal",
    fast = "Rápido",

    local_only = "Solo en Local",

    open_credits = "Abre los créditos",

    button = "Botón",

    popup_pref_applied = 'Character Select:\nTu Personaje Preferido\n"%s"\nse ha aplicado exitosamente!',
    popup_no_chars = "Character Select:\nNo se encontro ningun Personaje.",
    popup_pref_not_found_saved = 'Character Select:\nTu Personaje Preferido\n"%s"\nno se pudo encontrar.',
    popup_pref_not_found = 'Character Select:\nTu Personaje Preferido\nno se pudo encontrar.',
    popup_unlocked = 'Character Select:\nSe Desbloqueo a %s\ncomo un Personaje Jugable!',

    cmd_desc = "Abre el menú de Character Select",
}