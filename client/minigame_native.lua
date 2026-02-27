-- Native GTA minigames using DrawRect (no NUI needed)
MinigameNative = {}

-- Draw text on screen with shadow
local function DrawText2D(text, x, y, scale, r, g, b, a, center)
    SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(2, 2, 0, 0, 0, 255)
    SetTextEdge(1, 0, 0, 0, 255)
    
    if center then
        SetTextCentre(true)
    end
    
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

-- Draw 3D text in world
local function Draw3DText(x, y, z, text, scale, r, g, b, a)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    
    if onScreen then
        SetTextFont(4)
        SetTextProportional(1)
        SetTextScale(scale, scale)
        SetTextColour(r, g, b, a)
        SetTextDropShadow(2, 2, 0, 0, 0, 255)
        SetTextEdge(1, 0, 0, 0, 255)
        SetTextCentre(true)
        SetTextEntry("STRING")
        AddTextComponentString(text)
        DrawText(_x, _y)
    end
end

-- Common Minigame: Simple Timing Bar (Small & In Perspective)
function MinigameNative.Common()
    -- print("^3[MinigameNative] Starting Common minigame^7")
    
    -- Random target position
    local targetPos = 0.25 + math.random() * 0.4
    local targetWidth = 0.18
    
    local startTime = GetGameTimer()
    local speed = 4000  -- 4s per cycle
    local completed = false
    local success = false
    
    -- New: Multiple hits required, no time limit
    local hitsRequired = 3
    local hitsSuccessful = 0
    local direction = 1  -- 1 = forward, -1 = backward
    local indicatorPos = 0.0
    
    local ped = PlayerPedId()
    
    while not completed do
        Wait(0)
        
        -- Calculate indicator position with bounce
        local elapsed = GetGameTimer() - startTime
        local progress = (elapsed % speed) / speed
        
        -- Bounce logic: go forward then backward
        if direction == 1 then
            indicatorPos = progress
            if indicatorPos >= 1.0 then
                direction = -1
                startTime = GetGameTimer()
            end
        else
            indicatorPos = 1.0 - progress
            if indicatorPos <= 0.0 then
                direction = 1
                startTime = GetGameTimer()
            end
        end
        
        -- Get player coords and camera
        local coords = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)
        
        -- Position in front of player (closer and lower)
        local forwardX = coords.x + math.sin(math.rad(heading)) * 1.5
        local forwardY = coords.y + math.cos(math.rad(heading)) * 1.5
        local forwardZ = coords.z + 0.8  -- Lower position
        
        -- Draw 3D title
        Draw3DText(forwardX, forwardY, forwardZ + 0.3, "~p~CATCH THE FISH!", 0.25, 224, 195, 255, 255)
        
        -- Convert 3D position to screen space for UI
        local onScreen, screenX, screenY = World3dToScreen2d(forwardX, forwardY, forwardZ)
        
        if onScreen then
            -- Small bar dimensions
            local barWidth = 0.25  -- Smaller width
            local barHeight = 0.012
            local barX = screenX
            local barY = screenY
            
            -- Draw subtle background glow
            DrawRect(barX, barY, barWidth + 0.01, barHeight + 0.01, 157, 123, 216, 50)
            
            -- Draw main bar background
            DrawRect(barX, barY, barWidth, barHeight, 10, 5, 15, 180)
            
            -- Calculate positions relative to bar
            local barStart = barX - (barWidth / 2)
            
            -- Draw target zone (green glow)
            local targetX = barStart + (targetPos * barWidth)
            local targetW = targetWidth * (barWidth / 0.5)
            DrawRect(targetX, barY, targetW, barHeight * 0.8, 100, 255, 150, 120)
            DrawRect(targetX, barY, targetW, barHeight * 0.6, 157, 255, 123, 180)
            
            -- Draw indicator (purple glow)
            local indicatorX = barStart + (indicatorPos * barWidth)
            DrawRect(indicatorX, barY, 0.005, barHeight * 1.2, 224, 195, 255, 255)
            DrawRect(indicatorX, barY, 0.008, barHeight * 0.8, 157, 123, 216, 150)
            
            -- Draw hint below bar
            DrawText2D("~p~SPACE~w~ to catch", barX, barY + 0.025, 0.25, 200, 200, 200, 200, true)
            
            -- Draw hits progress (instead of time bar)
            DrawText2D("~p~" .. hitsSuccessful .. "~w~/~p~" .. hitsRequired, barX, barY - 0.03, 0.3, 200, 200, 200, 255, true)
            
            -- Draw progress dots
            local dotSpacing = 0.015
            local dotsStartX = barX - ((hitsRequired - 1) * dotSpacing / 2)
            for i = 1, hitsRequired do
                local dotX = dotsStartX + ((i - 1) * dotSpacing)
                if i <= hitsSuccessful then
                    -- Completed - green
                    DrawRect(dotX, barY + 0.045, 0.008, 0.008, 157, 255, 123, 255)
                else
                    -- Not completed - dark
                    DrawRect(dotX, barY + 0.045, 0.008, 0.008, 50, 40, 70, 150)
                end
            end
        end
        
        -- Check for space press
        if IsControlJustPressed(0, 22) then
            local targetStart = targetPos
            local targetEnd = targetPos + (targetWidth / 0.5)
            
            if indicatorPos >= targetStart and indicatorPos <= targetEnd then
                -- Success hit!
                hitsSuccessful = hitsSuccessful + 1
                PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                -- print("^2[MinigameNative] Hit " .. hitsSuccessful .. "/" .. hitsRequired .. "^7")
                
                if hitsSuccessful >= hitsRequired then
                    completed = true
                    success = true
                    -- print("^2[MinigameNative] Common minigame SUCCESS!^7")
                else
                    -- Generate new target position for next hit
                    targetPos = 0.25 + math.random() * 0.4
                end
            else
                -- Miss - play error sound but continue
                PlaySoundFrontend(-1, "CANCEL", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                -- print("^1[MinigameNative] Missed! Keep trying...^7")
            end
        end
        
        -- ESC to cancel
        if IsControlJustPressed(0, 322) then
            completed = true
            success = false
            -- print("^1[MinigameNative] Common minigame CANCELLED!^7")
        end
    end
    
    return success
end

-- Uncommon Minigame: Direction Sequence (Small & In Perspective)
function MinigameNative.Uncommon()
    -- print("^3[MinigameNative] Starting Uncommon minigame^7")
    
    -- Generate random sequence
    local arrows = {"↑", "→", "↓", "←"}
    local arrowNames = {"W", "D", "S", "A"}
    local controls = {32, 34, 33, 35}
    local sequenceLength = 4 + math.random(0, 1)
    local sequence = {}
    
    for i = 1, sequenceLength do
        table.insert(sequence, math.random(1, 4))
    end
    
    local currentIndex = 1
    local completed = false
    local success = false
    local startTime = GetGameTimer()
    local duration = 25000  -- Increased from 20s to 25s
    
    local ped = PlayerPedId()
    
    while not completed and (GetGameTimer() - startTime) < duration do
        Wait(0)
        
        -- Get player coords
        local coords = GetEntityCoords(ped)
        local heading = GetEntityHeading(ped)
        local forwardX = coords.x + math.sin(math.rad(heading)) * 1.5
        local forwardY = coords.y + math.cos(math.rad(heading)) * 1.5
        local forwardZ = coords.z + 0.8
        
        -- Draw 3D title
        Draw3DText(forwardX, forwardY, forwardZ + 0.3, "~p~REEL IT IN!", 0.25, 224, 195, 255, 255)
        
        -- Convert to screen space
        local onScreen, screenX, screenY = World3dToScreen2d(forwardX, forwardY, forwardZ)
        
        if onScreen then
            -- Small boxes
            local boxSize = 0.025
            local spacing = 0.035
            local totalWidth = (#sequence * spacing) - (spacing - boxSize)
            local startX = screenX - (totalWidth / 2)
            
            for i = 1, #sequence do
                local x = startX + ((i - 1) * spacing)
                
                -- Determine color
                if i < currentIndex then
                    -- Completed - green
                    DrawRect(x, screenY, boxSize, boxSize, 100, 255, 150, 100)
                    DrawRect(x, screenY, boxSize * 0.8, boxSize * 0.8, 157, 255, 123, 200)
                elseif i == currentIndex then
                    -- Current - purple pulse
                    local pulse = math.abs(math.sin(GetGameTimer() / 300))
                    DrawRect(x, screenY, boxSize, boxSize, 157, 123, 216, 100 + (pulse * 100))
                    DrawRect(x, screenY, boxSize * 0.8, boxSize * 0.8, 224, 195, 255, 200 + (pulse * 55))
                else
                    -- Upcoming - dark
                    DrawRect(x, screenY, boxSize, boxSize, 50, 40, 70, 150)
                end
                
                -- Draw arrow
                DrawText2D(arrows[sequence[i]], x, screenY - 0.01, 0.35, 255, 255, 255, 255, true)
            end
            
            -- Draw hint
            DrawText2D("Press: ~p~" .. arrowNames[sequence[currentIndex]], screenX, screenY + 0.03, 0.3, 200, 200, 200, 255, true)
            
            -- Time remaining
            local timeRemaining = 1 - ((GetGameTimer() - startTime) / duration)
            DrawRect(screenX, screenY + 0.05, totalWidth * timeRemaining, 0.003, 157, 123, 216, 150)
        end
        
        -- Check for key press
        for i = 1, 4 do
            if IsControlJustPressed(0, controls[i]) then
                if sequence[currentIndex] == i then
                    PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                    currentIndex = currentIndex + 1
                    
                    if currentIndex > #sequence then
                        completed = true
                        success = true
                        -- print("^2[MinigameNative] Uncommon minigame SUCCESS!^7")
                    end
                else
                    PlaySoundFrontend(-1, "CANCEL", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                    completed = true
                    success = false
                    -- print("^1[MinigameNative] Uncommon minigame FAILED!^7")
                end
                break
            end
        end
        
        if IsControlJustPressed(0, 322) then
            completed = true
            success = false
        end
    end
    
    if not completed then
        -- print("^1[MinigameNative] Uncommon minigame TIMEOUT!^7")
    end
    
    return success
end

-- Rare Minigame: Rhythm Timing (Small & In Perspective)
function MinigameNative.Rare()
    -- print("^3[MinigameNative] Starting Rare minigame^7")
    
    local score = 0
    local requiredScore = 4
    local attempts = 6
    local currentAttempt = 1
    local completed = false
    
    local ped = PlayerPedId()
    
    while not completed and currentAttempt <= attempts do
        local targetPos = 0.3 + math.random() * 0.4
        local hitWindow = 0.12
        local speed = 3000  -- Increased from 2500ms to 3000ms (slower)
        local attemptStart = GetGameTimer()
        local attemptDuration = 5000  -- Increased from 4s to 5s per attempt
        local hit = false
        
        while not hit and (GetGameTimer() - attemptStart) < attemptDuration do
            Wait(0)
            
            local elapsed = (GetGameTimer() - attemptStart) % speed
            local indicatorPos = elapsed / speed
            
            -- Get player coords
            local coords = GetEntityCoords(ped)
            local heading = GetEntityHeading(ped)
            local forwardX = coords.x + math.sin(math.rad(heading)) * 1.5
            local forwardY = coords.y + math.cos(math.rad(heading)) * 1.5
            local forwardZ = coords.z + 0.8
            
            -- Draw 3D title
            Draw3DText(forwardX, forwardY, forwardZ + 0.3, "~p~PERFECT RHYTHM!", 0.25, 224, 195, 255, 255)
            
            -- Convert to screen space
            local onScreen, screenX, screenY = World3dToScreen2d(forwardX, forwardY, forwardZ)
            
            if onScreen then
                -- Small bar
                local barWidth = 0.25
                local barHeight = 0.012
                local barStart = screenX - (barWidth / 2)
                
                -- Background
                DrawRect(screenX, screenY, barWidth, barHeight, 10, 5, 15, 180)
                
                -- Target zone
                local targetX = barStart + (targetPos * barWidth)
                local targetW = hitWindow * (barWidth / 0.5)
                DrawRect(targetX, screenY, targetW, barHeight * 0.8, 100, 255, 150, 120)
                DrawRect(targetX, screenY, targetW, barHeight * 0.6, 157, 255, 123, 180)
                
                -- Indicator
                local indicatorX = barStart + (indicatorPos * barWidth)
                DrawRect(indicatorX, screenY, 0.005, barHeight * 1.2, 224, 195, 255, 255)
                DrawRect(indicatorX, screenY, 0.008, barHeight * 0.8, 157, 123, 216, 150)
                
                -- Score
                DrawText2D("~p~" .. score .. "~w~/~p~" .. requiredScore, screenX, screenY - 0.03, 0.3, 200, 200, 200, 255, true)
                DrawText2D(currentAttempt .. "/" .. attempts, screenX, screenY + 0.025, 0.25, 150, 150, 150, 200, true)
            end
            
            -- Check for space
            if IsControlJustPressed(0, 22) then
                hit = true
                
                local distance = math.abs(indicatorPos - targetPos)
                if distance < (hitWindow / 0.5) then
                    score = score + 1
                    PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                    -- print("^2[MinigameNative] Hit! Score: " .. score .. "^7")
                    
                    if score >= requiredScore then
                        completed = true
                        -- print("^2[MinigameNative] Rare minigame SUCCESS!^7")
                    end
                else
                    PlaySoundFrontend(-1, "CANCEL", "HUD_FRONTEND_DEFAULT_SOUNDSET", true)
                    -- print("^1[MinigameNative] Miss!^7")
                end
            end
            
            if IsControlJustPressed(0, 322) then
                return false
            end
        end
        
        if not hit then
            -- print("^1[MinigameNative] Missed attempt " .. currentAttempt .. "^7")
        end
        
        currentAttempt = currentAttempt + 1
        Wait(500)
    end
    
    return score >= requiredScore
end

-- Epic Minigame: Memory sequence (simplified)
function MinigameNative.Epic()
    -- print("^3[MinigameNative] Starting Epic minigame^7")
    
    -- For now, just use Rare minigame with higher difficulty
    return MinigameNative.Rare()
end
