local cfg = require 'modules.blips.cfgBlips'
local Blips = cfg.Blips

CreateThread(function()
    for _, v in pairs(Blips) do
        local blip = AddBlipForCoord(v.coords)
        SetBlipSprite(blip, v.sprite)
        SetBlipDisplay(blip, v.display)
        SetBlipScale(blip, v.scale)
        SetBlipColour(blip, v.color)
        SetBlipAsShortRange(blip, v.shortRange)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(v.label)
        EndTextCommandSetBlipName(blip)
    end
end)
