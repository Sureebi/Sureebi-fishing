WaterDetector = {}

-- Cache for water detection results
local cache = {
    lastCoords = nil,
    lastResult = nil,
    lastWaterHeight = nil,
    lastUpdate = 0,
    cacheDuration = 150  -- 150ms cache
}

-- Check if player is in a mountain lake or elevated water zone
local function IsInElevatedWaterZone(playerCoords)
    -- Check if player is in Paleto lakes (high altitude)
    local paletoSmall = vector3(3096.79, 6026.53, 121.13)
    local paletoLarge = vector3(2546.91, 6149.75, 166.13)
    
    local distSmall = #(playerCoords - paletoSmall)
    local distLarge = #(playerCoords - paletoLarge)
    
    if distSmall < 250.0 or distLarge < 350.0 then
        return true
    end
    
    -- Check if player is in Mirror Park Lake (elevated)
    local mirrorPark = vector3(1087.83, -646.72, 53.06)
    if #(playerCoords - mirrorPark) < 150.0 then
        return true
    end
    
    -- Check if player is in Richman Lake (elevated)
    local richmanLakes = {
        vector3(71.61, 842.92, 206.48),
        vector3(5.89, 674.56, 202.18),
        vector3(-162.93, 754.38, 205.54),
        vector3(-259.2, 819.5, 203.57)
    }
    
    for _, lake in ipairs(richmanLakes) do
        if #(playerCoords - lake) < 400.0 then
            return true
        end
    end
    
    return false
end

-- Check if water exists at player location
function WaterDetector.IsNearWater(playerCoords)
    local currentTime = GetGameTimer()
    
    -- Check cache
    if cache.lastCoords and cache.lastResult ~= nil then
        local dx = playerCoords.x - cache.lastCoords.x
        local dy = playerCoords.y - cache.lastCoords.y
        local dz = playerCoords.z - cache.lastCoords.z
        local distance = math.sqrt(dx * dx + dy * dy + dz * dz)
        
        -- Use cache if player hasn't moved much and cache is fresh
        if distance < 2.0 and (currentTime - cache.lastUpdate) < cache.cacheDuration then
            return cache.lastResult
        end
    end
    
    -- Perform water detection
    local startTime = GetGameTimer()
    
    -- Check if in elevated water zone (mountain lakes)
    local isElevated = IsInElevatedWaterZone(playerCoords)
    
    -- Simplified water detection - check multiple points around player
    local hasWater = false
    local checkRadius = isElevated and 15.0 or 10.0
    
    -- Check at player position
    local waterAtPlayer = WaterDetector.GetWaterHeight(playerCoords)
    if waterAtPlayer and math.abs(playerCoords.z - waterAtPlayer) < checkRadius then
        hasWater = true
    end
    
    -- Check in front of player
    if not hasWater then
        local heading = GetEntityHeading(PlayerPedId())
        for dist = 5.0, checkRadius, 2.5 do
            local forwardX = playerCoords.x + math.sin(math.rad(heading)) * dist
            local forwardY = playerCoords.y + math.cos(math.rad(heading)) * dist
            
            local waterHeight = WaterDetector.GetWaterHeight({x = forwardX, y = forwardY, z = playerCoords.z})
            if waterHeight and math.abs(playerCoords.z - waterHeight) < checkRadius then
                hasWater = true
                break
            end
        end
    end
    
    -- Check around player (4 directions)
    if not hasWater then
        local directions = {0, 90, 180, 270}
        for _, angle in ipairs(directions) do
            local checkX = playerCoords.x + math.sin(math.rad(angle)) * 5.0
            local checkY = playerCoords.y + math.cos(math.rad(angle)) * 5.0
            
            local waterHeight = WaterDetector.GetWaterHeight({x = checkX, y = checkY, z = playerCoords.z})
            if waterHeight and math.abs(playerCoords.z - waterHeight) < checkRadius then
                hasWater = true
                break
            end
        end
    end
    
    -- Ensure detection completes within 100ms
    local elapsedTime = GetGameTimer() - startTime
    if elapsedTime > 100 then
        -- print("^3[WaterDetector] Warning: Detection took " .. elapsedTime .. "ms (target: <100ms)^7")
    end
    
    -- Update cache
    cache.lastCoords = {x = playerCoords.x, y = playerCoords.y, z = playerCoords.z}
    cache.lastResult = hasWater
    cache.lastUpdate = currentTime
    
    return hasWater
end

-- Get water height at coordinates
function WaterDetector.GetWaterHeight(coords)
    local waterHeight = GetWaterHeight(coords.x, coords.y, coords.z)
    
    -- GetWaterHeight returns -1 if no water found
    if waterHeight and waterHeight > -1.0 then
        cache.lastWaterHeight = waterHeight
        return waterHeight
    end
    
    return nil
end

-- Get distance to nearest water (returns distance in meters, or nil if no water found)
function WaterDetector.GetDistanceToWater(playerCoords)
    local closestDistance = nil
    
    -- Check at player position at different heights
    for zOffset = -10, 10, 2 do
        local checkZ = playerCoords.z + zOffset
        local waterAtPlayer = WaterDetector.GetWaterHeight({x = playerCoords.x, y = playerCoords.y, z = checkZ})
        if waterAtPlayer then
            -- Calculate distance including height difference
            local dist = math.abs(playerCoords.z - waterAtPlayer)
            if not closestDistance or dist < closestDistance then
                closestDistance = dist
            end
        end
    end
    
    -- Check in multiple directions around player at different heights
    local directions = {0, 45, 90, 135, 180, 225, 270, 315}
    
    for _, angle in ipairs(directions) do
        for dist = 2.5, 15.0, 2.5 do
            local checkX = playerCoords.x + math.sin(math.rad(angle)) * dist
            local checkY = playerCoords.y + math.cos(math.rad(angle)) * dist
            
            -- Check at multiple heights
            for zOffset = -10, 10, 2 do
                local checkZ = playerCoords.z + zOffset
                
                local waterHeight = WaterDetector.GetWaterHeight({x = checkX, y = checkY, z = checkZ})
                if waterHeight then
                    -- Calculate 3D distance to water
                    local dx = checkX - playerCoords.x
                    local dy = checkY - playerCoords.y
                    local dz = waterHeight - playerCoords.z
                    local distance = math.sqrt(dx * dx + dy * dy + dz * dz)
                    
                    if not closestDistance or distance < closestDistance then
                        closestDistance = distance
                    end
                end
            end
        end
    end
    
    return closestDistance
end

-- Clear cache (useful for testing)
function WaterDetector.ClearCache()
    cache.lastCoords = nil
    cache.lastResult = nil
    cache.lastWaterHeight = nil
    cache.lastUpdate = 0
end
