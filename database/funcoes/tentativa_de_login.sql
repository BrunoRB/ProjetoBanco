--INSERTS;

CREATE OR REPLACE FUNCTION tentativaDeLoginCadastrar (usuario INTEGER, check BOOLEN)
RETURNS INTEGER AS $$
DECLARE
	id_gerada INT;
BEGIN 
	INSERT INTO tentativa_de_login (fk_usuario, data_horario_login, sucesso)
		VALUES (usuario, CURRENT_TIMESTAMP, check) RETURNING fk_usuario INTO id_gerada;
		RETURN id_gerada;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE EXCEPTION '[Erro] Dados inválidos inseridos!';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;



--DELETES;

--Inativa o usuário
CREATE OR REPLACE FUNCTION tentativaDeLoginExcluir (id INTEGER)
RETURNS INTEGER AS $$
BEGIN 
	DELETE FROM tentativa_de_login WHERE fk_usuario = id;
	IF (FOUND) THEN
		RAISE NOTICE 'Salvo com sucesso!';
		RETURN 1;
	ELSE
		RAISE EXCEPTION 'Erro ao excluir!';
		RETURN 0;
	END IF;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE EXCEPTION '[Erro] Dados inválidos inseridos!';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;

--END DELETES;