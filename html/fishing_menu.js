// console.log('===== FISHING MENU JS LOADED =====');

// Helper function to get resource name
function GetParentResourceName() {
    // Try to get from window location hostname
    if (window.location.hostname && window.location.hostname !== '') {
        // Remove cfx-nui- prefix if present
        const hostname = window.location.hostname;
        if (hostname.startsWith('cfx-nui-')) {
            const resourceName = hostname.replace('cfx-nui-', '');
            // console.log('Resource name from hostname:', resourceName);
            return resourceName;
        }
        // console.log('Resource name from hostname:', hostname);
        return hostname;
    }
    
    // Try to get from window location URL
    if (window.location.href.includes('://nui_')) {
        const parts = window.location.href.split('/');
        for (let i = 0; i < parts.length; i++) {
            if (parts[i].includes('nui_')) {
                const resourceName = parts[i].replace('nui_', '');
                // console.log('Resource name from URL:', resourceName);
                return resourceName;
            }
        }
    }
    
    // Fallback - this should match your actual resource folder name
    // console.log('Resource name fallback: tmw_fishing');
    return 'tmw_fishing';
}

// Helper function to convert fish_name to readable label
function getFishLabel(fishName) {
    if (!fishName) return '-';
    
    // Remove 'fish_' prefix and convert underscores to spaces
    let label = fishName.replace('fish_', '').replace(/_/g, ' ');
    
    // Capitalize first letter of each word
    label = label.split(' ').map(word => word.charAt(0).toUpperCase() + word.slice(1)).join(' ');
    
    return label;
}

// console.log('Resource name:', GetParentResourceName());

let currentTab = 'dashboard';
let currentLeaderboard = 'total';

function switchTab(tab) {
    currentTab = tab;
    
    // Update nav buttons
    document.querySelectorAll('.nav-btn').forEach(btn => {
        btn.classList.toggle('active', btn.dataset.tab === tab);
    });
    
    // Update tab content
    document.querySelectorAll('.tab-content').forEach(content => {
        content.classList.remove('active');
    });
    document.getElementById(`tab-${tab}`).classList.add('active');
    
    // Update page title
    const titles = {
        dashboard: 'Начало',
        shop: 'Магазин',
        sell: 'Продажба на риби',
        stats: 'Статистики',
        leaderboard: 'Класации'
    };
    document.getElementById('pageTitle').textContent = titles[tab] || tab;
    
    // Load data
    loadTabData(tab);
}

function switchLeaderboard(lb) {
    currentLeaderboard = lb;
    
    document.querySelectorAll('.lb-tab').forEach(btn => {
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
    }
}

// Load dashboard
async function loadDashboard() {
    try {
        const stats = await fetch(`https://${GetParentResourceName()}/getPlayerStats`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        }).then(r => r.json()).catch(() => ({}));
        
        if (stats && Object.keys(stats).length > 0) {
            document.getElementById('totalCatches').textContent = stats.total_fish_caught || 0;
            
            // Format weight: remove trailing zeros after decimal point
            const totalWeightKg = (stats.total_weight || 0) / 1000;
            document.getElementById('totalWeight').textContent = totalWeightKg.toFixed(3).replace(/\.?0+$/, '') + ' кг';
            
            const biggestFishLabel = getFishLabel(stats.biggest_fish_type);
            document.getElementById('biggestFish').textContent = biggestFishLabel || '-';
            
            // Handle both old (multiplied) and new (direct) length values
            const rawLongestLength = stats.longest_fish_length || 0;
            const longestLengthInMeters = rawLongestLength > 1000 ? rawLongestLength / 10000 : rawLongestLength / 100;
            document.getElementById('longestFish').textContent = longestLengthInMeters.toFixed(3).replace(/\.?0+$/, '') + ' м';
            
            // Update sidebar
            document.getElementById('sidebarCatches').textContent = stats.total_fish_caught || 0;
            document.getElementById('sidebarWeight').textContent = totalWeightKg.toFixed(3).replace(/\.?0+$/, '') + ' кг';
        }
        
        const recentCatches = await fetch(`https://${GetParentResourceName()}/getRecentCatches`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        }).then(r => r.json()).catch(() => []);
        
        const list = document.getElementById('recentList');
        list.innerHTML = '';
        
        if (recentCatches && recentCatches.length > 0) {
            recentCatches.forEach(c => {
                const item = document.createElement('div');
                item.className = 'recent-item';
                const fishLabel = getFishLabel(c.fish_type);
                
                // Handle both old (multiplied) and new (direct) length values
                const rawLength = c.fish_length || 0;
                const lengthInMeters = rawLength > 1000 ? rawLength / 10000 : rawLength / 100;
                const weightKg = (c.fish_weight || 0) / 1000;
                
                item.innerHTML = `
                    <div class="recent-info">
                        <div class="recent-name">${fishLabel}</div>
                        <div class="recent-details">${weightKg.toFixed(3).replace(/\.?0+$/, '')} кг • ${lengthInMeters.toFixed(3).replace(/\.?0+$/, '')} м • ${c.location}</div>
                    </div>
                `;
                list.appendChild(item);
            });
        } else {
            list.innerHTML = '<div style="color: #a0a0a0; text-align: center; padding: 20px;">Все още нямаш улови</div>';
        }
    } catch (error) {
        console.error('Error loading dashboard:', error);
    }
}

