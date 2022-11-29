local QBCore = exports['qb-core']:GetCoreObject()
local spawnedPlants = 0
local rockSpawn = {}

if Config.UseBlips then

		MRblip = AddBlipForCoord(2951.18, 2788.59, 41.4)
        SetBlipSprite (MRblip, 78)
        SetBlipDisplay(MRblip, 6)
        SetBlipScale  (MRblip, 0.85)
        SetBlipAsShortRange(MRblip, true)
        SetBlipColour(MRblip, 21)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('Mining Sport')
        EndTextCommandSetBlipName(MRblip)

		MRblip = AddBlipForCoord(1086.7, 4205.58, 30.67)
        SetBlipSprite (MRblip, 760)
        SetBlipDisplay(MRblip, 6)
        SetBlipScale  (MRblip, 0.85)
        SetBlipAsShortRange(MRblip, true)
        SetBlipColour(MRblip, 21)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('Mining Washing Location')
        EndTextCommandSetBlipName(MRblip)

		MRblip = AddBlipForCoord(1107.64, -2009.61, 30.88)
        SetBlipSprite (MRblip, 472)
        SetBlipDisplay(MRblip, 6)
        SetBlipScale  (MRblip, 0.85)
        SetBlipAsShortRange(MRblip, true)
        SetBlipColour(MRblip, 21)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('Melt Factory')
        EndTextCommandSetBlipName(MRblip)

		MRblip = AddBlipForCoord(-620.2, -229.5, 38.06)
        SetBlipSprite (MRblip, 443)
        SetBlipDisplay(MRblip, 6)
        SetBlipScale  (MRblip, 0.85)
        SetBlipAsShortRange(MRblip, true)
        SetBlipColour(MRblip, 21)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentSubstringPlayerName('Mining Seller')
        EndTextCommandSetBlipName(MRblip)
end

CreateThread(function()
    RequestModel(Config.SpwanPed)
      while not HasModelLoaded(Config.SpwanPed) do
      Wait(1)
    end
      MrPed = CreatePed(1, Config.SpwanPed, Config.PedLocation, false, false)
      SetPedFleeAttributes(MrPed, 0, 0)
      SetPedDiesWhenInjured(MrPed, false)
      TaskStartScenarioInPlace(MrPed, "WORLD_HUMAN_CLIPBOARD", 0, true)
      SetPedKeepTask(MrPed, true)
      SetBlockingOfNonTemporaryEvents(MrPed, true)
      SetEntityInvincible(MrPed, true)
      FreezeEntityPosition(MrPed, true)

	  MrPed = CreatePed(1, Config.SpwanPed, Config.SellerPedLocation, false, false)
      SetPedFleeAttributes(MrPed, 0, 0)
      SetPedDiesWhenInjured(MrPed, false)
      TaskStartScenarioInPlace(MrPed, "WORLD_HUMAN_CLIPBOARD", 0, true)
      SetPedKeepTask(MrPed, true)
      SetBlockingOfNonTemporaryEvents(MrPed, true)
      SetEntityInvincible(MrPed, true)
      FreezeEntityPosition(MrPed, true)
end)

-- Apanhar Plantas
RegisterNetEvent('mr-mining:client:Minerstone', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)
	local nearbyObject, nearbyID
	for i=1, #rockSpawn, 1 do
		if GetDistanceBetweenCoords(coords, GetEntityCoords(rockSpawn[i]), false) < 1.2 then
			nearbyObject, nearbyID = rockSpawn[i], i
		end
	end
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(HasItem)
		if HasItem then
			isPickingUp = true
			TaskStartScenarioInPlace(playerPed, 'world_human_const_drill', 0, false)
			QBCore.Functions.Progressbar('name_here', Config.Alerts['drill_progressbar'], 4000, false, true, {
		    disableMovement = true,
		    disableCarMovement = true,
		    disableMouse = false,
		    disableCombat = true,
			}, {}, {}, {}, function()
				ClearPedTasks(playerPed)
				Wait(1000)
				DeleteObject(nearbyObject) 
				table.remove(rockSpawn, nearbyID)
				spawnedPlants = spawnedPlants - 1
				TriggerServerEvent('mr-mining:server:Mrstone')
			end)
		else
			local requiredItems = {
				[1] = {name = QBCore.Shared.Items[Config.targetitem]["name"], image = QBCore.Shared.Items[Config.targetitem]["image"]},
			}  
			QBCore.Functions.Notify(Config.Alerts['error_drill'], 'error', 2500)
			TriggerEvent('inventory:client:requiredItems', requiredItems, true)
			Wait(3000)
			TriggerEvent('inventory:client:requiredItems', requiredItems, false)
		end
	end, Config.targetitem)
end)

RegisterNetEvent("mr-mining:Miningshop", function()
	TriggerServerEvent(Config.InventoryOpenInventory, "shop", "Miners", Config.MiningShop)
end)

