CREATE OR REPLACE function recursoInsert(idR int, nomeR varchar(250), descricaoR varchar(250)) RETURNS integer AS $fun$
DECLARE
	id_gerada INTEGER;
BEGIN
	INSERT INTO recurso(id, nome, descricao) VALUES(idR, nomeR, descricaoR)
	RETURNING id_projeto INTO id_gerada;
	RETURN id_gerada;
END;
$fun$ LANGUAGE 'plpgsql';

CREATE OR REPLACE function recursoUpdate(idR int, nomeR varchar(250), descricaoR varchar(250)) RETURNS integer AS $fun$
DECLARE
	id_gerada INTEGER;
BEGIN
	UPDATE recurso
	SET nome = nomeR, 
		descricao = descricaoR
	WHERE id = idR
	RETURNING id_projeto INTO id_gerada;
	RETURN id_gerada;
END;
$fun$ LANGUAGE 'plpgsql';

CREATE OR REPLACE function recursoDelete(idR int) RETURNS integer AS $fun$
DECLARE
	id_gerada INTEGER;
BEGIN
	DELETE FROM recurso
	WHERE id = idR
	RETURNING id_projeto INTO id_gerada;
	RETURN id_gerada;
END;
$fun$ LANGUAGE 'plpgsql';

CREATE OR REPLACE function listaRecurso() RETURNS SETOF recurso AS $fun$
DECLARE 
	result recurso%ROWTYPE;
BEGIN
	FOR result IN SELECT id, nome, descricao FROM recurso LOOP
		RETURN NEXT result;
	END LOOP;
	RETURN;
END;
$fun$ LANGUAGE 'plpgsql';
