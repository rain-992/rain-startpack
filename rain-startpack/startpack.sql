CREATE TABLE IF NOT EXISTS `player_startpack` (
    `id` int(11) NOT NULL AUTO_INCREMENT,
    `citizenid` varchar(50) NOT NULL,
    `received` tinyint(1) NOT NULL DEFAULT 0,
    `received_at` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `character_name` varchar(255) DEFAULT NULL,
    PRIMARY KEY (`id`),
    UNIQUE KEY `citizenid_index` (`citizenid`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;