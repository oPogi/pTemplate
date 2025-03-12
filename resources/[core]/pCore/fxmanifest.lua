fx_version 'adamant'
game 'gta5'
lua54 'yes'
creator "Pogi"

shared_scripts {
    "@ox_lib/init.lua",
    "modules/blips/cfgBlips.lua",
    "modules/coffre/cfgCoffre.lua",
    "modules/plateau/cfgPlateau.lua",
    "modules/boss/cfgBoss.lua",
    "modules/annonce/cfgAnnonce.lua",
    "modules/peds/cfgPeds.lua",
    "modules/garage/cfgGarage.lua"
}

client_scripts {
    "lib/cLib.lua",
    "modules/blips/cBlips.lua",
    "modules/coffre/cCoffre.lua",
    "modules/plateau/cPlateau.lua",
    "modules/boss/cBoss.lua",
    "modules/annonce/cAnnonce.lua",
    "modules/peds/cPeds.lua",
    "modules/garage/cGarage.lua"
}

server_scripts {
    "lib/sLib.lua",
    "modules/coffre/sCoffre.lua",
    "modules/plateau/sPlateau.lua",
    "modules/boss/sBoss.lua",
    "modules/annonce/sAnnonce.lua"
}
