LootTables = {}

-- Bait system: Each water type has preferred baits that increase catch chance
LootTables.BaitSystem = {
    River = {
        preferred = {'bait_earthworm', 'bait_bread', 'bait_spinner'},
        bonus = 1.5  -- 50% better chance with correct bait
    },
    Alamo_River_North = {
        preferred = {'bait_earthworm', 'bait_bread', 'bait_spinner'},
        bonus = 1.5
    },
    Alamo_Sea = {
        preferred = {'bait_corn', 'bait_boilie', 'bait_silicone'},
        bonus = 1.5
    },
    Mirror_Park = {
        preferred = {'bait_corn', 'bait_boilie', 'bait_silicone'},
        bonus = 1.5
    },
    Power_Plant = {
        preferred = {'bait_corn', 'bait_boilie', 'bait_silicone'},
        bonus = 1.5
    },
    Richman_Lake = {
        preferred = {'bait_corn', 'bait_boilie', 'bait_silicone'},
        bonus = 1.5
    },
    Paleto_Lake_Small = {
        preferred = {'bait_corn', 'bait_boilie', 'bait_silicone'},
        bonus = 1.5
    },
    Paleto_Lake_Large = {
        preferred = {'bait_corn', 'bait_boilie', 'bait_silicone'},
        bonus = 1.5
    },
    Canal = {
        preferred = {'bait_earthworm', 'bait_bread'},
        bonus = 1.3
    },
    Ocean = {
        preferred = {'bait_seaworm', 'bait_shrimp', 'bait_squid', 'bait_metal_jig', 'bait_trolling_lure'},
        bonus = 1.5
    },
    Default = {
        preferred = {'bait_corn', 'bait_earthworm'},
        bonus = 1.3
    }
}

-- River loot table (15 речни риби + малко trash)
LootTables.River = {
    -- Common fish (55%)
    {item = "fish_chub", rarity = "Common", weight = 14},
    {item = "fish_barbel", rarity = "Common", weight = 13},
    {item = "fish_sichel", rarity = "Common", weight = 9},
    {item = "fish_white_bream", rarity = "Common", weight = 9},
    {item = "fish_bleak", rarity = "Common", weight = 10},
    
    -- Uncommon fish (25%)
    {item = "fish_carp", rarity = "Uncommon", weight = 10},
    {item = "fish_crucian_carp", rarity = "Uncommon", weight = 8},
    {item = "fish_roach", rarity = "Uncommon", weight = 7},
    
    -- Rare fish (12%)
    {item = "fish_trout", rarity = "Rare", weight = 5},
    {item = "fish_perch", rarity = "Rare", weight = 4},
    {item = "fish_nase", rarity = "Rare", weight = 3},
    
    -- Epic fish (3%)
    {item = "fish_catfish", rarity = "Epic", weight = 1.5},
    {item = "fish_grass_carp", rarity = "Epic", weight = 1},
    {item = "fish_asp", rarity = "Epic", weight = 0.5},
    
    -- Trash (5%)
    {item = "trash_plastic_bottle", rarity = "Trash", weight = 2},
    {item = "trash_old_boot", rarity = "Trash", weight = 1.5},
    {item = "trash_rusty_can", rarity = "Trash", weight = 1},
    {item = "trash_old_rope", rarity = "Trash", weight = 0.5}
}

-- Alamo River North (различни риби от обикновената река)
LootTables.Alamo_River_North = {
    {item = "fish_barbel", rarity = "Common", weight = 20},
    {item = "fish_white_bream", rarity = "Common", weight = 15},
    {item = "fish_roach", rarity = "Common", weight = 15},
    {item = "fish_bleak", rarity = "Common", weight = 10},
    
    {item = "fish_carp", rarity = "Uncommon", weight = 12},
    {item = "fish_crucian_carp", rarity = "Uncommon", weight = 8},
    {item = "fish_rudd", rarity = "Uncommon", weight = 5},
    
    {item = "fish_perch", rarity = "Rare", weight = 6},
    {item = "fish_trout", rarity = "Rare", weight = 4},
    {item = "fish_nase", rarity = "Rare", weight = 2},
    
    {item = "fish_catfish", rarity = "Epic", weight = 2},
    {item = "fish_asp", rarity = "Epic", weight = 1}
}

