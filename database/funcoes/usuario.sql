CREATE OR REPLACE FUNCTION usuarioCadastrar (id INTEGER, nome VARCHAR, login VARCHAR, senha VARCHAR, inativo BOOLEAN, inatividade DATE)
RETURNS INTEGER AS $$
DECLARE
	id_gerada INT;
BEGIN 
	INSERT INTO usuario (id_usuario, nome, login, senha, inativo, data_inatividade)
		VALUES (id, nome, login, md5('senha'), inativo, inatividade) RETURNING id_usuario INTO id_gerada;
		RETURN id_gerada;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE '[Erro] Dados inválidos inseridos !';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION usuarioCadastrar (nome VARCHAR, login VARCHAR, senha VARCHAR, inativo BOOLEAN, inatividade DATE)
RETURNS INTEGER AS $$
DECLARE
	id_gerada INT;
BEGIN 
	INSERT INTO usuario (nome, login, senha, inativo, data_inatividade)
		VALUES (nome, login, md5('senha'), inativo, inatividade) RETURNING id_usuario INTO id_gerada;
		RETURN id_gerada;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE '[Erro] Dados inválidos inseridos !';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;



CREATE OR REPLACE FUNCTION usuarioCadastrar (nome VARCHAR, login VARCHAR, senha VARCHAR)
RETURNS INTEGER AS $$
DECLARE
	id_gerada INT;
BEGIN 
	INSERT INTO usuario (nome, login, senha)
		VALUES (nome, login, md5('senha')) RETURNING id_usuario INTO id_gerada;
		RETURN id_gerada;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE '[Erro] Dados inválidos inseridos !';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;




CREATE OR REPLACE FUNCTION usuarioExcluir (id INTEGER)
RETURNS INTEGER AS $$
BEGIN 
	UPDATE usuario SET inativo = TRUE, data_inatividade = CURRENT_DATE WHERE id_usuario = (id);
	IF (FOUND) THEN
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE '[Erro] Dados inválidos inseridos !';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;