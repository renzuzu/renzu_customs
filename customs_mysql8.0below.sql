CREATE TABLE IF NOT EXISTS `renzu_customs` (
	`shop` VARCHAR(64) NOT NULL COLLATE 'utf8mb4_general_ci',
	`inventory` LONGTEXT NULL COLLATE 'utf8mb4_general_ci',
	PRIMARY KEY (`shop`) USING BTREE
)
COLLATE='utf8mb4_general_ci'
ENGINE=InnoDB
;
