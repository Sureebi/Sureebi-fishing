# 🎣 Динамична Риболовна Система

Модерна и реалистична риболовна система за FiveM с поддръжка на множество водоеми, 60 вида риби, 4 минигейма и пълна статистика.

## 📋 Съдържание

- [Характеристики](#характеристики)
- [Зависимости](#зависимости)
- [Инсталация](#инсталация)
- [Предмети](#предмети)
- [Локации](#локации)
- [Конфигурация](#конфигурация)

---

## ✨ Характеристики

### 🌊 Водоеми
- **Реки** - 15 вида речни риби
- **Езера и язовири** - 15 вида езерни риби
- **Морски води** - 15 вида морски риби
- **Океан** - 15 вида океански риби

### 🎮 Минигейми (4 типа)
- **Common** - Прост timing с отблъскване (3 успешни удара)
- **Uncommon** - Последователност от стрелки
- **Rare** - Ритмичен timing (5/7 удара)
- **Epic** - Запомняне на pattern (3x3 grid)

### 📊 Статистика
- Лични статистики (общо уловени, най-голяма риба)
- Световни рекорди по вид риба
- Класации (общо улови, най-голяма риба)
- История на уловите
- Статистики по категории (река, езеро, море, океан)

### 🌍 Локализация
- Български (по подразбиране)
- Английски
- Лесно добавяне на нови езици

---

## 📦 Зависимости

### Задължителни
- [ox_lib](https://github.com/overextended/ox_lib)
- [ox_target](https://github.com/overextended/ox_target)
- [ox_inventory](https://github.com/overextended/ox_inventory)
- OneSync Infinity
- MySQL (oxmysql)

---

## 🔧 Инсталация

### 1. Инсталирай ресурса
```bash
# Копирай папката в resources/
# Добави в server.cfg:
ensure ox_lib
ensure ox_target
ensure ox_inventory
ensure fishing_script  # Името на твоя ресурс
```

### 2. Импортирай базата данни
```sql
-- Изпълни fishing_database.sql в твоята MySQL база
-- Това ще създаде 4 таблици:
-- - fishing_stats (статистики на играчи)
-- - fishing_catches (история на уловите)
-- - fishing_records (световни рекорди)
-- - fishing_category_stats (статистики по категории)
```

### 3. Добави предметите в ox_inventory
Отвори `ox_inventory/data/items.lua` и копирай ВСИЧКИ предмети от `OX_INVENTORY_ITEMS_READY.lua`

### 4. Добави магазина в ox_inventory
Отвори `ox_inventory/data/shops.lua` и копирай магазина от `OX_INVENTORY_SHOPS_READY.lua`

### 5. Рестартирай сървъра
```bash
restart ox_inventory
restart fishing_script
```

---

## 🎒 Предмети

### 🎣 Екипировка
- **fishingrod** - Въдица (500$)

### 🪱 Примамки (11 вида)

#### Речни примамки
- **bait_earthworm** - Земен червей (5$)
- **bait_bread** - Хлебна троха (3$)
- **bait_spinner** - Въртяща блесна (50$)

#### Язовирни примамки
- **bait_corn** - Царевица (4$)
- **bait_boilie** - Бойли (40$)
- **bait_silicone** - Силиконова рибка (60$)

#### Морски примамки
- **bait_seaworm** - Морски червей (8$)
- **bait_shrimp** - Скарида (10$)
- **bait_squid** - Парче калмар (35$)

#### Океански примамки
- **bait_metal_jig** - Метален джиг (150$)
- **bait_trolling_lure** - Тролинг воблер (200$)

### 🐟 Риби (60 вида)

#### Речни риби (15)
fish_carp, fish_crucian_carp, fish_chub, fish_sichel, fish_barbel, fish_trout, fish_catfish, fish_perch, fish_white_bream, fish_bleak, fish_nase, fish_roach, fish_rudd, fish_grass_carp, fish_asp

#### Язовирни риби (15)
fish_silver_carp, fish_bighead_carp, fish_tench, fish_channel_catfish, fish_white_amur, fish_black_carp, fish_sunfish, fish_silver_crucian, fish_mirror_carp, fish_common_carp, fish_black_bass, fish_eel, fish_peled, fish_whitefish, fish_rainbow_trout

#### Морски риби (15)
fish_horse_mackerel, fish_sea_bream, fish_bluefish, fish_sea_bass, fish_gilthead, fish_goby, fish_turbot, fish_bonito, fish_mackerel, fish_grey_mullet, fish_red_mullet, fish_garfish, fish_anchovy, fish_shad, fish_wrasse

#### Океански риби (15)
fish_yellowfin_tuna, fish_bluefin_tuna, fish_swordfish, fish_blue_marlin, fish_black_marlin, fish_mahi_mahi, fish_wahoo, fish_cod, fish_halibut, fish_grouper, fish_barracuda, fish_red_snapper, fish_tarpon, fish_flounder, fish_shark

### 🗑️ Боклук (15 вида)
trash_old_boot, trash_torn_tire, trash_plastic_bottle, trash_rusty_can, trash_broken_bottle, trash_old_rope, trash_torn_net, trash_rusty_chain, trash_broken_bucket, trash_metal_scrap, trash_old_umbrella, trash_broken_flashlight, trash_broken_rod, trash_worn_glove, trash_old_phone

---

## 📍 Локации

### Риболовни магазини (2 локации)
1. **Vespucci Beach** - (-1694.65, -1057.43, 13.02)
2. **Paleto Bay** - (1297.19, 4340.98, 39.07)

### Изкупуване на риба
- **Локация** - (-1803.36, -1198.21, 13.02)
- **NPC** - Dock Worker
- Продава ВСИЧКИ риби наведнъж

### Риболовни зони
- **Mirror Park Lake** - Езеро в Mirror Park (приоритет 0)
- **Paleto Lake Small** - Малко езеро в Paleto (приоритет 1)
- **Paleto Lake Large** - Голямо езеро в Paleto (приоритет 2)
- **Richman Lake** - Езеро в Richman (приоритет 3)
- **Power Plant** - Езеро при електроцентралата (приоритет 4)
- **Alamo Sea** - Голямо солено езеро (приоритет 5)
- **Alamo River North** - Северна река (приоритет 6)
- **Ocean** - Океан (приоритет 10)
- **River** - Реки (приоритет 11)
- **Canal** - Канали (приоритет 12)

---

## ⚙️ Конфигурация

### Основни настройки
```lua
Config.Locale = 'bg'  -- Език (bg/en)
Config.Debug.Enabled = false  -- Debug режим
Config.Blips.ShowZones = false  -- Показване на зони на картата
```

### Време за чакане (по рядкост)
- **Common** - 60-100 секунди
- **Uncommon** - 100-180 секунди
- **Rare** - 180-240 секунди
- **Epic** - 240-300 секунди

### Нотификации
- Продължителност: 10 секунди
- Тип: ox_lib notify

---

## 🎯 Как работи

### 1. Купи въдица и примамки
Посети един от двата риболовни магазина

### 2. Намери водоем
- Отиди до река, езеро, море или океан
- Използвай правилната примамка за водоема

### 3. Започни риболов
- Използвай въдицата от инвентара
- Изчакай минигейма (време зависи от рядкостта)

### 4. Играй минигейма
- **Common** - Натискай SPACE 3 пъти в правилния момент
- **Uncommon** - Повтори последователността от стрелки
- **Rare** - Улучи 5 от 7 удара
- **Epic** - Запомни и повтори pattern-а

### 5. Продай рибата
Отиди при изкупвача на риба и продай уловите си

---

## 🔑 Важни правила

### Примамки
- ❌ Без примамка = НЕ можеш да ловиш
- ❌ Грешна примамка = Чакаш 5 минути и не хващаш нищо
- ✅ Правилна примамка = Нормален риболов

### Примамки по водоеми
- **Реки** → Земен червей, Хлебна троха, Въртяща блесна
- **Езера** → Царевица, Бойли, Силиконова рибка
- **Море** → Морски червей, Скарида, Парче калмар
- **Океан** → Метален джиг, Тролинг воблер
- **Канали** → Земен червей, Хлебна троха

### Боклук
- **Канали** - 70% шанс за боклук
- **Океан** - 10% шанс за боклук
- **Реки** - 5% шанс за боклук
- **Езера** - Без боклук

---

## 📝 Команди (Admin)

```bash
/clearfishingdata  # Изтрива ВСИЧКИ данни за риболов
/resetplayerfishing [id]  # Изтрива данните на конкретен играч
```

---

## 🌐 Добавяне на нов език

1. Създай нов файл в `locales/` (напр. `de.lua`)
2. Копирай структурата от `locales/en.lua`
3. Преведи всички текстове
4. Промени `Config.Locale` в `shared/config.lua`

---

## 🐛 Поддръжка

При проблеми провери:
1. Всички зависимости са стартирани
2. Базата данни е импортирана
3. Предметите са добавени в ox_inventory
4. Магазинът е добавен в ox_inventory
5. Конзолата за грешки

---

## 📄 Лиценз

Този скрипт е създаден за лично ползване. Всички права запазени.

---

**Версия:** 1.0.2  
**Последна актуализация:** 2026
