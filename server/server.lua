local QBCore = exports['qb-core']:GetCoreObject()

Rebel = {
    {'mining_copperfragment', math.random(Config.Rebel.CopperMin, Config.Rebel.CopperMax)},
    {'mining_ironfragment', math.random(Config.Rebel.IronMin, Config.Rebel.IronMax)},
    {'mining_goldnugget', math.random(Config.Rebel.GoldMin, Config.Rebel.GoldMax)},
}

-- Apanhar Plantas
RegisterServerEvent('mr-mining:server:Mrstone', function() 
    local src = source
    local Player  = QBCore.Functions.GetPlayer(src)
    local quantity = math.random(Mining.StoneMin, Mining.StoneMax)
        if Player.Functions.AddItem("mining_stone", quantity) then   
        TriggerClientEvent(Config.InventoryItemBox, src, QBCore.Shared.Items["mining_stone"], 'add')
    else
        TriggerClientEvent('QBCore:Notify', src, 'Pockets Full..', 'error')
    end		
end)

RegisterNetEvent('mr-mining:server:buydrill', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local DrillRebelPrice = Config.DrillPrice
    local drill = Player.Functions.GetItemByName('mining_drill')
    if not drill then
        Player.Functions.AddItem('mining_drill', 1)
        TriggerClientEvent(Config.InventoryItemBox, source, QBCore.Shared.Items['mining_drill'], "add")
        Player.Functions.RemoveMoney("cash", DrillRebelPrice)
    elseif drill then
        TriggerClientEvent('QBCore:Notify', source, Config.Text["check_drill"], 'error')
    end
end)

RegisterNetEvent('mr-mining:Seller', function()
    local source = source
    local price = 0
    local Player = QBCore.Functions.GetPlayer(source)
    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then
        for k, v in pairs(Player.PlayerData.items) do
            if Player.PlayerData.items[k] ~= nil then
                if Config.Sell[Player.PlayerData.items[k].name] ~= nil then
                    price = price + (Config.Sell[Player.PlayerData.items[k].name].price * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Player.PlayerData.items[k].name], "remove")
                end
            end
        end
        Player.Functions.AddMoney("cash", price)
        TriggerClientEvent('QBCore:Notify', source, 'The buyer has bought the marterials')
	end
end)

QBCore.Functions.CreateUseableItem("mining_storage", function(source, item)
    local Player = QBCore.Functions.GetPlayer(source)
    TriggerClientEvent("mr-mining:stash", source, item.name)
end)

RegisterNetEvent('mr-mining:server:Washed', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local minerstone = Player.Functions.GetItemByName('mining_stone')
    local ChanceItem = Rebel[math.random(1, #Rebel)]
    if not minerstone then
        TriggerClientEvent('QBCore:Notify', source, 'You dont have the rigth items...', 'error')
    end
    local amount = minerstone.amount
    if amount >= 1 then
        amount = 1
    else
        return false
    end
    TriggerClientEvent(Config.InventoryItemBox, source, QBCore.Shared.Items['mining_stone'], "remove")
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[ChanceItem[1]], "add")
    Player.Functions.RemoveItem("mining_stone", 1)
    Player.Functions.AddItem(ChanceItem[1], ChanceItem[2])
end)

RegisterNetEvent('mr-mining:server:meltiron', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local minermelt = Player.Functions.GetItemByName('mining_ironfragment')
    if not minermelt then
        TriggerClientEvent('QBCore:Notify', source, Config.Alerts['error_ironCheck'], 'error')
    end
    local amount = minermelt.amount
    if amount >= 1 then
        amount = 1
    else
        return false
    end
    TriggerClientEvent(Config.InventoryItemBox, source, QBCore.Shared.Items['mining_ironfragment'], "remove")
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["mining_ironbar"], "add")
    Player.Functions.RemoveItem("mining_ironfragment", 1)
    Player.Functions.AddItem("mining_ironbar")
end)

RegisterNetEvent('mr-mining:server:meltGold', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local minermelt = Player.Functions.GetItemByName('mining_goldnugget')
    if not minermelt then
        TriggerClientEvent('QBCore:Notify', source, Config.Alerts['error_goldCheck'], 'error')
    end
    local amount = minermelt.amount
    if amount >= 1 then
        amount = 1
    else
        return false
    end
    TriggerClientEvent(Config.InventoryItemBox, source, QBCore.Shared.Items['mining_goldnugget'], "remove")
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["mining_goldbar"], "add")
    Player.Functions.RemoveItem("mining_goldnugget", 1)
    Player.Functions.AddItem("mining_goldbar")
end)

RegisterNetEvent('mr-mining:server:meltCopper', function()
    local source = source
    local Player = QBCore.Functions.GetPlayer(tonumber(source))
    local minermelt = Player.Functions.GetItemByName('mining_copperfragment')
    if not minermelt then
        TriggerClientEvent('QBCore:Notify', source, Config.Alerts['error_copperCheck'], 'error')
    end
    local amount = minermelt.amount
    if amount >= 1 then
        amount = 1
    else
        return false
    end
    TriggerClientEvent(Config.InventoryItemBox, source, QBCore.Shared.Items['mining_copperfragment'], "remove")
    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items["mining_copperbar"], "add")
    Player.Functions.RemoveItem("mining_copperfragment", 1)
    Player.Functions.AddItem("mining_copperbar")
end)

RegisterNetEvent('mr-mining:server:mrsellmelt', function(args) 
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local args = tonumber(args)
	if args == 1 then 
		local ironbar = Player.Functions.GetItemByName("mining_ironbar")
		if ironbar ~= nil then
			local payment = math.random(100,200)
			Player.Functions.RemoveItem("mining_ironbar", 1, k)
			Player.Functions.AddMoney('bank', payment , "ironbar_sell")
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['mining_ironbar'], "remove", 1)
			TriggerClientEvent('QBCore:Notify', src, "1 "..source.." sell for $"..payment, "success")
		else
		    TriggerClientEvent('QBCore:Notify', src, "You dont have Iron Bar to sell", "error")
        end
	elseif args == 2 then
		local copperbar = Player.Functions.GetItemByName("mining_copperbar")
		if copperbar ~= nil then
			local payment = math.random(200,300)
			Player.Functions.RemoveItem("mining_copperbar", 1, k)
			Player.Functions.AddMoney('bank', payment , "copperbar_sell")
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['mining_copperbar'], "remove", 1)
			TriggerClientEvent('QBCore:Notify', src, "1 "..source.."  sell for $"..payment, "success")
		else
		    TriggerClientEvent('QBCore:Notify', src, "You dont have Copper Bar to sell", "error")
        end
	elseif args == 3 then
		local goldbar = Player.Functions.GetItemByName("mining_goldbar")
		if goldbar ~= nil then
			local payment = math.random(300,400)
			Player.Functions.RemoveItem("mining_goldbar", 1, k)
			Player.Functions.AddMoney('bank', payment , "goldbar_sell")
			TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items['mining_goldbar'], "remove", 1)
			TriggerClientEvent('QBCore:Notify', src, "1 "..source.."  sell for $"..payment, "success")
		else
		    TriggerClientEvent('QBCore:Notify', src, "You dont have Gold Bar to sell", "error")
        end
    end
end)