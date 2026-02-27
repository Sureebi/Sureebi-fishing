-- Fishing Shop Peds with ox_target

local shopPeds = {}

-- Shop Ped Model
local PED_MODEL = 'a_m_m_hillbilly_01'  -- Hillbilly for fishing shop

-- Shop Ped Locations (same shop, two locations)
local SHOP_LOCATIONS = {
    {
        name = 'FishingShop',
        coords = vector4(-1819.82, -1220.5, 13.02, 37.24),  -- Поправена Z координата
        model = PED_MODEL,
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        blip = {
            enabled = true,
            sprite = 68,
            color = 3,
            scale = 0.8,
            label = 'Риболовен магазин'
        }
    },
    {
        name = 'FishingShop',
        coords = vector4(1297.19, 4340.98, 39.07, 167.28),
        model = PED_MODEL,
        scenario = 'WORLD_HUMAN_STAND_MOBILE',
        blip = {
            enabled = true,
            sprite = 68,
            color = 3,
            scale = 0.8,
            label = 'Риболовен магазин'
        }
    }
}

-- Spawn shop ped
local function SpawnShopPed(shopData)
    -- Request model
    RequestModel(shopData.model)
    while not HasModelLoaded(shopData.model) do
        Wait(100)
    end
    
    -- Create ped
    local ped = CreatePed(4, shopData.model, shopData.coords.x, shopData.coords.y, shopData.coords.z - 1.0, shopData.coords.w, false, true)
    
    -- Set ped properties
    SetEntityAsMissionEntity(ped, true, true)
    SetPedFleeAttributes(ped, 0, false)
    SetPedDiesWhenInjured(ped, false)
    SetPedKeepTask(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    
    -- Set scenario
    if shopData.scenario then
        TaskStartScenarioInPlace(ped, shopData.scenario, 0, true)
    end
    
    -- Add ox_target
    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'fishing_shop_' .. shopData.name,
            icon = 'fas fa-fish',
            label = 'Отвори магазин',
            onSelect = function()
                exports.ox_inventory:openInventory('shop', { type = shopData.name, id = 1 })
            end,
            distance = 2.5
        }
    })
    
    -- Create blip if enabled
    if shopData.blip and shopData.blip.enabled then
        local blip = AddBlipForCoord(shopData.coords.x, shopData.coords.y, shopData.coords.z)
        SetBlipSprite(blip, shopData.blip.sprite)
        SetBlipColour(blip, shopData.blip.color)
        SetBlipScale(blip, shopData.blip.scale)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(shopData.blip.label)
        EndTextCommandSetBlipName(blip)
        
        shopData.blipHandle = blip
    end
    
    -- Store ped handle
    shopData.pedHandle = ped
    
    -- print("^2[ShopPeds] Spawned " .. shopData.name .. " at " .. shopData.coords.x .. ", " .. shopData.coords.y .. ", " .. shopData.coords.z .. "^7")
    
    return ped
end

-- Spawn all shop peds
CreateThread(function()
    Wait(1000)  -- Wait for resources to load
    
    -- print("^3[ShopPeds] Spawning fishing shop peds...^7")
    
    for _, shopData in ipairs(SHOP_LOCATIONS) do
        local ped = SpawnShopPed(shopData)
        table.insert(shopPeds, shopData)
    end
    
    -- print("^2[ShopPeds] Spawned " .. #shopPeds .. " fishing shop peds^7")
end)

-- Cleanup on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then return end
    
    -- print("^3[ShopPeds] Cleaning up shop peds...^7")
    
    for _, shopData in ipairs(shopPeds) do
        if shopData.pedHandle and DoesEntityExist(shopData.pedHandle) then
            DeleteEntity(shopData.pedHandle)
        end
        
        if shopData.blipHandle and DoesBlipExist(shopData.blipHandle) then
            RemoveBlip(shopData.blipHandle)
        end
    end
    
    -- print("^2[ShopPeds] Cleanup complete^7")
end)
