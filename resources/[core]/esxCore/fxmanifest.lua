fx_version 'adamant'
game 'gta5'
lua54 'yes'

shared_script {
    '@ox_lib/init.lua',
    '@es_extended/imports.lua',
    'modules/license/cfgLicense.lua',
    'modules/basicneeds/cfgBasicneeds.lua',
    'modules/status/cfgStatus.lua',
    'modules/society/cfgSociety.lua',
    'modules/billing/cfgBilling.lua',
    'modules/identity/cfgIdentity.lua'
}

client_scripts {
    'modules/service/cMain.lua',
    'modules/basicneeds/cMain.lua',
    'modules/status/cMain.lua',
    'modules/status/cStatus.lua',
    'modules/society/cMain.lua',
    'modules/billing/cMain.lua',
    'modules/identity/cMain.lua'
}

server_scripts {
	'@oxmysql/lib/MySQL.lua',
    'modules/addonaccount/*.lua',
    'modules/addoninventory/*.lua',
    'modules/cron/sMain.lua',
    'modules/license/sMain.lua',
    'modules/service/sMain.lua',
    'modules/datastore/*.lua',
    'modules/basicneeds/sMain.lua',
    'modules/status/sMain.lua',
    'modules/society/sMain.lua',
    'modules/billing/sMain.lua',
    'modules/identity/sMain.lua'
}

server_exports {
    'GetSharedAccount',
    'AddSharedAccount',
    'GetAccount',
    'GetSharedInventory',
    'AddSharedInventory'
}

ui_page 'modules/status/html/ui.html'

files {
	'modules/status/html/ui.html',
	'modules/status/html/css/app.css',
	'modules/status/html/scripts/app.js',
    'modules/chat/style.css',
    'modules/chat/shadow.js'
}

chat_theme 'esx' {
    styleSheet = 'modules/chat/style.css',
    script = 'modules/chat/shadow.js',
    msgTemplates = {
        default = '<b>{0}</b><span>{1}</span>'
    }
}