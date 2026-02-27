Config = {}

-- Locale Settings
Config.Locale = 'bg'  -- 'bg' or 'en'

-- Water Type Enum
Config.WaterType = {
    OCEAN = "Ocean",
    RIVER = "River",
    CANAL = "Canal",
    ALAMO_SEA = "Alamo_Sea",
    ALAMO_RIVER_NORTH = "Alamo_River_North",  -- Second river to Alamo Sea (different fish)
    MIRROR_PARK = "Mirror_Park",
    POWER_PLANT = "Power_Plant",
    RICHMAN_LAKE = "Richman_Lake",
    PALETO_LAKE_SMALL = "Paleto_Lake_Small",
    PALETO_LAKE_LARGE = "Paleto_Lake_Large",
    DEFAULT = "Default"
}

-- Rarity Tier Enum
Config.RarityTier = {
    COMMON = "Common",
    UNCOMMON = "Uncommon",
    RARE = "Rare",
    EPIC = "Epic",
    TRASH = "Trash"
}

-- Proximity Detection Settings
Config.ZoneProximityRadius = 50.0  -- meters

-- Zone Priority (lower number = higher priority)
Config.ZonePriority = {
    Mirror_Park = 0,        -- HIGHEST priority (overrides everything)
    Power_Plant = 0,        -- HIGHEST priority (overrides everything)
    Richman_Lake = 0,       -- HIGHEST priority (overrides everything)
    Paleto_Lake_Small = 0,  -- HIGHEST priority (overrides everything)
    Paleto_Lake_Large = 0,  -- HIGHEST priority (overrides everything)
    Canal = 1,              -- High priority (small specific zones)
    Alamo_River_North = 2,  -- Medium priority (specific river)
    River = 2,              -- Medium priority
    Alamo_Sea = 2,          -- Medium priority
    Ocean = 3,              -- Lower priority (large zone)
    Default = 4             -- Fallback
}

-- Rarity Base Probabilities
Config.RarityWeights = {
    Common = 60,    -- 60%
    Uncommon = 25,  -- 25%
    Rare = 12,      -- 12%
    Epic = 3        -- 3%
}

-- Fish Size Ranges (weight in grams, length in cm)
Config.FishSizes = {
    -- River Fish (Речни риби)
    fish_carp = {weight = {min = 500, max = 5000}, length = {min = 20, max = 80}},
    fish_crucian_carp = {weight = {min = 200, max = 800}, length = {min = 15, max = 35}},
    fish_chub = {weight = {min = 300, max = 1200}, length = {min = 18, max = 45}},
    fish_sichel = {weight = {min = 150, max = 600}, length = {min = 12, max = 28}},
    fish_barbel = {weight = {min = 400, max = 1500}, length = {min = 20, max = 50}},
    fish_trout = {weight = {min = 500, max = 1800}, length = {min = 25, max = 55}},
    fish_catfish = {weight = {min = 1000, max = 15000}, length = {min = 30, max = 180}},
    fish_perch = {weight = {min = 200, max = 900}, length = {min = 15, max = 38}},
    fish_white_bream = {weight = {min = 150, max = 700}, length = {min = 12, max = 32}},
    fish_bleak = {weight = {min = 50, max = 200}, length = {min = 8, max = 18}},
    fish_nase = {weight = {min = 300, max = 1100}, length = {min = 18, max = 42}},
    fish_roach = {weight = {min = 100, max = 500}, length = {min = 10, max = 25}},
    fish_rudd = {weight = {min = 150, max = 600}, length = {min = 12, max = 28}},
    fish_grass_carp = {weight = {min = 2000, max = 8000}, length = {min = 50, max = 120}},
    fish_asp = {weight = {min = 800, max = 3000}, length = {min = 30, max = 75}},
    
    -- Reservoir/Lake Fish (Язовирни риби)
    fish_silver_carp = {weight = {min = 1500, max = 6000}, length = {min = 40, max = 100}},
    fish_bighead_carp = {weight = {min = 2000, max = 7000}, length = {min = 45, max = 110}},
    fish_tench = {weight = {min = 500, max = 2000}, length = {min = 25, max = 60}},
    fish_channel_catfish = {weight = {min = 1000, max = 4500}, length = {min = 35, max = 90}},
    fish_white_amur = {weight = {min = 2500, max = 9000}, length = {min = 55, max = 125}},
    fish_black_carp = {weight = {min = 2000, max = 8500}, length = {min = 50, max = 120}},
    fish_sunfish = {weight = {min = 80, max = 300}, length = {min = 8, max = 22}},
    fish_silver_crucian = {weight = {min = 200, max = 900}, length = {min = 15, max = 35}},
    fish_mirror_carp = {weight = {min = 2000, max = 8000}, length = {min = 50, max = 115}},
    fish_common_carp = {weight = {min = 2000, max = 8000}, length = {min = 50, max = 115}},
    fish_black_bass = {weight = {min = 600, max = 2500}, length = {min = 25, max = 65}},
    fish_eel = {weight = {min = 400, max = 1500}, length = {min = 40, max = 100}},
    fish_peled = {weight = {min = 600, max = 2200}, length = {min = 28, max = 68}},
    fish_whitefish = {weight = {min = 500, max = 1800}, length = {min = 25, max = 58}},
    fish_rainbow_trout = {weight = {min = 700, max = 2500}, length = {min = 30, max = 70}},
    
    -- Sea Fish (Морски риби)
    fish_horse_mackerel = {weight = {min = 100, max = 400}, length = {min = 12, max = 28}},
    fish_sea_bream = {weight = {min = 300, max = 1200}, length = {min = 18, max = 45}},
    fish_bluefish = {weight = {min = 800, max = 3000}, length = {min = 30, max = 75}},
    fish_sea_bass = {weight = {min = 600, max = 2500}, length = {min = 25, max = 65}},
    fish_gilthead = {weight = {min = 500, max = 1800}, length = {min = 22, max = 55}},
    fish_goby = {weight = {min = 30, max = 150}, length = {min = 6, max = 15}},
    fish_turbot = {weight = {min = 1000, max = 4000}, length = {min = 35, max = 85}},
    fish_bonito = {weight = {min = 900, max = 3500}, length = {min = 32, max = 78}},
    fish_mackerel = {weight = {min = 200, max = 800}, length = {min = 15, max = 38}},
    fish_grey_mullet = {weight = {min = 400, max = 1500}, length = {min = 20, max = 52}},
    fish_red_mullet = {weight = {min = 150, max = 600}, length = {min = 12, max = 32}},
    fish_garfish = {weight = {min = 200, max = 900}, length = {min = 25, max = 65}},
    fish_anchovy = {weight = {min = 20, max = 100}, length = {min = 5, max = 15}},
    fish_shad = {weight = {min = 180, max = 700}, length = {min = 14, max = 35}},
    fish_wrasse = {weight = {min = 120, max = 500}, length = {min = 10, max = 28}},
    
    -- Ocean Fish (Океански риби)
    fish_yellowfin_tuna = {weight = {min = 10000, max = 50000}, length = {min = 100, max = 200}},
    fish_bluefin_tuna = {weight = {min = 15000, max = 80000}, length = {min = 120, max = 250}},
    fish_swordfish = {weight = {min = 12000, max = 60000}, length = {min = 150, max = 300}},
    fish_blue_marlin = {weight = {min = 14000, max = 70000}, length = {min = 180, max = 350}},
    fish_black_marlin = {weight = {min = 15000, max = 75000}, length = {min = 190, max = 360}},
    fish_mahi_mahi = {weight = {min = 3000, max = 15000}, length = {min = 60, max = 150}},
    fish_wahoo = {weight = {min = 5000, max = 25000}, length = {min = 80, max = 180}},
    fish_cod = {weight = {min = 2500, max = 12000}, length = {min = 50, max = 130}},
    fish_halibut = {weight = {min = 8000, max = 40000}, length = {min = 100, max = 220}},
    fish_grouper = {weight = {min = 7000, max = 35000}, length = {min = 90, max = 200}},
    fish_barracuda = {weight = {min = 4000, max = 20000}, length = {min = 70, max = 170}},
    fish_red_snapper = {weight = {min = 2000, max = 8000}, length = {min = 45, max = 100}},
    fish_tarpon = {weight = {min = 9000, max = 45000}, length = {min = 110, max = 230}},
    fish_flounder = {weight = {min = 800, max = 3000}, length = {min = 30, max = 75}},
    fish_shark = {weight = {min = 20000, max = 100000}, length = {min = 200, max = 400}}
}

