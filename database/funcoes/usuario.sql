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


--Gera uma nova senha randômica ao usuário e a retorna para que esta seja disponibilizada para ele por email
CREATE OR REPLACE FUNCTION recuperarSenha (login VARCHAR)
RETURNS VARCHAR AS $$
DECLARE
	id INT;
	password VARCHAR;
BEGIN
	password:= ROUND(RANDOM()*10000000); 
	SELECT INTO id id_usuario FROM usuario WHERE email = login;
	IF (FOUND) THEN
		UPDATE usuario SET senha = md5(password) WHERE id_usuario = (id);
		RAISE NOTICE 'Nova senha enviada para o seu email! Altere a senha para uma de sua preferência quando logar novamente no sistema.';
		RETURN password;
	ELSE
		RAISE EXCEPTION '[Erro] Email não cadastrado no sistema!';
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

--Inativa o usuário
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


--Exclui todos usuários que estão inativos à um ano ou mais
CREATE OR REPLACE FUNCTION usuarioExcluir ()
RETURNS INTEGER AS $$
BEGIN
	DELETE FROM usuario WHERE inativo = TRUE AND age(data_inatividade) >= '1 year';
	IF (FOUND) THEN
		RAISE NOTICE 'Usuários excluídos com sucesso!';
		RETURN 1;
	ELSE
		RAISE EXCEPTION 'Usuários não excluídos!';
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
	id INT;
	name VARCHAR;
	inatividade BOOLEAN;
BEGIN 
	SELECT INTO id, name id_usuario, nome FROM usuario WHERE email = login AND senha = md5(password);
	IF (FOUND) THEN
		SELECT INTO inatividade inativo FROM usuario WHERE id_usuario = id;
		IF (inatividade = TRUE) THEN
			UPDATE usuario SET inativo = FALSE, data_inatividade = NULL WHERE id_usuario = (id);
			RAISE NOTICE 'Sua conta foi reativada!';
		END IF;	
		RAISE NOTICE 'Olá, %', name;
		RETURN id;
	ELSE
		RAISE EXCEPTION '[Erro] Email ou senha inválidos!';
		RETURN 0;
	END IF;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE EXCEPTION '[Erro] Dados inválidos inseridos!';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;

--END LOGIN;