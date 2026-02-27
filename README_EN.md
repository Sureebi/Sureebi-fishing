# 🎣 Dynamic Fishing System

Modern and realistic fishing system for FiveM with support for multiple water bodies, 60 fish species, 4 minigames, and full statistics.

## 📋 Table of Contents

- [Features](#features)
- [Dependencies](#dependencies)
- [Installation](#installation)
- [Items](#items)
- [Locations](#locations)
- [Configuration](#configuration)

---

## ✨ Features

### 🌊 Water Bodies
- **Rivers** - 15 river fish species
- **Lakes and Reservoirs** - 15 lake fish species
- **Sea Waters** - 15 sea fish species
- **Ocean** - 15 ocean fish species

### 🎮 Minigames (4 types)
- **Common** - Simple timing with kickback (3 successful hits)
- **Uncommon** - Arrow sequence
- **Rare** - Rhythmic timing (5/7 hits)
- **Epic** - Pattern memory (3x3 grid)

### 📊 Statistics
- Personal statistics (total caught, biggest fish)
- World records by fish type
- Leaderboards (total catches, biggest fish)
- Catch history
- Category statistics (river, lake, sea, ocean)

### 🌍 Localization
- Bulgarian (default)
- English
- Easy to add new languages

---

## 📦 Dependencies

### Required
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_target](https://github.com/overextended/ox_target)
- [ox_inventory](https://github.com/overextended/ox_inventory)
- OneSync Infinity
- MySQL (oxmysql)

---

## 🔧 Installation

### 1. Install the resource
```bash
# Copy the folder to resources/
# Add to server.cfg:
ensure ox_lib
ensure ox_target
ensure ox_inventory
ensure fishing_script  # Your resource name
```

### 2. Import the database
```sql
-- Execute fishing_database.sql in your MySQL database
-- This will create 4 tables:
-- - fishing_stats (player statistics)
-- - fishing_catches (catch history)
-- - fishing_records (world records)
-- - fishing_category_stats (category statistics)
```

### 3. Add items to ox_inventory
Open `ox_inventory/data/items.lua` and copy ALL items from `OX_INVENTORY_ITEMS_READY.lua`

### 4. Add shop to ox_inventory
Open `ox_inventory/data/shops.lua` and copy the shop from `OX_INVENTORY_SHOPS_READY.lua`

### 5. Restart the server
```bash
restart ox_inventory
restart fishing_script
```

---

## 🎒 Items

### 🎣 Equipment
- **fishingrod** - Fishing Rod ($500)

### 🪱 Baits (11 types)

#### River Baits
- **bait_earthworm** - Earthworm ($5)
- **bait_bread** - Bread Crumb ($3)
- **bait_spinner** - Spinner ($50)

#### Lake Baits
- **bait_corn** - Corn ($4)
- **bait_boilie** - Boilie ($40)
- **bait_silicone** - Silicone Lure ($60)

#### Sea Baits
- **bait_seaworm** - Sea Worm ($8)
- **bait_shrimp** - Shrimp ($10)
- **bait_squid** - Squid Piece ($35)

#### Ocean Baits
- **bait_metal_jig** - Metal Jig ($150)
- **bait_trolling_lure** - Trolling Lure ($200)

### 🐟 Fish (60 species)

#### River Fish (15)
fish_carp, fish_crucian_carp, fish_chub, fish_sichel, fish_barbel, fish_trout, fish_catfish, fish_perch, fish_white_bream, fish_bleak, fish_nase, fish_roach, fish_rudd, fish_grass_carp, fish_asp

#### Lake Fish (15)
fish_silver_carp, fish_bighead_carp, fish_tench, fish_channel_catfish, fish_white_amur, fish_black_carp, fish_sunfish, fish_silver_crucian, fish_mirror_carp, fish_common_carp, fish_black_bass, fish_eel, fish_peled, fish_whitefish, fish_rainbow_trout

#### Sea Fish (15)
fish_horse_mackerel, fish_sea_bream, fish_bluefish, fish_sea_bass, fish_gilthead, fish_goby, fish_turbot, fish_bonito, fish_mackerel, fish_grey_mullet, fish_red_mullet, fish_garfish, fish_anchovy, fish_shad, fish_wrasse

#### Ocean Fish (15)
fish_yellowfin_tuna, fish_bluefin_tuna, fish_swordfish, fish_blue_marlin, fish_black_marlin, fish_mahi_mahi, fish_wahoo, fish_cod, fish_halibut, fish_grouper, fish_barracuda, fish_red_snapper, fish_tarpon, fish_flounder, fish_shark

### 🗑️ Trash (15 types)
trash_old_boot, trash_torn_tire, trash_plastic_bottle, trash_rusty_can, trash_broken_bottle, trash_old_rope, trash_torn_net, trash_rusty_chain, trash_broken_bucket, trash_metal_scrap, trash_old_umbrella, trash_broken_flashlight, trash_broken_rod, trash_worn_glove, trash_old_phone

---

## 📍 Locations

### Fishing Shops (2 locations)
1. **Vespucci Beach** - (-1694.65, -1057.43, 13.02)
2. **Paleto Bay** - (1297.19, 4340.98, 39.07)

### Fish Buyer
- **Location** - (-1803.36, -1198.21, 13.02)
- **NPC** - Dock Worker
- Sells ALL fish at once

### Fishing Zones
- **Mirror Park Lake** - Lake in Mirror Park (priority 0)
- **Paleto Lake Small** - Small lake in Paleto (priority 1)
- **Paleto Lake Large** - Large lake in Paleto (priority 2)
- **Richman Lake** - Lake in Richman (priority 3)
- **Power Plant** - Lake at power plant (priority 4)
- **Alamo Sea** - Large salt lake (priority 5)
- **Alamo River North** - North river (priority 6)
- **Ocean** - Ocean (priority 10)
- **River** - Rivers (priority 11)
- **Canal** - Canals (priority 12)

---

## ⚙️ Configuration

### Basic Settings
```lua
Config.Locale = 'bg'  -- Language (bg/en)
Config.Debug.Enabled = false  -- Debug mode
Config.Blips.ShowZones = false  -- Show zones on map
```

### Wait Time (by rarity)
- **Common** - 60-100 seconds
- **Uncommon** - 100-180 seconds
- **Rare** - 180-240 seconds
- **Epic** - 240-300 seconds

### Notifications
- Duration: 10 seconds
- Type: ox_lib notify

---

## 🎯 How It Works

### 1. Buy rod and baits
Visit one of the two fishing shops

### 2. Find a water body
- Go to river, lake, sea or ocean
- Use the correct bait for the water body

### 3. Start fishing
- Use the fishing rod from inventory
- Wait for the minigame (time depends on rarity)

### 4. Play the minigame
- **Common** - Press SPACE 3 times at the right moment
- **Uncommon** - Repeat the arrow sequence
- **Rare** - Hit 5 out of 7 strikes
- **Epic** - Remember and repeat the pattern

### 5. Sell the fish
Go to the fish buyer and sell your catches

---

## 🔑 Important Rules

### Baits
- ❌ No bait = CAN'T fish
- ❌ Wrong bait = Wait 5 minutes and catch nothing
- ✅ Correct bait = Normal fishing

### Baits by Water Body
- **Rivers** → Earthworm, Bread Crumb, Spinner
- **Lakes** → Corn, Boilie, Silicone Lure
- **Sea** → Sea Worm, Shrimp, Squid Piece
- **Ocean** → Metal Jig, Trolling Lure
- **Canals** → Earthworm, Bread Crumb

### Trash
- **Canals** - 70% chance for trash
- **Ocean** - 10% chance for trash
- **Rivers** - 5% chance for trash
- **Lakes** - No trash

---

## 📝 Commands (Admin)

```bash
/clearfishingdata  # Deletes ALL fishing data
/resetplayerfishing [id]  # Deletes specific player data
```

---

## 🌐 Adding a New Language

1. Create a new file in `locales/` (e.g. `de.lua`)
2. Copy the structure from `locales/en.lua`
3. Translate all texts
4. Change `Config.Locale` in `shared/config.lua`

---

## 🐛 Support

If you have issues, check:
1. All dependencies are started
2. Database is imported
3. Items are added to ox_inventory
4. Shop is added to ox_inventory
5. Console for errors

---

## 📄 License

This script is created for personal use. All rights reserved.

---

**Version:** 1.0.2  
**Last Update:** 2026
