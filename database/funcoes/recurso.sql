CREATE OR REPLACE function recursoInsert(idR int, nomeR varchar(250), descricaoR varchar(250)) RETURNS integer AS $fun$
BEGIN
	INSERT INTO recurso(id, nome, descricao) VALUES(idR, nomeR, descricaoR);
	RETURN 1;
END;
$fun$ LANGUAGE 'plpgsql';

CREATE OR REPLACE function recursoUpdate(idR int, nomeR varchar(250), descricaoR varchar(250)) RETURNS integer AS $fun$
BEGIN
	UPDATE recurso
	SET nome = nomeR, 
		descricao = descricaoR
	WHERE id = idR;
	RETURN 1;
END;
$fun$ LANGUAGE 'plpgsql';

CREATE OR REPLACE function recursoDelete(idR int) RETURNS integer AS $fun$
BEGIN
	DELETE FROM recurso
	WHERE id = idR;
	RETURN 1;
END;
$fun$ LANGUAGE 'plpgsql';

