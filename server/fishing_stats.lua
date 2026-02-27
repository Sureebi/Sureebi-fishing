-- ============================================
-- FISHING STATISTICS & LEADERBOARD SYSTEM
-- ============================================

-- print("^2[FishingStats] Statistics system loaded^7")

FishingStats = {}

-- MySQL connection (adjust based on your framework)
local function ExecuteSQL(query, params)
    local result = MySQL.Sync.fetchAll(query, params or {})
    return result
end

local function ExecuteSQLInsert(query, params)
    local result = MySQL.Sync.insert(query, params or {})
    return result
end

-- Generate random fish size based on config
function FishingStats.GenerateFishSize(fishType)
    local sizeConfig = Config.FishSizes[fishType]
    
    if not sizeConfig then
        -- print("^1[FishingStats] No size config for: " .. tostring(fishType) .. "^7")
        return {weight = 1000, length = 30}
    end
    
    -- Generate random weight and length
    local weight = math.random(sizeConfig.weight.min, sizeConfig.weight.max)
    local length = math.random(sizeConfig.length.min, sizeConfig.length.max)
    
    return {
        weight = weight,  -- in grams
        length = length   -- in cm
    }
end

-- Get player identifier (works with QBOX/QBCore and ESX)
local function GetPlayerIdentifier(source)
    -- Try to get identifier from GetPlayerIdentifiers (universal method)
    local identifiers = GetPlayerIdentifiers(source)
    if identifiers then
        for _, identifier in pairs(identifiers) do
            if string.find(identifier, "license:") then
                return identifier
            end
        end
    end
    
    return nil
end

-- Get player name (works with any framework)
local function GetPlayerNameSafe(source)
    return GetPlayerName(source) or "Unknown"
end

