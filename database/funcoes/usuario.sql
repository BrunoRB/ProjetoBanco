--INSERTS;

CREATE OR REPLACE FUNCTION usuarioCadastrar (nome VARCHAR, email VARCHAR, senha VARCHAR)
RETURNS INTEGER AS $$
DECLARE
	id_gerada INT;
BEGIN 
	INSERT INTO usuario (nome, email, senha)
		VALUES (nome, email, md5(senha)) RETURNING id_usuario INTO id_gerada;
		RAISE NOTICE 'Usu�rio cadastrado com sucesso!';
		RETURN id_gerada;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE '[Erro] Dados inv�lidos inseridos!';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;


--DELETES;

CREATE OR REPLACE FUNCTION usuarioExcluir (id INTEGER)
RETURNS INTEGER AS $$
BEGIN 
	UPDATE usuario SET inativo = TRUE, data_inatividade = CURRENT_DATE WHERE id_usuario = (id);
	IF (FOUND) THEN
		RAISE NOTICE 'Usu�rio inativado com sucesso!';
		RETURN 1;
	ELSE
		RAISE NOTICE 'Usu�rio n�o inativado!';
		RETURN 0;
	END IF;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE '[Erro] Dados inv�lidos inseridos!';
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
BEGIN 
	SELECT INTO id_gerada, name id_usuario, nome FROM usuario WHERE email = login AND senha = md5(password);
	IF (FOUND) THEN
		RAISE NOTICE 'Ol�, %', name;
		RETURN id_gerada;
	ELSE
		RAISE NOTICE '[Erro] Login ou senha inv�lidos!';
		RETURN 0;
	END IF;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE '[Erro] Dados inv�lidos inseridos!';
		RETURN 0;
END;
$$ LANGUAGE PLPGSQL;

--END LOGIN;