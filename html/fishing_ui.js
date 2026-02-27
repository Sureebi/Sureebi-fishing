let currentTab = 'dashboard';
let currentLeaderboard = 'total';

// Helper to get resource name
function GetParentResourceName() {
    // Try hostname first and remove cfx-nui- prefix
    if (window.location.hostname && window.location.hostname !== '') {
        const hostname = window.location.hostname;
        if (hostname.startsWith('cfx-nui-')) {
            return hostname.replace('cfx-nui-', '');
        }
        return hostname;
    }
    // Fallback - this should match your actual resource folder name
    return 'tmw_fishing';
}

// Tab switching
document.querySelectorAll('.tab-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        const tab = btn.dataset.tab;
        switchTab(tab);
    });
});

function switchTab(tab) {
    currentTab = tab;
    
    // Update buttons
    document.querySelectorAll('.tab-btn').forEach(btn => {
        btn.classList.toggle('active', btn.dataset.tab === tab);
    });
    
    // Update panes
    document.querySelectorAll('.tab-pane').forEach(pane => {
        pane.classList.remove('active');
    });
    document.getElementById(`${tab}-tab`).classList.add('active');
    
    // Load data for tab
    loadTabData(tab);
}

// Leaderboard switching
document.querySelectorAll('.lb-btn').forEach(btn => {
    btn.addEventListener('click', () => {
        const lb = btn.dataset.lb;
        switchLeaderboard(lb);
    });
});

function switchLeaderboard(lb) {
    currentLeaderboard = lb;
    
    document.querySelectorAll('.lb-btn').forEach(btn => {
        btn.classList.toggle('active', btn.dataset.lb === lb);
    });
    
    loadLeaderboard(lb);
}

// Load tab data
function loadTabData(tab) {
    switch(tab) {
        case 'dashboard':
            loadDashboard();
            break;
        case 'shop':
            loadShop();
            break;
        case 'stats':
            loadStats();
            break;
        case 'leaderboard':
            loadLeaderboard(currentLeaderboard);
            break;
        case 'collection':
            loadCollection();
            break;
    }
}

// Load dashboard
async function loadDashboard() {
    try {
        const stats = await fetch(`https://${GetParentResourceName()}/getPlayerStats`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        }).then(r => r.text()).then(text => text ? JSON.parse(text) : {}).catch(() => ({}));
        
        if (stats && Object.keys(stats).length > 0) {
            document.getElementById('total-catches').textContent = stats.total_catches || 0;
            document.getElementById('total-weight').textContent = ((stats.total_weight || 0) / 1000).toFixed(2) + ' кг';
            document.getElementById('biggest-fish').textContent = stats.biggest_fish_name || '-';
            document.getElementById('longest-fish').textContent = (stats.longest_fish_length || 0).toFixed(1) + ' см';
        }
        
        const recentCatches = await fetch(`https://${GetParentResourceName()}/getRecentCatches`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        }).then(r => r.text()).then(text => text ? JSON.parse(text) : []).catch(() => []);
        
        const list = document.getElementById('recent-catches-list');
        list.innerHTML = '';
        
        if (recentCatches && recentCatches.length > 0) {
            recentCatches.forEach(c => {
                const item = document.createElement('div');
                item.className = 'catch-item';
                item.innerHTML = `
                    <div class="catch-info">
                        <div class="catch-name">${c.fish_name}</div>
                        <div class="catch-details">${(c.weight / 1000).toFixed(2)} кг • ${c.length.toFixed(1)} см • ${c.location}</div>
                    </div>
                    <div class="catch-rarity" style="color: ${getRarityColor(c.rarity)}">${c.rarity}</div>
                `;
                list.appendChild(item);
            });
        } else {
            list.innerHTML = '<div style="color: #8b8b8b; text-align: center; padding: 20px;">Все още нямаш улови</div>';
        }
    } catch (error) {
        console.error('Error loading dashboard:', error);
    }
}

