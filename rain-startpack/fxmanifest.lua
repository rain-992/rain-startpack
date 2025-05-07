fx_version 'cerulean'
game 'gta5'

description 'rain新手礼包系统'
author 'Rain'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    '@qb-core/shared/locale.lua',
    'config.lua'
}

client_scripts {
    'client/main.lua'
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    'server/main.lua'
}

dependencies {
    'qb-core',
    'qb-target',
    'ox_lib'
}

lua54 'yes'