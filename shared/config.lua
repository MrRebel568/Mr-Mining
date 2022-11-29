Config = Config or {}

Config = {
    RockSpawn = vector3(2947.22, 2789.96, 40.54),
    PedLocation = vector4(2965.99, 2754.16, 42.22, 264.26),
    SellerPedLocation = vector4(-618.18, -227.85, 37.06, 126.42),
    WashStone = vector3(1093.53, 4211.85, 30.94),
    SellerLocation = vector3(-618.18, -227.86, 38.06),
    MeltLocation = vector3(1111.55, -2009.33, 30.89),
    SpwanPed = "ig_lamardavis",
    SpawnObject = 'prop_rock_1_i',
    TargetObject = "prop_rock_1_i"
}

Config.UseBlips = true

Config.targetitem = "mining_drill"
Config.washitem = "mining_stone"
Config.DrillPrice = 150
Config.InventoryItemBox = "inventory:client:ItemBox"
Config.InventoryOpenInventory = "inventory:server:OpenInventory"
Config.InventoryCurrentStash = "inventory:client:SetCurrentStash"

Config.QBlock = 'qb-lock'
Config.QBTarget = 'qb-target'
Config.QBMenu = "qb-menu"

Mining = {
    StoneMin = 4,
    StoneMax = 8
}

Config.Rebel = {
    CopperMin = 2,
    CopperMax = 4,

    IronMin = 2,
    IronMax = 3,

    GoldMin = 1,
    GoldMax = 3,

    -- Smelting Min and Max
    meltIronMin = 5,
    meltIronMax = 8,
    meltCopperMin = 2,
    meltCooperMax = 5,
    meltGoldMin = 5,
    meltGoldMax = 8,

    -- Bars Received
    IronBarsMin = 1,
    IronBarsMax = 2,
    CopperBarsMin = 1,
    CopperBarsMax = 2,
    GoldBarsMin = 1,
    GoldBarsMax = 2,
}

Config.Sell = {
    ["mining_ironfragment"] = {
        ["price"] = math.random(35, 45)
    },
    ["mining_goldnugget"] = {
        ["price"] = math.random(75, 80)
    },
    ["mining_copperfragment"] = {
        ["price"] = math.random(25, 35)
    },
}

Config.MiningShop = {
    label = "Minging Shop",
    slots = 10,
    items = {
        [1] = {
            name = "water_bottle",
            price = 10,
            amount = 20,
            info = {},
            type = "item",
            slot = 1,
        },
        [2] = {
            name = "sandwich",
            price = 10,
            amount = 20,
            info = {},
            type = "item",
            slot = 2,
        },
        [4] = {
            name = "mining_storage",
            price = 10,
            amount = 20,
            info = {},
            type = "item",
            slot = 3,
        },
    }
}

Config.Alerts = {
    ['cancel'] = 'Cancelled',
    ['back'] = '<- Go Back!',
    ['error_drill'] = 'You need a Drill!',
    ['drill_progressbar'] = 'Drill For Stone.',
    ['blip_name'] = 'Mining Sport',
    ['depo_label'] = 'Talk to boss',
    ['drill_stone'] = "Drill Stone",
    ['drill_icon'] = "fas fa-seedling",

    ['check_drill'] = 'You already have a drill',
    ['min_washpro'] = 'WASHING STONE',

    ['wash_stone'] = "Wash Stone",
    ['wash_icon'] = "fas fa-circle",

    ['sell_lab'] = 'Sell',
    ['sell_icon'] = "fas fa-circle",
    ['error_ironCheck'] = 'You don\'t have any Iron fragments to melt',
    ['error_goldCheck'] = 'You don\'t have any gold Nuggets to melt',
    ['error_copperCheck'] = 'You don\'t have any Copper fragments to melt',
    ['ironSmelted'] = 'You have melted ',
    ['ironSmeltedEnd'] = ' Iron Bars',
    ['ironSmeltedMiddle'] = ' Amount of Iron Fragments for ',
    ['melt_iron'] = 'melting Iron Fragments',
    ['melt_Gold'] = 'melt Gold Nuggets',
    ['melt_copper'] = 'Melting Copper Fragments',

    ['melt_rocks'] = 'Melt Rocks',
    ['melt_rocksicon'] = "Fas Fa-hands",

    ['drill_menubss'] = "Mining Boss",
    ['drill_get'] = "Mining Boss",
    ['drill_shop'] = "Open Mining Shop",

    ['seller_menubss'] = "Seller Menu",
    ['seller_ironbar'] = "Sell Iron Bar",
    ['seller_copperbar'] = "Sell Copper Bar",
    ['seller_goldbar'] = "Sell Gold Bar",

    ['melt_goldbar'] = 'Melting Gold Nuggets',
    ['melt_goldbartext'] = 'Melt Nuggets into golden bars',
    ['melt_copperbar'] = 'Melt Copper Fragments',
    ['melt_copperbartext'] = 'Melt Fragments into Copper Bars',
    ['melt_ironbar'] = 'Melt Iron Fragments',
    ['melt_ironbartext'] = 'Melt Fragments into Iron Bars',
    ['melt_manubss'] = 'Melt Options',
}