// Load shop
async function loadShop() {
    const shopItems = {
        equipment: [
            { name: 'Въдица', price: 350, item: 'fishingrod', image: 'nui://ox_inventory/web/images/fishingrod.png', desc: 'Основен инструмент за риболов' }
        ],
        river: [
            { name: 'Червеи', price: 2, item: 'bait_earthworm', image: 'nui://ox_inventory/web/images/bait_earthworm.png', desc: 'За реки и канали' },
            { name: 'Хляб', price: 1, item: 'bait_bread', image: 'nui://ox_inventory/web/images/bait_bread.png', desc: 'За реки и канали' },
            { name: 'Блесна', price: 15, item: 'bait_spinner', image: 'nui://ox_inventory/web/images/bait_spinner.png', desc: 'За реки и канали' }
        ],
        lake: [
            { name: 'Царевица', price: 2, item: 'bait_corn', image: 'nui://ox_inventory/web/images/bait_corn.png', desc: 'За езера и язовири' },
            { name: 'Боили', price: 12, item: 'bait_boilie', image: 'nui://ox_inventory/web/images/bait_boilie.png', desc: 'За езера и язовири' },
            { name: 'Силиконова примамка', price: 18, item: 'bait_silicone', image: 'nui://ox_inventory/web/images/bait_silicone.png', desc: 'За езера и язовири' }
        ],
        ocean: [
            { name: 'Морски червеи', price: 4, item: 'bait_seaworm', image: 'nui://ox_inventory/web/images/bait_seaworm.png', desc: 'За океан и морета' },
            { name: 'Скариди', price: 5, item: 'bait_shrimp', image: 'nui://ox_inventory/web/images/bait_shrimp.png', desc: 'За океан и морета' },
            { name: 'Калмари', price: 14, item: 'bait_squid', image: 'nui://ox_inventory/web/images/bait_squid.png', desc: 'За океан и морета' },
            { name: 'Метален джиг', price: 15, item: 'bait_metal_jig', image: 'nui://ox_inventory/web/images/bait_metal_jig.png', desc: 'За океан и морета' },
            { name: 'Тролингова примамка', price: 24, item: 'bait_trolling_lure', image: 'nui://ox_inventory/web/images/bait_trolling_lure.png', desc: 'За океан и морета' }
        ]
    };
    
    const grid = document.getElementById('shopGrid');
    grid.innerHTML = '';
    
    // Equipment section
    const equipmentSection = document.createElement('div');
    equipmentSection.className = 'shop-section';
    equipmentSection.innerHTML = '<h3 class="shop-section-title">🎣 Екипировка</h3><div class="shop-section-grid"></div>';
    grid.appendChild(equipmentSection);
    
    const equipmentGrid = equipmentSection.querySelector('.shop-section-grid');
    shopItems.equipment.forEach(item => {
        const div = createShopItem(item);
        equipmentGrid.appendChild(div);
    });
    
    // River baits section
    const riverSection = document.createElement('div');
    riverSection.className = 'shop-section';
    riverSection.innerHTML = '<h3 class="shop-section-title">🏞️ Примамки за реки и канали</h3><div class="shop-section-grid"></div>';
    grid.appendChild(riverSection);
    
    const riverGrid = riverSection.querySelector('.shop-section-grid');
    shopItems.river.forEach(item => {
        const div = createShopItem(item);
        riverGrid.appendChild(div);
    });
    
    // Lake baits section
    const lakeSection = document.createElement('div');
    lakeSection.className = 'shop-section';
    lakeSection.innerHTML = '<h3 class="shop-section-title">🏔️ Примамки за езера и язовири</h3><div class="shop-section-grid"></div>';
    grid.appendChild(lakeSection);
    
    const lakeGrid = lakeSection.querySelector('.shop-section-grid');
    shopItems.lake.forEach(item => {
        const div = createShopItem(item);
        lakeGrid.appendChild(div);
    });
    
    // Ocean baits section
    const oceanSection = document.createElement('div');
    oceanSection.className = 'shop-section';
    oceanSection.innerHTML = '<h3 class="shop-section-title">🌊 Примамки за океан и морета</h3><div class="shop-section-grid"></div>';
    grid.appendChild(oceanSection);
    
    const oceanGrid = oceanSection.querySelector('.shop-section-grid');
    shopItems.ocean.forEach(item => {
        const div = createShopItem(item);
        oceanGrid.appendChild(div);
    });
}

