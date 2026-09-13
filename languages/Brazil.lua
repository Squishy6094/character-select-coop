return {
    mod_name = "Seleção de Personagem",
    
    -- Utils Failsafing
    error_version_popup = "\n\\#FFAAAA\\A Seleção de Personagem requer\n a versão mais recente de CoopDX para ser utilizada!\n\nVoçê encontrará a versão mais recente de CoopDX aqui:\n\\#AAAAFF\\https://sm64coopdx.com",
    error_version_message = "\\#FFAAAA\\Erro da Versão da Seleção de Personagem:\nVersão %d < %d",
    error_version_fix = "\\#FFAAAA\\A melhor forma de solucionar isso é por reinstalar SM64CoopDX da página oficial ou do repositório de Github!\n\\#AAAAFF\\https://sm64coopdx.com/\nhttps://github.com/coop-deluxe/sm64coopdx/",
    error_file_missing = "Arquivo em falta '%s'",
    error_file_old = "Arquivo legado '%s'",
    error_file_popup = "\\#FFAAAA\\Seleção de Personagem está tendo\nerros de arquivo e não é capaz de carregar!\n\nErros estão registrados no Bate-Papo!",
    error_file_issues = "\\#FFAAAA\\Problemas com Arquivos da Seleção de Personagem: %s",
    error_file_fix = "\\#FFAAAA\\A melhor forma de solucionar tais erros é por deletar a sua cópia da Seleção de Personagem e instalar a versão mais recente do repositório de Github!\n\\#AAAAFF\\https://github.com/Squishy6094/character-select-coop/\\#FFAAAA\\", 
    
    -- Menu Text
    menu_version = "Versão: %s | sm64coopdx",
    menu_birthday = "%d anos da Seleção de Personagem!",
    menu_unavailible = "Seleção de Personagem está indisponível",
    menu_char_cannot_change = "Personagem incapaz de ser alternade",
    menu_char_set = 'Personagem definide como "%s" Com êxito!',
    menu_char_not_found = "Personagem não encontrade",
    menu_curr_char = "Personagem Atual: ",
    menu_boot = "Seleção de Personagem tem %d personagens selecionaveís!\nVocê pode utilizar o comando \\#ffff33\\/char-select \\#ffffff\\ou o \\#ffff33\\Botão Z no menu de pausa \\#ffffff\\\npara abrir o menu!",
    menu_boot_no_chars = "Seleção de Personagem está ativa!\nVocê pode utilizar o comando \\#ffff33\\/char-select \\#ffffff\\ou o \\#ffff33\\Botão Z no menu de pausa \\#ffffff\\\npara abrir o menu!",
    menu_boot_too_many_chars = "\\#FFAAAA\\Aviso: Ter muitos personagens\npoderá ser instável, Para uma expêrience melhor, é sugerido\ndesativar alguns pacotes!",
    menu_restrict_moveset = "Movimentos Personalizados estão Restritos",
    menu_restrict_palette = "Paletas estão Restritas",
    menu_restrict_moveset_and_palette = "Movimentos Personalizados e Paletas estão Restritos",

    binds_char = "Mudar Personagem",
    binds_costume = "Mudar Traje",
    binds_pref_char = "Definir Personagem Favorite",
    binds_exit = "Mudar Personagem",
    binds_list = "Alternar Visualização de Lista",
    binds_grid = "Altermar Visualização de Grid",
    binds_palette = "Mudar Paleta",
    binds_category = "Alternar Categorias",
    binds_options = "Página de Opções",
    binds_options_scroll = "Navegar Opções",
    binds_options_toggle = "Alternar Opções",
    binds_options_exit = "Sair da Página de Opções",
    binds_credits_scroll = "Navegar Créditos",
    binds_credits_switch = "Trocar Página",
    binds_credits_exit = "Sair da Página de Créditos",

    menu_error_model = "Falha em encontrar um modelo de personagem",
    menu_error_model_fix = "Favor, verifique a integridade do pacote!",

    menu_help = "Os Comandos disponíveis da Seleção de Personagem:" ..
        "\n\\#ffff33\\/char-select help\\#ffffff\\ - Demonstra comandos disponíveis" ..
        "\n\\#ffff33\\/char-select menu\\#ffffff\\ - Abre o Menu" ..
        "\n\\#ffff33\\/char-select [name/num]\\#ffffff\\ - Alterna ê Personagem" ..
        "\n\\#ff3333\\/char-select reset\\#ffffff\\ - Formata seus Dados",
    menu_reset_are_you_sure = "\\#ffdcdc\\Têm certeza que quer formatar seus dados da Seleção de Personagem, Inclusive Sue Personagem Favorite\ne Opções?\n\nDigite \\#ff3333\\/char-select reset\\#ffdcdc\\ ou habilite \\#ff3333\\Formatar meus Dados\\#ffdcdc\\ para confirmar.",
    menu_reset_done = "\\#ff3333\\Dados Salvos da Seleção de Personagem Reiniciados!\\#ffffff\\\n\nNota: Se erros ainda estiverem presentes, talvez seja necessário apagar dados nesse diretório:\n\\#dcdcFF\\%appdata%/sm64coopdx/sav/character-select-coop.sav",

    menu_options_header = "OPÇÕES",
    menu_credits_header = "CRÉDITOS",

    -- Toggle Categories
    menu_category_menu = "Menu",
    menu_category_char = "Personagem",
    menu_category_misc = "Diversos",
    menu_category_host = "Anfitriane",
    menu_category_packs = "Pacotes",

    -- Toggles Options
    notifs = "Notificações",
    menu_color = "Cor do Menu",
    menu_music = "Música do Menu",
    menu_scroll_speed = "Velocidade de Navegação do Menu",
    char_voices = "Dublagem de Personagens",
    char_visuals = "Visuais de Personagens",
    char_moveset = "Movimentos Personalizados de Personagens",
    restrict_movesets = "Restringir Movimentos Personalizados",
    reset_save_data = "Formatar meus Dados",
    credits = "Créditos",

    -- Toggle Descriptions
    notif_desc1 = "Alterna se pop-ups e",
    notif_desc2 = "Mensagens de Bate-Papo são mostradas.",
    menu_color_desc1 = "Alterna a Cor do Menu",
    menu_music_desc1 = "Alterna a música que toca",
    menu_music_desc2 = "no menu.",
    menu_scroll_speed_desc1 = "Alterna quão rápida é a navegação",
    menu_scroll_speed_desc2 = "pelo Menu.",
    char_voices_desc1 = "Alterna se dublagens personalizadas são reproduzidas",
    char_voices_desc2 = "para personagens que-as suportam.",
    char_visuals_desc1 = "Alterna se Personagens são capazes",
    char_visuals_desc2 = "de alternar os visuais de",
    char_visuals_desc3 = "Objetos e Texturas.",
    char_moveset_desc1 = "Alterna se Movimentos Personalizados",
    char_moveset_desc2 = "estarão ativados em",
    char_moveset_desc3 = "personagens compatíveis.",
    restrict_movesets_desc1 = "Restringe ativação de Movimentos Personalizados.",
    restrict_movesets_desc2 = "(Somente para Anfitriane)",
    reset_save_data_desc1 = "Reinicia os Dados Salvos da",
    reset_save_data_desc2 = "Seleção de Personagem.",
    credits_desc1 = "Muito Obrigada por Utilizar",
    credits_desc2 = "Seleção de Personagem!",

    -- Toggles
    on = "Habilitade",
    off = "Deshabilitade",
    forced_off = "Deshabilitade Pele Anfitriane",
    host_only = "Exclusive ae Anfitriane",
    api_only = "Exclusivo ao API",

    popups_only = "Somente Pop-ups",

    auto = "Automática",
    saved = "Salva",
    red = "Vermelha",
    orange = "Laranja",
    yellow = "Amarela",
    green = "Verde",
    blue = "Azul",
    pink = "Rosa",
    purple = "Roxa",
    white = "Branca",
    black = "Preta",

    breakroom_only = "Somente 'Breakroom'",
    character_only = "Somente de Personagem",

    slow = "Lenta",
    normal = "Normal",
    fast = "Rápida",

    local_only = "Somente Local",

    open_credits = "Abrir Créditos",

    button = "Botão",

    popup_pref_applied = 'Seleção de Personagem::\nSue Personagem Favorite\n"%s"\nfoi aplicade com êxito!',
    popup_no_chars = "Seleção de Personagem::\nSem Personagens Encontrades",
    popup_pref_not_found_saved = 'Seleção de Personagem:\nSue Personagem Favorite\n"%s"\nNão foi encontrade.',
    popup_pref_not_found = 'Seleção de Personagem:\nSue Personagem Favorite\nNão foi encontrade.',
    popup_unlocked = 'Seleção de Personagem:\nDesbloqueou %s\nComo ume Personagem Jogável!',

    cmd_desc = "Abre a Seleção de Personagem",
}