-- Zone Definitions

-- Fishing Settings
Config.Fishing = {
    RodItemName = "fishingrod",  -- Changed from fishing_rod to fishingrod
    MinigameDifficulty = {"easy", "medium"},
    MinigameKeys = {"w", "a", "s", "d"},
    MinigameDuration = 5000,  -- 5 seconds
    MinigameAreaSize = 20,
    MinigameSpeedMultiplier = 1.0,
    RateLimitSeconds = 5  -- Max 1 attempt per 5 seconds
}

-- Fish Buyer NPC
Config.FishBuyer = {
    Location = vec4(-1803.36, -1198.21, 12.02, 48.99),  -- Fish buyer остава тук
    PedModel = "s_m_m_dockwork_01",  -- Dock worker ped
    BlipEnabled = true,
    BlipSprite = 500,  -- Briefcase/Money icon (различна от магазина)
    BlipColor = 2,    -- Green (за пари)
    BlipScale = 0.8,
    BlipLabel = "Изкупуване на риба"
}

-- Fish Selling Prices (в лева)
Config.FishPrices = {
        -- River Fish (Речни риби) - 15 броя
    fish_chub = 12,
    fish_barbel = 14,
    fish_sichel = 8,
    fish_white_bream = 9,
    fish_bleak = 6,

    fish_carp = 22,
    fish_crucian_carp = 18,
    fish_roach = 15,
    fish_rudd = 16,

    fish_trout = 45,
    fish_perch = 35,
    fish_nase = 40,

    fish_catfish = 120,
    fish_grass_carp = 160,
    fish_asp = 180,
    
    -- Reservoir/Lake Fish (Язовирни риби) - 15 броя
    fish_common_carp = 18,
    fish_silver_crucian = 14,
    fish_sunfish = 6,

    fish_tench = 28,
    fish_black_bass = 30,
    fish_whitefish = 26,
    fish_peled = 24,
    fish_eel = 22,

    fish_silver_carp = 55,
    fish_bighead_carp = 65,
    fish_rainbow_trout = 40,

    fish_mirror_carp = 150,
    fish_white_amur = 180,
    fish_channel_catfish = 110,
    fish_black_carp = 170,
    
    -- Sea Fish (Морски риби) - 15 броя
    fish_anchovy = 3,
    fish_goby = 4,
    fish_horse_mackerel = 8,
    fish_mackerel = 12,
    fish_red_mullet = 10,
    fish_wrasse = 8,
    fish_shad = 9,

    fish_sea_bream = 22,
    fish_gilthead = 28,
    fish_grey_mullet = 20,
    fish_garfish = 14,

    fish_sea_bass = 40,
    fish_bluefish = 45,
    fish_bonito = 50,
    fish_turbot = 70,
    
    -- Ocean Fish (Океански риби) - 15 броя
    fish_flounder = 12,
    fish_red_snapper = 18,
    fish_cod = 20,

    fish_mahi_mahi = 35,
    fish_wahoo = 40,
    fish_barracuda = 32,
    fish_grouper = 38,

    fish_halibut = 80,
    fish_tarpon = 85,
    fish_yellowfin_tuna = 90,

    fish_bluefin_tuna = 180,
    fish_swordfish = 160,
    fish_blue_marlin = 200,
    fish_black_marlin = 220,
    fish_shark = 200,
}