-- Initialize player stats (create if not exists)
function FishingStats.InitializePlayer(source)
    local identifier = GetPlayerIdentifier(source)
    if not identifier then return false end
    
    local playerName = GetPlayerNameSafe(source)
    
    -- Check if player exists
    local result = ExecuteSQL('SELECT id FROM fishing_stats WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    })
    
    if not result or #result == 0 then
        -- Create new player stats
        ExecuteSQLInsert('INSERT INTO fishing_stats (identifier, player_name) VALUES (@identifier, @name)', {
            ['@identifier'] = identifier,
            ['@name'] = playerName
        })
        
        -- print("^2[FishingStats] Initialized stats for player: " .. playerName .. "^7")
    end
    
    return true
end

-- Record a fish catch
function FishingStats.RecordCatch(source, fishType, weight, length, location, rarity)
    -- print("^3[FishingStats] RecordCatch called for player " .. source .. "^7")
    
    local identifier = GetPlayerIdentifier(source)
    if not identifier then 
        -- print("^1[FishingStats] No identifier found for player " .. source .. "^7")
        return false 
    end
    
    -- print("^3[FishingStats] Identifier: " .. identifier .. "^7")
    
    local playerName = GetPlayerNameSafe(source)
    
    -- Insert catch record
    local insertId = ExecuteSQLInsert([[
        INSERT INTO fishing_catches 
        (identifier, player_name, fish_type, fish_weight, fish_length, location, rarity) 
        VALUES (@identifier, @name, @fish, @weight, @length, @location, @rarity)
    ]], {
        ['@identifier'] = identifier,
        ['@name'] = playerName,
        ['@fish'] = fishType,
        ['@weight'] = weight,
        ['@length'] = length,
        ['@location'] = location,
        ['@rarity'] = rarity
    })
    
    -- print("^2[FishingStats] Catch inserted with ID: " .. tostring(insertId) .. "^7")
    
    -- Update player stats
    FishingStats.UpdatePlayerStats(source, fishType, weight, length)
    
    -- Check for records
    FishingStats.CheckRecords(source, fishType, weight, length, location)
    
    -- print(string.format("^2[FishingStats] Recorded catch: %s caught %s (%dg, %dcm)^7", 
    --     playerName, fishType, weight, length))
    
    return true
end

-- Update player statistics
function FishingStats.UpdatePlayerStats(source, fishType, weight, length)
    local identifier = GetPlayerIdentifier(source)
    if not identifier then return end
    
    -- Get current stats
    local stats = ExecuteSQL('SELECT * FROM fishing_stats WHERE identifier = @identifier', {
        ['@identifier'] = identifier
    })
    
    if not stats or #stats == 0 then
        FishingStats.InitializePlayer(source)
        stats = ExecuteSQL('SELECT * FROM fishing_stats WHERE identifier = @identifier', {
            ['@identifier'] = identifier
        })
    end
    
    local currentStats = stats[1]
    local newTotalFish = currentStats.total_fish_caught + 1
    local newTotalWeight = (currentStats.total_weight or 0) + weight
    local updateBiggest = false
    local updateLongest = false
    
    -- Check if this is the biggest fish
    if weight > currentStats.biggest_fish_weight then
        updateBiggest = true
    end
    
    -- Check if this is the longest fish
    if length > currentStats.longest_fish_length then
        updateLongest = true
    end
    
    -- Update stats
    if updateBiggest and updateLongest then
        ExecuteSQL([[
            UPDATE fishing_stats 
            SET total_fish_caught = @total,
                total_weight = @total_weight,
                biggest_fish_weight = @weight,
                biggest_fish_type = @fish,
                biggest_fish_length = @big_length,
                longest_fish_length = @length,
                longest_fish_type = @long_fish
            WHERE identifier = @identifier
        ]], {
            ['@identifier'] = identifier,
            ['@total'] = newTotalFish,
            ['@total_weight'] = newTotalWeight,
            ['@weight'] = weight,
            ['@fish'] = fishType,
            ['@big_length'] = length,
            ['@length'] = length,
            ['@long_fish'] = fishType
        })
    elseif updateBiggest then
        ExecuteSQL([[
            UPDATE fishing_stats 
            SET total_fish_caught = @total,
                total_weight = @total_weight,
                biggest_fish_weight = @weight,
                biggest_fish_type = @fish,
                biggest_fish_length = @length
            WHERE identifier = @identifier
        ]], {
            ['@identifier'] = identifier,
            ['@total'] = newTotalFish,
            ['@total_weight'] = newTotalWeight,
            ['@weight'] = weight,
            ['@fish'] = fishType,
            ['@length'] = length
        })
    elseif updateLongest then
        ExecuteSQL([[
            UPDATE fishing_stats 
            SET total_fish_caught = @total,
                total_weight = @total_weight,
                longest_fish_length = @length,
                longest_fish_type = @fish
            WHERE identifier = @identifier
        ]], {
            ['@identifier'] = identifier,
            ['@total'] = newTotalFish,
            ['@total_weight'] = newTotalWeight,
            ['@length'] = length,
            ['@fish'] = fishType
        })
    else
        ExecuteSQL([[
            UPDATE fishing_stats 
            SET total_fish_caught = @total,
                total_weight = @total_weight
            WHERE identifier = @identifier
        ]], {
            ['@identifier'] = identifier,
            ['@total'] = newTotalFish,
            ['@total_weight'] = newTotalWeight
        })
    end
    
    -- Update category stats
    FishingStats.UpdateCategoryStats(identifier, fishType, weight)
end

-- Update category statistics
function FishingStats.UpdateCategoryStats(identifier, fishType, weight)
    -- Determine category
    local category = FishingStats.GetFishCategory(fishType)
    if not category then return end
    
    -- Check if category stats exist
    local result = ExecuteSQL([[
        SELECT * FROM fishing_category_stats 
        WHERE identifier = @identifier AND category = @category
    ]], {
        ['@identifier'] = identifier,
        ['@category'] = category
    })
    
    if not result or #result == 0 then
        -- Create new category stats
        ExecuteSQLInsert([[
            INSERT INTO fishing_category_stats 
            (identifier, category, fish_caught, total_weight, biggest_weight, biggest_type) 
            VALUES (@identifier, @category, 1, @weight, @weight, @fish)
        ]], {
            ['@identifier'] = identifier,
            ['@category'] = category,
            ['@weight'] = weight,
            ['@fish'] = fishType
        })
    else
        -- Update existing
        local current = result[1]
        local newCount = current.fish_caught + 1
        local newTotalWeight = (current.total_weight or 0) + weight
        
        if weight > (current.biggest_weight or 0) then
            ExecuteSQL([[
                UPDATE fishing_category_stats 
                SET fish_caught = @count, total_weight = @total_weight, biggest_weight = @weight, biggest_type = @fish
                WHERE identifier = @identifier AND category = @category
            ]], {
                ['@identifier'] = identifier,
                ['@category'] = category,
                ['@count'] = newCount,
                ['@total_weight'] = newTotalWeight,
                ['@weight'] = weight,
                ['@fish'] = fishType
            })
        else
            ExecuteSQL([[
                UPDATE fishing_category_stats 
                SET fish_caught = @count, total_weight = @total_weight
                WHERE identifier = @identifier AND category = @category
            ]], {
                ['@identifier'] = identifier,
                ['@category'] = category,
                ['@count'] = newCount,
                ['@total_weight'] = newTotalWeight
            })
        end
    end
end

-- Get fish category
function FishingStats.GetFishCategory(fishType)
    local categories = {
        river = {
            'fish_carp', 'fish_crucian_carp', 'fish_chub', 'fish_sichel', 'fish_barbel',
            'fish_trout', 'fish_catfish', 'fish_perch', 'fish_white_bream', 'fish_bleak',
            'fish_nase', 'fish_roach', 'fish_rudd', 'fish_grass_carp', 'fish_asp'
        },
        lake = {
            'fish_silver_carp', 'fish_bighead_carp', 'fish_tench', 'fish_channel_catfish',
            'fish_white_amur', 'fish_black_carp', 'fish_sunfish', 'fish_silver_crucian',
            'fish_mirror_carp', 'fish_common_carp', 'fish_black_bass', 'fish_eel',
            'fish_peled', 'fish_whitefish', 'fish_rainbow_trout'
        },
        sea = {
            'fish_horse_mackerel', 'fish_sea_bream', 'fish_bluefish', 'fish_sea_bass',
            'fish_gilthead', 'fish_goby', 'fish_turbot', 'fish_bonito', 'fish_mackerel',
            'fish_grey_mullet', 'fish_red_mullet', 'fish_garfish', 'fish_anchovy',
            'fish_shad', 'fish_wrasse'
        },
        ocean = {
            'fish_yellowfin_tuna', 'fish_bluefin_tuna', 'fish_swordfish', 'fish_blue_marlin',
            'fish_black_marlin', 'fish_mahi_mahi', 'fish_wahoo', 'fish_cod', 'fish_halibut',
            'fish_grouper', 'fish_barracuda', 'fish_red_snapper', 'fish_tarpon',
            'fish_flounder', 'fish_shark'
        }
    }
    
    for category, fishes in pairs(categories) do
        for _, fish in ipairs(fishes) do
            if fish == fishType then
                return category
            end
        end
    end
    
    return nil
end

-- Check and update world records
function FishingStats.CheckRecords(source, fishType, weight, length, location)
    local identifier = GetPlayerIdentifier(source)
    if not identifier then return end
    
    local playerName = GetPlayerNameSafe(source)
    
    -- Check weight record
    local weightRecord = ExecuteSQL([[
        SELECT * FROM fishing_records 
        WHERE fish_type = @fish AND record_type = 'weight'
    ]], {
        ['@fish'] = fishType
    })
    
    if not weightRecord or #weightRecord == 0 or weight > weightRecord[1].record_value then
        -- New weight record!
        if weightRecord and #weightRecord > 0 then
            -- Update existing
            ExecuteSQL([[
                UPDATE fishing_records 
                SET record_value = @value, holder_identifier = @identifier, 
                    holder_name = @name, location = @location, set_at = NOW()
                WHERE fish_type = @fish AND record_type = 'weight'
            ]], {
                ['@fish'] = fishType,
                ['@value'] = weight,
                ['@identifier'] = identifier,
                ['@name'] = playerName,
                ['@location'] = location
            })
        else
            -- Insert new
            ExecuteSQLInsert([[
                INSERT INTO fishing_records 
                (fish_type, record_type, record_value, holder_identifier, holder_name, location)
                VALUES (@fish, 'weight', @value, @identifier, @name, @location)
            ]], {
                ['@fish'] = fishType,
                ['@value'] = weight,
                ['@identifier'] = identifier,
                ['@name'] = playerName,
                ['@location'] = location
            })
        end
        
        -- Notify player
        TriggerClientEvent('ox_lib:notify', source, {
            title = '🏆 НОВ РЕКОРД!',
            description = string.format('Световен рекорд за %s по тегло: %.2fкг!', fishType, weight / 1000),
            type = 'success',
            duration = 8000
        })
        
        -- print(string.format("^3[FishingStats] NEW WEIGHT RECORD: %s - %s (%.2fkg)^7", 
        --     playerName, fishType, weight / 1000))
    end
    
    -- Check length record
    local lengthRecord = ExecuteSQL([[
        SELECT * FROM fishing_records 
        WHERE fish_type = @fish AND record_type = 'length'
    ]], {
        ['@fish'] = fishType
    })
    
    if not lengthRecord or #lengthRecord == 0 or length > lengthRecord[1].record_value then
        -- New length record!
        if lengthRecord and #lengthRecord > 0 then
            ExecuteSQL([[
                UPDATE fishing_records 
                SET record_value = @value, holder_identifier = @identifier, 
                    holder_name = @name, location = @location, set_at = NOW()
                WHERE fish_type = @fish AND record_type = 'length'
            ]], {
                ['@fish'] = fishType,
                ['@value'] = length,
                ['@identifier'] = identifier,
                ['@name'] = playerName,
                ['@location'] = location
            })
        else
            ExecuteSQLInsert([[
                INSERT INTO fishing_records 
                (fish_type, record_type, record_value, holder_identifier, holder_name, location)
                VALUES (@fish, 'length', @value, @identifier, @name, @location)
            ]], {
                ['@fish'] = fishType,
                ['@value'] = length,
                ['@identifier'] = identifier,
                ['@name'] = playerName,
                ['@location'] = location
            })
        end
        
        TriggerClientEvent('ox_lib:notify', source, {
            title = '🏆 НОВ РЕКОРД!',
            description = string.format('Световен рекорд за %s по дължина: %dсм!', fishType, length),
            type = 'success',
            duration = 8000
        })
        
        -- print(string.format("^3[FishingStats] NEW LENGTH RECORD: %s - %s (%dcm)^7", 
        --     playerName, fishType, length))
    end
end

-- Initialize player on join
AddEventHandler('playerConnecting', function()
    local source = source
    Wait(2000)  -- Wait for player to fully load
    FishingStats.InitializePlayer(source)
end)

-- print("^2[FishingStats] Statistics system loaded^7")

-- Admin command to clear all fishing data
RegisterCommand('clearfishingdata', function(source, args, rawCommand)
    -- Check if player has admin permission (adjust based on your framework)
    local hasPermission = false
    
    -- For QBOX/QBCore
    if GetResourceState('qbx_core') == 'started' or GetResourceState('qb-core') == 'started' then
        local Player = exports.qbx_core and exports.qbx_core:GetPlayer(source) or exports['qb-core']:GetPlayer(source)
        if Player and (Player.PlayerData.job.name == 'admin' or IsPlayerAceAllowed(source, 'command.clearfishingdata')) then
            hasPermission = true
        end
    else
        -- Fallback to ACE permissions
        if IsPlayerAceAllowed(source, 'command.clearfishingdata') then
            hasPermission = true
        end
    end
    
    if not hasPermission then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Грешка',
            description = 'Нямаш права за тази команда!',
            type = 'error'
        })
        return
    end
    
    -- Clear all fishing data
    MySQL.query.await('TRUNCATE TABLE fishing_stats')
    MySQL.query.await('TRUNCATE TABLE fishing_catches')
    MySQL.query.await('TRUNCATE TABLE fishing_records')
    MySQL.query.await('TRUNCATE TABLE fishing_category_stats')
    
    -- print("^2[FishingStats] All fishing data cleared by admin^7")
    
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Успех',
        description = 'Всички данни за риболов са изчистени!',
        type = 'success'
    })