RegisterNetEvent('mr-mining:client:buydrill', function()
    TriggerServerEvent('mr-mining:server:buydrill')
end)

RegisterNetEvent("mr-mining:stash", function()
    TriggerEvent(Config.InventoryCurrentStash, "Miner Stash")
    TriggerServerEvent(Config.InventoryOpenInventory, "stash", "Miner Stash", {
        maxweight = 30000,
        slots = 5,
    })
end)

RegisterNetEvent('mr-mining:client:mRWash', function()
	local playerPed = PlayerPedId()
	TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_BUM_WASH', 0, false)
		QBCore.Functions.Progressbar("mr_washing", Config.Alerts['min_washpro'], 2000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
	}, {}, {}, function() 
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent("mr-mining:server:Washed")
	end, function() 
		QBCore.Functions.Notify(Config.Alerts['cancel'], "error")
	end)
end)

RegisterNetEvent('mr-mining:client:meltiron', function()
	local playerPed = PlayerPedId()
	TriggerEvent('animations:client:EmoteCommandStart', {"Warmth"})
		QBCore.Functions.Progressbar("mr_melting", Config.Alerts['ironSmeltedEnd'], 2000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
	}, {}, {}, function() 
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent("mr-mining:server:meltiron")
	end, function() 
		QBCore.Functions.Notify(Config.Alerts['cancel'], "error")
	end)
end)

RegisterNetEvent('mr-mining:client:meltGold', function()
	local playerPed = PlayerPedId()
	TriggerEvent('animations:client:EmoteCommandStart', {"Warmth"})
		QBCore.Functions.Progressbar("mr_melting", Config.Alerts['melt_Gold'], 2000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
	}, {}, {}, function() 
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent("mr-mining:server:meltGold")
	end, function() 
		QBCore.Functions.Notify(Config.Alerts['cancel'], "error")
	end)
end)

RegisterNetEvent('mr-mining:client:meltCopper', function()
	local playerPed = PlayerPedId()
	TriggerEvent('animations:client:EmoteCommandStart', {"Warmth"})
		QBCore.Functions.Progressbar("mr_melting", Config.Alerts['melt_copper'], 2000, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
	}, {}, {}, function() 
		TriggerEvent('animations:client:EmoteCommandStart', {"c"})
		ClearPedTasks(PlayerPedId())
		TriggerServerEvent("mr-mining:server:meltCopper")
	end, function() 
		QBCore.Functions.Notify(Config.Alerts['cancel'], "error")
	end)
end)

-- Pegar Coordenadas
CreateThread(function()
	while true do
		Wait(10)
		local coords = GetEntityCoords(PlayerPedId())
		if GetDistanceBetweenCoords(coords, Config.RockSpawn, true) < 50 then
			SpawnrockSpawn()
			Wait(500)
		else
			Wait(500)
		end
	end
end)

-- Eliminar Plantas ao Apanhar
AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		for k, v in pairs(rockSpawn) do
			DeleteObject(v)
		end
	end
end)

-- Spawn Plantas
function SpawnObject(model, coords, cb)
	local model = (type(model) == 'number' and model or GetHashKey(model))
	RequestModel(model)
	while not HasModelLoaded(model) do
		Wait(1)
	end
    local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, true)
    SetModelAsNoLongerNeeded(model)
    PlaceObjectOnGroundProperly(obj)
    FreezeEntityPosition(obj, true)
    if cb then
        cb(obj)
    end
end

-- Gerar Coordenadas para as Plantas
function SpawnrockSpawn()
	while spawnedPlants < 10 do
		Wait(1)
		local plantCoords = GeneratePlantsCoords()
		SpawnObject(Config.SpawnObject, plantCoords, function(obj)
			table.insert(rockSpawn, obj)
			spawnedPlants = spawnedPlants + 1
		end)
	end
end 

-- Validar Coordenadas
function ValidatePlantsCoord(plantCoord)
	if spawnedPlants > 0 then
		local validate = true
		for k, v in pairs(rockSpawn) do
			if GetDistanceBetweenCoords(plantCoord, GetEntityCoords(v), true) < 5 then
				validate = false
			end
		end
		if GetDistanceBetweenCoords(plantCoord, Config.RockSpawn, false) > 50 then
			validate = false
		end
		return validate
	else
		return true
	end
end

-- Gerar Box Coords
function GeneratePlantsCoords()
	while true do
		Wait(1)
		local MrRebelX, MrCoordY
		math.randomseed(GetGameTimer())
		local modX = math.random(-15, 15)
		Wait(100)
		math.randomseed(GetGameTimer())
		local modY = math.random(-15, 15)
		MrRebelX = Config.RockSpawn.x + modX
		MrCoordY = Config.RockSpawn.y + modY
		local coordZ = GetCoordZPlants(MrRebelX, MrCoordY)
		local coord = vector3(MrRebelX, MrCoordY, coordZ)
		if ValidatePlantsCoord(coord) then
			return coord
		end
	end
end