-- Debug Settings
Config.Debug = {
    Enabled = false,  -- Disabled debug visualization
    ShowZones = false,  -- Изключено
    ShowProximityRadius = false,  -- Изключено
    ShowDistances = false,  -- Изключено
    ShowPlayerMarker = false,  -- Изключено
    UpdateInterval = 0,  -- 0 = every frame
    
    Colors = {
        Ocean = {0, 100, 255, 150},
        River = {0, 255, 100, 150},
        Canal = {255, 255, 0, 150},
        Alamo_Sea = {0, 255, 255, 150},
        Alamo_River_North = {50, 200, 150, 150},  -- Teal/turquoise (different from regular river)
        Mirror_Park = {138, 43, 226, 150},  -- Purple
        Power_Plant = {255, 140, 0, 150},   -- Orange
        Richman_Lake = {220, 220, 220, 150}, -- Light gray/white (luxury)
        Paleto_Lake_Small = {100, 200, 255, 150}, -- Light blue (mountain)
        Paleto_Lake_Large = {100, 200, 255, 150}, -- Light blue (mountain)
        Closest = {255, 255, 255, 255},
        ProximityRadius = {255, 255, 255, 50},
        PlayerMarker = {255, 0, 0, 200}
    },
    
    TestLocations = {
        ocean = vector3(-1500.0, -1000.0, 1.0),
        canal = vector3(-200.0, -1000.0, 1.0),
        river = vector3(-2000.0, 2500.0, 1.0),
        alamo = vector3(1300.0, 4200.0, 1.0)
    }
}


-- Blip Settings
Config.Blips = {
    Enabled = false,  -- Изключени blips за зони
    
    -- Blip locations (center of each zone)
    Locations = {
        {
            name = "Ocean Fishing",
            coords = vector3(-1500.0, -1000.0, 1.0),
            sprite = 68,  -- Fish icon
            color = 3,    -- Blue
            scale = 0.8
        },
        {
            name = "Canal Fishing (South)",
            coords = vector3(-200.0, -1200.0, 1.0),
            sprite = 68,
            color = 5,    -- Yellow
            scale = 0.7
        },
        {
            name = "Canal Fishing (Central)",
            coords = vector3(-400.0, -600.0, 1.0),
            sprite = 68,
            color = 5,
            scale = 0.7
        },
        {
            name = "Canal Fishing (Industrial)",
            coords = vector3(900.0, -2900.0, 1.0),
            sprite = 68,
            color = 5,
            scale = 0.7
        },
        {
            name = "Canal Fishing (Port 1)",
            coords = vector3(994.16, -3235.5, 4.89),
            sprite = 68,
            color = 5,
            scale = 0.7
        },
        {
            name = "Canal Fishing (Port 2)",
            coords = vector3(365.7, -3089.62, 9.07),
            sprite = 68,
            color = 5,
            scale = 0.7
        },
        {
            name = "Canal Fishing (Port 3)",
            coords = vector3(268.34, -2661.19, 5.02),
            sprite = 68,
            color = 5,
            scale = 0.7
        },
        {
            name = "Canal Fishing (Port 4)",
            coords = vector3(-331.31, -2667.55, 5.14),
            sprite = 68,
            color = 5,
            scale = 0.7
        },
        {
            name = "Alamo Sea Fishing",
            coords = vector3(1300.0, 4200.0, 20.0),
            sprite = 68,
            color = 4,    -- Cyan
            scale = 0.8
        },
        {
            name = "Zancudo River Fishing",
            coords = vector3(-1800.0, 2600.0, 1.0),
            sprite = 68,
            color = 2,    -- Green
            scale = 0.7
        },
        {
            name = "Paleto Bay River Fishing",
            coords = vector3(-250.0, 6250.0, 1.0),
            sprite = 68,
            color = 2,    -- Green
            scale = 0.7
        },
        {
            name = "Vinewood River Fishing",
            coords = vector3(800.0, 1200.0, 200.0),
            sprite = 68,
            color = 2,
            scale = 0.7
        },
        {
            name = "Mirror Park Lake",
            coords = vector3(1087.83, -646.72, 53.06),
            sprite = 68,
            color = 27,  -- Purple (special lake)
            scale = 0.9
        },
        {
            name = "Power Plant Lake",
            coords = vector3(1900.0, 200.0, 160.0),
            sprite = 68,
            color = 46,  -- Orange (industrial lake)
            scale = 0.9
        },
        {
            name = "Richman Lake",
            coords = vector3(-50.0, 750.0, 205.0),
            sprite = 68,
            color = 7,  -- Light gray/white (luxury area)
            scale = 0.9
        },
        {
            name = "Paleto Small Lake",
            coords = vector3(3096.79, 6026.53, 121.13),
            sprite = 68,
            color = 38,  -- Light blue (mountain lake)
            scale = 0.8
        },
        {
            name = "Paleto Large Lake",
            coords = vector3(2546.91, 6149.75, 166.13),
            sprite = 68,
            color = 38,  -- Light blue (mountain lake)
            scale = 0.9
        }
    }
}

-- ============================================
-- ZONE DEFINITIONS (Large section moved to end)
-- ============================================

