function OpenBossMenu(society)
    local PlayerData = ESX.GetPlayerData()
    ESX.TriggerServerCallback('esx_society:isBoss', function(isBoss)
		if isBoss then
            lib.registerContext({
                id = 'boss_menu',
                title = 'Gestion ' .. society .. ' ',
                options = {
                    {
                        title = 'Compte Entreprise',
                        description = 'Vérifier le solde du compte entreprise',
                        icon = 'fa-solid fa-money-bill',
                        onSelect = function()
                            TriggerServerEvent('esx_society:checkSocietyBalance', society)
                            lib.showContext('boss_menu')
                        end
                    },
                    {
                        title = 'Déposer',
                        description = 'Déposer des fonds',
                        icon = 'fa-solid fa-money-bill',
                        onSelect = function()
                            local input = lib.inputDialog('Deposer des fonds', {
                                { type = 'number', label = 'Montant ?', description = 'Combien souhaitez-vous déposer ?', icon = 'hashtag', required = true },
                            })

                            if not input then return end

                            local deposit = tonumber(input[1])

                            local isdeposit = lib.alertDialog({
                                header = 'Deposer des fonds',
                                content = 'Etes-vous sûr de vouloir déposer ?' .. deposit .. ' $ ?',
                                centered = true,
                                cancel = true
                            })
                            if isdeposit == 'cancel' then
                                ESX.ShowNotification('Vous avez annuler la transaction !', 'error')
                                return
                            else
                                TriggerServerEvent('esx_society:depositMoney', society, deposit)
                            end
                        end
                    },
                    {
                        title = 'Retirer',
                        description = 'Retirer du compte entreprise',
                        icon = 'fa-solid fa-money-bill',
                        onSelect = function()
                            local input = lib.inputDialog('Retirer des fonds', {
                                { type = 'number', label = 'Montant ?', description = 'Combien souhaitez-vous retirer ?', icon = 'hashtag', required = true },
                            })

                            if not input then return end

                            local withdraw = tonumber(input[1])

                            local iswithdraw = lib.alertDialog({
                                header = 'Retirer des fonds',
                                content = 'Êtes-vous sûr de vouloir vous retirer ?' .. withdraw .. ' $ ?',
                                centered = true,
                                cancel = true
                            })
                            if iswithdraw == 'cancel' then
                                ESX.ShowNotification('Vous avez annuler la transaction !', 'error')
                                return
                            else
                                TriggerServerEvent('esx_society:withdrawMoney', society, withdraw)
                            end
                        end
                    },
                    {
                        title = 'Employer',
                        description = 'Gérer les employers',
                        icon = 'fa-solid fa-address-book',   
                        onSelect = function()
                            OpenManagePlayersMenu(society)
                        end
                    },
                    {
                        title = 'Salaire',
                        description = 'Gestion des salaires',
                        icon = 'fa-solid fa-business-time', 
                        onSelect = function()
                            OpenPayCheckMenu(society)
                        end
                    },
                    {
                        title = 'Grade',
                        description = 'Gestion des nom de grade',
                        icon = 'fa-solid fa-business-time',
                        onSelect = function()
                            GestionGradeLabel(society)
                        end
                    }
                }
            })
            lib.showContext('boss_menu')
        end
    end, PlayerData.job.name, PlayerData.job.grade_name)
end

function OpenManagePlayersMenu(society)
    lib.registerContext({
        id = 'recrute_menu_boss',
        title = 'Gestion des employers',
        options = {
            {
                title = 'Employer',
                description = 'Gestion des employers',
                onSelect = function()
                    local options = {}

                    ESX.TriggerServerCallback('esx_society:getEmployees', function(employees)
                        for i=1, #employees, 1 do
                            local gradeLabel = (employees[i].job.grade_label == '' and employees[i].job.label or employees[i].job.grade_label)
                
                            options[#options+1] = {
                                icon = "fas fa-user", 
                                title = employees[i].name,
                                description = ' ' ..gradeLabel, gradeLabel = gradeLabel, data = employees[i],
                                onSelect = function()
                                    lib.registerContext({
                                        id = 'manage_society_menu',
                                        title = 'Gestion des employers',
                                        options = {
                                            {
                                                title = 'Promouvoir',
                                                description = 'Promouvoir un employer',
                                                onSelect = function()
                                                    OpenPromoteMenu(society, employees[i])
                                                end
                                            },
                                            {
                                                title = 'Licencier',
                                                description = 'Licencier un employer',
                                                onSelect = function()
                                                    ESX.TriggerServerCallback('esx_society:setJob', function()
                                                    end, employees[i].identifier, 'unemployed', 0, 'fire')
                                                end
                                            }
                                        }
                                    })

                                    lib.showContext('manage_society_menu')
                                end
                            }
                        end

                        lib.registerContext({
                            id = 'manage_already_employee',
                            title = 'Gestion des employers',
                            options = options,
                            menu = 'boss_menu'
                        })
                        lib.showContext('manage_already_employee')
                    end, society)
                end
            },
            {
                title = 'Recruter',
                description = 'Recruter un employer',
                onSelect = function()
                    OpenRecruitMenu(society)
                end
            },
            {
                title = 'revenir',
                onSelect = function()
                    lib.showContext('boss_menu')
                end
            }
        }
    })

    lib.showContext('recrute_menu_boss')
