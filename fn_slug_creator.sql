DROP FUNCTION IF EXISTS `fn_slug_creator`;

DELIMITER $$

CREATE FUNCTION `fn_slug_creator` (_text TEXT)
	RETURNS TEXT
BEGIN
	
	SET _text = lower(_text);
	SET _text = REGEXP_REPLACE(_text, '[\\W_]{1,}', '--');
	SET _text = REGEXP_REPLACE(_text, '(-\\w-|-){1,}', '-'); /* Remove Single Alphabet */
	RETURN 	_text;
	
END$$

DELIMITER ;