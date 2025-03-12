local Boss = require 'modules.boss.cfgBoss'
local BossMenu = Boss.Boss

AddEventHandler('onServerResourceStart', function(resourceName)
    if resourceName == GetCurrentResourceName() then
        for _, v in pairs(BossMenu) do
            FuncBossRegister(v.Job)
        end
    end
end)