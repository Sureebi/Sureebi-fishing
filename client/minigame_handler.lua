MinigameHandler = {}

local minigameResult = nil
local minigameActive = false

-- NUI Callback for minigame result
RegisterNUICallback('minigameResult', function(data, cb)
    -- print("^2[MinigameHandler] Received result: " .. tostring(data.success) .. "^7")
    minigameResult = data.success
    minigameActive = false
    cb('ok')
end)

-- Start fishing minigame based on rarity (using NUI)
function MinigameHandler.StartFishing(rarity)
    if not rarity then
        rarity = "Common"
    end
    
    -- print("^3[MinigameHandler] Starting NUI minigame with rarity: " .. rarity .. "^7")
    
    minigameResult = nil
    minigameActive = true
    
    -- Open NUI
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "startMinigame",
        rarity = rarity
    })
    
    -- print("^3[MinigameHandler] NUI opened, waiting for result...^7")
    
    -- Wait for result
    local timeout = 0
    while minigameActive and timeout < 600 do  -- Increased timeout for multiple rounds
        Wait(100)
        timeout = timeout + 1
    end
    
    -- Close NUI
    SetNuiFocus(false, false)
    SendNUIMessage({
        action = "closeMinigame"
    })
    
    -- print("^3[MinigameHandler] Minigame finished. Result: " .. tostring(minigameResult) .. "^7")
    
    return minigameResult == true
end
