fx_version 'cerulean'
game 'gta5'
lua54 'yes'

author 'Kenny'
description 'Kenny\'s Selling Script'
version '1.0.0'

shared_scripts {
    '@ox_lib/init.lua',
    'shared/config.lua'
}

client_scripts {
    'client/client.lua'
}

server_scripts {
    'server/server.lua'
}


dependancies {
    'ox_inventory',
    'ox_lib',
    'qb-core'
}
