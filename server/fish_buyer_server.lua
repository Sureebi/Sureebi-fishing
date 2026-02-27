-- Fish categories
local FishCategories = {
    river = {
        'fish_carp', 'fish_crucian_carp', 'fish_chub', 'fish_sichel', 'fish_barbel',
        'fish_trout', 'fish_catfish', 'fish_perch', 'fish_white_bream', 'fish_bleak',
        'fish_nase', 'fish_roach', 'fish_rudd', 'fish_grass_carp', 'fish_asp'
    },
    lake = {
        'fish_silver_carp', 'fish_bighead_carp', 'fish_tench', 'fish_channel_catfish',
        'fish_white_amur', 'fish_black_carp', 'fish_sunfish', 'fish_silver_crucian',
        'fish_mirror_carp', 'fish_common_carp', 'fish_black_bass', 'fish_eel',
        'fish_peled', 'fish_whitefish', 'fish_rainbow_trout'
    },
    sea = {
        'fish_horse_mackerel', 'fish_sea_bream', 'fish_bluefish', 'fish_sea_bass',
        'fish_gilthead', 'fish_goby', 'fish_turbot', 'fish_bonito', 'fish_mackerel',
        'fish_grey_mullet', 'fish_red_mullet', 'fish_garfish', 'fish_anchovy',
        'fish_shad', 'fish_wrasse'
    },
    ocean = {
        'fish_yellowfin_tuna', 'fish_bluefin_tuna', 'fish_swordfish', 'fish_blue_marlin',
        'fish_black_marlin', 'fish_mahi_mahi', 'fish_wahoo', 'fish_cod', 'fish_halibut',
        'fish_grouper', 'fish_barracuda', 'fish_red_snapper', 'fish_tarpon',
        'fish_flounder', 'fish_shark'
    }
}

-- Get category name in Bulgarian
local function GetCategoryName(category)
    return _('fish_category_' .. category)
end

-- Server event for selling fish by category
RegisterNetEvent('fishing:sellFish', function(category)
    local source = source
    
    -- print("^3[FishBuyer] Player " .. source .. " attempting to sell " .. category .. " fish^7")
    
    local totalMoney = 0
    local totalFishSold = 0
    local fishSoldDetails = {}
    
    -- Determine which fish to sell
    local fishToSell = {}
    if category == 'all' then
        -- Sell all fish
        for fishItem, _ in pairs(Config.FishPrices) do
            table.insert(fishToSell, fishItem)
        end
    else
        -- Sell specific category
        fishToSell = FishCategories[category] or {}
    end
    
    -- Loop through fish to sell
    for _, fishItem in ipairs(fishToSell) do
        local price = Config.FishPrices[fishItem]
        
        if price then
            -- Check if player has this fish
            local fishCount = exports.ox_inventory:Search(source, 'count', fishItem)
            
            if fishCount and fishCount > 0 then
                -- Remove fish from inventory
                local removed = exports.ox_inventory:RemoveItem(source, fishItem, fishCount)
                
                if removed then
                    local itemTotal = fishCount * price
                    totalMoney = totalMoney + itemTotal
                    totalFishSold = totalFishSold + fishCount
                    
                    -- Store details for logging
                    table.insert(fishSoldDetails, {
                        item = fishItem,
                        count = fishCount,
                        price = price,
                        total = itemTotal
                    })
                    
                    -- print(string.format("^2[FishBuyer] Sold %dx %s for $%d (total: $%d)^7", 
                    --     fishCount, fishItem, price, itemTotal))
                end
            end
        end
    end
    
    if totalFishSold > 0 then
        -- Add money to player (using ox_inventory money system)
        local moneyAdded = exports.ox_inventory:AddItem(source, 'money', totalMoney)
        
        if moneyAdded then
            -- Send success notification
            TriggerClientEvent('ox_lib:notify', source, {
                title = _('notification_title_sale'),
                description = _('sell_success', totalFishSold, GetCategoryName(category), totalMoney),
                type = 'success',
                duration = 10000
            })
            
            -- print(string.format("^2[FishBuyer] Player %d sold %d %s fish for total $%d^7", 
            --     source, totalFishSold, category, totalMoney))
        else
            -- Failed to add money - give fish back
            for _, fishData in ipairs(fishSoldDetails) do
                exports.ox_inventory:AddItem(source, fishData.item, fishData.count)
            end
            
            TriggerClientEvent('ox_lib:notify', source, {
                title = _('notification_title_error'),
                description = _('money_error'),
                type = 'error',
                duration = 10000
            })
            
            -- print("^1[FishBuyer] Failed to add money to player " .. source .. "^7")
        end
    else
        -- No fish to sell
        TriggerClientEvent('ox_lib:notify', source, {
            title = _('notification_title_no_fish'),
            description = _('no_fish_to_sell', GetCategoryName(category)),
            type = 'error',
            duration = 10000
        })
        
        -- print("^1[FishBuyer] Player " .. source .. " has no " .. category .. " fish to sell^7")
    end
end)

-- Server event for buying items
RegisterNetEvent('fishing:buyItem', function(item, price, quantity)
    local source = source
    quantity = quantity or 1
    
    -- Validate quantity
    if quantity < 1 or quantity > 100 then
        TriggerClientEvent('ox_lib:notify', source, {
            title = _('notification_title_error'),
            description = _('invalid_quantity'),
            type = 'error',
            duration = 10000
        })
        return
    end
    
    local totalPrice = price * quantity
    
    -- print(string.format("^3[FishBuyer] Player %d attempting to buy %dx %s for $%d^7", source, quantity, item, totalPrice))
    
    -- Check if player has enough money
    local playerMoney = exports.ox_inventory:Search(source, 'count', 'money')
    
    if playerMoney and playerMoney >= totalPrice then
        -- Remove money
        local moneyRemoved = exports.ox_inventory:RemoveItem(source, 'money', totalPrice)
        
        if moneyRemoved then
            -- Add items
            local itemAdded = exports.ox_inventory:AddItem(source, item, quantity)
            
            if itemAdded then
                -- Success
                TriggerClientEvent('ox_lib:notify', source, {
                    title = _('notification_title_purchase'),
                    description = _('purchase_success', quantity, item, totalPrice),
                    type = 'success',
                    duration = 10000
                })
                
                -- print(string.format("^2[FishBuyer] Player %d bought %dx %s for $%d^7", source, quantity, item, totalPrice))
            else
                -- Failed to add items - refund money
                exports.ox_inventory:AddItem(source, 'money', totalPrice)
                
                TriggerClientEvent('ox_lib:notify', source, {
                    title = _('notification_title_error'),
                    description = _('inventory_full_purchase'),
                    type = 'error',
                    duration = 10000
                })
                
                -- print(string.format("^1[FishBuyer] Failed to add items to player %d - inventory full^7", source))
            end
        else
            TriggerClientEvent('ox_lib:notify', source, {
                title = _('notification_title_error'),
                description = _('payment_error'),
                type = 'error',
                duration = 10000
            })
        end
    else
        -- Not enough money
        TriggerClientEvent('ox_lib:notify', source, {
            title = _('notification_title_error'),
            description = _('not_enough_money', totalPrice, playerMoney or 0),
            type = 'error',
            duration = 10000
        })
        
        -- print(string.format("^1[FishBuyer] Player %d doesn't have enough money (has $%d, needs $%d)^7", 
        --     source, playerMoney or 0, totalPrice))
    end
end)
