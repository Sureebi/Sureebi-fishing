ProximityDetector = {}

-- Cache for proximity detection results
local cache = {
    lastCoords = nil,
    lastWaterType = nil,
    lastDistances = nil,
    lastUpdate = 0,
    cacheDuration = 150  -- 150ms cache
}

-- Calculate distances to all zones
function ProximityDetector.GetDistancesToAllZones(coords)
    local distances = {}
    local zones = ZoneManager.GetAllZones()
    
    for zoneName, zoneData in pairs(zones) do
        local distance = ZoneManager.GetDistanceToZone(coords, zoneName, zoneData)
        distances[zoneData.waterType] = distances[zoneData.waterType] or math.huge
        
        -- Keep the minimum distance for each water type
        if distance < distances[zoneData.waterType] then
            distances[zoneData.waterType] = distance
        end
    end
    
    return distances
end

-- Find closest zone within max distance with priority tiebreaker
function ProximityDetector.GetClosestZone(coords, maxDistance)
    local distances = ProximityDetector.GetDistancesToAllZones(coords)
    local closestZone = nil
    local closestDistance = math.huge
    local closestPriority = math.huge
    
    for waterType, distance in pairs(distances) do
        if distance <= maxDistance then
            local priority = Config.ZonePriority[waterType] or 999
            
            -- Select by priority first, then by distance
            if priority < closestPriority or (priority == closestPriority and distance < closestDistance) then
                closestZone = waterType
                closestDistance = distance
                closestPriority = priority
            end
        end
    end
    
    return closestZone, closestDistance
end

-- Get water type based on proximity (with caching)
function ProximityDetector.GetWaterType(coords)
    local currentTime = GetGameTimer()
    
    -- Check cache
    if cache.lastCoords and cache.lastWaterType then
        local dx = coords.x - cache.lastCoords.x
        local dy = coords.y - cache.lastCoords.y
        local dz = coords.z - cache.lastCoords.z
        local distance = math.sqrt(dx * dx + dy * dy + dz * dz)
        
        -- Use cache if player hasn't moved much and cache is fresh
        if distance < 2.0 and (currentTime - cache.lastUpdate) < cache.cacheDuration then
            return cache.lastWaterType
        end
    end
    
    -- Calculate new water type
    local closestZone, distance = ProximityDetector.GetClosestZone(coords, Config.ZoneProximityRadius)
    local waterType = closestZone or Config.WaterType.DEFAULT
    
    -- Update cache
    cache.lastCoords = {x = coords.x, y = coords.y, z = coords.z}
    cache.lastWaterType = waterType
    cache.lastUpdate = currentTime
    
    return waterType
end

-- Get distances without caching (for debug purposes)
function ProximityDetector.GetDistancesToAllZonesUncached(coords)
    return ProximityDetector.GetDistancesToAllZones(coords)
end

-- Clear cache (useful for testing)
function ProximityDetector.ClearCache()
    cache.lastCoords = nil
    cache.lastWaterType = nil
    cache.lastDistances = nil
    cache.lastUpdate = 0
end