-- Alamo Sea (язовирни риби - 15)
LootTables.Alamo_Sea = {
    {item = "fish_common_carp", rarity = "Common", weight = 15},
    {item = "fish_crucian_carp", rarity = "Common", weight = 12},
    {item = "fish_silver_crucian", rarity = "Common", weight = 10},
    {item = "fish_white_bream", rarity = "Common", weight = 10},
    {item = "fish_sunfish", rarity = "Common", weight = 8},
    
    {item = "fish_tench", rarity = "Uncommon", weight = 10},
    {item = "fish_black_bass", rarity = "Uncommon", weight = 8},
    {item = "fish_whitefish", rarity = "Uncommon", weight = 7},
    
    {item = "fish_silver_carp", rarity = "Rare", weight = 6},
    {item = "fish_bighead_carp", rarity = "Rare", weight = 4},
    {item = "fish_rainbow_trout", rarity = "Rare", weight = 2},
    
    {item = "fish_mirror_carp", rarity = "Epic", weight = 3},
    {item = "fish_white_amur", rarity = "Epic", weight = 3},
    {item = "fish_channel_catfish", rarity = "Epic", weight = 2}
}

-- Mirror Park Lake (градско езеро - смесени риби)
LootTables.Mirror_Park = {
    {item = "fish_common_carp", rarity = "Common", weight = 20},
    {item = "fish_crucian_carp", rarity = "Common", weight = 15},
    {item = "fish_sunfish", rarity = "Common", weight = 15},
    {item = "fish_white_bream", rarity = "Common", weight = 10},
    
    {item = "fish_tench", rarity = "Uncommon", weight = 12},
    {item = "fish_black_bass", rarity = "Uncommon", weight = 10},
    {item = "fish_roach", rarity = "Uncommon", weight = 3},
    
    {item = "fish_rainbow_trout", rarity = "Rare", weight = 6},
    {item = "fish_perch", rarity = "Rare", weight = 4},
    {item = "fish_eel", rarity = "Rare", weight = 2},
    
    {item = "fish_mirror_carp", rarity = "Epic", weight = 2},
    {item = "fish_black_carp", rarity = "Epic", weight = 1}
}

-- Power Plant Lake (индустриално езеро)
LootTables.Power_Plant = {
    {item = "fish_common_carp", rarity = "Common", weight = 18},
    {item = "fish_crucian_carp", rarity = "Common", weight = 15},
    {item = "fish_white_bream", rarity = "Common", weight = 12},
    {item = "fish_roach", rarity = "Common", weight = 10},
    {item = "fish_eel", rarity = "Common", weight = 5},
    
    {item = "fish_tench", rarity = "Uncommon", weight = 10},
    {item = "fish_black_bass", rarity = "Uncommon", weight = 8},
    {item = "fish_channel_catfish", rarity = "Uncommon", weight = 7},
    
    {item = "fish_silver_carp", rarity = "Rare", weight = 5},
    {item = "fish_bighead_carp", rarity = "Rare", weight = 4},
    {item = "fish_peled", rarity = "Rare", weight = 3},
    
    {item = "fish_mirror_carp", rarity = "Epic", weight = 2},
    {item = "fish_white_amur", rarity = "Epic", weight = 1}
}

-- Richman Lake (луксозно езеро)
LootTables.Richman_Lake = {
    {item = "fish_rainbow_trout", rarity = "Common", weight = 20},
    {item = "fish_black_bass", rarity = "Common", weight = 15},
    {item = "fish_sunfish", rarity = "Common", weight = 15},
    {item = "fish_whitefish", rarity = "Common", weight = 10},
    
    {item = "fish_common_carp", rarity = "Uncommon", weight = 12},
    {item = "fish_tench", rarity = "Uncommon", weight = 10},
    {item = "fish_peled", rarity = "Uncommon", weight = 3},
    
    {item = "fish_mirror_carp", rarity = "Rare", weight = 6},
    {item = "fish_silver_carp", rarity = "Rare", weight = 4},
    {item = "fish_bighead_carp", rarity = "Rare", weight = 2},
    
    {item = "fish_white_amur", rarity = "Epic", weight = 2},
    {item = "fish_black_carp", rarity = "Epic", weight = 1}
}

-- Paleto Small Lake (планинско езеро)
LootTables.Paleto_Lake_Small = {
    {item = "fish_rainbow_trout", rarity = "Common", weight = 25},
    {item = "fish_trout", rarity = "Common", weight = 20},
    {item = "fish_whitefish", rarity = "Common", weight = 15},
    
    {item = "fish_perch", rarity = "Uncommon", weight = 15},
    {item = "fish_peled", rarity = "Uncommon", weight = 10},
    
    {item = "fish_black_bass", rarity = "Rare", weight = 8},
    {item = "fish_tench", rarity = "Rare", weight = 4},
    
    {item = "fish_mirror_carp", rarity = "Epic", weight = 2},
    {item = "fish_silver_carp", rarity = "Epic", weight = 1}
}