end

function OpenPayCheckMenu(society)
    local options = {}
    ESX.TriggerServerCallback('esx_society:getJob', function(job)
        if not job then
            return
        end

		for i=1, #job.grades, 1 do
			local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)

			options[#options+1] = {
				icon = "fas fa-wallet",
				title = ('%s'):format(gradeLabel),
                description = ('Salary: %s'):format(ESX.Math.GroupDigits(job.grades[i].salary) .. ' $'),
				value = job.grades[i].grade,
                onSelect = function()
                    local input = lib.inputDialog('Salaire', {
                        { type = 'input', label = 'Montant ?', description = 'A combien souhaitez-vous fixer le salaire ?', icon = 'hashtag', required = true },
                    })

                    if not input then return end

                    local amount = tonumber(input[1])

                    local isPaycheck = lib.alertDialog({
                        header = 'Changer le salaire',
                        content = 'Etes-vous sûr de vouloir modifier le salaire de ' .. job.grades[i].label .. ' to ' .. amount .. ' $ ?',
                        centered = true,
                        cancel = true
                    })
                    if isPaycheck == 'Annuler' then
                        ESX.ShowNotification('Vous avez cancel la transaction', 'error')
                        return
                    else
                        TriggerServerEvent('esx_society:setJobSalary', society, job.grades[i].grade, amount)
                        lib.showContext('paycheck_menu')
                    end
            end
			}
		end

        lib.registerContext({
            id = 'paycheck_menu',
            title = 'Changement de salaire',
            options = options,
            menu = 'boss_menu'
        })
        lib.showContext('paycheck_menu')
    end, society)
end

function GestionGradeLabel(society)
    local options = {}
	ESX.TriggerServerCallback('esx_society:getJob', function(job)
		if not job then
			return
		end

        for i=1, #job.grades, 1 do
			local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)

            options[#options + 1] = {
                icon = "fas fa-wallet",
                title = ('%s'):format(gradeLabel),
                value = job.grades[i].grade,
                description = ('Grade: %s'):format(job.grades[i].grade),
                onSelect = function()
                    local input = lib.inputDialog('Gestion des grades', {
                        { type = 'input', label = 'Grades', description = 'Quelle est le nom du grade ?', required = true },
                    })

                    if not input then return end

                    local gradeName = input[1]

                    local isChangeGrade = lib.alertDialog({
                        header = 'Changer le nom des grades',
                        content = 'Etes-vous sûr de vouloir modifier le nom du grade pour ' .. job.grades[i].label .. ' to ' .. gradeName .. ' ?',
                        centered = true,
                        cancel = true
                    })
                    if isChangeGrade == 'cancel' then
                        ESX.ShowNotification('Vous avez cancel la transaction', 'error')
                        return
                    else
                        TriggerServerEvent('esx_society:setJobLabel', society, job.grades[i].grade, gradeName)
                        lib.showContext('grade_label_menu')
                    end
                end
            }
		end

        lib.registerContext({
            id = 'grade_label_menu',
            title = 'Changement de nom',
            options = options,
            menu = 'boss_menu'
        })
        lib.showContext('grade_label_menu')
    end, society)
end

function OpenPromoteMenu(society, employee)
    local options = {}
    ESX.TriggerServerCallback('esx_society:getJob', function(job)
        if not job then
            return
        end

        for i = 1, #job.grades, 1 do
            local gradeLabel = (job.grades[i].label == '' and job.label or job.grades[i].label)

            options[#options + 1] = {
                icon = "fas fa-user",
                title = gradeLabel,
                description = ('Grade: %s'):format(job.grades[i].grade),
                value = job.grades[i].grade,
                onSelect = function()
                    ESX.TriggerServerCallback('esx_society:setJob', function()
                    end, employee.identifier, society, job.grades[i].grade, 'promote')
                end
            }
        end
        lib.registerContext({
            id = 'promote_menu',
            title = 'promotemenu_2',
            options = options,
            menu = 'boss_menu'
        })
        lib.showContext('promote_menu')
    end, society, employee)
end

function OpenRecruitMenu(society)
    local options = {}
    ESX.TriggerServerCallback('esx_society:getOnlinePlayers', function(players)

        for i = 1, #players, 1 do
            if players[i].job.name ~= society then
                options[#options + 1] = {
                    title = players[i].name,
                    value = players[i].source,
                    name = players[i].name,
                    identifier = players[i].identifier,
                    onSelect = function()
                        ESX.TriggerServerCallback('esx_society:setJob', function()
                        end, players[i].identifier, society, 0, 'hire')
                    end
                }
            end
        end

        lib.registerContext({
            id = 'recruit_menu',
            title = 'recruitmenu_2',
            options = options,
            menu = 'boss_menu'
        })
        lib.showContext('recruit_menu')
    end)
end

AddEventHandler('esx_society:openBossMenu', function(society)
	OpenBossMenu(society)
end)