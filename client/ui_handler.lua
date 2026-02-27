UIHandler = {}

-- Show notification using oxlib
local function ShowNotification(message, type)
    if lib and lib.notify then
        lib.notify({
            title = _('notification_title_fishing'),
            description = message,
            type = type or 'info',
            duration = 10000
        })
    else
        -- Fallback to native notifications
        SetNotificationTextEntry('STRING')
        AddTextComponentString(message)
        DrawNotification(false, false)
    end
end

-- No water detected
function UIHandler.NoWater()
    ShowNotification(_('no_water'), 'error')
end

-- No fishing rod
function UIHandler.NoFishingRod()
    ShowNotification(_('no_fishing_rod'), 'error')
end

-- Minigame failed
function UIHandler.MinigameFailed()
    ShowNotification(_('minigame_failed'), 'error')
end

-- Inventory full
function UIHandler.InventoryFull()
    ShowNotification(_('inventory_full'), 'error')
end

-- Catch success
function UIHandler.CatchSuccess(itemName, rarity)
    local rarityColors = {
        Common = 'success',
        Uncommon = 'inform',
        Rare = 'warning',
        Epic = 'error',
        Trash = 'info'
    }
    
    local message = _('catch_success', itemName, rarity)
    ShowNotification(message, rarityColors[rarity] or 'success')
end

-- Generic error
function UIHandler.Error(message)
    ShowNotification(message, 'error')
end

-- Generic success
function UIHandler.Success(message)
    ShowNotification(message, 'success')
end

-- Generic info
function UIHandler.Info(message)
    ShowNotification(message, 'info')
end