Config.Zones = {
    -- Ocean: Large polygon covering coastal waters
    Ocean = {
        type = "polygon",
        waterType = Config.WaterType.OCEAN,
        points = {
            -- Pacific Ocean boundary (simplified)
            {x = -3500.0, y = -500.0},
            {x = -3500.0, y = 8000.0},
            {x = -1000.0, y = 8000.0},
            {x = -500.0, y = 7000.0},
            {x = 500.0, y = 6500.0},
            {x = 1500.0, y = 6000.0},
            {x = 3000.0, y = 4500.0},
            {x = 3500.0, y = 3000.0},
            {x = 3500.0, y = -500.0},
            {x = 2000.0, y = -2000.0},
            {x = 500.0, y = -3000.0},
            {x = -1000.0, y = -3500.0},
            {x = -2500.0, y = -3000.0}
        }
    },

    -- Canal: Los Santos canal system (EXPANDED - multiple radius zones)
    Canal_South = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -200.0, y = -1200.0, z = 1.0},
        radius = 300.0  -- Large radius to cover canal area
    },
    
    Canal_Central = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -400.0, y = -600.0, z = 1.0},
        radius = 300.0
    },
    
    Canal_North = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -300.0, y = 0.0, z = 1.0},
        radius = 300.0
    },
    
    Canal_Industrial = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 900.0, y = -2900.0, z = 1.0},
        radius = 400.0  -- Industrial canal area
    },
    
    -- Additional Canal Zones (from user coordinates)
    Canal_Port_1 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 994.16, y = -3235.5, z = 4.89},
        radius = 250.0
    },
    
    Canal_Port_2 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 365.7, y = -3089.62, z = 9.07},
        radius = 250.0
    },
    
    Canal_Port_3 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 268.34, y = -2661.19, z = 5.02},
        radius = 250.0
    },
    
    Canal_Port_4 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -331.31, y = -2667.55, z = 5.14},
        radius = 250.0
    },
    
    -- Extended Canal Network (full coverage)
    Canal_C1 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -677.89, y = -2469.35, z = 12.94},
        radius = 200.0
    },
    
    Canal_C2 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -274.42, y = -2244.29, z = 7.36},
        radius = 200.0
    },
    
    Canal_C3_LARGE = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -125.04, y = -2418.17, z = 5.0},
        radius = 500.0  -- GIGANTIC ZONE
    },
    
    Canal_C4 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 33.39, y = -2198.89, z = 3.63},
        radius = 200.0
    },
    
    Canal_C5 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 54.71, y = -2166.37, z = 0.58},
        radius = 200.0
    },
    
    Canal_C6 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 27.9, y = -2010.71, z = 0.47},
        radius = 200.0
    },
    
    Canal_C7 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -74.04, y = -1925.41, z = 0.46},
        radius = 200.0
    },
    
    Canal_C8 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -255.03, y = -1784.32, z = -0.42},
        radius = 200.0
    },
    
    Canal_C9 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -407.16, y = -1622.48, z = -0.73},
        radius = 200.0
    },
    
    Canal_C10 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -525.95, y = -1543.15, z = -0.72},
        radius = 200.0
    },
    
    Canal_C11 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -698.22, y = -1534.36, z = -0.72},
        radius = 200.0
    },
    
    Canal_C12 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -806.37, y = -1600.1, z = -0.72},
        radius = 200.0
    },
    
    Canal_C13 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -898.81, y = -1687.04, z = 2.9},
        radius = 200.0
    },
    
    Canal_C14 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -991.76, y = -1772.62, z = 3.86},
        radius = 200.0
    },
    
    Canal_C15 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -882.06, y = -1562.31, z = 3.12},
        radius = 200.0
    },
    
    Canal_C16 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -826.92, y = -1457.01, z = 3.26},
        radius = 200.0
    },
    
    Canal_C17 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -747.29, y = -1376.94, z = 3.92},
        radius = 200.0
    },
    
    Canal_C18 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -911.27, y = -1455.23, z = 5.79},
        radius = 200.0
    },
    
    Canal_C19 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -891.06, y = -1357.57, z = 3.32},
        radius = 200.0
    },
    
    Canal_C20 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -971.49, y = -1382.12, z = 3.81},
        radius = 200.0
    },
    
    Canal_C21 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1019.72, y = -1302.07, z = 3.95},
        radius = 200.0
    },
    
    Canal_C22 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1057.96, y = -1233.58, z = 3.33},
        radius = 200.0
    },
    
    Canal_C23_LARGE = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1059.41, y = -1030.41, z = 1.53},
        radius = 500.0  -- GIGANTIC ZONE
    },
    
    Canal_C24 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1230.83, y = -934.15, z = 3.55},
        radius = 200.0
    },
    
    Canal_C25 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1304.81, y = -851.29, z = 1.7},
        radius = 200.0
    },
    
    Canal_C26 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1400.45, y = -819.48, z = 1.74},
        radius = 200.0
    },
    
    Canal_C27 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1483.87, y = -845.92, z = 1.54},
        radius = 200.0
    },
    
    Canal_C28 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1544.67, y = -873.73, z = 1.1},
        radius = 200.0
    },
    
    Canal_C29 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1634.64, y = -910.43, z = 1.4},
        radius = 200.0
    },
    
    Canal_C30 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1722.22, y = -948.6, z = 1.42},
        radius = 200.0
    },
    
    Canal_C31 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1772.33, y = -969.7, z = 0.16},
        radius = 200.0
    },
    
    -- Additional Extended Canal Network (Part 2)
    Canal_D1 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 215.84, y = -2891.36, z = 6.6},
        radius = 200.0
    },
    
    Canal_D2 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 636.21, y = -3130.7, z = -8.23},
        radius = 200.0
    },
    
    Canal_D3_LARGE = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 631.12, y = -2129.72, z = 2.96},
        radius = 500.0  -- GIGANTIC ZONE
    },
    
    Canal_D4 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 625.42, y = -2241.55, z = 1.96},
        radius = 200.0
    },
    
    Canal_D5 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 615.51, y = -2344.19, z = 2.4},
        radius = 200.0
    },
    
    Canal_D6 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 658.49, y = -1935.47, z = 10.82},
        radius = 200.0
    },
    
    Canal_D7 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 668.3, y = -1774.98, z = 11.34},
        radius = 200.0
    },
    
    Canal_D8 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 684.62, y = -1627.92, z = 11.55},
        radius = 200.0
    },
    
    Canal_D9 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 747.51, y = -1571.84, z = 11.9},
        radius = 200.0
    },
    
    Canal_D10 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 823.33, y = -1509.02, z = 12.14},
        radius = 200.0
    },
    
    Canal_D11 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 882.43, y = -1441.14, z = 12.51},
        radius = 200.0
    },
    
    Canal_D12 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 930.14, y = -1367.21, z = 13.81},
        radius = 200.0
    },
    
    Canal_D13 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 1002.53, y = -1300.22, z = 15.29},
        radius = 200.0
    },
    
    Canal_D14 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 1085.52, y = -1231.89, z = 16.31},
        radius = 200.0
    },
    
    Canal_D15 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 1166.23, y = -1162.1, z = 22.92},
        radius = 200.0
    },
    
    Canal_D16 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 662.18, y = -1515.95, z = 12.19},
        radius = 200.0
    },
    
    Canal_D17 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 649.21, y = -1471.14, z = 11.97},
        radius = 200.0
    },
    
    Canal_D18 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 609.38, y = -1336.96, z = 12.66},
        radius = 200.0
    },
    
    Canal_D19 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 592.71, y = -1235.04, z = 13.01},
        radius = 200.0
    },
    
    Canal_D20 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 592.6, y = -1098.71, z = 12.8},
        radius = 200.0
    },
    
    Canal_D21 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 591.24, y = -940.64, z = 14.02},
        radius = 200.0
    },
    
    Canal_D22 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 591.27, y = -784.86, z = 15.13},
        radius = 200.0
    },
    
    Canal_D23 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 604.19, y = -642.56, z = 16.76},
        radius = 200.0
    },
    
    Canal_D24 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 697.56, y = -475.62, z = 19.92},
        radius = 200.0
    },
    
    Canal_D25 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 816.77, y = -419.7, z = 28.09},
        radius = 200.0
    },
    
    Canal_D26 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 933.71, y = -396.37, z = 42.82},
        radius = 200.0
    },
    
    Canal_D27 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 1013.51, y = -341.9, z = 48.8},
        radius = 200.0
    },
    
    Canal_D28 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 1057.03, y = -273.31, z = 52.27},
        radius = 200.0
    },
    
    Canal_D29_LARGE = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 1140.74, y = -151.6, z = 56.36},
        radius = 500.0  -- GIGANTIC ZONE
    },
    
    Canal_D30 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 1214.87, y = -93.1, z = 59.16},
        radius = 200.0
    },
    
    Canal_D31 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 1269.44, y = -57.31, z = 62.83},
        radius = 200.0
    },
    
    Canal_D32 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 1266.93, y = 16.33, z = 66.8},
        radius = 200.0
    },
    
    Canal_D33 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 1360.48, y = -64.69, z = 75.72},
        radius = 200.0
    },
    
    Canal_D34 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 1446.85, y = -67.92, z = 98.04},
        radius = 200.0
    },
    
    Canal_D35 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 1518.42, y = -47.33, z = 115.46},
        radius = 200.0
    },
    
    Canal_D36 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 1590.29, y = -28.79, z = 122.53},
        radius = 200.0
    },
    
    -- Mirror Park Lake (HIGHEST PRIORITY - overrides all other zones)
    Mirror_Park_Lake = {
        type = "radius",
        waterType = Config.WaterType.MIRROR_PARK,
        center = {x = 1087.83, y = -646.72, z = 53.06},
        radius = 150.0  -- Reduced zone
    },
    
    -- Additional Canal Zone
    Canal_E1 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = 509.9, y = -2745.03, z = 10.46},
        radius = 200.0
    },
    
    -- Power Plant Lake (HIGHEST PRIORITY - overrides all other zones)
    Power_Plant_Lake_1 = {
        type = "radius",
        waterType = Config.WaterType.POWER_PLANT,
        center = {x = 1952.36, y = 382.9, z = 165.62},
        radius = 150.0
    },
    
    Power_Plant_Lake_2 = {
        type = "radius",
        waterType = Config.WaterType.POWER_PLANT,
        center = {x = 1960.04, y = 216.94, z = 162.8},
        radius = 150.0
    },
    
    Power_Plant_Lake_3 = {
        type = "radius",
        waterType = Config.WaterType.POWER_PLANT,
        center = {x = 1947.24, y = 102.86, z = 158.12},
        radius = 150.0
    },
    
    Power_Plant_Lake_4 = {
        type = "radius",
        waterType = Config.WaterType.POWER_PLANT,
        center = {x = 1809.63, y = 9.73, z = 159.99},
        radius = 150.0
    },
    
    -- Richman/Rockford Hills Lake (HIGHEST PRIORITY - overrides all other zones)
    Richman_Lake_1 = {
        type = "radius",
        waterType = Config.WaterType.RICHMAN_LAKE,
        center = {x = 71.61, y = 842.92, z = 206.48},
        radius = 100.0  -- Reduced zone
    },
    
    Richman_Lake_2 = {
        type = "radius",
        waterType = Config.WaterType.RICHMAN_LAKE,
        center = {x = 5.89, y = 674.56, z = 202.18},
        radius = 100.0  -- Reduced zone
    },
    
    Richman_Lake_3 = {
        type = "radius",
        waterType = Config.WaterType.RICHMAN_LAKE,
        center = {x = -162.93, y = 754.38, z = 205.54},
        radius = 100.0  -- Reduced zone
    },
    
    Richman_Lake_4 = {
        type = "radius",
        waterType = Config.WaterType.RICHMAN_LAKE,
        center = {x = -259.2, y = 819.5, z = 203.57},
        radius = 100.0  -- Reduced zone
    },
    
    Richman_Lake_5 = {
        type = "radius",
        waterType = Config.WaterType.RICHMAN_LAKE,
        center = {x = 47.99, y = 922.0, z = 201.27},
        radius = 100.0
    },
    
    Richman_Lake_6 = {
        type = "radius",
        waterType = Config.WaterType.RICHMAN_LAKE,
        center = {x = 194.06, y = 843.36, z = 202.51},
        radius = 100.0
    },

    -- Alamo Sea: Radius-based zone
    Alamo_Sea = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_SEA,
        center = {x = 1300.0, y = 4200.0, z = 20.0},
        radius = 500.0
    },
    
    Alamo_Sea_East = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_SEA,
        center = {x = 2070.45, y = 4330.28, z = 32.26},
        radius = 500.0
    },
    
    Alamo_Sea_South = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_SEA,
        center = {x = 372.77, y = 3945.5, z = 38.49},
        radius = 500.0
    },
    
    Alamo_Sea_Southwest = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_SEA,
        center = {x = 937.4, y = 3884.24, z = 48.06},
        radius = 500.0
    },
    
    Alamo_Sea_West = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_SEA,
        center = {x = 181.25, y = 4041.67, z = 59.97},
        radius = 500.0
    },

    -- Zancudo River (EXPANDED - multiple zones along river)
    Zancudo_River_West = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2300.0, y = 2400.0, z = 1.0},
        radius = 150.0
    },
    
    Zancudo_River_Central = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1800.0, y = 2600.0, z = 1.0},
        radius = 150.0
    },
    
    Zancudo_River_East = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1300.0, y = 2400.0, z = 1.0},
        radius = 150.0
    },
    
    -- Extended Zancudo River zones
    Zancudo_River_Z1 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -910.62, y = 2804.74, z = 9.71},
        radius = 80.0
    },
    
    Zancudo_River_Z2 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -951.48, y = 2816.76, z = 10.88},
        radius = 80.0
    },
    
    Zancudo_River_Z3 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -996.11, y = 2824.86, z = 6.36},
        radius = 80.0
    },
    
    Zancudo_River_Z4 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1024.72, y = 2835.28, z = 4.72},
        radius = 80.0
    },
    
    Zancudo_River_Z5 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1063.78, y = 2820.81, z = 3.88},
        radius = 80.0
    },
    
    Zancudo_River_Z6 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1095.96, y = 2810.77, z = 2.3},
        radius = 80.0
    },
    
    Zancudo_River_Z7 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1137.87, y = 2786.18, z = 1.27},
        radius = 80.0
    },
    
    Zancudo_River_Z8 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1171.5, y = 2751.9, z = 0.9},
        radius = 80.0
    },
    
    Zancudo_River_Z9 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1201.88, y = 2718.93, z = 0.29},
        radius = 80.0
    },
    
    Zancudo_River_Z10 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1237.44, y = 2689.08, z = 0.9},
        radius = 80.0
    },
    
    Zancudo_River_Z11 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1293.82, y = 2657.59, z = -0.32},
        radius = 80.0
    },
    
    Zancudo_River_Z12 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1351.8, y = 2638.97, z = 1.18},
        radius = 80.0
    },
    
    Zancudo_River_Z13 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1423.03, y = 2625.94, z = 1.68},
        radius = 80.0
    },
    
    Zancudo_River_Z14 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1495.6, y = 2627.85, z = 1.39},
        radius = 80.0
    },
    
    Zancudo_River_Z15 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1548.82, y = 2644.05, z = 0.05},
        radius = 80.0
    },
    
    Zancudo_River_Z16 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1625.82, y = 2621.52, z = 1.47},
        radius = 80.0
    },
    
    Zancudo_River_Z17 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1623.28, y = 2559.45, z = 2.1},
        radius = 80.0
    },
    
    Zancudo_River_Z18 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1573.47, y = 2519.9, z = 2.66},
        radius = 80.0
    },
    
    Zancudo_River_Z19 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1531.71, y = 2473.1, z = 2.94},
        radius = 80.0
    },
    
    Zancudo_River_Z20 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1493.44, y = 2422.22, z = 4.54},
        radius = 80.0
    },
    
    Zancudo_River_Z21 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1463.65, y = 2362.99, z = 9.35},
        radius = 80.0
    },
    
    Zancudo_River_Z22 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1449.22, y = 2307.25, z = 15.51},
        radius = 80.0
    },
    
    Zancudo_River_Z23 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1437.33, y = 2247.57, z = 18.05},
        radius = 80.0
    },
    
    Zancudo_River_Z24 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1418.96, y = 2188.01, z = 25.64},
        radius = 80.0
    },
    
    Zancudo_River_Z25 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1428.21, y = 2147.1, z = 32.18},
        radius = 80.0
    },
    
    Zancudo_River_Z26 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1445.04, y = 2106.58, z = 40.84},
        radius = 80.0
    },
    
    Zancudo_River_Z27 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1450.72, y = 2045.66, z = 56.71},
        radius = 80.0
    },
    
    Zancudo_River_Z28 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1441.0, y = 1988.82, z = 58.91},
        radius = 80.0
    },
    
    Zancudo_River_Z29 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1469.77, y = 1942.62, z = 64.74},
        radius = 80.0
    },
    
    Zancudo_River_Z30 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1463.76, y = 1890.73, z = 72.61},
        radius = 80.0
    },
    
    Zancudo_River_Z31 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1473.39, y = 1835.3, z = 79.26},
        radius = 80.0
    },
    
    Zancudo_River_Z32 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1515.1, y = 1763.18, z = 86.89},
        radius = 80.0
    },
    
    Zancudo_River_Z33 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1533.37, y = 1700.39, z = 94.71},
        radius = 80.0
    },
    
    Zancudo_River_Z34 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1527.41, y = 1661.35, z = 96.84},
        radius = 80.0
    },
    
    Zancudo_River_Z35 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1524.37, y = 1621.95, z = 100.24},
        radius = 80.0
    },
    
    Zancudo_River_Z36 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1509.86, y = 1568.1, z = 106.43},
        radius = 80.0
    },
    
    Zancudo_River_Z37 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1517.76, y = 1532.47, z = 110.39},
        radius = 80.0
    },
    
    Zancudo_River_Z38 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1531.22, y = 1493.03, z = 110.16},
        radius = 80.0
    },
    
    Zancudo_River_Z39 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1540.92, y = 1454.92, z = 114.8},
        radius = 80.0
    },
    
    Zancudo_River_Z40 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1555.04, y = 1440.51, z = 117.21},
        radius = 80.0
    },
    
    Zancudo_River_Z41 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1589.09, y = 1408.62, z = 120.94},
        radius = 80.0
    },
    
    Zancudo_River_Z42 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1614.55, y = 1377.16, z = 123.55},
        radius = 80.0
    },
    
    Zancudo_River_Z43 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1636.94, y = 1345.67, z = 127.53},
        radius = 80.0
    },
    
    Zancudo_River_Z44 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1650.17, y = 1311.39, z = 131.57},
        radius = 80.0
    },
    
    Zancudo_River_Z45 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1658.2, y = 1254.22, z = 139.1},
        radius = 80.0
    },
    
    Zancudo_River_Z46 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1654.45, y = 1203.78, z = 145.12},
        radius = 80.0
    },
    
    Zancudo_River_Z47 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1649.01, y = 1169.63, z = 149.71},
        radius = 80.0
    },
    
    Zancudo_River_Z48 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1651.63, y = 1339.22, z = 132.21},
        radius = 80.0
    },
    
    Zancudo_River_Z49 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1682.42, y = 1331.24, z = 142.84},
        radius = 80.0
    },
    
    Zancudo_River_Z50 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1713.7, y = 1332.17, z = 153.63},
        radius = 80.0
    },
    
    Zancudo_River_Z51 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1755.19, y = 1340.41, z = 165.07},
        radius = 80.0
    },
    
    Zancudo_River_Z52 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1798.46, y = 1355.26, z = 175.69},
        radius = 80.0
    },
    
    Zancudo_River_Z53 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1844.91, y = 1360.51, z = 187.49},
        radius = 80.0
    },
    
    Zancudo_River_Z54 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1883.07, y = 1358.21, z = 200.23},
        radius = 80.0
    },
    
    Zancudo_River_Z55 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1924.67, y = 1344.98, z = 213.33},
        radius = 80.0
    },
    
    Zancudo_River_Z56 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2013.79, y = 2547.95, z = 0.34},
        radius = 80.0
    },
    
    Zancudo_River_Z57 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2081.8, y = 2575.94, z = 0.4},
        radius = 80.0
    },
    
    Zancudo_River_Z58 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2156.9, y = 2527.98, z = 5.25},
        radius = 80.0
    },
    
    Zancudo_River_Z59 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2189.54, y = 2605.7, z = 8.04},
        radius = 80.0
    },
    
    Zancudo_River_Z60 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2275.97, y = 2615.38, z = 7.98},
        radius = 80.0
    },
    
    Zancudo_River_Z61 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2262.25, y = 2710.81, z = 7.22},
        radius = 80.0
    },
    
    Zancudo_River_Z62 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2327.9, y = 2585.86, z = 7.74},
        radius = 80.0
    },
    
    Zancudo_River_Z63 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2391.95, y = 2629.0, z = 4.67},
        radius = 80.0
    },
    
    Zancudo_River_Z64 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2437.33, y = 2586.46, z = 4.56},
        radius = 80.0
    },
    
    Zancudo_River_Z65 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2496.17, y = 2553.69, z = 4.5},
        radius = 80.0
    },
    
    Zancudo_River_Z66 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2547.98, y = 2591.88, z = 4.23},
        radius = 80.0
    },
    
    Zancudo_River_Z67 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2612.23, y = 2576.59, z = 5.85},
        radius = 80.0
    },
    
    Zancudo_River_Z68 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2666.8, y = 2587.06, z = 5.07},
        radius = 80.0
    },
    
    Zancudo_River_Z69 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2734.69, y = 2605.86, z = 4.97},
        radius = 80.0
    },
    
    Zancudo_River_Z70 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2745.19, y = 2675.47, z = 6.61},
        radius = 80.0
    },
    
    Zancudo_River_Z71 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2708.97, y = 2768.76, z = 8.37},
        radius = 80.0
    },
    
    Zancudo_River_Z72 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2653.81, y = 2778.0, z = 7.17},
        radius = 80.0
    },
    
    Zancudo_River_Z73 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2568.9, y = 2797.99, z = 5.39},
        radius = 80.0
    },
    
    Zancudo_River_Z74 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2503.74, y = 2784.33, z = 3.68},
        radius = 80.0
    },
    
    Zancudo_River_Z75 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2450.43, y = 2766.97, z = 2.18},
        radius = 80.0
    },
    
    Zancudo_River_Z76 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2394.51, y = 2763.81, z = 3.98},
        radius = 80.0
    },
    
    Zancudo_River_Z77 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2326.42, y = 2765.54, z = 3.65},
        radius = 80.0
    },
    
    Zancudo_River_Z78 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2278.79, y = 2796.28, z = 2.54},
        radius = 80.0
    },
    
    Zancudo_River_Z79 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2254.42, y = 2754.45, z = 4.27},
        radius = 80.0
    },
    
    Zancudo_River_Z80 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2278.89, y = 2710.7, z = 4.92},
        radius = 80.0
    },
    
    Zancudo_River_Z81 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2253.41, y = 2661.45, z = 5.34},
        radius = 80.0
    },

    -- Paleto Bay River (EXPANDED)
    Paleto_River_West = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -400.0, y = 6300.0, z = 1.0},
        radius = 350.0
    },
    
    Paleto_River_East = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -100.0, y = 6200.0, z = 1.0},
        radius = 350.0
    },
    
    -- River connecting Ocean to Alamo Sea
    River_Alamo_1 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2632.14, y = 2688.33, z = 4.23},
        radius = 80.0
    },
    
    River_Alamo_2 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -2690.01, y = 2804.51, z = 6.85},
        radius = 80.0
    },
    
    River_Alamo_3 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -1407.67, y = 2566.61, z = 24.18},
        radius = 80.0
    },
    
    River_Alamo_South = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -797.17, y = 2833.64, z = 10.71},
        radius = 80.0
    },
    
    River_Alamo_4 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -684.92, y = 2905.06, z = 13.95},
        radius = 80.0
    },
    
    River_Alamo_5 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -609.9, y = 2956.02, z = 14.71},
        radius = 80.0
    },
    
    River_Alamo_6 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -536.64, y = 2925.26, z = 16.71},
        radius = 80.0
    },
    
    River_Alamo_7 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -440.73, y = 2929.36, z = 16.52},
        radius = 80.0
    },
    
    River_Alamo_8 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -373.77, y = 3006.62, z = 16.62},
        radius = 80.0
    },
    
    River_Alamo_9 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -310.64, y = 3024.17, z = 19.03},
        radius = 80.0
    },
    
    River_Alamo_10 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -239.23, y = 2997.84, z = 19.18},
        radius = 80.0
    },
    
    River_Alamo_11 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -198.56, y = 3036.81, z = 19.94},
        radius = 80.0
    },
    
    River_Alamo_12 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -149.64, y = 3086.81, z = 20.72},
        radius = 80.0
    },
    
    River_Alamo_13 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -102.43, y = 3107.79, z = 23.38},
        radius = 80.0
    },
    
    River_Alamo_14 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = -34.11, y = 3113.36, z = 26.96},
        radius = 80.0
    },
    
    River_Alamo_15 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = 29.91, y = 3134.72, z = 26.54},
        radius = 80.0
    },
    
    River_Alamo_16 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = 63.96, y = 3187.47, z = 27.49},
        radius = 80.0
    },
    
    River_Alamo_17 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = 92.24, y = 3274.18, z = 29.69},
        radius = 80.0
    },
    
    River_Alamo_18 = {
        type = "radius",
        waterType = Config.WaterType.RIVER,
        center = {x = 130.32, y = 3360.4, z = 33.09},
        radius = 80.0
    },
    
    -- North River to Alamo Sea (different fish than main river)
    Alamo_River_North_1 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -296.88, y = 4378.44, z = 31.5},
        radius = 80.0
    },
    
    Alamo_River_North_2 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -371.72, y = 4429.89, z = 32.15},
        radius = 80.0
    },
    
    Alamo_River_North_3 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -470.11, y = 4419.07, z = 32.92},
        radius = 80.0
    },
    
    Alamo_River_North_4 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -593.88, y = 4422.91, z = 15.62},
        radius = 80.0
    },
    
    Alamo_River_North_5 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -714.49, y = 4443.61, z = 16.32},
        radius = 80.0
    },
    
    Alamo_River_North_6 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -807.08, y = 4439.31, z = 16.88},
        radius = 80.0
    },
    
    Alamo_River_North_7 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -909.38, y = 4394.56, z = 12.41},
        radius = 80.0
    },
    
    Alamo_River_North_8 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -994.97, y = 4376.04, z = 12.11},
        radius = 80.0
    },
    
    Alamo_River_North_9 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -1080.67, y = 4396.9, z = 10.91},
        radius = 80.0
    },
    
    Alamo_River_North_10 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -1160.03, y = 4392.47, z = 5.78},
        radius = 80.0
    },
    
    Alamo_River_North_11 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -1246.49, y = 4379.75, z = 5.96},
        radius = 80.0
    },
    
    Alamo_River_North_12 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -1316.83, y = 4351.41, z = 5.09},
        radius = 80.0
    },
    
    Alamo_River_North_13 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -1368.51, y = 4327.38, z = 2.76},
        radius = 80.0
    },
    
    Alamo_River_North_14 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -1447.05, y = 4333.38, z = 2.07},
        radius = 80.0
    },
    
    Alamo_River_North_15 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -1526.66, y = 4353.76, z = 0.68},
        radius = 80.0
    },
    
    Alamo_River_North_16 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -1586.75, y = 4379.41, z = 1.66},
        radius = 80.0
    },
    
    Alamo_River_North_17 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -1627.9, y = 4444.91, z = 1.65},
        radius = 80.0
    },
    
    Alamo_River_North_18 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -1683.25, y = 4477.41, z = 1.48},
        radius = 80.0
    },
    
    Alamo_River_North_19 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -1754.79, y = 4514.38, z = 2.39},
        radius = 80.0
    },
    
    Alamo_River_North_20 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -1822.53, y = 4602.85, z = 1.52},
        radius = 80.0
    },
    
    Alamo_River_North_21 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -1878.5, y = 4645.5, z = 7.51},
        radius = 80.0
    },
    
    Alamo_River_North_22 = {
        type = "radius",
        waterType = Config.WaterType.ALAMO_RIVER_NORTH,
        center = {x = -205.82, y = 4285.38, z = 38.45},
        radius = 80.0
    },
    
    -- Vineyard Canal (flows to Alamo Sea)
    Canal_Vineyard_1 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1627.6, y = 2087.14, z = 72.47},
        radius = 80.0
    },
    
    Canal_Vineyard_2 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1684.65, y = 2069.55, z = 97.68},
        radius = 80.0
    },
    
    Canal_Vineyard_3 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1724.69, y = 2055.98, z = 107.62},
        radius = 80.0
    },
    
    Canal_Vineyard_4 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -2153.62, y = 1662.76, z = 230.24},
        radius = 80.0
    },
    
    Canal_Vineyard_5 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -2120.46, y = 1702.22, z = 215.17},
        radius = 80.0
    },
    
    Canal_Vineyard_6 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -2059.3, y = 1739.4, z = 199.09},
        radius = 80.0
    },
    
    Canal_Vineyard_7 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -2006.65, y = 1772.54, z = 179.61},
        radius = 80.0
    },
    
    Canal_Vineyard_8 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1954.33, y = 1801.53, z = 169.21},
        radius = 80.0
    },
    
    Canal_Vineyard_9 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1886.68, y = 1850.65, z = 157.76},
        radius = 80.0
    },
    
    Canal_Vineyard_10 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1832.0, y = 1882.03, z = 143.15},
        radius = 80.0
    },
    
    Canal_Vineyard_11 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1799.3, y = 1940.8, z = 128.28},
        radius = 80.0
    },
    
    Canal_Vineyard_12 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1893.53, y = 1990.03, z = 138.99},
        radius = 80.0
    },
    
    Canal_Vineyard_13 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1844.31, y = 2000.59, z = 130.0},
        radius = 80.0
    },
    
    Canal_Vineyard_14 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1781.58, y = 1999.1, z = 118.68},
        radius = 80.0
    },
    
    Canal_Vineyard_15 = {
        type = "radius",
        waterType = Config.WaterType.CANAL,
        center = {x = -1730.02, y = 2033.64, z = 111.42},
        radius = 80.0
    },
    
    -- Paleto Bay Small Lake (HIGHEST PRIORITY)
    Paleto_Lake_Small = {
        type = "radius",
        waterType = Config.WaterType.PALETO_LAKE_SMALL,
        center = {x = 3096.79, y = 6026.53, z = 121.13},
        radius = 30.0  -- Minimal zone
    },
    
    -- Paleto Bay Large Lake (HIGHEST PRIORITY)
    Paleto_Lake_Large = {
        type = "radius",
        waterType = Config.WaterType.PALETO_LAKE_LARGE,
        center = {x = 2546.91, y = 6149.75, z = 166.13},
        radius = 60.0  -- Slightly larger zone
    }
}
