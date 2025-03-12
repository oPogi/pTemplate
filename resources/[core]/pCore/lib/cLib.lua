pCore = exports['es_extended']:getSharedObject()

GetJob = function()
    local job = pCore.GetPlayerData().job
    if job ~= nil then
        return job.name
    else
        return nil
    end
end

GetJobGrade = function()
    local job = pCore.GetPlayerData().job
    if job ~= nil then
        return job.grade
    else
        return nil
    end
end

SpawnCar = function(model, coords, plate)
    if pCore.Game.IsSpawnPointClear(coords, 5.0) then
        pCore.Game.SpawnVehicle(model, coords, coords.w, function(vehicle)
            SetVehicleNumberPlateText(vehicle, plate)
        end)
    else
        Notify('Un véhicule est déjà présent', 'error')
    end
end

DeleteVehicle = function(vehicle)
    return pCore.Game.DeleteVehicle(vehicle)
end

GetPlayerPosition = function()
    return pCore.GetPlayerData().coords
end

Notify = function(text, type)
    pCore.ShowNotification(text, type)
end

OpenBossMenu = function(job)
    if job == nil then return end
    TriggerEvent('esx_society:openBossMenu', job, function()
    end, { wash = false })
end

Progress = function(time, label, dict, clip)
    if time and label and dict and clip then
        lib.progressBar({
            duration = time,
            label = label,
            useWhileDead = false,
            canCancel = false,
            disable = {
                car = true,
                move = true
            },
            anim = {
                dict = dict,
                clip = clip
            }
        })
    end
end

AnimationPed = function(ped, dict, anim)
    if not DoesEntityExist(ped) and not dict and not anim then return end
    lib.requestAnimDict(dict, true)
    lib.playAnim(ped, dict, anim, 3.0, 1.0, -1, 1, 0, false, false, false)
end
