fx_version 'cerulean'
lua54 'on'
game 'gta5'
ui_page 'html/index.html'

shared_scripts {
	--'@renzu_shield/init.lua',
    '@ox_lib/init.lua',
}

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
	'html/*',
	'html/**/*',
	'handling.min.json',
	"data/carcols_gen9.meta",
    "data/carmodcols_gen9.meta",
    "data/carmodcols.ymt"
}

data_file "CARCOLS_GEN9_FILE" "data/carcols_gen9.meta"
data_file "CARMODCOLS_GEN9_FILE" "data/carmodcols_gen9.meta"
data_file "FIVEM_LOVES_YOU_447B37BE29496FA0" "data/carmodcols.ymt"