// Helper function to create shop item element
function createShopItem(item) {
    const div = document.createElement('div');
    div.className = 'shop-item';
    div.innerHTML = `
        <img src="${item.image}" class="shop-item-img" onerror="this.style.display='none'">
        <div class="shop-item-name">${item.name}</div>
        <div class="shop-item-price">${item.price} лв</div>
        <div class="shop-item-tooltip">${item.desc}</div>
    `;
    div.onclick = () => buyItem(item.item, item.price, item.name);
    return div;
}

// Load stats
async function loadStats() {
    try {
        const categoryStats = await fetch(`https://${GetParentResourceName()}/getCategoryStats`, {
            method: 'POST',
            headers: { 'Content-Type': 'application/json' },
            body: JSON.stringify({})
        }).then(r => r.json()).catch(() => []);
        
        const container = document.getElementById('categoryStats');
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
                const totalWeightKg = (cat.total_weight || 0) / 1000;
                const biggestWeightKg = (cat.biggest_fish_weight || 0) / 1000;
                card.innerHTML = `
                    <h4>${categories[cat.category] || cat.category}</h4>
                    <div class="category-stat">
                        <span class="category-stat-label">Общо улови:</span>
                        <span class="category-stat-value">${cat.total_catches || 0}</span>
                    </div>
                    <div class="category-stat">
                        <span class="category-stat-label">Общо тегло:</span>
                        <span class="category-stat-value">${totalWeightKg.toFixed(3).replace(/\.?0+$/, '')} кг</span>
                    </div>
                    <div class="category-stat">
                        <span class="category-stat-label">Най-голяма риба:</span>
                        <span class="category-stat-value">${biggestWeightKg.toFixed(3).replace(/\.?0+$/, '')} кг</span>
                    </div>
                `;
                container.appendChild(card);
            });
        } else {
            container.innerHTML = '<div style="color: #a0a0a0; text-align: center; padding: 40px;">Все още нямаш статистики</div>';
        }
    } catch (error) {
        console.error('Error loading stats:', error);
    }
}