// Load shop
async function loadShop() {
    const shopItems = [
        { name: 'Въдица', price: 500, item: 'fishingrod', image: 'nui://ox_inventory/web/images/fishingrod.png' },
        { name: 'Червеи', price: 15, item: 'bait_earthworm', image: 'nui://ox_inventory/web/images/bait_earthworm.png' },
        { name: 'Хляб', price: 15, item: 'bait_bread', image: 'nui://ox_inventory/web/images/bait_bread.png' },
        { name: 'Блесна', price: 20, item: 'bait_spinner', image: 'nui://ox_inventory/web/images/bait_spinner.png' },
        { name: 'Царевица', price: 20, item: 'bait_corn', image: 'nui://ox_inventory/web/images/bait_corn.png' },
        { name: 'Боили', price: 25, item: 'bait_boilie', image: 'nui://ox_inventory/web/images/bait_boilie.png' },
        { name: 'Силиконова примамка', price: 30, item: 'bait_silicone', image: 'nui://ox_inventory/web/images/bait_silicone.png' },
        { name: 'Морски червеи', price: 30, item: 'bait_seaworm', image: 'nui://ox_inventory/web/images/bait_seaworm.png' },
        { name: 'Скариди', price: 35, item: 'bait_shrimp', image: 'nui://ox_inventory/web/images/bait_shrimp.png' },
        { name: 'Калмари', price: 40, item: 'bait_squid', image: 'nui://ox_inventory/web/images/bait_squid.png' },
        { name: 'Метален джиг', price: 50, item: 'bait_metal_jig', image: 'nui://ox_inventory/web/images/bait_metal_jig.png' },
        { name: 'Тролингова примамка', price: 100, item: 'bait_trolling_lure', image: 'nui://ox_inventory/web/images/bait_trolling_lure.png' }
    ];
    
    const grid = document.getElementById('shop-items');
    grid.innerHTML = '';
    
    shopItems.forEach(item => {
        const div = document.createElement('div');
        div.className = 'shop-item';
        div.innerHTML = `
            <img src="${item.image}" class="shop-item-image" onerror="this.style.display='none'">
            <div class="shop-item-name">${item.name}</div>
            <div class="shop-item-price">${item.price} лв</div>
        `;
        div.onclick = () => buyItem(item.item, item.price);
        grid.appendChild(div);
    });
}

// Load stats
async function loadStats() {
    try {
        const categoryStats = await fetch(`https://${GetParentResourceName()}/getCategoryStats`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        }).then(r => r.text()).then(text => text ? JSON.parse(text) : []).catch(() => []);
        
        const container = document.getElementById('category-stats');
        container.innerHTML = '';
        
        const categories = {
            'river': '🏞️ Речни',
            'lake': '🏔️ Езерни/Язовирни',
            'sea': '🌊 Морски',
            'ocean': '🌊 Океански'
        };
        
        if (categoryStats && categoryStats.length > 0) {
            categoryStats.forEach(cat => {
                const card = document.createElement('div');
                card.className = 'category-card';
                card.innerHTML = `
                    <h4>${categories[cat.category] || cat.category}</h4>
                    <div class="category-stat">
                        <span class="category-stat-label">Общо улови:</span>
                        <span class="category-stat-value">${cat.total_catches || 0}</span>
                    </div>
                    <div class="category-stat">
                        <span class="category-stat-label">Общо тегло:</span>
                        <span class="category-stat-value">${((cat.total_weight || 0) / 1000).toFixed(2)} кг</span>
                    </div>
                    <div class="category-stat">
                        <span class="category-stat-label">Най-голяма риба:</span>
                        <span class="category-stat-value">${((cat.biggest_fish_weight || 0) / 1000).toFixed(2)} кг</span>
                    </div>
                `;
                container.appendChild(card);
            });
        } else {
            container.innerHTML = '<div style="color: #8b8b8b; text-align: center; padding: 40px; grid-column: 1/-1;">Все още нямаш статистики по категории</div>';
        }
    } catch (error) {
        console.error('Error loading stats:', error);
    }
}

// Load leaderboard
async function loadLeaderboard(type) {
    try {
        let data;
        const content = document.getElementById('leaderboard-content');
        
        if (type === 'total') {
            data = await fetch(`https://${GetParentResourceName()}/getLeaderboardTotal`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            }).then(r => r.text()).then(text => text ? JSON.parse(text) : []).catch(() => []);
            
            content.innerHTML = '';
            if (data && data.length > 0) {
                data.forEach((player, index) => {
                    const item = document.createElement('div');
                    item.className = 'leaderboard-item';
                    item.innerHTML = `
                        <div class="lb-rank">#${index + 1}</div>
                        <div class="lb-info">
                            <div class="lb-name">${player.player_name || 'Unknown'}</div>
                            <div class="lb-details">Улови: ${player.total_catches} • Тегло: ${(player.total_weight / 1000).toFixed(2)} кг</div>
                        </div>
                    `;
                    content.appendChild(item);
                });
            } else {
                content.innerHTML = '<div style="color: #8b8b8b; text-align: center; padding: 40px;">Все още няма данни</div>';
            }
        } else if (type === 'biggest') {
            data = await fetch(`https://${GetParentResourceName()}/getLeaderboardBiggest`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            }).then(r => r.text()).then(text => text ? JSON.parse(text) : []).catch(() => []);
            
            content.innerHTML = '';
            if (data && data.length > 0) {
                data.forEach((player, index) => {
                    const item = document.createElement('div');
                    item.className = 'leaderboard-item';
                    item.innerHTML = `
                        <div class="lb-rank">#${index + 1}</div>
                        <div class="lb-info">
                            <div class="lb-name">${player.player_name || 'Unknown'}</div>
                            <div class="lb-details">${player.biggest_fish_name} • ${(player.biggest_fish_weight / 1000).toFixed(2)} кг • ${player.biggest_fish_length.toFixed(1)} см</div>
                        </div>
                    `;
                    content.appendChild(item);
                });
            } else {
                content.innerHTML = '<div style="color: #8b8b8b; text-align: center; padding: 40px;">Все още няма данни</div>';
            }
        } else if (type === 'records') {
            data = await fetch(`https://${GetParentResourceName()}/getWorldRecords`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            }).then(r => r.text()).then(text => text ? JSON.parse(text) : []).catch(() => []);
            
            content.innerHTML = '';
            if (data && data.length > 0) {
                data.forEach((record, index) => {
                    const item = document.createElement('div');
                    item.className = 'leaderboard-item';
                    item.innerHTML = `
                        <div class="lb-rank">🏆</div>
                        <div class="lb-info">
                            <div class="lb-name">${record.fish_name}</div>
                            <div class="lb-details">${record.player_name || 'Unknown'} • ${(record.weight / 1000).toFixed(2)} кг • ${record.length.toFixed(1)} см</div>
                        </div>
                    `;
                    content.appendChild(item);
                });
            } else {
                content.innerHTML = '<div style="color: #8b8b8b; text-align: center; padding: 40px;">Все още няма световни рекорди</div>';
            }
        }
    } catch (error) {
        console.error('Error loading leaderboard:', error);
    }
}

