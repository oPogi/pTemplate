local Coffree = require 'modules.coffre.cfgCoffre'
local Coffre = Coffree.Coffre
local LocaleCoffre = Coffree.Locale_Coffre

CreateThread(function()
    for _, v in pairs(Coffre) do 
        local data = {
            name = 'coffre' .. v.Name,
            coords = v.Coords,
            radius = 0.45,
            debug = false,
            options = {
                {
                    label = LocaleCoffre["Target_label"],
                    icon = LocaleCoffre["Target_icon"],
                    iconColor = LocaleCoffre["Target_iconColor"],
                    groups = v.Job,
                    distance = 2,
                    canInteract = function()
                        return true
                    end,
                    onSelect = function()
                        exports.ox_inventory:openInventory('stash', v.Name)
                    end
                }
            }
        }
        exports.ox_target:addSphereZone(data)
    end
end)