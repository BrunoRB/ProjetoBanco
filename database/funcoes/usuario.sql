--INSERTS;

CREATE OR REPLACE FUNCTION usuarioCadastrar (nome VARCHAR, email VARCHAR, senha VARCHAR)
RETURNS INTEGER AS $$
DECLARE
	id_gerada INT;
BEGIN 
	INSERT INTO usuario (nome, email, senha)
		VALUES (nome, email, md5(senha)) RETURNING id_usuario INTO id_gerada;
		RAISE NOTICE 'Usuário cadastrado com sucesso!';
		RETURN id_gerada;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE EXCEPTION '[Erro] Dados inválidos inseridos!';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;


--UPDATES;

CREATE OR REPLACE FUNCTION alterarSenha (id INTEGER, senha_antiga VARCHAR, senha_nova VARCHAR)
RETURNS INTEGER AS $$
DECLARE
	password VARCHAR;
BEGIN 
	SELECT INTO password senha FROM usuario WHERE id_usuario = id;
	IF (password = md5(senha_antiga)) THEN
		UPDATE usuario SET senha = md5(senha_nova) WHERE id_usuario = (id);
		RAISE NOTICE 'Senha alterada com sucesso!';		
		RETURN 1;
	ELSE
		RAISE EXCEPTION 'Senha atual incorreta!';
		RETURN 0;
	END IF;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE EXCEPTION '[Erro] Dados inválidos inseridos!';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;

--END UPDATES:


--DELETES;

CREATE OR REPLACE FUNCTION usuarioExcluir (id INTEGER)
RETURNS INTEGER AS $$
BEGIN 
	UPDATE usuario SET inativo = TRUE, data_inatividade = CURRENT_DATE WHERE id_usuario = (id);
	IF (FOUND) THEN
		RAISE NOTICE 'Usuário inativado com sucesso!';
		RETURN 1;
	ELSE
		RAISE EXCEPTION 'Usuário não inativado!';
		RETURN 0;
	END IF;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE EXCEPTION '[Erro] Dados inválidos inseridos!';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;

--END DELETES;


--LOGIN;

CREATE OR REPLACE FUNCTION logar (login VARCHAR, password VARCHAR)
RETURNS INTEGER AS $$
DECLARE
	id_gerada INT;
	name VARCHAR;
	inatividade BOOLEAN;
BEGIN 
	SELECT INTO id_gerada, name id_usuario, nome FROM usuario WHERE email = login AND senha = md5(password);
	IF (FOUND) THEN
		SELECT INTO inatividade inativo FROM usuario WHERE id_usuario = id_gerada;
		IF (inatividade = TRUE) THEN
			UPDATE usuario SET inativo = FALSE, data_inatividade = NULL WHERE id_usuario = (id_gerada);
			RAISE NOTICE 'Sua conta foi reativada!';
		END IF;	
		RAISE NOTICE 'Olá, %', name;
		RETURN id_gerada;
	ELSE
		RAISE EXCEPTION '[Erro] Login ou senha inválidos!';
		RETURN 0;
	END IF;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE EXCEPTION '[Erro] Dados inválidos inseridos!';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;

--END LOGIN;