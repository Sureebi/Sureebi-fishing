-- ============================================
-- FISHING ITEMS FOR OX_INVENTORY
-- Копирай всичко от тук и го постави в ox_inventory/data/items.lua
-- ============================================

-- FISHING ROD
['fishingrod'] = {
    label = 'Въдица',
    weight = 500,
    stack = false,
    close = true,
    description = 'Въдица за риболов',
    client = {
        event = 'Sureebi_fishing:client:Fish'
    }
},

-- ============================================
-- BAITS (Примамки) - 11 броя
-- ============================================

-- River Baits (Речни примамки)
['bait_earthworm'] = {
    label = 'Земен червей',
    weight = 5,
    stack = true,
    close = true,
    description = 'Подходяща за реки и канали'
},

['bait_bread'] = {
    label = 'Хлебна троха',
    weight = 5,
    stack = true,
    close = true,
    description = 'Отлична за речен риболов'
},

['bait_spinner'] = {
    label = 'Въртяща блесна',
    weight = 10,
    stack = true,
    close = true,
    description = 'Ефективна за реки и потоци'
},

-- Reservoir/Lake Baits (Язовирни примамки)
['bait_corn'] = {
    label = 'Царевица',
    weight = 5,
    stack = true,
    close = true,
    description = 'Доста подходяща за язовири'
},

['bait_boilie'] = {
    label = 'Бойли',
    weight = 10,
    stack = true,
    close = true,
    description = 'Перфектна за езера и язовири'
},

['bait_silicone'] = {
    label = 'Силиконова рибка',
    weight = 15,
    stack = true,
    close = true,
    description = 'Идеална за язовири и езера'
},

-- Sea Baits (Морски примамки)
['bait_seaworm'] = {
    label = 'Морски червей (нереис)',
    weight = 5,
    stack = true,
    close = true,
    description = 'Отлична за морски риболов'
},

['bait_shrimp'] = {
    label = 'Скарида',
    weight = 10,
    stack = true,
    close = true,
    description = 'Подходяща за морски води'
},

['bait_squid'] = {
    label = 'Парче калмар',
    weight = 10,
    stack = true,
    close = true,
    description = 'Ефективна за морски риболов'
},

-- Ocean Baits (Океански примамки)
['bait_metal_jig'] = {
    label = 'Метален джиг',
    weight = 50,
    stack = true,
    close = true,
    description = 'За дълбоководен океански риболов'
},

['bait_trolling_lure'] = {
    label = 'Тролинг воблер',
    weight = 50,
    stack = true,
    close = true,
    description = 'За големи океански хищници'
},

-- ============================================
-- TRASH ITEMS (Боклук) - 15 броя
-- ============================================

['trash_old_boot'] = {
    label = 'Стара обувка',
    weight = 200,  --
    stack = true,
    close = true,
    description = 'Мокра стара обувка от водата'
},

['trash_torn_tire'] = {
    label = 'Скъсана гума',
    weight = 2000,  -- 
    stack = true,
    close = true,
    description = 'Стара автомобилна гума'
},

['trash_plastic_bottle'] = {
    label = 'Празна пластмасова бутилка',
    weight = 10,  -- 
    stack = true,
    close = true,
    description = 'Празна пластмасова бутилка'
},

['trash_rusty_can'] = {
    label = 'Ръждясала консерва',
    weight = 50,  -- 
    stack = true,
    close = true,
    description = 'Стара ръждясала консервна кутия'
},

['trash_broken_bottle'] = {
    label = 'Счупена стъклена бутилка',
    weight = 100,  -- 
    stack = true,
    close = true,
    description = 'Опасна счупена бутилка'
},

['trash_old_rope'] = {
    label = 'Старо въже',
    weight = 150,  -- 
    stack = true,
    close = true,
    description = 'Гнило старо въже'
},

['trash_torn_net'] = {
    label = 'Скъсана рибарска мрежа',
    weight = 400,  -- 
    stack = true,
    close = true,
    description = 'Скъсана и безполезна мрежа'
},

['trash_rusty_chain'] = {
    label = 'Ръждясала верига',
    weight = 500,  -- 
    stack = true,
    close = true,
    description = 'Тежка ръждясала верига'
},

['trash_broken_bucket'] = {
    label = 'Счупена кофа',
    weight = 200,  -- 
    stack = true,
    close = true,
    description = 'Стара пластмасова кофа с дупки'
},

['trash_metal_scrap'] = {
    label = 'Метален скрап (ламарина)',
    weight = 400,  -- 
    stack = true,
    close = true,
    description = 'Парче ръждясала ламарина'
},

['trash_old_umbrella'] = {
    label = 'Стар чадър',
    weight = 250,  -- 
    stack = true,
    close = true,
    description = 'Счупен и безполезен чадър'
},