-- Paleto Large Lake (голямо планинско езеро)
LootTables.Paleto_Lake_Large = {
    {item = "fish_rainbow_trout", rarity = "Common", weight = 20},
    {item = "fish_trout", rarity = "Common", weight = 15},
    {item = "fish_whitefish", rarity = "Common", weight = 15},
    {item = "fish_peled", rarity = "Common", weight = 10},
    
    {item = "fish_perch", rarity = "Uncommon", weight = 12},
    {item = "fish_black_bass", rarity = "Uncommon", weight = 10},
    {item = "fish_tench", rarity = "Uncommon", weight = 3},
    
    {item = "fish_common_carp", rarity = "Rare", weight = 6},
    {item = "fish_silver_carp", rarity = "Rare", weight = 4},
    {item = "fish_bighead_carp", rarity = "Rare", weight = 2},
    
    {item = "fish_mirror_carp", rarity = "Epic", weight = 2},
    {item = "fish_white_amur", rarity = "Epic", weight = 1}
}

-- Canal (канал - много боклук + малко риба)
LootTables.Canal = {
    -- Trash items (70% chance)
    {item = "trash_plastic_bottle", rarity = "Trash", weight = 12},
    {item = "trash_rusty_can", rarity = "Trash", weight = 10},
    {item = "trash_old_boot", rarity = "Trash", weight = 8},
    {item = "trash_broken_bottle", rarity = "Trash", weight = 7},
    {item = "trash_torn_tire", rarity = "Trash", weight = 6},
    {item = "trash_old_rope", rarity = "Trash", weight = 5},
    {item = "trash_broken_bucket", rarity = "Trash", weight = 5},
    {item = "trash_metal_scrap", rarity = "Trash", weight = 4},
    {item = "trash_torn_net", rarity = "Trash", weight = 4},
    {item = "trash_rusty_chain", rarity = "Trash", weight = 3},
    {item = "trash_old_umbrella", rarity = "Trash", weight = 2},
    {item = "trash_broken_flashlight", rarity = "Trash", weight = 2},
    {item = "trash_worn_glove", rarity = "Trash", weight = 1},
    {item = "trash_old_phone", rarity = "Trash", weight = 1},
    
    -- Fish (30% chance)
    {item = "fish_bleak", rarity = "Common", weight = 10},
    {item = "fish_roach", rarity = "Common", weight = 8},
    {item = "fish_white_bream", rarity = "Common", weight = 5},
    
    {item = "fish_crucian_carp", rarity = "Uncommon", weight = 4},
    {item = "fish_perch", rarity = "Uncommon", weight = 2},
    
    {item = "fish_eel", rarity = "Rare", weight = 0.8},
    {item = "fish_catfish", rarity = "Rare", weight = 0.2}
}

-- Ocean (океан - 15 океански риби + малко trash)
LootTables.Ocean = {
    -- Common fish (50%)
    {item = "fish_mahi_mahi", rarity = "Common", weight = 12},
    {item = "fish_wahoo", rarity = "Common", weight = 10},
    {item = "fish_cod", rarity = "Common", weight = 10},
    {item = "fish_flounder", rarity = "Common", weight = 9},
    {item = "fish_red_snapper", rarity = "Common", weight = 9},
    
    -- Uncommon fish (25%)
    {item = "fish_yellowfin_tuna", rarity = "Uncommon", weight = 8},
    {item = "fish_barracuda", rarity = "Uncommon", weight = 7},
    {item = "fish_grouper", rarity = "Uncommon", weight = 6},
    {item = "fish_tarpon", rarity = "Uncommon", weight = 4},
    
    -- Rare fish (12%)
    {item = "fish_swordfish", rarity = "Rare", weight = 4},
    {item = "fish_halibut", rarity = "Rare", weight = 4},
    {item = "fish_blue_marlin", rarity = "Rare", weight = 2},
    {item = "fish_black_marlin", rarity = "Rare", weight = 2},
    
    -- Epic fish (3%)
    {item = "fish_bluefin_tuna", rarity = "Epic", weight = 2},
    {item = "fish_shark", rarity = "Epic", weight = 1},
    
    -- Trash (10% - океански боклук)
    {item = "trash_plastic_bottle", rarity = "Trash", weight = 3},
    {item = "trash_torn_net", rarity = "Trash", weight = 2},
    {item = "trash_old_rope", rarity = "Trash", weight = 2},
    {item = "trash_broken_bucket", rarity = "Trash", weight = 1},
    {item = "trash_metal_scrap", rarity = "Trash", weight = 1},
    {item = "trash_broken_rod", rarity = "Trash", weight = 1}
}

