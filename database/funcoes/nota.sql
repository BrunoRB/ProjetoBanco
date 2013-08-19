-- INSERTS;

--todos
CREATE OR REPLACE FUNCTION notaCadastrar (id INTEGER, titulo VARCHAR, texto TEXT, date DATE, usuario INTEGER)
RETURNS INTEGER AS $$
DECLARE
	id_gerada INT;
BEGIN 
	INSERT INTO nota (id_nota, titulo, texto, date, fk_usuario)
		VALUES (id, titulo, text, date, usuario) RETURNING id_nota INTO id_gerada;
		RAISE NOTICE 'Nota cadastrada com sucesso!';
		RETURN id_gerada;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE '[Erro] Dados inválidos inseridos !';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION notaCadastrar (titulo VARCHAR, texto TEXT, usuario INTEGER)
RETURNS INTEGER AS $$
DECLARE
	id_gerada INT;
BEGIN 
	INSERT INTO nota (titulo, texto, fk_usuario)
		VALUES (titulo, texto, usuario) RETURNING id_nota INTO id_gerada;
		RAISE NOTICE 'Nota cadastrada com sucesso!';
		RETURN id_gerada;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE '[Erro] Dados inválidos inseridos !';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;


--DELETES;

CREATE OR REPLACE FUNCTION notaExcluir(id_exclusao INTEGER) RETURNS INTEGER AS $$
	BEGIN
		DELETE FROM nota WHERE id_nota = id_exclusao;
		
		IF (FOUND) THEN
			RAISE NOTICE 'Nota excluída com sucesso!';
			RETURN 1;
		END IF;
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETES;
