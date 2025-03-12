local Peds = require 'modules.peds.cfgPeds'
local Peds = Peds.Peds

CreateThread(function()
    for _, v in pairs(Peds) do
        local ped = CreatePed(0, v.Model, v.Coords.x, v.Coords.y, v.Coords.z - 1, v.Coords.w, false, false)
        lib.requestModel(v.Model)
        if v.Scenario and not v.AnimationName and not v.AnimationDict then
            TaskStartScenarioInPlace(ped, v.Scenario, 0, true)
        end
        if v.AnimationName and v.AnimationDict and not v.Scenario then
            AnimationPed(ped, v.AnimationDict, v.AnimationName)
        end
        FreezeEntityPosition(ped, true)
        SetEntityInvincible(ped, true)
        SetBlockingOfNonTemporaryEvents(ped, true)
        SetEntityAsMissionEntity(ped, true, true)
    end
end)