['trash_broken_flashlight'] = {
    label = 'Повреден фенер',
    weight = 100,  -- 
    stack = true,
    close = true,
    description = 'Фенер който не работи'
},

['trash_broken_rod'] = {
    label = 'Счупена въдица',
    weight = 300,  -- 
    stack = true,
    close = true,
    description = 'Стара счупена въдица'
},

['trash_worn_glove'] = {
    label = 'Износена ръкавица',
    weight = 50,  -- 
    stack = true,
    close = true,
    description = 'Мокра износена ръкавица'
},

['trash_old_phone'] = {
    label = 'Стар телефон (неработещ)',
    weight = 100,  -- 
    stack = true,
    close = true,
    description = 'Воден стар телефон'
},

-- ============================================
-- RIVER FISH (Речни риби) - 15 броя
-- ============================================

['fish_carp'] = {
    label = 'Шаран',
    weight = 2500,
    stack = true,
    close = true,
    description = 'Обикновен речен шаран'
},

['fish_crucian_carp'] = {
    label = 'Каракуда',
    weight = 800,
    stack = true,
    close = true,
    description = 'Малка златиста риба'
},

['fish_chub'] = {
    label = 'Кефал',
    weight = 1200,
    stack = true,
    close = true,
    description = 'Речен кефал'
},

['fish_sichel'] = {
    label = 'Скобар',
    weight = 600,
    stack = true,
    close = true,
    description = 'Малка речна риба'
},

['fish_barbel'] = {
    label = 'Мряна',
    weight = 1500,
    stack = true,
    close = true,
    description = 'Речна мряна с мустаци'
},

['fish_trout'] = {
    label = 'Пъстърва (балканска)',
    weight = 1800,
    stack = true,
    close = true,
    description = 'Балканска пъстърва'
},

['fish_catfish'] = {
    label = 'Сом',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Голям речен сом'
},

['fish_perch'] = {
    label = 'Костур (речен)',
    weight = 900,
    stack = true,
    close = true,
    description = 'Речен костур'
},

['fish_white_bream'] = {
    label = 'Бяла риба (сулка)',
    weight = 700,
    stack = true,
    close = true,
    description = 'Обикновена бяла риба'
},

['fish_bleak'] = {
    label = 'Уклей',
    weight = 200,
    stack = true,
    close = true,
    description = 'Много малка речна риба'
},

['fish_nase'] = {
    label = 'Морунаш',
    weight = 1100,
    stack = true,
    close = true,
    description = 'Речен морунаш'
},

['fish_roach'] = {
    label = 'Платика',
    weight = 500,
    stack = true,
    close = true,
    description = 'Обикновена платика'
},

['fish_rudd'] = {
    label = 'Червеноперка',
    weight = 600,
    stack = true,
    close = true,
    description = 'Риба с червени перки'
},

['fish_grass_carp'] = {
    label = 'Амур',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Голям амур'
},

['fish_asp'] = {
    label = 'Распер (жерех)',
    weight = 3000,
    stack = true,
    close = true,
    description = 'Хищен речен распер'
},

-- ============================================
-- RESERVOIR/LAKE FISH (Язовирни риби) - 15 броя
-- ============================================

['fish_silver_carp'] = {
    label = 'Толстолоб (бял)',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Бял толстолоб'
},

['fish_bighead_carp'] = {
    label = 'Толстолоб (пъстър)',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Пъстър толстолоб'
},

['fish_tench'] = {
    label = 'Лин',
    weight = 2000,
    stack = true,
    close = true,
    description = 'Язовирен лин'
},

['fish_channel_catfish'] = {
    label = 'Американски сом',
    weight = 4500,
    stack = true,
    close = true,
    description = 'Канален сом'
},

['fish_white_amur'] = {
    label = 'Бял амур',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Голям бял амур'
},

['fish_black_carp'] = {
    label = 'Черен амур',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Черен амур'
},

['fish_sunfish'] = {
    label = 'Слънчева рибка',
    weight = 300,
    stack = true,
    close = true,
    description = 'Малка цветна рибка'
},

['fish_silver_crucian'] = {
    label = 'Сребриста каракуда',
    weight = 900,
    stack = true,
    close = true,
    description = 'Сребриста каракуда'
},

['fish_mirror_carp'] = {
    label = 'Огледален шаран',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Голям огледален шаран'
},

['fish_common_carp'] = {
    label = 'Люспест шаран',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Голям люспест шаран'
},

['fish_black_bass'] = {
    label = 'Черен костур (бас)',
    weight = 2500,
    stack = true,
    close = true,
    description = 'Американски черен костур'
},

['fish_eel'] = {
    label = 'Змиорка (сладководна)',
    weight = 1500,
    stack = true,
    close = true,
    description = 'Сладководна змиорка'
},

['fish_peled'] = {
    label = 'Пелед',
    weight = 2200,
    stack = true,
    close = true,
    description = 'Северна риба пелед'
},