-- Default (малки езера/локви - смесени)
LootTables.Default = {
    {item = "fish_crucian_carp", rarity = "Common", weight = 25},
    {item = "fish_roach", rarity = "Common", weight = 20},
    {item = "fish_white_bream", rarity = "Common", weight = 15},
    
    {item = "fish_common_carp", rarity = "Uncommon", weight = 15},
    {item = "fish_perch", rarity = "Uncommon", weight = 10},
    
    {item = "fish_tench", rarity = "Rare", weight = 8},
    {item = "fish_black_bass", rarity = "Rare", weight = 4},
    
    {item = "fish_mirror_carp", rarity = "Epic", weight = 2},
    {item = "fish_catfish", rarity = "Epic", weight = 1}
}

-- Get loot table for water type
function LootTables.GetTable(waterType)
    if waterType == "Ocean" then
        return LootTables.Ocean
    elseif waterType == "River" then
        return LootTables.River
    elseif waterType == "Canal" then
        return LootTables.Canal
    elseif waterType == "Alamo_Sea" then
        return LootTables.Alamo_Sea
    elseif waterType == "Alamo_River_North" then
        return LootTables.Alamo_River_North
    elseif waterType == "Mirror_Park" then
        return LootTables.Mirror_Park
    elseif waterType == "Power_Plant" then
        return LootTables.Power_Plant
    elseif waterType == "Richman_Lake" then
        return LootTables.Richman_Lake
    elseif waterType == "Paleto_Lake_Small" then
        return LootTables.Paleto_Lake_Small
    elseif waterType == "Paleto_Lake_Large" then
        return LootTables.Paleto_Lake_Large
    elseif waterType == "Default" then
        return LootTables.Default
    else
        -- print("^1[LootTables] Unknown water type: " .. tostring(waterType) .. "^7")
        return nil
    end
end

-- Check if player has correct bait for water type
function LootTables.HasCorrectBait(waterType, playerBaits)
    local baitInfo = LootTables.BaitSystem[waterType]
    if not baitInfo then
        return false, 1.0
    end
    
    for _, bait in ipairs(baitInfo.preferred) do
        if playerBaits[bait] and playerBaits[bait] > 0 then
            return true, baitInfo.bonus
        end
    end
    
    return false, 1.0
end

-- Get all items for a rarity tier
function LootTables.GetItemsByRarity(waterType, rarity)
    local lootTable = LootTables.GetTable(waterType)
    if not lootTable then
        return {}
    end
    
    local items = {}
    for _, entry in ipairs(lootTable) do
        if entry.rarity == rarity then
            table.insert(items, entry.item)
        end
    end
    
    return items
end

-- Validate loot table probabilities sum to 100%
function LootTables.Validate(waterType)
    local lootTable = LootTables.GetTable(waterType)
    if not lootTable then
        return false, "Loot table not found for water type: " .. tostring(waterType)
    end
    
    local totalWeight = 0
    for _, entry in ipairs(lootTable) do
        totalWeight = totalWeight + entry.weight
    end
    
    -- Check if sum equals 100% within 0.1% tolerance
    local tolerance = 0.1
    if math.abs(totalWeight - 100.0) <= tolerance then
        return true, nil
    else
        return false, string.format("Total weight is %.2f%% (expected 100%% ±%.1f%%)", totalWeight, tolerance)
    end
end

-- Validate all loot tables
function LootTables.ValidateAll()
    local waterTypes = {"Ocean", "River", "Canal", "Alamo_Sea", "Alamo_River_North", "Mirror_Park", "Power_Plant", "Richman_Lake", "Paleto_Lake_Small", "Paleto_Lake_Large", "Default"}
    local allValid = true
    
    -- print("^3[LootTables] Validating all loot tables...^7")
    
    for _, waterType in ipairs(waterTypes) do
        local valid, error = LootTables.Validate(waterType)
        if valid then
            -- print("^2[LootTables] " .. waterType .. ": VALID^7")
        else
            -- print("^1[LootTables] " .. waterType .. ": INVALID - " .. error .. "^7")
            allValid = false
        end
    end
    
    if allValid then
        -- print("^2[LootTables] All loot tables validated successfully!^7")
    else
        -- print("^1[LootTables] Some loot tables failed validation!^7")
    end
    
    return allValid
end
