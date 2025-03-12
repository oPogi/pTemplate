RegisterNetEvent('pcore:annonce')
AddEventHandler('pcore:annonce', function(title, description, job, char)
    if job == nil then return end
    ServerNotify(title, description, char)
end)