end, false)

-- Admin command to reset specific player's fishing data
RegisterCommand('resetplayerfishing', function(source, args, rawCommand)
    -- Check if player has admin permission
    local hasPermission = false
    
    if GetResourceState('qbx_core') == 'started' or GetResourceState('qb-core') == 'started' then
        local Player = exports.qbx_core and exports.qbx_core:GetPlayer(source) or exports['qb-core']:GetPlayer(source)
        if Player and (Player.PlayerData.job.name == 'admin' or IsPlayerAceAllowed(source, 'command.resetplayerfishing')) then
            hasPermission = true
        end
    else
        if IsPlayerAceAllowed(source, 'command.resetplayerfishing') then
            hasPermission = true
        end
    end
    
    if not hasPermission then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Грешка',
            description = 'Нямаш права за тази команда!',
            type = 'error'
        })
        return
    end
    
    local targetId = tonumber(args[1])
    if not targetId then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Грешка',
            description = 'Използвай: /resetplayerfishing [player_id]',
            type = 'error'
        })
        return
    end
    
    local identifier = GetPlayerIdentifier(targetId)
    if not identifier then
        TriggerClientEvent('ox_lib:notify', source, {
            title = 'Грешка',
            description = 'Играчът не е намерен!',
            type = 'error'
        })
        return
    end
    
    -- Delete player's fishing data
    MySQL.query.await('DELETE FROM fishing_stats WHERE identifier = ?', {identifier})
    MySQL.query.await('DELETE FROM fishing_catches WHERE identifier = ?', {identifier})
    MySQL.query.await('DELETE FROM fishing_category_stats WHERE identifier = ?', {identifier})
    
    local playerName = GetPlayerName(targetId)
    -- print(string.format("^2[FishingStats] Fishing data reset for player %s (%s)^7", playerName, identifier))
    
    TriggerClientEvent('ox_lib:notify', source, {
        title = 'Успех',
        description = string.format('Данните за %s са изчистени!', playerName),
        type = 'success'
    })
end, false)
