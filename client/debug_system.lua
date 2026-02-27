DebugSystem = {}

local debugEnabled = Config.Debug.Enabled  -- Use config setting
local lastInfoUpdate = 0
local cachedInfo = {}

-- Toggle debug mode
function DebugSystem.Toggle()
    debugEnabled = not debugEnabled
    
    if debugEnabled then
        -- print("^2[Debug] Fishing debug mode ENABLED^7")
        UIHandler.Success(_('debug_enabled'))
    else
        -- print("^1[Debug] Fishing debug mode DISABLED^7")
        UIHandler.Info(_('debug_disabled'))
    end
end

-- Draw a line between two points
local function DrawLine3D(x1, y1, z1, x2, y2, z2, r, g, b, a)
    DrawLine(x1, y1, z1, x2, y2, z2, r, g, b, a)
end

-- Draw zone boundaries
function DebugSystem.DrawZones(closestZone)
    local zones = ZoneManager.GetAllZones()
    
    for zoneName, zoneData in pairs(zones) do
        local color = Config.Debug.Colors[zoneData.waterType] or {255, 255, 255, 150}
        
        -- Highlight closest zone
        if zoneData.waterType == closestZone then
            color = Config.Debug.Colors.Closest
        end
        
        if zoneData.type == "polygon" then
            -- Draw polygon edges
            for i = 1, #zoneData.points do
                local j = (i % #zoneData.points) + 1
                local p1 = zoneData.points[i]
                local p2 = zoneData.points[j]
                
                -- Draw line at water level (z = 0)
                DrawLine3D(p1.x, p1.y, 0.0, p2.x, p2.y, 0.0, color[1], color[2], color[3], color[4])
                
                -- Draw vertical lines at each point
                DrawLine3D(p1.x, p1.y, -5.0, p1.x, p1.y, 5.0, color[1], color[2], color[3], color[4])
            end
        elseif zoneData.type == "radius" then
            -- Draw radius zone as circle
            local segments = 36
            local center = zoneData.center
            local radius = zoneData.radius
            
            for i = 0, segments - 1 do
                local angle1 = (i / segments) * 2 * math.pi
                local angle2 = ((i + 1) / segments) * 2 * math.pi
                
                local x1 = center.x + math.cos(angle1) * radius
                local y1 = center.y + math.sin(angle1) * radius
                local x2 = center.x + math.cos(angle2) * radius
                local y2 = center.y + math.sin(angle2) * radius
                
                DrawLine3D(x1, y1, center.z, x2, y2, center.z, color[1], color[2], color[3], color[4])
            end
        end
    end
end

-- Draw proximity radius around player
function DebugSystem.DrawProximityRadius(coords, radius)
    local color = Config.Debug.Colors.ProximityRadius
    local segments = 36
    
    for i = 0, segments - 1 do
        local angle1 = (i / segments) * 2 * math.pi
        local angle2 = ((i + 1) / segments) * 2 * math.pi
        
        local x1 = coords.x + math.cos(angle1) * radius
        local y1 = coords.y + math.sin(angle1) * radius
        local x2 = coords.x + math.cos(angle2) * radius
        local y2 = coords.y + math.sin(angle2) * radius
        
        DrawLine3D(x1, y1, coords.z, x2, y2, coords.z, color[1], color[2], color[3], color[4])
    end
end

-- Display debug info as on-screen text
function DebugSystem.DisplayInfo(waterType, distances, closestZone)
    local currentTime = GetGameTimer()
    
    -- Update cached info every 100ms
    if (currentTime - lastInfoUpdate) > 100 then
        cachedInfo = {
            waterType = waterType,
            distances = distances,
            closestZone = closestZone
        }
        lastInfoUpdate = currentTime
    end
    
    -- Build info text
    local lines = {
        "~y~=== FISHING DEBUG ===~w~",
        "Water Type: ~b~" .. (cachedInfo.waterType or "Unknown") .. "~w~",
        "",
        "~y~Distances:~w~"
    }
    
    if cachedInfo.distances then
        for zone, dist in pairs(cachedInfo.distances) do
            local distStr = string.format("%.1f", dist)
            local marker = (zone == cachedInfo.closestZone) and " ~g~[CLOSEST]~w~" or ""
            table.insert(lines, string.format("- %s: %sm%s", zone, distStr, marker))
        end
    end
    
    table.insert(lines, "")
    table.insert(lines, "Proximity Radius: ~b~" .. Config.ZoneProximityRadius .. "m~w~")
    
    -- Draw text on screen
    SetTextFont(0)
    SetTextProportional(1)
    SetTextScale(0.35, 0.35)
    SetTextColour(255, 255, 255, 255)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    
    local yOffset = 0.4
    for _, line in ipairs(lines) do
        AddTextComponentString(line)
        DrawText(0.02, yOffset)
        yOffset = yOffset + 0.025
    end
end

-- Draw player position marker
local function DrawPlayerMarker(coords)
    local color = Config.Debug.Colors.PlayerMarker
    DrawMarker(28, coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 
        0.5, 0.5, 0.5, color[1], color[2], color[3], color[4], false, false, 2, false, nil, nil, false)
end

-- Main debug update loop
function DebugSystem.Update()
    if not debugEnabled then
        return
    end
    
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    
    -- Get water type and distances
    local waterType = ProximityDetector.GetWaterType(coords)
    local distances = ProximityDetector.GetDistancesToAllZonesUncached(coords)
    local closestZone, _ = ProximityDetector.GetClosestZone(coords, Config.ZoneProximityRadius)
    
    -- Draw visualizations
    if Config.Debug.ShowZones then
        DebugSystem.DrawZones(closestZone)
    end
    
    if Config.Debug.ShowProximityRadius then
        DebugSystem.DrawProximityRadius(coords, Config.ZoneProximityRadius)
    end
    
    if Config.Debug.ShowDistances then
        DebugSystem.DisplayInfo(waterType, distances, closestZone)
    end
    
    if Config.Debug.ShowPlayerMarker then
        DrawPlayerMarker(coords)
    end
end

-- Start debug loop
CreateThread(function()
    while true do
        Wait(Config.Debug.UpdateInterval)
        DebugSystem.Update()
    end
end)


-- Debug Commands

-- Toggle debug mode
RegisterCommand('fishdebug', function()
    DebugSystem.Toggle()
end, false)

-- Print current info to console
RegisterCommand('fishinfo', function()
    local ped = PlayerPedId()
    local coords = GetEntityCoords(ped)
    local waterType = ProximityDetector.GetWaterType(coords)
    local distances = ProximityDetector.GetDistancesToAllZonesUncached(coords)
    local hasWater = WaterDetector.IsNearWater(coords)
    
    -- print("^3=== FISHING INFO ===^7")
    -- print("^3Coordinates: ^7" .. string.format("%.2f, %.2f, %.2f", coords.x, coords.y, coords.z))
    -- print("^3Has Water: ^7" .. tostring(hasWater))
    -- print("^3Water Type: ^7" .. waterType)
    -- print("^3Distances:^7")
    
    for zone, dist in pairs(distances) do
        -- print(string.format("  - %s: %.1fm", zone, dist))
    end
    
    -- print("^3Proximity Radius: ^7" .. Config.ZoneProximityRadius .. "m")
    -- print("^3===================^7")
end, false)

-- Teleport to test coordinates
RegisterCommand('fishtp', function(source, args)
    local location = args[1] or "ocean"
    local testLocations = Config.Debug.TestLocations
    
    if testLocations[location] then
        local ped = PlayerPedId()
        SetEntityCoords(ped, testLocations[location].x, testLocations[location].y, testLocations[location].z)
        UIHandler.Success("Teleported to " .. location)
        -- print("^2[Debug] Teleported to " .. location .. "^7")
    else
        UIHandler.Error("Unknown location: " .. location)
        -- print("^1[Debug] Unknown location: " .. location .. "^7")
        -- print("^3Available locations: ocean, canal, river, alamo^7")
    end
end, false)
