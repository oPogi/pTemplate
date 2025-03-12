local Boss = require 'modules.boss.cfgBoss'
local BossMenu = Boss.Boss
local LocaleBoss = Boss.Locale_Boss

CreateThread(function()
    for _, v in pairs(BossMenu) do
        local data = {
            name = 'boss' .. v.Job,
            coords = v.Coords,
            radius = 0.45,
            debug = false,
            options = {
                {
                    label = LocaleBoss["Target_label"],
                    icon = LocaleBoss["Target_icon"],
                    iconColor = LocaleBoss["Target_iconColor"],
                    groups = v.Job,
                    distance = 2,
                    canInteract = function()
                        return true
                    end,
                    onSelect = function()
                        OpenBossMenu(v.Job)
                    end
                }
            }
        }
        exports.ox_target:addSphereZone(data)
    end
end)