// Load leaderboard
async function loadLeaderboard(type) {
    try {
        let data;
        const content = document.getElementById('lbContent');
        
        if (type === 'total') {
            data = await fetch(`https://${GetParentResourceName()}/getLeaderboardTotal`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            }).then(r => r.json()).catch(() => []);
            
            content.innerHTML = '';
            if (data && data.length > 0) {
                data.forEach((player, index) => {
                    const item = document.createElement('div');
                    item.className = 'lb-item';
                    const totalWeightKg = (player.total_weight || 0) / 1000;
                    item.innerHTML = `
                        <div class="lb-rank">#${index + 1}</div>
                        <div class="lb-info">
                            <div class="lb-name">${player.player_name || 'Unknown'}</div>
                            <div class="lb-details">Улови: ${player.total_catches} • Тегло: ${totalWeightKg.toFixed(3).replace(/\.?0+$/, '')} кг</div>
                        </div>
                    `;
                    content.appendChild(item);
                });
            } else {
                content.innerHTML = '<div style="color: #a0a0a0; text-align: center; padding: 40px;">Все още няма данни</div>';
            }
        } else if (type === 'biggest') {
            data = await fetch(`https://${GetParentResourceName()}/getLeaderboardBiggest`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            }).then(r => r.json()).catch(() => []);
            
            content.innerHTML = '';
            if (data && data.length > 0) {
                data.forEach((player, index) => {
                    const item = document.createElement('div');
                    item.className = 'lb-item';
                    const fishLabel = getFishLabel(player.biggest_fish_name);
                    // Handle both old (multiplied) and new (direct) length values
                    const rawLength = player.biggest_fish_length || 0;
                    const lengthInMeters = rawLength > 1000 ? rawLength / 10000 : rawLength / 100;
                    const weightKg = (player.biggest_fish_weight || 0) / 1000;
                    
                    item.innerHTML = `
                        <div class="lb-rank">#${index + 1}</div>
                        <div class="lb-info">
                            <div class="lb-name">${player.player_name || 'Unknown'}</div>
                            <div class="lb-details">${fishLabel} • ${weightKg.toFixed(3).replace(/\.?0+$/, '')} кг • ${lengthInMeters.toFixed(3).replace(/\.?0+$/, '')} м</div>
                        </div>
                    `;
                    content.appendChild(item);
                });
            } else {
                content.innerHTML = '<div style="color: #a0a0a0; text-align: center; padding: 40px;">Все още няма данни</div>';
            }
        } else if (type === 'records') {
            data = await fetch(`https://${GetParentResourceName()}/getWorldRecords`, {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({})
            }).then(r => r.json()).catch(() => []);
            
            content.innerHTML = '';
            if (data && data.length > 0) {
                data.forEach((record) => {
                    const item = document.createElement('div');
                    item.className = 'lb-item';
                    const fishLabel = getFishLabel(record.fish_name);
                    
                    // Handle both old (multiplied) and new (direct) length values
                    const rawLength = record.length || 0;
                    const lengthInMeters = rawLength > 1000 ? rawLength / 10000 : rawLength / 100;
                    const weightKg = (record.weight || 0) / 1000;
                    
                    item.innerHTML = `
                        <div class="lb-rank">🏆</div>
                        <div class="lb-info">
                            <div class="lb-name">${record.player_name || 'Unknown'}</div>
                            <div class="lb-details">${fishLabel} • ${weightKg.toFixed(3).replace(/\.?0+$/, '')} кг • ${lengthInMeters.toFixed(3).replace(/\.?0+$/, '')} м</div>
                        </div>
                    `;
                    content.appendChild(item);
                });
            } else {
                content.innerHTML = '<div style="color: #a0a0a0; text-align: center; padding: 40px;">Все още няма рекорди</div>';
            }
        }
    } catch (error) {
        console.error('Error loading leaderboard:', error);
    }
}

// Buy item - show modal
let currentBuyItem = null;

