local Plateauu = require 'modules.plateau.cfgPlateau'
local Plateau = Plateauu.Plateau
local LocalePlateau = Plateauu.Locale_Plateau

CreateThread(function()
    for _, v in pairs(Plateau) do 
        local data = {
            name = 'plateau' .. v.Name,
            coords = v.Coords,
            radius = 0.45,
            debug = false,
            options = {
                {
                    label = LocalePlateau["Target_label"],
                    icon = LocalePlateau["Target_icon"],
                    iconColor = LocalePlateau["Target_iconColor"],
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