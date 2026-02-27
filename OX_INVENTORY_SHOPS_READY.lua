-- ============================================
-- FISHING SHOP FOR OX_INVENTORY
-- Копирай това и го добави в ox_inventory/data/shops.lua
-- ============================================

FishingShop = {
    name = 'Риболовен магазин',
    blip = {
        id = 68,
        colour = 3,
        scale = 0.8
    },
    inventory = {
        -- Fishing Rod
        { name = 'fishingrod', price = 350 },
        
        -- River Baits (Речни примамки)
        { name = 'bait_earthworm', price = 2 },
        { name = 'bait_bread', price = 1 },
        { name = 'bait_spinner', price = 15 },
        
        -- Reservoir/Lake Baits (Язовирни примамки)
        { name = 'bait_corn', price = 2 },
        { name = 'bait_boilie', price = 12 },
        { name = 'bait_silicone', price = 18 },
        
        -- Sea Baits (Морски примамки)
        { name = 'bait_seaworm', price = 4 },
        { name = 'bait_shrimp', price = 5 },
        { name = 'bait_squid', price = 14 },
        
        -- Ocean Baits (Океански примамки)
        { name = 'bait_metal_jig', price = 15 },
        { name = 'bait_trolling_lure', price = 24 }
    },
    locations = {
        vec3(-1694.65, -1057.43, 13.02),  -- Location 1
        vec3(1297.19, 4340.98, 39.07)     -- Location 2
    }
}
