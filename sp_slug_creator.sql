DROP PROCEDURE IF EXISTS `sp_slug_creator`;

DELIMITER $$

CREATE PROCEDURE `sp_slug_creator` (
	IN _table VARCHAR(30) CHARSET utf8, 
	IN _col_title VARCHAR(30) CHARSET utf8,
	IN _col_slug VARCHAR(30) CHARSET utf8
)
	MODIFIES SQL DATA
BEGIN
	SET @_sql := CONCAT(
		"UPDATE `", _table, "` SET `",	_col_slug, "` = ", 
		"
			lower(
				REGEXP_REPLACE(
					REGEXP_REPLACE(`",	_col_title, "`, ?, ?), ?, ?)
			);
		"
	);
	
	PREPARE STMT FROM @_sql;
	
	SET @a1 := '[\\W_]{1,}';
	SET @a2 := '--';
	SET @a3 := '(-\\w-|-){1,}';
	SET @a4 := '-';
	
	EXECUTE STMT USING @a1, @a2, @a3, @a4;	
	
END$$

DELIMITER ;
