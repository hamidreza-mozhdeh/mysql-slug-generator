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
	
	EXECUTE STMT USING '[\\W_]{1,}', '--', '(-\\w-|-){1,}', '-';	
	
END$$

DELIMITER ;
