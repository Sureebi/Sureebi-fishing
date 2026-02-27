-- Rate limiting storage
local playerLastFishing = {}
local playerFishingSessions = {}

-- Get player identifier
local function GetPlayerIdentifierByType(source, idType)
    local identifiers = GetPlayerIdentifiers(source)
    if identifiers then
        for _, identifier in pairs(identifiers) do
            if string.find(identifier, idType) then
                return identifier
            end
        end
    end
    return nil
end

-- Validate water type
local function IsValidWaterType(waterType)
    local validTypes = {"Ocean", "River", "Canal", "Alamo_Sea", "Alamo_River_North", "Mirror_Park", "Power_Plant", "Richman_Lake", "Paleto_Lake_Small", "Paleto_Lake_Large", "Default"}
    for _, validType in ipairs(validTypes) do
        if waterType == validType then
            return true
        end
    end
    return false
end

-- Check rate limiting
local function CheckRateLimit(source)
    local currentTime = os.time()
    local lastTime = playerLastFishing[source] or 0
    
    if (currentTime - lastTime) < Config.Fishing.RateLimitSeconds then
        return false, (Config.Fishing.RateLimitSeconds - (currentTime - lastTime))
    end
    
    playerLastFishing[source] = currentTime
    return true, 0
end

-- Server event for starting fishing (determines rarity and wait time)
RegisterNetEvent('fishing:startFishing', function(waterType)
    local source = source
    
    -- print("^3[FishingServer] Start fishing from player " .. source .. " for water type: " .. tostring(waterType) .. "^7")
    
    -- Validate water type
    if not IsValidWaterType(waterType) then
        waterType = "Default"
    end
    
    -- Check if player has ANY bait
    local allBaits = {
        'bait_earthworm', 'bait_bread', 'bait_spinner',
        'bait_corn', 'bait_boilie', 'bait_silicone',
        'bait_seaworm', 'bait_shrimp', 'bait_squid',
        'bait_metal_jig', 'bait_trolling_lure'
    }
    
    local hasBait = false
    for _, baitItem in ipairs(allBaits) do
        local baitCount = exports.ox_inventory:Search(source, 'count', baitItem)
        if baitCount and baitCount > 0 then
            hasBait = true
            break
        end
    end
    
    if not hasBait then
        -- No bait at all - stop fishing immediately
        TriggerClientEvent('fishing:nothingBites', source, _('no_bait'))
        -- print("^1[FishingServer] Player " .. source .. " has no bait^7")
        return
    end
    
    -- Get preferred baits for this water type
    local baitInfo = LootTables.BaitSystem[waterType]
    if not baitInfo then
        -- print("^1[FishingServer] No bait info for water type: " .. tostring(waterType) .. "^7")
        TriggerClientEvent('fishing:nothingBites', source, "Грешка при проверка на примамка!")
        return
    end
    
    -- Check if player has correct bait
    local hasCorrectBait = false
    for _, baitItem in ipairs(baitInfo.preferred) do
        local baitCount = exports.ox_inventory:Search(source, 'count', baitItem)
        if baitCount and baitCount > 0 then
            hasCorrectBait = true
            break
        end
    end
    
    if not hasCorrectBait then
        -- Wrong bait - notify player immediately and wait 5 minutes
        -- print("^1[FishingServer] Player " .. source .. " has wrong bait, waiting 5 minutes^7")
        
        -- Send immediate notification about wrong bait
        TriggerClientEvent('ox_lib:notify', source, {
            title = _('notification_title_wrong_bait'),
            description = _('wrong_bait'),
            type = 'error',
            duration = 10000
        })
        
        TriggerClientEvent('fishing:startMinigame', source, nil, 300000)  -- 5 minutes
        
        -- After 5 minutes, send "nothing bites" message
        SetTimeout(300000, function()
            TriggerClientEvent('fishing:nothingBites', source, _('nothing_bites'))
        end)
        return
    end
    
    -- Correct bait - generate rarity and normal wait time
    local itemName, rarity = LootGenerator.GenerateCatch(waterType)
    
    if not rarity then
        rarity = "Common"
    end
    
    -- Determine wait time based on rarity (in milliseconds)
    local waitTime = math.random(30000, 45000)  --  seconds for Common
    if rarity == "Uncommon" then
        waitTime = math.random(40000, 100000)  --  seconds
    elseif rarity == "Rare" then
        waitTime = math.random(100000, 120000)  --  seconds
    elseif rarity == "Epic" then
        waitTime = math.random(120000, 140000)  --  seconds
    end
    
    -- print("^2[FishingServer] Player " .. source .. " has correct bait, rarity: " .. tostring(rarity) .. ", wait: " .. (waitTime/1000) .. "s^7")
    
    -- Store fishing session data
    if not playerFishingSessions then
        playerFishingSessions = {}
    end
    playerFishingSessions[source] = {
        waterType = waterType,
        rarity = rarity,
        itemName = itemName
    }
    
    -- Send minigame trigger to client
    TriggerClientEvent('fishing:startMinigame', source, rarity, waitTime)
end)

