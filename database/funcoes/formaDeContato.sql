CREATE OR REPLACE function formaDeContatoInsert(idR int, tipoR varchar(100), valorR varchar(200)) RETURNS integer AS $$
BEGIN
	INSERT INTO formaDeContato(id, tipo, valor) VALUES(idR, tipoR, valorR);
	RETURN 1;
END;
$fun$ LANGUAGE 'plpgsql';

CREATE OR REPLACE function formaDeContatoUpdate(idR int, tipoR varchar(100), valorR varchar(200)) RETURNS integer AS $$
BEGIN
	UPDATE formaDeContato
	SET tipo = tipoR,
		valor = valorR
	WHERE id = idR;
	RETURN 1;
END;
$fun$ LANGUAGE 'plpgsql';

CREATE OR REPLACE function formaDeContatoDelete(idR int) RETURNS integer AS $$
BEGIN
	DELETE FROM formaDeContato
	WHERE id = idR;
	RETURN 1;
END;
$fun$ LANGUAGE 'plpgsql';

