local Annonce = require 'modules.annonce.cfgAnnonce'
local AnnonceStation = Annonce.Annonce
local LocaleAnnonce = Annonce.Locale_Annonce

CreateThread(function()
    for _, v in pairs(AnnonceStation) do
        local data = {
            name = 'annonce' .. v.Job,
            coords = v.Coords,
            radius = 0.45,
            debug = false,
            options = {
                {
                    label = LocaleAnnonce["Target_label"],
                    icon = LocaleAnnonce["Target_icon"],
                    iconColor = LocaleAnnonce["Target_iconColor"],
                    groups = v.Job,
                    distance = 2,
                    canInteract = function()
                        return true
                    end,
                    onSelect = function()
                        local job = GetJob()
                        if job == v.Job then
                            local input = exports.ox_lib:inputDialog(LocaleAnnonce["Input_title"], {
                                { label = LocaleAnnonce["Input_labeltitle"],       type = 'input' },
                                { label = LocaleAnnonce["Input_labeldescription"], type = 'input' }
                            })
                            if not input then return end
                            TriggerServerEvent('pcore:annonce', input[1], input[2], job, v.Char)
                        end
                    end
                }
            }
        }
        exports.ox_target:addSphereZone(data)
    end
end)
