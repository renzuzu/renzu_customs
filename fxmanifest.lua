fx_version 'cerulean'
lua54 'on'
game 'gta5'
ui_page 'html/index.html'

server_scripts {
	'@mysql-async/lib/MySQL.lua', -- uncomment if ghmatti and oxmysql
	'config.lua',
	'framework/sv_wrapper.lua',
	'server/server.lua'
}

client_scripts {
	'config.lua',
	'framework/cl_wrapper.lua',
	'client/function.lua',
	'client/client.lua',
	'client/events.lua',
	'client/nui_event.lua',
}

files {
	'html/design.css',
	'html/index.html',
	'html/*.js',
	'html/fonts/*',	
	'html/img/*.svg',
	'imgs/uploads/*.jpg',
	'html/audio/*.ogg',
	'handling.min.json'
}