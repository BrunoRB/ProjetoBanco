CREATE OR REPLACE FUNCTION usuarioCadastrar (id INTEGER, nome VARCHAR, login VARCHAR, senha VARCHAR, email VARCHAR, inativo BOOLEAN, inatividade DATE)
RETURNS INTEGER AS $$
DECLARE
	id_gerada INT;
BEGIN 
	INSERT INTO usuario (id_usuario, nome, login, senha, email, inativo, data_inatividade)
		VALUES (id, nome, login, md5(senha), email, inativo, inatividade) RETURNING id_usuario INTO id_gerada;
		RAISE NOTICE 'Usuário cadastrado com sucesso!';
		RETURN id_gerada;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE '[Erro] Dados inválidos inseridos !';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION usuarioCadastrar (nome VARCHAR, login VARCHAR, senha VARCHAR, email VARCHAR, inativo BOOLEAN, inatividade DATE)
RETURNS INTEGER AS $$
DECLARE
	id_gerada INT;
BEGIN 
	INSERT INTO usuario (nome, login, senha, email, inativo, data_inatividade)
		VALUES (nome, login, md5(senha), email, inativo, inatividade) RETURNING id_usuario INTO id_gerada;
		RAISE NOTICE 'Usuário cadastrado com sucesso!';
		RETURN id_gerada;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE '[Erro] Dados inválidos inseridos !';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;



CREATE OR REPLACE FUNCTION usuarioCadastrar (nome VARCHAR, login VARCHAR, senha VARCHAR, email VARCHAR)
RETURNS INTEGER AS $$
DECLARE
	id_gerada INT;
BEGIN 
	INSERT INTO usuario (nome, login, senha, email)
		VALUES (nome, login, md5(senha), email) RETURNING id_usuario INTO id_gerada;
		RAISE NOTICE 'Usuário cadastrado com sucesso!';
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
		RAISE NOTICE 'Usuário inativado com sucesso!';
		RETURN 1;
	ELSE
		RAISE NOTICE 'Usuário não inativado!';
		RETURN 0;
	END IF;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE '[Erro] Dados inválidos inseridos !';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;



CREATE OR REPLACE FUNCTION logar (logon VARCHAR, password VARCHAR)
RETURNS INTEGER AS $$
DECLARE
	id_gerada INT;
	name VARCHAR;
BEGIN 
	SELECT INTO id_gerada, name id_usuario, nome FROM usuario WHERE login = logon AND senha = md5(password);
	IF (FOUND) THEN
		RAISE NOTICE 'Olá, %', name;
		RETURN id_gerada;
	ELSE
		RAISE NOTICE '[Erro] Login ou senha inválidos!';
		RETURN 0;
	END IF;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE '[Erro] Dados inválidos inseridos!';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;