-- Verificar Altura das Coordenadas
function GetCoordZPlants(x, y)
	local groundCheckHeights = { 35, 36.0, 37.0, 38.0, 39.0, 40.0, 41.0, 42.0, 43.0, 44.0, 45.0, 46.0, 47.0, 48.0, 49.0, 50.0, 51.0, 52.0, 53.0, 54.0, 55.0 }
	for i, height in ipairs(groundCheckHeights) do
		local foundGround, z = GetGroundZFor_3dCoord(x, y, height)
		if foundGround then
			return z
		end
	end
	return 53.85
end

CreateThread(function()
exports[Config.QBTarget]:AddTargetModel(Config.TargetObject, {
    options = {
        {
            event = "mr-mining:client:Minerstone",
            icon = Config.Alerts['drill_icon'],
            label = Config.Alerts['drill_stone'],
        },
    },
    distance = 2.0
})
exports[Config.QBTarget]:AddBoxZone("MrPed", Config.PedLocation, 1, 1, {
	name="MrPed",
	heading=0,
	debugpoly = false,
}, {
	options = {
		{
			event = "mr-mining:client:getdrill",
			icon = "fas fa-dollar-sign",
			label = Config.Alerts['depo_label'],
		},
	},
	distance = 1.5
})
exports[Config.QBTarget]:AddBoxZone("Water", Config.WashStone, 33.0, 8, {
	name = "Water",
	heading	= 321,
	debugPoly = false,
	minZ=28.34,
	maxZ=32.34
}, {
	options = {
		{
			type = "Client",
			event = "mr-mining:client:mRWash",
			icon = Config.Alerts['wash_icon'],
			label = Config.Alerts['wash_stone'],
		},
	},
	distance = 2.5
})
exports[Config.QBTarget]:AddBoxZone("miningseller", Config.SellerLocation, 0.7, 0.5, {
	name = "miningseller",
	heading	= 40,
	debugPoly = false,
	minZ=34.86,
	maxZ=38.86
}, {
	options = {
		{
			type = "Client",
			event = "mr-mining:client:sellermenu",
			icon = Config.Alerts['sell_icon'],
			label = Config.Alerts['sell_lab'],
		},
	},
	distance = 2.5
})

exports[Config.QBTarget]:AddBoxZone("name_here", Config.MeltLocation, 3.4, 3, {
	name = "name_here",
	heading	= 330,
	debugPoly = false,
	minZ=29.69,
	maxZ=33.69
}, {
	options = {
		{
			type = "Client",
			event = "mr-mining:client:meltmenu",
			icon = Config.Alerts['melt_rocksicon'],
			label = Config.Alerts['melt_rocks'],
		},
	},
	distance = 2.5
})
end)

RegisterNetEvent('mr-mining:client:getdrill', function()
    exports[Config.QBMenu]:openMenu({
        {
            header = Config.Alerts['drill_menubss'],
            isMenuHeader = true,
        },
        {
            header = Config.Alerts['drill_get'],
            params = {
                event = "mr-mining:client:buydrill",
            }
        },
		{
            header = Config.Alerts['drill_shop'],
            params = {
                event = "mr-mining:Miningshop",
            }
        },
		{
			header = Config.Alerts['back'],
		},
    })
end)

RegisterNetEvent('mr-mining:client:sellermenu', function()
    exports[Config.QBMenu]:openMenu({
        {
            header = Config.Alerts['seller_menubss'],
            isMenuHeader = true,
        },
        {
            header = Config.Alerts['seller_ironbar'],
            params = {
				isServer = true,
                event = "mr-mining:server:mrsellmelt",
				args = 1,
            }
        },
		{
            header = Config.Alerts['seller_copperbar'],
            params = {
				isServer = true,
                event = "mr-mining:server:mrsellmelt",
				args = 2,
            }
        },
		{
            header = Config.Alerts['seller_goldbar'],
            params = {
				isServer = true,
                event = "mr-mining:server:mrsellmelt",
				args = 3,
            }
        },
		{
			header = Config.Alerts['back'],
		},
    })
end)

RegisterNetEvent('mr-mining:client:meltmenu', function()
	local meltMenu = {
	  	{
		header = Config.Alerts['melt_manubss'],
		isMenuHeader = true,
	  	},
		{
		  header = Config.Alerts['melt_ironbar'],
		  txt = Config.Alerts['melt_ironbartext'],
		  params = {
			  event = 'mr-mining:client:meltiron',
			}
		},
		{
		  header = Config.Alerts['melt_copperbar'],
		  txt = Config.Alerts['melt_copperbartext'],
		  params = {
			  event = 'mr-mining:client:meltCopper',
			}
		},
		{
		  header = Config.Alerts['melt_goldbar'],
		  txt = Config.Alerts['melt_goldbartext'],
		  params = {
			  event = 'mr-mining:client:meltGold',
			}
		},
		{
			header = Config.Alerts['back'],
		},
	  }
	exports[Config.QBMenu]:openMenu(meltMenu)
end)
