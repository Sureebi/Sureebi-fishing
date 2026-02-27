LootGenerator = {}

-- Weighted random selection from loot table
function LootGenerator.WeightedRandom(lootTable)
    if not lootTable or #lootTable == 0 then
        return nil
    end
    
    -- Calculate cumulative weights
    local cumulativeWeights = {}
    local totalWeight = 0
    
    for i, entry in ipairs(lootTable) do
        totalWeight = totalWeight + entry.weight
        cumulativeWeights[i] = totalWeight
    end
    
    -- Generate random number between 0 and total weight
    local random = math.random() * totalWeight
    
    -- Find item where random falls within cumulative range
    for i, cumulativeWeight in ipairs(cumulativeWeights) do
        if random <= cumulativeWeight then
            return lootTable[i]
        end
    end
    
    -- Fallback (should never reach here)
    return lootTable[#lootTable]
end

-- Generate catch result for water type
function LootGenerator.GenerateCatch(waterType)
    -- Get loot table for water type
    local lootTable = LootTables.GetTable(waterType)
    
    if not lootTable then
        -- print("^1[LootGenerator] Loot table not found for water type: " .. tostring(waterType) .. "^7")
        return nil, nil
    end
    
    -- Perform weighted random selection
    local success, result = pcall(function()
        return LootGenerator.WeightedRandom(lootTable)
    end)
    
    if not success or not result then
        -- print("^1[LootGenerator] Failed to generate catch for water type: " .. tostring(waterType) .. "^7")
        return nil, nil
    end
    
    return result.item, result.rarity
end

-- Validate that generated catch is from correct water type
function LootGenerator.ValidateCatch(waterType, itemName)
    local lootTable = LootTables.GetTable(waterType)
    if not lootTable then
        return false
    end
    
    for _, entry in ipairs(lootTable) do
        if entry.item == itemName then
            return true
        end
    end
    
    return false
end
