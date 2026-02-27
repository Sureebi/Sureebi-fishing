-- Blip Management
local createdBlips = {}
local createdRadiusBlips = {}

-- Create blips for fishing zones
local function CreateFishingBlips()
    if not Config.Blips.Enabled then
        return
    end
    
    for _, blipData in ipairs(Config.Blips.Locations) do
        local blip = AddBlipForCoord(blipData.coords.x, blipData.coords.y, blipData.coords.z)
        
        SetBlipSprite(blip, blipData.sprite)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, blipData.scale)
        SetBlipColour(blip, blipData.color)
        SetBlipAsShortRange(blip, true)
        
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(blipData.name)
        EndTextCommandSetBlipName(blip)
        
        table.insert(createdBlips, blip)
    end
    
    -- print("^2[Fishing] Created " .. #createdBlips .. " fishing zone blips^7")
end

-- Create radius blips showing zone boundaries
local function CreateRadiusBlips()
    if not Config.Blips.Enabled then
        return
    end
    
    -- Get all zones from config
    local zones = Config.Zones
    
    for zoneName, zoneData in pairs(zones) do
        if zoneData.type == "radius" then
            -- Create radius blip for each radius zone
            local radiusBlip = AddBlipForRadius(zoneData.center.x, zoneData.center.y, zoneData.center.z, zoneData.radius)
            
            -- Set color based on water type
            local color = 1  -- Red default
            if zoneData.waterType == "Ocean" then
                color = 3  -- Blue
            elseif zoneData.waterType == "River" then
                color = 2  -- Green
            elseif zoneData.waterType == "Canal" then
                color = 5  -- Yellow
            elseif zoneData.waterType == "Alamo_Sea" then
                color = 4  -- Cyan
            elseif zoneData.waterType == "Alamo_River_North" then
                color = 52  -- Teal/turquoise
            elseif zoneData.waterType == "Mirror_Park" then
                color = 27  -- Purple
            elseif zoneData.waterType == "Power_Plant" then
                color = 46  -- Orange
            elseif zoneData.waterType == "Richman_Lake" then
                color = 7  -- Light gray/white
            elseif zoneData.waterType == "Paleto_Lake_Small" then
                color = 38  -- Light blue
            elseif zoneData.waterType == "Paleto_Lake_Large" then
                color = 38  -- Light blue
            end
            
            SetBlipColour(radiusBlip, color)
            SetBlipAlpha(radiusBlip, 128)  -- Semi-transparent
            
            table.insert(createdRadiusBlips, radiusBlip)
        end
    end
    
    -- print("^2[Fishing] Created " .. #createdRadiusBlips .. " radius zone blips^7")
end

-- Remove all blips
local function RemoveFishingBlips()
    for _, blip in ipairs(createdBlips) do
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
    
    for _, blip in ipairs(createdRadiusBlips) do
        if DoesBlipExist(blip) then
            RemoveBlip(blip)
        end
    end
    
    createdBlips = {}
    createdRadiusBlips = {}
    -- print("^3[Fishing] Removed all fishing zone blips^7")
end

-- Create blips on resource start
CreateThread(function()
    Wait(1000)  -- Wait for resource to fully load
    CreateFishingBlips()
    CreateRadiusBlips()
end)

-- Remove blips on resource stop
AddEventHandler('onResourceStop', function(resourceName)
    if GetCurrentResourceName() ~= resourceName then
        return
    end
    
    RemoveFishingBlips()
end)

-- Command to toggle blips
RegisterCommand('fishblips', function()
    if #createdBlips > 0 or #createdRadiusBlips > 0 then
        RemoveFishingBlips()
        UIHandler.Info(_('blips_hidden'))
    else
        CreateFishingBlips()
        CreateRadiusBlips()
        UIHandler.Success(_('blips_shown'))
    end
end, false)
