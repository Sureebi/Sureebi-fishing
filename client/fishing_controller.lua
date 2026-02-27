FishingController = {}

local isFishing = false
local fishingProp = nil
local fishingTextUI = nil

-- Stop fishing animation (defined early to avoid nil errors)
local function StopFishingAnimation()
    local ped = PlayerPedId()
    
    -- Stop animation
    ClearPedTasks(ped)
    
    -- Remove prop
    RemoveFishingRodProp()
    
    -- Hide text UI
    if fishingTextUI then
        lib.hideTextUI()
        fishingTextUI = nil
    end
end

-- Function to cancel fishing
function FishingController.CancelFishing()
    if isFishing then
        isFishing = false
        StopFishingAnimation()
        UIHandler.Info(_('fishing_cancelled'))
        -- print("^3[FishingController] Fishing cancelled by player^7")
    end
end

-- Key listener for X to cancel fishing with ox_lib text UI
CreateThread(function()
    while true do
        Wait(0)
        
        if isFishing then
            -- Show ox_lib text UI on left side
            if not fishingTextUI then
                lib.showTextUI('[X] - Прекрати риболова', {
                    position = "left-center",
                    icon = 'fish',
                    iconColor = '#3b82f6'
                })
                fishingTextUI = true
            end
            
            -- Check for X key press
            if IsControlJustPressed(0, 73) then -- X key (VEH_DUCK)
                FishingController.CancelFishing()
            end
        else
            Wait(500) -- Sleep longer when not fishing
        end
    end
end)

-- Load animation dictionary
function LoadAnimDict(dict)
    if not HasAnimDictLoaded(dict) then
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Wait(10)
        end
    end
end

-- Create fishing rod prop
function CreateFishingRodProp()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    
    -- Fishing rod prop model (using a pole-like object)
    local propModel = "prop_fishing_rod_01"
    
    RequestModel(propModel)
    while not HasModelLoaded(propModel) do
        Wait(10)
    end
    
    -- Create prop and attach to player
    fishingProp = CreateObject(propModel, coords.x, coords.y, coords.z, true, true, false)
    AttachEntityToEntity(fishingProp, ped, GetPedBoneIndex(ped, 18905), 0.1, 0.05, 0.0, 80.0, 120.0, 160.0, true, true, false, true, 1, true)
    
    SetModelAsNoLongerNeeded(propModel)
    
    return fishingProp
end

-- Remove fishing rod prop
function RemoveFishingRodProp()
    if fishingProp and DoesEntityExist(fishingProp) then
        DeleteEntity(fishingProp)
        fishingProp = nil
    end
end

-- Play fishing animation
function PlayFishingAnimation()
    local ped = PlayerPedId()
    
    -- Load animation
    LoadAnimDict("amb@world_human_stand_fishing@idle_a")
    
    -- Play animation
    TaskPlayAnim(ped, "amb@world_human_stand_fishing@idle_a", "idle_c", 8.0, 8.0, -1, 1, 0, false, false, false)
    
    -- Create fishing rod prop
    CreateFishingRodProp()
end

-- Main fishing flow
function FishingController.StartFishing()
    if isFishing then
        UIHandler.Info(_('already_fishing'))
        return
    end
    
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    
    -- Step 1: Determine water type from closest zone within 50m proximity radius
    local waterType = ProximityDetector.GetWaterType(coords)
    
    -- Step 2: Check water based on zone type
    local hasWater = false
    
    if waterType == Config.WaterType.RIVER or 
       waterType == Config.WaterType.ALAMO_RIVER_NORTH or 
       waterType == Config.WaterType.RICHMAN_LAKE or
       waterType == Config.WaterType.ALAMO_SEA or
       waterType == Config.WaterType.MIRROR_PARK or
       waterType == Config.WaterType.POWER_PLANT or
       waterType == Config.WaterType.PALETO_LAKE_SMALL or
       waterType == Config.WaterType.PALETO_LAKE_LARGE or
       waterType == Config.WaterType.CANAL then
        -- For rivers, lakes, Alamo Sea, Mirror Park, Power Plant, Paleto Lakes, Canals - just check if in zone (no water distance check)
        hasWater = true
    elseif waterType == Config.WaterType.OCEAN then
        -- For ocean, check distance to water (including above - for piers/docks)
        -- GetDistanceToWater checks from -10 to +10 meters vertically
        local distanceToWater = WaterDetector.GetDistanceToWater(coords)
        hasWater = distanceToWater and distanceToWater <= 15.0  -- Increased to 15m to allow fishing from piers
    else
        -- For other zones (Default), check distance to water (must be within 10 meters)
        local distanceToWater = WaterDetector.GetDistanceToWater(coords)
        hasWater = distanceToWater and distanceToWater <= 10.0
    end
    
    if not hasWater then
        UIHandler.NoWater()
        return
    end
    
    -- Step 3: Start fishing animation
    isFishing = true
    PlayFishingAnimation()
    UIHandler.Info(_('waiting_for_bite'))
    
    -- Wait a bit for animation to start
    Wait(1000)
    
    -- Step 4: Request rarity from server (determines wait time)
    TriggerServerEvent('fishing:startFishing', waterType)
end

-- Handle wait time and minigame from server
RegisterNetEvent('fishing:startMinigame', function(rarity, waitTime)
    if not isFishing then return end
    
    -- print("^3[FishingController] Waiting " .. (waitTime/1000) .. " seconds for rarity: " .. tostring(rarity) .. "^7")
    
    -- Wait for fish to bite
    Wait(waitTime)
    
    if not isFishing then return end
    
    -- Start minigame
    local minigameSuccess = MinigameHandler.StartFishing(rarity)
    
    -- Stop animation
    StopFishingAnimation()
    isFishing = false
    
    if not minigameSuccess then
        UIHandler.MinigameFailed()
        return
    end
    
    -- Minigame success - request catch from server (server will check bait here)
    TriggerServerEvent('fishing:attemptCatch')
end)

-- Handle "nothing bites" scenario (wrong bait or no bait)
RegisterNetEvent('fishing:nothingBites', function(message)
    if not isFishing then return end
    
    StopFishingAnimation()
    isFishing = false
    UIHandler.Info(message or "Нищо не клъвна...")
end)

-- Handle successful catch response from server
function FishingController.OnCatchSuccess(itemName, rarity)
    UIHandler.CatchSuccess(itemName, rarity)
end

-- Handle failed catch response from server
function FishingController.OnCatchFailed(reason)
    if reason == "inventory_full" then
        UIHandler.InventoryFull()
    else
        UIHandler.Error(reason or "Failed to catch fish")
    end
end

-- Register client event for catch result
RegisterNetEvent('fishing:catchResult', function(success, itemName, rarity, reason)
    if success then
        FishingController.OnCatchSuccess(itemName, rarity)
    else
        FishingController.OnCatchFailed(reason)
    end
end)

-- Register event for fishing rod usage (called from ox_inventory)
RegisterNetEvent('Sureebi_fishing:client:Fish', function()
    FishingController.StartFishing()
end)
