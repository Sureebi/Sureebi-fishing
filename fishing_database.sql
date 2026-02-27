-- ============================================
-- FISHING LEADERBOARD & STATS DATABASE
-- ============================================

-- Player fishing statistics
CREATE TABLE IF NOT EXISTS `fishing_stats` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(50) NOT NULL,
    `player_name` VARCHAR(100) NOT NULL,
    `total_fish_caught` INT(11) DEFAULT 0,
    `total_weight` INT(11) DEFAULT 0,
    `total_money_earned` INT(11) DEFAULT 0,
    `biggest_fish_weight` INT(11) DEFAULT 0,
    `biggest_fish_type` VARCHAR(50) DEFAULT NULL,
    `biggest_fish_length` INT(11) DEFAULT 0,
    `longest_fish_length` INT(11) DEFAULT 0,
    `longest_fish_type` VARCHAR(50) DEFAULT NULL,
    `last_updated` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `identifier` (`identifier`),
    INDEX `idx_total_fish` (`total_fish_caught`),
    INDEX `idx_biggest_weight` (`biggest_fish_weight`),
    INDEX `idx_money` (`total_money_earned`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Individual fish catches (history)
CREATE TABLE IF NOT EXISTS `fishing_catches` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(50) NOT NULL,
    `player_name` VARCHAR(100) NOT NULL,
    `fish_type` VARCHAR(50) NOT NULL,
    `fish_weight` INT(11) NOT NULL,
    `fish_length` INT(11) NOT NULL,
    `location` VARCHAR(50) NOT NULL,
    `rarity` VARCHAR(20) NOT NULL,
    `sold` TINYINT(1) DEFAULT 0,
    `sold_price` INT(11) DEFAULT 0,
    `caught_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    INDEX `idx_identifier` (`identifier`),
    INDEX `idx_fish_type` (`fish_type`),
    INDEX `idx_weight` (`fish_weight`),
    INDEX `idx_length` (`fish_length`),
    INDEX `idx_caught_at` (`caught_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Fish records (world records per fish type)
CREATE TABLE IF NOT EXISTS `fishing_records` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `fish_type` VARCHAR(50) NOT NULL,
    `record_type` ENUM('weight', 'length') NOT NULL,
    `record_value` INT(11) NOT NULL,
    `holder_identifier` VARCHAR(50) NOT NULL,
    `holder_name` VARCHAR(100) NOT NULL,
    `location` VARCHAR(50) NOT NULL,
    `set_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `fish_record` (`fish_type`, `record_type`),
    INDEX `idx_fish_type` (`fish_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Category statistics (river, lake, sea, ocean)
CREATE TABLE IF NOT EXISTS `fishing_category_stats` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `identifier` VARCHAR(50) NOT NULL,
    `category` ENUM('river', 'lake', 'sea', 'ocean') NOT NULL,
    `fish_caught` INT(11) DEFAULT 0,
    `total_weight` INT(11) DEFAULT 0,
    `money_earned` INT(11) DEFAULT 0,
    `biggest_weight` INT(11) DEFAULT 0,
    `biggest_type` VARCHAR(50) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `player_category` (`identifier`, `category`),
    INDEX `idx_identifier` (`identifier`),
    INDEX `idx_category` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;
