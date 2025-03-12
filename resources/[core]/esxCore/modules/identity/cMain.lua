local loadingScreenFinished = false
local guiEnabled = false
local timecycleModifier = "hud_def_blur"
local Identity = require 'modules.identity.cfgIdentity'
local Locale_Identity = Identity.Locale_Identity

RegisterNetEvent('esx_identity:alreadyRegistered', function()
    while not loadingScreenFinished do Wait(100) end
    TriggerEvent('esx_skin:playerRegistered')
end)

RegisterNetEvent('esx_identity:setPlayerData', function(data)
    SetTimeout(1, function()
        ESX.SetPlayerData("name", ('%s %s'):format(data.firstName, data.lastName))
        ESX.SetPlayerData('firstName', data.firstName)
        ESX.SetPlayerData('lastName', data.lastName)
        ESX.SetPlayerData('dateofbirth', data.dateOfBirth)
        ESX.SetPlayerData('sex', data.sex)
        ESX.SetPlayerData('height', data.height)
        ESX.SetPlayerData('starter', data.starter)
    end)
end)

AddEventHandler('esx:loadingScreenOff', function()
    loadingScreenFinished = true
end)

if not Identity.Identity.UseDeferrals then
    local input

    function showRegistration(state)
        guiEnabled = state

        if state then
            SetTimecycleModifier(timecycleModifier)
        else
            lib.closeInputDialog()
            ClearTimecycleModifier()
            return
        end

        input = lib.inputDialog(Locale_Identity['application_name'], {
            {type = 'input', label = Locale_Identity['first_name'], description = Locale_Identity['first_name_description'], required = true},
            {type = 'input', label = Locale_Identity['last_name'], description = Locale_Identity['last_name_description'], required = true},
            {type = 'number', label = Locale_Identity['height'], min = Identity.Identity.MinHeight, max = Identity.Identity.MaxHeight, description = Locale_Identity['height_description'], required = true},
            {type = 'date', label = Locale_Identity['dob'], description = Locale_Identity['dob_description'], format = Identity.Identity.DateFormat, required = true},
            {type = 'select', label = Locale_Identity['gender'], description = Locale_Identity['gender_description'], options = {{value = "m", label = Locale_Identity['gender_male']}, {value = "f", label = Locale_Identity['gender_female']}}, required = true},
            {type = 'select', label = 'Starter', description = 'Votre starter est votre decision de vie avec votre personnage', options = {{value = "illegal", label = "Illégal"}, {value = "legal", label = "Légal"}}, required = true},
        }, {
            allowCancel = false
        })

        local data = {}
        data.firstname = input[1]
        data.lastname = input[2]
        data.height = input[3]
        data.dateofbirth = math.floor(input[4]/1000) --ox_lib returns date with millisecond accuracy
        data.sex = input[5] --m or f
        data.starter = input[6]

        TriggerServerEvent('pogi:starter', input[6])

        ESX.TriggerServerCallback('esx_identity:registerIdentity', function(callback)
            if not callback then return end --Something is wrong with formating

            ClearTimecycleModifier()
            lib.notify({
                title = Locale_Identity['application_name'],
                description = Locale_Identity['application_accepted'],
                type = 'success',
                position = 'top',
            })
            TriggerEvent('esx_skin:openSaveableMenu')
        end, data)
    end

    RegisterNetEvent('esx_identity:showRegisterIdentity', function()
        TriggerEvent('esx_skin:resetFirstSpawn')
        if not ESX.PlayerData.dead then showRegistration(true) end
    end)
end
