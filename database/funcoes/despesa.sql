CREATE OR REPLACE function despesaInsert(idR int, nomeR varchar(250), descricaoR text, valorR numeric(7,2)) RETURNS integer AS $fun$
DECLARE
	id_gerada INTEGER;
BEGIN
	INSERT INTO despesa(id, nome, descricao, valor) VALUES(idR, nomeR, descricaoR, valorR)
	RETURNING id_projeto INTO id_gerada;
	RETURN id_gerada;
END;
$fun$ LANGUAGE 'plpgsql';

CREATE OR REPLACE function despesaUpdate(idR int, nomeR varchar(250), descricaoR text, valorR numeric(7,2)) RETURNS integer AS $fun$
DECLARE
	id_gerada INTEGER;
BEGIN
	UPDATE despesa
	SET nome = nomeR, 
		descricao = descricaoR,
		valor = valorR
	Where id = idR
	RETURNING id_projeto INTO id_gerada;
	RETURN id_gerada;
END;
$fun$ LANGUAGE 'plpgsql';

CREATE OR REPLACE function despesaDelete(idR int) RETURNS integer AS $fun$
DECLARE
	id_gerada INTEGER;
BEGIN
	DELETE FROM despesa
	WHERE id = idR
	RETURNING id_projeto INTO id_gerada;
	RETURN id_gerada;
END;
$fun$ LANGUAGE 'plpgsql';

CREATE OR REPLACE function listaDespesa() RETURNS SETOF despesa AS $fun$
DECLARE 
	result despesa%ROWTYPE;
BEGIN
	FOR result IN SELECT id, nome, descricao, valor FROM despesa LOOP
		RETURN NEXT result;
	END LOOP;
	RETURN;
END;
$fun$ LANGUAGE 'plpgsql';
