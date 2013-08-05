CREATE OR REPLACE function despesaInsert(idR int, nomeR varchar(250), descricaoR text, valorR numeric(7,2)) RETURNS integer AS $fun$
BEGIN
	INSERT INTO despesa(id, nome, descricao, valor) VALUES(idR, nomeR, descricaoR, valorR);
	RETURN 1;
END;
$fun$ LANGUAGE 'plpgsql';

CREATE OR REPLACE function despesaUpdate(idR int, nomeR varchar(250), descricaoR text, valorR numeric(7,2)) RETURNS integer AS $fun$
BEGIN
	UPDATE despesa
	SET nome = nomeR, 
		descricao = descricaoR,
		valor = valorR
	Where id = idR;
	RETURN 1;
END;
$fun$ LANGUAGE 'plpgsql';

CREATE OR REPLACE function despesaDelete(idR int) RETURNS integer AS $fun$
BEGIN
	DELETE FROM despesa
	WHERE id = idR;
	RETURN 1;
END;
$fun$ LANGUAGE 'plpgsql';

