fx_version 'cerulean'
game 'gta5'

author 'sureebi'
description 'TMW Fishing - Advanced fishing system with dynamic water detection'
version '1.0.1'

shared_script '@ox_lib/init.lua'

shared_scripts {
    'locales/locale.lua',
    'locales/bg.lua',
    'locales/en.lua',
    'shared/config.lua'
}

client_scripts {
    'client/water_detector.lua',
    'client/zone_manager.lua',
    'client/proximity_detector.lua',
    'client/minigame_native.lua',
    'client/minigame_handler.lua',
    'client/ui_handler.lua',
    'client/fishing_controller.lua',
    'client/debug_system.lua',
    'client/blips.lua',
    'client/fish_buyer.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/loot_tables.lua',
    'server/loot_generator.lua',
    'server/fishing_stats.lua',
    'server/fishing_api.lua',
    'server/fishing_server.lua',
    'server/fish_buyer_server.lua'
}

ui_page 'html/index.html'

files {
    'html/test.html',
    'html/index.html',
    'html/script.js',
    'html/style.css',
    'html/fishing_menu.html',
    'html/fishing_menu.css',
    'html/fishing_menu.js',
    'html/fishing_ui.html',
    'html/fishing_ui.css',
    'html/fishing_ui.js'
}

dependencies {
    'ox_inventory',
    'ox_lib',
    'ox_target',
    'oxmysql'
}

lua54 'yes'