// Load collection
async function loadCollection() {
    try {
        const collection = await fetch(`https://${GetParentResourceName()}/getFishCollection`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        }).then(r => r.text()).then(text => text ? JSON.parse(text) : []).catch(() => []);
        
        const grid = document.getElementById('fish-collection');
        grid.innerHTML = '';
        
        if (collection && collection.length > 0) {
            collection.forEach(fish => {
                const item = document.createElement('div');
                item.className = 'collection-item';
                const fishImage = `nui://ox_inventory/web/images/${fish.fish_name}.png`;
                item.innerHTML = `
                    <img src="${fishImage}" class="collection-fish-image" onerror="this.style.display='none'">
                    <div class="collection-fish-name">${fish.fish_name}</div>
                    <div class="collection-stat">
                        <span class="collection-stat-label">Най-голяма:</span>
                        <span class="collection-stat-value">${(fish.max_weight / 1000).toFixed(2)} кг</span>
                    </div>
                    <div class="collection-stat">
                        <span class="collection-stat-label">Най-дълга:</span>
                        <span class="collection-stat-value">${fish.max_length.toFixed(1)} см</span>
                    </div>
                    <div class="collection-stat">
                        <span class="collection-stat-label">Хванати:</span>
                        <span class="collection-stat-value">${fish.times_caught}x</span>
                    </div>
                `;
                grid.appendChild(item);
            });
        } else {
            grid.innerHTML = '<div style="color: #8b8b8b; text-align: center; padding: 40px; grid-column: 1/-1;">Все още нямаш колекция от риби</div>';
        }
    } catch (error) {
        console.error('Error loading collection:', error);
    }
}

// Buy item
function buyItem(item, price) {
    fetch(`https://${GetParentResourceName()}/buyItem`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ item, price })
    });
}

// Sell fish
function sellFish(category) {
    fetch(`https://${GetParentResourceName()}/sellFish`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ category })
    });
}

// Global flag to track if we requested close
let closeRequested = false;

// Close UI - called from button click
function closeUI() {
    // console.log('=== CLOSING UI ===');
    
    // Set flag
    closeRequested = true;
    
    // Hide UI immediately
    const container = document.getElementById('fishing-container');
    container.classList.add('hidden');
    // console.log('UI hidden, closeRequested = true');
    
    // Try to notify Lua (even though it doesn't work, keep trying)
    fetch(`https://${GetParentResourceName()}/closeUI`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ closeRequested: true })
    }).catch(() => {});
}

// Expose function for Lua to check
window.isUIHidden = function() {
    const container = document.getElementById('fishing-container');
    return container && container.classList.contains('hidden');
};

// Expose function for Lua to check close request
window.wasCloseRequested = function() {
    const result = closeRequested;
    closeRequested = false; // Reset after check
    return result;
};

// Get rarity color
function getRarityColor(rarity) {
    const colors = {
        'Common': '#9ca3af',
        'Uncommon': '#4ade80',
        'Rare': '#3b82f6',
        'Epic': '#a855f7'
    };
    return colors[rarity] || '#9ca3af';
}

// NUI Messages
window.addEventListener('message', (event) => {
    const data = event.data;
    
    if (data.action === 'openUI') {
        document.getElementById('fishing-container').classList.remove('hidden');
        switchTab('dashboard');
    } else if (data.action === 'closeUI') {
        document.getElementById('fishing-container').classList.add('hidden');
        // console.log('UI hidden by Lua');
    } else if (data.action === 'forceClose') {
        // Force close from Lua
        document.getElementById('fishing-container').classList.add('hidden');
        // console.log('Force closed by Lua');
    }
});

// Listen for our own close event to notify Lua
window.addEventListener('nuiCloseUI', () => {
    // console.log('Custom close event received');
});

// ESC to close - pass through to Lua
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape' || e.keyCode === 27) {
        e.preventDefault();
        e.stopPropagation();
        // console.log('ESC intercepted - calling closeUI()');
        closeUI();
    }
});