function buyItem(item, price, name) {
    currentBuyItem = { item, price, name };
    
    // Set modal content
    document.getElementById('modal-item-name').textContent = name;
    document.getElementById('modal-item-price').textContent = price + ' лв/бр';
    document.getElementById('modal-item-img').src = `nui://ox_inventory/web/images/${item}.png`;
    document.getElementById('quantity-input').value = 1;
    
    // Calculate total
    updateModalTotal();
    
    // Show modal
    document.getElementById('buy-modal').classList.remove('hidden');
}

function updateModalTotal() {
    if (!currentBuyItem) return;
    
    const quantity = parseInt(document.getElementById('quantity-input').value) || 1;
    const total = currentBuyItem.price * quantity;
    
    document.getElementById('modal-total-price').textContent = total + ' лв';
}

function closeBuyModal() {
    document.getElementById('buy-modal').classList.add('hidden');
    currentBuyItem = null;
}

function confirmPurchase() {
    if (!currentBuyItem) return;
    
    const quantity = parseInt(document.getElementById('quantity-input').value) || 1;
    
    if (quantity < 1 || quantity > 100) {
        alert('Количеството трябва да е между 1 и 100!');
        return;
    }
    
    // Send purchase request
    fetch(`https://${GetParentResourceName()}/buyItem`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({
            item: currentBuyItem.item,
            price: currentBuyItem.price,
            quantity: quantity
        })
    });
    
    // Close modal
    closeBuyModal();
}

// Initialize when DOM is ready
document.addEventListener('DOMContentLoaded', () => {
    // console.log('=== FISHING MENU: DOM Ready ===');
    
    // Quantity input listener
    const quantityInput = document.getElementById('quantity-input');
    if (quantityInput) {
        quantityInput.addEventListener('input', updateModalTotal);
    }
    
    // Close button listener
    const closeBtn = document.getElementById('closeBtn');
    if (closeBtn) {
        closeBtn.addEventListener('click', () => {
            const container = document.getElementById('container');
            container.classList.add('hidden');
            
            fetch(`https://${GetParentResourceName()}/closeUI`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({})
            });
        });
    }
    
    // Tab switching
    document.querySelectorAll('.nav-btn').forEach(btn => {
        btn.addEventListener('click', () => {
            const tab = btn.dataset.tab;
            switchTab(tab);
        });
    });
    
    // Leaderboard tabs
    document.querySelectorAll('.lb-tab').forEach(btn => {
        btn.addEventListener('click', () => {
            const lb = btn.dataset.lb;
            switchLeaderboard(lb);
        });
    });
});

// Sell fish
function sellFish(category) {
    fetch(`https://${GetParentResourceName()}/sellFish`, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify({ category })
    });
}

function closeMenu() {
    const container = document.getElementById('container');
    container.classList.add('hidden');
    
    fetch(`https://${GetParentResourceName()}/closeUI`, {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: JSON.stringify({})
    });
}

// NUI Messages
window.addEventListener('message', (event) => {
    const data = event.data;
    
    // console.log('=== FISHING MENU: Message received ===', data);
    
    if (data.action === 'openUI') {
        // console.log('=== FISHING MENU: Opening UI ===');
        document.getElementById('container').classList.remove('hidden');
        switchTab('dashboard');
    } else if (data.action === 'closeUI') {
        // console.log('=== FISHING MENU: Closing UI ===');
        document.getElementById('container').classList.add('hidden');
    }
});

// ESC key
document.addEventListener('keydown', (e) => {
    if (e.key === 'Escape') {
        const container = document.getElementById('container');
        const buyModal = document.getElementById('buy-modal');
        
        // Close modal first if open
        if (buyModal && !buyModal.classList.contains('hidden')) {
            closeBuyModal();
            e.preventDefault();
            return;
        }
        
        // Then close menu if open
        if (!container.classList.contains('hidden')) {
            container.classList.add('hidden');
            
            fetch(`https://${GetParentResourceName()}/closeUI`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({})
            });
            
            e.preventDefault();
        }
    }
});
