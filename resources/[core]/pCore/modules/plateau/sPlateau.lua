local Plateau = require 'modules.plateau.cfgPlateau'
local Plateau = Plateau.Plateau

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == 'ox_inventory' or resourceName == GetCurrentResourceName() then
        for _, v in pairs(Plateau) do 
            FuncCoffreRegister(v.Name, v.Label, v.Slots, v.Weight, nil, v.Coords)
        end
    end
end)