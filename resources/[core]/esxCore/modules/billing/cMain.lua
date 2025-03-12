local isDead = false
local Billing = require 'modules.billing.cfgBilling'
local Locale_Billing = Billing.Locale_Billing

local function showBillsMenu()
	ESX.TriggerServerCallback('esx_billing:getBills', function(bills)
		if #bills <= 0 then return ESX.ShowNotification(Locale_Billing['no_invoices']) end
		local elements = {}

		for _, v in ipairs(bills) do
			elements[#elements + 1] = {
				icon = 'fas fa-scroll',
				title = v.label,
				description = Locale_Billing['invoices_item']..ESX.Math.GroupDigits(v.amount),
				billId = v.id,
				onSelect = function()
					local billId = v.id
					ESX.TriggerServerCallback('esx_billing:payBill', function(resp)

						if not resp then return end
						TriggerEvent('esx_billing:paidBill', billId)
					end, billId)
				end
			}
		end

	    lib.registerContext({
			id = 'billing',
			title = Locale_Billing['invoices'],
			options = elements,
		})

		lib.showContext('billing')
	end)
end

RegisterCommand('showbills', function()
	if not isDead then
		showBillsMenu()
	end
end, false)

RegisterKeyMapping('showbills', Locale_Billing['keymap_showbills'], 'keyboard', 'F7')

AddEventHandler('esx:onPlayerDeath', function() isDead = true end)
AddEventHandler('esx:onPlayerSpawn', function() isDead = false end)