['fish_whitefish'] = {
    label = 'Сиг',
    weight = 1800,
    stack = true,
    close = true,
    description = 'Сладководен сиг'
},

['fish_rainbow_trout'] = {
    label = 'Пъстърва (дъгова)',
    weight = 2500,
    stack = true,
    close = true,
    description = 'Дъгова пъстърва'
},

-- ============================================
-- SEA FISH (Морски риби) - 15 броя
-- ============================================

['fish_horse_mackerel'] = {
    label = 'Сафрид',
    weight = 400,
    stack = true,
    close = true,
    description = 'Обикновен сафрид'
},

['fish_sea_bream'] = {
    label = 'Чернокоп',
    weight = 1200,
    stack = true,
    close = true,
    description = 'Морски чернокоп'
},

['fish_bluefish'] = {
    label = 'Лефер',
    weight = 3000,
    stack = true,
    close = true,
    description = 'Хищен лефер'
},

['fish_sea_bass'] = {
    label = 'Лаврак',
    weight = 2500,
    stack = true,
    close = true,
    description = 'Морски лаврак'
},

['fish_gilthead'] = {
    label = 'Ципура',
    weight = 1800,
    stack = true,
    close = true,
    description = 'Златоглава ципура'
},

['fish_goby'] = {
    label = 'Попче',
    weight = 150,
    stack = true,
    close = true,
    description = 'Малко попче'
},

['fish_turbot'] = {
    label = 'Калкан',
    weight = 4000,  -- 4 кг
    stack = true,
    close = true,
    description = 'Голям калкан'
},

['fish_bonito'] = {
    label = 'Паламуд',
    weight = 3500,
    stack = true,
    close = true,
    description = 'Паламуд'
},

['fish_mackerel'] = {
    label = 'Скумрия',
    weight = 800,
    stack = true,
    close = true,
    description = 'Обикновена скумрия'
},

['fish_grey_mullet'] = {
    label = 'Кефал (морски)',
    weight = 1500,
    stack = true,
    close = true,
    description = 'Морски кефал'
},

['fish_red_mullet'] = {
    label = 'Барбун',
    weight = 600,
    stack = true,
    close = true,
    description = 'Червен барбун'
},

['fish_garfish'] = {
    label = 'Зарган',
    weight = 900,
    stack = true,
    close = true,
    description = 'Зарган с дълга муцуна'
},

['fish_anchovy'] = {
    label = 'Хамсия',
    weight = 100,
    stack = true,
    close = true,
    description = 'Малка хамсия'
},

['fish_shad'] = {
    label = 'Трицона',
    weight = 700,
    stack = true,
    close = true,
    description = 'Морска трицона'
},

['fish_wrasse'] = {
    label = 'Морска врана',
    weight = 500,
    stack = true,
    close = true,
    description = 'Цветна морска врана'
},

-- ============================================
-- OCEAN FISH (Океански риби) - 15 броя
-- ============================================

['fish_yellowfin_tuna'] = {
    label = 'Риба тон (жълтоперка)',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Жълтоперест тон'
},

['fish_bluefin_tuna'] = {
    label = 'Син тон',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Син тон'
},

['fish_swordfish'] = {
    label = 'Риба меч',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Риба меч с дълъг нос'
},

['fish_blue_marlin'] = {
    label = 'Марлин (син)',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Син марлин'
},

['fish_black_marlin'] = {
    label = 'Марлин (черен)',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Черен марлин'
},

['fish_mahi_mahi'] = {
    label = 'Махи-махи (дорадо)',
    weight = 4500,  -- 4.5 кг 
    stack = true,
    close = true,
    description = 'Цветна махи-махи'
},

['fish_wahoo'] = {
    label = 'Уаху',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Бърз океански хищник'
},

['fish_cod'] = {
    label = 'Треска (атлантическа)',
    weight = 4000,  -- 4 кг 
    stack = true,
    close = true,
    description = 'Атлантическа треска'
},

['fish_halibut'] = {
    label = 'Халибут',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Голям халибут'
},

['fish_grouper'] = {
    label = 'Морски костур (групер)',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Голям морски групер'
},

['fish_barracuda'] = {
    label = 'Баракуда',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Опасна баракуда'
},

['fish_red_snapper'] = {
    label = 'Снепър (red snapper)',
    weight = 4000,  -- 4 кг 
    stack = true,
    close = true,
    description = 'Червен снепър'
},

['fish_tarpon'] = {
    label = 'Тарпон',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Сребрист тарпон'
},

['fish_flounder'] = {
    label = 'Платерина (flounder)',
    weight = 3000,  -- 3 кг
    stack = true,
    close = true,
    description = 'Плоска платерина'
},

['fish_shark'] = {
    label = 'Акула (синя)',
    weight = 5000,  -- 5 кг 
    stack = true,
    close = true,
    description = 'Синя акула - РЯДКА!'
},
