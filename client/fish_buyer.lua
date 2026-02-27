FishBuyer = {}

local buyerPeds = {}
local uiOpen = false

-- Unified NPC Locations
local NPC_LOCATIONS = {
    {
        name = 'FishingHub_1',
        coords = vector4(-1819.82, -1220.5, 13.02, 37.24),
        model = 'a_m_m_hillbilly_01',
        blip = {
            enabled = true,
            sprite = 68,
            color = 3,
            scale = 0.8,
            label = 'Риболовна Система'
        }
    },
    {
        name = 'FishingHub_2',
        coords = vector4(1297.19, 4340.98, 39.07, 167.28),
        model = 'a_m_m_hillbilly_01',
        blip = {
            enabled = true,
            sprite = 68,
            color = 3,
            scale = 0.8,
            label = 'Риболовна Система'
        }
    }
}

-- Spawn NPC
local function SpawnNPC(npcData)
    RequestModel(npcData.model)
    while not HasModelLoaded(npcData.model) do
        Wait(100)
    end
    
    local ped = CreatePed(4, npcData.model, npcData.coords.x, npcData.coords.y, npcData.coords.z - 1.0, npcData.coords.w, false, true)
    
    SetEntityAsMissionEntity(ped, true, true)
    SetPedFleeAttributes(ped, 0, false)
    SetPedDiesWhenInjured(ped, false)
    SetPedKeepTask(ped, true)
    SetBlockingOfNonTemporaryEvents(ped, true)
    FreezeEntityPosition(ped, true)
    SetEntityInvincible(ped, true)
    
    exports.ox_target:addLocalEntity(ped, {
        {
            name = 'fishing_ui_' .. npcData.name,
            icon = 'fas fa-fish',
            label = 'Риболовна Система',
            onSelect = function()
                FishBuyer.OpenUI()
            end,
            distance = 2.5
        }
    })
    
    if npcData.blip and npcData.blip.enabled then
        local blip = AddBlipForCoord(npcData.coords.x, npcData.coords.y, npcData.coords.z)
        SetBlipSprite(blip, npcData.blip.sprite)
        SetBlipColour(blip, npcData.blip.color)
        SetBlipScale(blip, npcData.blip.scale)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName('STRING')
        AddTextComponentString(npcData.blip.label)
        EndTextCommandSetBlipName(blip)
        npcData.blipHandle = blip
    end
    
    npcData.pedHandle = ped
    -- print("^2[FishingHub] Spawned NPC at " .. npcData.coords.x .. ", " .. npcData.coords.y .. "^7")
    
    return ped
end

-- Spawn all NPCs
function FishBuyer.SpawnNPCs()
    -- print("^3[FishingHub] Spawning NPCs...^7")
    
    for _, npcData in ipairs(NPC_LOCATIONS) do
        SpawnNPC(npcData)
        table.insert(buyerPeds, npcData)
    end
    
    -- print("^2[FishingHub] Spawned " .. #buyerPeds .. " NPCs^7")
end

-- Open UI
function FishBuyer.OpenUI()
    if uiOpen then return end
    
    uiOpen = true
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = 'openUI'
    })
end

-- Close UI
function FishBuyer.CloseUI()
    if not uiOpen then return end
    
    uiOpen = false
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = 'closeUI'
    })
end

-- NUI Callbacks
RegisterNUICallback('closeUI', function(data, cb)
    FishBuyer.CloseUI()
    cb('ok')
end)

RegisterNUICallback('getPlayerStats', function(data, cb)
    local stats = lib.callback.await('fishing:getPlayerStats', false)
    cb(stats or {})
end)

RegisterNUICallback('getCategoryStats', function(data, cb)
    local stats = lib.callback.await('fishing:getCategoryStats', false)
    cb(stats or {})
end)

RegisterNUICallback('getRecentCatches', function(data, cb)
    local catches = lib.callback.await('fishing:getRecentCatches', false)
    cb(catches or {})
end)

RegisterNUICallback('getLeaderboardTotal', function(data, cb)
    local leaderboard = lib.callback.await('fishing:getLeaderboardTotal', false)
    cb(leaderboard or {})
end)

RegisterNUICallback('getLeaderboardBiggest', function(data, cb)
    local leaderboard = lib.callback.await('fishing:getLeaderboardBiggest', false)
    cb(leaderboard or {})
end)

RegisterNUICallback('getWorldRecords', function(data, cb)
    local records = lib.callback.await('fishing:getWorldRecords', false)
    cb(records or {})
end)

RegisterNUICallback('getFishCollection', function(data, cb)
    local collection = lib.callback.await('fishing:getFishCollection', false)
    cb(collection or {})
end)

RegisterNUICallback('buyItem', function(data, cb)
    local item = data.item
    local price = data.price
    local quantity = data.quantity or 1
    
    -- Trigger purchase
    TriggerServerEvent('fishing:buyItem', item, price, quantity)
    cb('ok')
end)

RegisterNUICallback('sellFish', function(data, cb)
    local category = data.category
    TriggerServerEvent('fishing:sellFish', category)
    Wait(500)
    local stats = lib.callback.await('fishing:getPlayerStats', false)
    cb(stats)
end)

-- Cleanup
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        for _, npcData in ipairs(buyerPeds) do
            if npcData.pedHandle and DoesEntityExist(npcData.pedHandle) then
                DeleteEntity(npcData.pedHandle)
            end
            if npcData.blipHandle and DoesBlipExist(npcData.blipHandle) then
                RemoveBlip(npcData.blipHandle)
            end
        end
        if uiOpen then
            FishBuyer.CloseUI()
        end
    end
end)

-- Initialize
CreateThread(function()
    Wait(1000)
    FishBuyer.SpawnNPCs()
end)
