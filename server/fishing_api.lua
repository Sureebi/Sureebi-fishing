-- Fishing API Endpoints for UI
-- Provides data for leaderboards, statistics, and player info

-- Get player's personal statistics
lib.callback.register('fishing:getPlayerStats', function(source)
    local identifier = GetPlayerIdentifierByType(source, 'license')
    if not identifier then return nil end
    
    local result = MySQL.query.await([[
        SELECT * FROM fishing_stats WHERE identifier = ?
    ]], {identifier})
    
    if result and result[1] then
        return result[1]
    end
    return nil
end)

-- Get player's category statistics
lib.callback.register('fishing:getCategoryStats', function(source)
    local identifier = GetPlayerIdentifierByType(source, 'license')
    if not identifier then return {} end
    
    local result = MySQL.query.await([[
        SELECT category, fish_caught as total_catches, total_weight, biggest_weight as biggest_fish_weight
        FROM fishing_category_stats 
        WHERE identifier = ?
    ]], {identifier})
    
    return result or {}
end)

-- Get player's recent catches (last 10)
lib.callback.register('fishing:getRecentCatches', function(source)
    local identifier = GetPlayerIdentifierByType(source, 'license')
    if not identifier then return {} end
    
    local result = MySQL.query.await([[
        SELECT * FROM fishing_catches 
        WHERE identifier = ? 
        ORDER BY caught_at DESC 
        LIMIT 10
    ]], {identifier})
    
    return result or {}
end)

-- Get global leaderboard (top 10 by total catches)
lib.callback.register('fishing:getLeaderboardTotal', function(source)
    local result = MySQL.query.await([[
        SELECT identifier, player_name, total_fish_caught as total_catches, total_weight, biggest_fish_weight
        FROM fishing_stats 
        ORDER BY total_fish_caught DESC 
        LIMIT 10
    ]])
    
    return result or {}
end)

-- Get global leaderboard (top 10 by biggest fish)
lib.callback.register('fishing:getLeaderboardBiggest', function(source)
    local result = MySQL.query.await([[
        SELECT identifier, player_name, biggest_fish_type as biggest_fish_name, biggest_fish_weight, biggest_fish_length
        FROM fishing_stats 
        WHERE biggest_fish_weight > 0
        ORDER BY biggest_fish_weight DESC 
        LIMIT 10
    ]])
    
    return result or {}
end)

-- Get world records
lib.callback.register('fishing:getWorldRecords', function(source)
    local result = MySQL.query.await([[
        SELECT fish_type as fish_name, record_value as weight, holder_name as player_name, record_value as length, location
        FROM fishing_records 
        WHERE record_type = 'weight'
        ORDER BY record_value DESC
    ]])
    
    return result or {}
end)

-- Get category leaderboard
lib.callback.register('fishing:getCategoryLeaderboard', function(source, category)
    if not category then return {} end
    
    local result = MySQL.query.await([[
        SELECT identifier, player_name, total_catches, total_weight, biggest_fish_weight
        FROM fishing_category_stats 
        WHERE category = ?
        ORDER BY total_catches DESC 
        LIMIT 10
    ]], {category})
    
    return result or {}
end)

-- Get player's fish collection (unique fish caught)
lib.callback.register('fishing:getFishCollection', function(source)
    local identifier = GetPlayerIdentifierByType(source, 'license')
    if not identifier then return {} end
    
    local result = MySQL.query.await([[
        SELECT 
            fish_type as fish_name,
            MAX(fish_weight) as max_weight,
            MAX(fish_length) as max_length,
            COUNT(*) as times_caught,
            MAX(caught_at) as last_caught
        FROM fishing_catches 
        WHERE identifier = ?
        GROUP BY fish_type
        ORDER BY max_weight DESC
    ]], {identifier})
    
    return result or {}
end)

-- Helper function to get player identifier
function GetPlayerIdentifierByType(source, idType)
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
