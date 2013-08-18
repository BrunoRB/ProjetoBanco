CREATE OR REPLACE function formaDeContatoInsert(idR int, tipoR varchar(100), valorR varchar(200)) RETURNS integer AS $fun$
DECLARE
	id_gerada INTEGER;
BEGIN
	INSERT INTO formaDeContato(id, tipo, valor) VALUES(idR, tipoR, valorR)
	RETURNING id_projeto INTO id_gerada;
	RETURN id_gerada;
END;
$fun$ LANGUAGE 'plpgsql';

CREATE OR REPLACE function formaDeContatoUpdate(idR int, tipoR varchar(100), valorR varchar(200)) RETURNS integer AS $fun$
DECLARE
	id_gerada INTEGER;
BEGIN
	UPDATE formaDeContato
	SET tipo = tipoR,
		valor = valorR
	WHERE id = idR
	RETURNING id_projeto INTO id_gerada;
	RETURN id_gerada;
END;
$fun$ LANGUAGE 'plpgsql';

CREATE OR REPLACE function formaDeContatoDelete(idR int) RETURNS integer AS $fun$
DECLARE
	id_gerada INTEGER;
BEGIN
	DELETE FROM formaDeContato
	WHERE id = idR
	RETURNING id_projeto INTO id_gerada;
	RETURN id_gerada;
END;
$fun$ LANGUAGE 'plpgsql';

CREATE OR REPLACE function listaFormaDeContato() RETURNS SETOF formaDeContato AS $fun$
DECLARE 
	result formaDeContato%ROWTYPE;
BEGIN
	FOR result IN SELECT id, tipo, valor FROM formaDeContato LOOP
		RETURN NEXT result;
	END LOOP;
	RETURN;
END;
$fun$ LANGUAGE 'plpgsql';