-- Server event for fishing attempt (after minigame success)
RegisterNetEvent('fishing:attemptCatch', function()
    local source = source
    
    -- Get fishing session data
    local session = playerFishingSessions[source]
    if not session then
        -- print("^1[FishingServer] No fishing session for player " .. source .. "^7")
        TriggerClientEvent('fishing:catchResult', source, false, nil, nil, "No active fishing session")
        return
    end
    
    local waterType = session.waterType
    local rarity = session.rarity
    local itemName = session.itemName
    
    -- Clear session
    playerFishingSessions[source] = nil
    
    -- Check rate limiting
    local allowed, remaining = CheckRateLimit(source)
    if not allowed then
        TriggerClientEvent('fishing:catchResult', source, false, nil, nil, "Please wait " .. remaining .. " seconds")
        return
    end
    
    -- Get preferred baits for this water type
    local baitInfo = LootTables.BaitSystem[waterType]
    if not baitInfo then
        -- print("^1[FishingServer] No bait info for water type: " .. tostring(waterType) .. "^7")
        TriggerClientEvent('fishing:catchResult', source, false, nil, nil, "Invalid water type")
        return
    end
    
    -- Check if player has correct bait and consume it (md-fishing approach)
    local baitConsumed = false
    for _, baitItem in ipairs(baitInfo.preferred) do
        local baitCount = exports.ox_inventory:Search(source, 'count', baitItem)
        if baitCount and baitCount > 0 then
            local removed = exports.ox_inventory:RemoveItem(source, baitItem, 1)
            if removed then
                -- print("^2[FishingServer] Consumed 1x " .. baitItem .. " from player " .. source .. "^7")
                baitConsumed = true
                break
            end
        end
    end
    
    if not baitConsumed then
        -- No correct bait found - shouldn't happen but handle it
        -- print("^1[FishingServer] Player " .. source .. " has no correct bait after minigame^7")
        TriggerClientEvent('fishing:catchResult', source, false, nil, nil, _('no_bait'))
        return
    end
    
    -- Generate fish size using FishingStats system
    local fishSize = FishingStats.GenerateFishSize(itemName)
    
    if not fishSize then
        -- print("^1[FishingServer] Failed to generate fish size for " .. itemName .. "^7")
        TriggerClientEvent('fishing:catchResult', source, false, nil, nil, "Fish size generation error")
        return
    end
    
    -- Prepare metadata for ox_inventory
    -- ВАЖНО: Не слагаме 'weight' в metadata, защото ox_inventory го използва за override на теглото в инвентара
    -- Вместо това съхраняваме реалното тегло като 'fish_weight' и го показваме в описанието
    local metadata = {
        fish_weight = fishSize.weight,  -- Реално тегло на рибата (в грамове)
        fish_length = fishSize.length,  -- Дължина на рибата (в см)
        location = waterType,
        timestamp = os.time(),
        description = string.format("Тегло: %.3f кг | Дължина: %.3f м\nМясто: %s", 
            fishSize.weight / 1000, 
            fishSize.length / 100,
            waterType)
    }
    
    -- Add item to player inventory using ox_inventory with metadata
    local addSuccess, addError = pcall(function()
        return exports.ox_inventory:AddItem(source, itemName, 1, metadata)
    end)
    
    if not addSuccess then
        -- print("^1[FishingServer] ox_inventory error for player " .. source .. ": " .. tostring(addError) .. "^7")
        TriggerClientEvent('fishing:catchResult', source, false, nil, nil, "Inventory error")
        return
    end
    
    if not addError then
        -- Inventory full or item doesn't exist
        TriggerClientEvent('fishing:catchResult', source, false, nil, nil, "inventory_full")
        return
    end
    
    -- Record catch in database (skip trash items)
    if rarity ~= "Trash" then
        -- print("^3[FishingServer] About to call FishingStats.RecordCatch^7")
        -- print("^3[FishingServer] FishingStats exists: " .. tostring(FishingStats ~= nil) .. "^7")
        -- print("^3[FishingServer] RecordCatch exists: " .. tostring(FishingStats and FishingStats.RecordCatch ~= nil) .. "^7")
        
        FishingStats.RecordCatch(source, itemName, fishSize.weight, fishSize.length, waterType, rarity)
    else
        -- print("^3[FishingServer] Skipping trash item recording: " .. itemName .. "^7")
    end
    
    -- Success - send result back to client
    TriggerClientEvent('fishing:catchResult', source, true, itemName, rarity, nil)
    
    -- Log successful catch
    -- print(string.format("^2[FishingServer] Player %d caught %s (%s) in %s - %.2fkg, %.1fcm^7", 
    --     source, itemName, rarity, waterType, fishSize.weight / 1000, fishSize.length))
end)

-- Validate all loot tables on resource start
CreateThread(function()
    Wait(1000)  -- Wait for resource to fully load
    
    -- print("^3========================================^7")
    -- print("^3  Dynamic Fishing System v1.0.0^7")
    -- print("^3========================================^7")
    
    local valid = LootTables.ValidateAll()
    
    if not valid then
        -- print("^1[FishingServer] CRITICAL: Loot table validation failed!^7")
        -- print("^1[FishingServer] Please fix loot tables before using the fishing system.^7")
    end
    
    -- print("^3========================================^7")
end)

-- Clean up rate limiting and sessions on player disconnect
AddEventHandler('playerDropped', function()
    local source = source
    if playerLastFishing[source] then
        playerLastFishing[source] = nil
    end
    if playerFishingSessions[source] then
        playerFishingSessions[source] = nil
    end
end)
