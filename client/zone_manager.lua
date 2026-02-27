ZoneManager = {}

-- Get all defined zones from config
function ZoneManager.GetAllZones()
    return Config.Zones
end

-- Check if point is inside polygon using ray casting algorithm
function ZoneManager.IsInPolygon(point, polygon)
    local x, y = point.x, point.y
    local inside = false
    local j = #polygon
    
    for i = 1, #polygon do
        local xi, yi = polygon[i].x, polygon[i].y
        local xj, yj = polygon[j].x, polygon[j].y
        
        if ((yi > y) ~= (yj > y)) and (x < (xj - xi) * (y - yi) / (yj - yi) + xi) then
            inside = not inside
        end
        
        j = i
    end
    
    return inside
end

-- Calculate distance from point to line segment
local function DistanceToLineSegment(point, lineStart, lineEnd)
    local px, py = point.x, point.y
    local x1, y1 = lineStart.x, lineStart.y
    local x2, y2 = lineEnd.x, lineEnd.y
    
    local dx = x2 - x1
    local dy = y2 - y1
    
    if dx == 0 and dy == 0 then
        -- Line segment is a point
        local distX = px - x1
        local distY = py - y1
        return math.sqrt(distX * distX + distY * distY)
    end
    
    -- Calculate projection parameter
    local t = ((px - x1) * dx + (py - y1) * dy) / (dx * dx + dy * dy)
    t = math.max(0, math.min(1, t))
    
    -- Calculate closest point on line segment
    local closestX = x1 + t * dx
    local closestY = y1 + t * dy
    
    -- Calculate distance
    local distX = px - closestX
    local distY = py - closestY
    return math.sqrt(distX * distX + distY * distY)
end

-- Get bounding box for polygon (optimization)
local function GetBoundingBox(polygon)
    local minX, minY = math.huge, math.huge
    local maxX, maxY = -math.huge, -math.huge
    
    for _, point in ipairs(polygon) do
        minX = math.min(minX, point.x)
        minY = math.min(minY, point.y)
        maxX = math.max(maxX, point.x)
        maxY = math.max(maxY, point.y)
    end
    
    return {minX = minX, minY = minY, maxX = maxX, maxY = maxY}
end

-- Check if point is inside bounding box
local function IsInBoundingBox(point, bbox, margin)
    return point.x >= bbox.minX - margin and point.x <= bbox.maxX + margin and
           point.y >= bbox.minY - margin and point.y <= bbox.maxY + margin
end

-- Calculate distance from point to polygon zone
function ZoneManager.GetDistanceToPolygon(point, polygon)
    -- Bounding box pre-check with margin
    local bbox = GetBoundingBox(polygon)
    if not IsInBoundingBox(point, bbox, Config.ZoneProximityRadius * 2) then
        -- Point is far from polygon, return large distance
        local centerX = (bbox.minX + bbox.maxX) / 2
        local centerY = (bbox.minY + bbox.maxY) / 2
        local dx = point.x - centerX
        local dy = point.y - centerY
        return math.sqrt(dx * dx + dy * dy)
    end
    
    -- Check if point is inside polygon
    if ZoneManager.IsInPolygon(point, polygon) then
        return 0.0  -- Inside the zone
    end
    
    -- Calculate distance to nearest edge
    local minDistance = math.huge
    for i = 1, #polygon do
        local j = (i % #polygon) + 1
        local distance = DistanceToLineSegment(point, polygon[i], polygon[j])
        minDistance = math.min(minDistance, distance)
    end
    
    return minDistance
end

-- Calculate distance from point to radius zone
function ZoneManager.GetDistanceToRadius(point, center, radius)
    local dx = point.x - center.x
    local dy = point.y - center.y
    local distanceToCenter = math.sqrt(dx * dx + dy * dy)
    
    -- Distance is negative if inside, positive if outside
    local distance = distanceToCenter - radius
    
    -- Return 0 if inside, otherwise return distance to edge
    return math.max(0.0, distance)
end

-- Calculate distance from point to any zone
function ZoneManager.GetDistanceToZone(point, zoneName, zoneData)
    if zoneData.type == "polygon" then
        return ZoneManager.GetDistanceToPolygon(point, zoneData.points)
    elseif zoneData.type == "radius" then
        return ZoneManager.GetDistanceToRadius(point, zoneData.center, zoneData.radius)
    else
        -- print("^1[ZoneManager] Unknown zone type: " .. tostring(zoneData.type) .. "^7")
        return math.huge
    end
end
