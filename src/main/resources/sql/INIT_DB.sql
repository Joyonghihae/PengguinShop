-- MYSQL INIT_DB SQL
CREATE TABLE `GRADE` (
	`grade_no`	int(11) unsigned	NOT NULL AUTO_INCREMENT,
	`name` 	varchar(100)	NULL,
	`saved_money`	float	NULL,
	PRIMARY KEY (grade_no)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `USER` (
	`user_seq`	int(20) unsigned	NOT NULL AUTO_INCREMENT,
	`name` 	varchar(20)	NOT NULL,
	`user_id`	varchar(20)	NOT NULL,
	`pw`     	varchar(20)	NOT NULL,
	`email`	           varchar(200)	NOT NULL,
	`phone`	varchar(20)	NOT NULL,
	`address`	varchar(100)	NOT NULL,
	`status`	tinyint(5) unsigned	NULL DEFAULT 0,
	`last_visit_date`	datetime	NULL DEFAULT CURRENT_TIMESTAMP ,
	`authority`	tinyint(2)	NULL DEFAULT 0,
	`grade_no`	int(10) unsigned	NOT NULL,
	PRIMARY KEY (user_seq),
CONSTRAINT USER_FK_GNO FOREIGN KEY (grade_no) REFERENCES GRADE(grade_no),
KEY `idx_user_userid` (`user_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ORDER` (
	`order_uid`	int(11) unsigned	NOT NULL AUTO_INCREMENT,
	`user_seq`	int(20) unsigned	NOT NULL,
	`use_point`	int(20) unsigned	NULL,
	`delivery_cost`	decimal(12, 2)	NULL,
	`order_status`	int(5) unsigned	NULL DEFAULT 0,
	`address`	varchar(200)	NULL,
	`order_date`	datetime	NULL,
	`pay_status`	tinyint(3) unsigned	NULL DEFAULT 0,
	`total_cost`	decimal(12, 2)	NULL,
	PRIMARY KEY (order_uid),
CONSTRAINT ORDER_FK_GNO FOREIGN KEY (user_seq) REFERENCES USER(user_seq),
KEY `idx_order_orderuid` (`order_uid`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ITEM` (
	`item_no`	int(11) unsigned	NOT NULL AUTO_INCREMENT,
	`item_name`	varchar(100)	NOT NULL,
	`price`	decimal(12,2)	NOT NULL,
	`item_option`	int(11) unsigned	NOT NULL,
	`item_color`	varchar(100)	NOT NULL,
	`item_info`	varchar(3000)	NULL,
	`stock`	int(11) unsigned	NOT NULL,
PRIMARY KEY (item_no),
INDEX `idx_item_itemno` (`item_no`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `order_item` (
	`order_item_id`	int(11) unsigned	NOT NULL,
	`item_no`	int(100) unsigned	NOT NULL AUTO_INCREMENT,
	`order_uid`	int(11) unsigned	NOT NULL,
	`item_count`	int(11) unsigned	NULL,
	PRIMARY KEY (order_item_id),
CONSTRAINT ORDER_ITEM_FK_GNO FOREIGN KEY (item_no) REFERENCES ITEM(item_no),
CONSTRAINT ORDER_ITEM_FK_OUID FOREIGN KEY (order_uid) REFERENCES `ORDER`(order_uid)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `CART` (
	`cart_uid`	int(11) unsigned	NOT NULL AUTO_INCREMENT,
	`count`		int(10) unsigned	NULL,
	`user_seq`	int(20) unsigned	NOT NULL,
	`item_no`	int(100) unsigned	NOT NULL,
	PRIMARY KEY (cart_uid),
	CONSTRAINT CART_FK_GNO FOREIGN KEY (item_no) REFERENCES ITEM(item_no),
CONSTRAINT CART_FK_USEQ FOREIGN KEY (user_seq) REFERENCES USER(user_seq),
INDEX `idx_cart_cartuid` (`cart_uid`)

)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `BOARD` (
	`board_id`	int(11) unsigned	NOT NULL,
	`title`		varchar(100)	NULL,
	`enroll_date`	date	NULL,
	`count`		int(11) unsigned	NULL,
	`content`	varchar(3000)	NULL,
	`modify_date`	date	NULL,
	`sort`		int(11) unsigned	NULL,
	`status`	tinyint(2) unsigned	NULL DEFAULT 0,
	`user_seq`	int(20) unsigned	NOT NULL,
	PRIMARY KEY (board_id),
CONSTRAINT BOARD_FK_GNO FOREIGN KEY (user_seq) REFERENCES USER(user_seq)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `ATTACH` (
	`attach_no`	int	NOT NULL AUTO_INCREMENT,
	`attach_path`	varchar(300)	NULL,
	`attach_name`	varchar(300)	NULL,
	`attach_level`	int(10) unsigned	NULL,
	`date`	timestamp	NULL DEFAULT CURRENT_TIMESTAMP,
	`status`	int(3)	NULL DEFAULT 0,
	`board_id`	int(11) unsigned	NOT NULL,
	PRIMARY KEY (`attach_no`),
	CONSTRAINT ATTACH_FK_BID FOREIGN KEY(`board_id`) REFERENCES BOARD(`board_id`)
)ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `SETTING` (
	`setting_id`	int(10) unsigned	NOT NULL,
	`setting_key`	varchar(300)	NOT NULL,
	`setting_value`	varchar(3000)	NULL,
	`last_modified`	timestamp	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	PRIMARY KEY(`setting_id`, `setting_key`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

select * from information_schema.TABLE_CONSTRAINTS tc ;

-- constraint error ??
CREATE TABLE `COUPON` (
	`coupon_id`	int(11) unsigned	NOT NULL AUTO_INCREMENT,
	`coupon_name`	varchar(100)	NULL,
	`price`	decimal(12,2) 	NULL DEFAULT 0,
	`ratio`	float	NULL DEFAULT 0,
	`expire_date`	date	NOT NULL,
	`state`	tinyint(10)	NOT NULL DEFAULT 0,
	`user_seq`	int(11)unsigned	NOT NULL,
	PRIMARY KEY (`coupon_id`),
	FOREIGN KEY(`user_seq`) REFERENCES `USER`(`user_seq`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `COMMENT` (
	`comment_id`	int(11) unsigned	NOT NULL AUTO_INCREMENT,
	`comment_content`	varchar(3000)	NULL,
	`comment_date`	timestamp	NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`board_id`	int(11) unsigned	NOT NULL,
	`user_seq`	int(11) unsigned	NOT NULL,
	PRIMARY KEY(comment_id),
	CONSTRAINT COMMENT_FK_BID FOREIGN KEY (board_id) REFERENCES BOARD(board_id),
CONSTRAINT COMMENT_FK_USEQ FOREIGN KEY (user_seq) REFERENCES USER(user_seq)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `VISIT` (
	`insert_date`	int(10) unsigned NOT NULL,
	`count`	bigint(20) unsigned	NULL,
	PRIMARY KEY(insert_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `REVENUE` (
	`insert_date`	int(10) unsigned	NOT NULL,
	`revenue`	bigint(20) unsigned	NULL,
PRIMARY KEY (insert_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 예상 : 같은 컬럼 제약조건 한계가 잇는듯?
CREATE TABLE `AUDITLOG` (
	`auditlog_seq`	int(11) unsigned	NOT NULL,
	`page`		varchar(100)	NOT NULL,
	`detail`		varchar(255),
	`time`		timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
	`conn_ip`	varchar(20) NOT NULL,
	`user_seq`	int(11) unsigned NOT NULL,
PRIMARY KEY (auditlog_seq),
FOREIGN KEY (`user_seq` ) REFERENCES USER(`user_seq`),
KEY `idx_AUDITLOG_PAGE`(`page`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

CREATE TABLE `CATEGORY` (
	`category_id`	int(11) unsigned	NOT NULL AUTO_INCREMENT,
	`category_name`		varchar(100)	NOT NULL,
	`parent_id`		int(11) unsigned NOT NULL DEFAULT 0,
	`full_code`		varchar(255) NOT NULL,
	`full_name`	varchar(255) NOT NULL,
	PRIMARY KEY (category_id),
KEY `idx_CATEGORY_PID`(`parent_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;