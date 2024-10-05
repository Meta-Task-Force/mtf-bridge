fx_version 'cerulean'
game 'gta5'

name "mtf-bridge"
description "Bridge For MTF Scripts"
author "MTF"
version "1.0.2"
lua54 'yes'

shared_scripts {
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/main.lua'
}
