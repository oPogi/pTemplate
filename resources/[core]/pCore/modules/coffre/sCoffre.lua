local Coffre = require 'modules.coffre.cfgCoffre'
local Coffre = Coffre.Coffre

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        for _, v in pairs(Coffre) do
            FuncCoffreRegister(v.Name, v.Label, v.Slots, v.Weight, v.Job, v.Coords)
        end
    end
end)