ServerNotify = function(title, description, char)
    TriggerClientEvent('esx:showAdvancedNotification', -1, 'Annonce', title, description, char, 9)
end

FuncBossRegister = function(job)
    TriggerEvent('esx_society:registerSociety', job, job, 'society_' .. job, 'society_' .. job, 'society_' .. job, { type = 'private' })
end

FuncCoffreRegister = function(name, label, slots, weight, job, coords)
    if job then
        exports.ox_inventory:RegisterStash(name, label, slots, weight, nil, { [job] = 0 }, coords)
    else
        exports.ox_inventory:RegisterStash(name, label, slots, weight, nil, nil, coords)
    end
end
