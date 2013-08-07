CREATE OR REPLACE FUNCTION usuarioInsert (id INTEGER, nome VARCHAR, login VARCHAR, senha VARCHAR, inativo BOOLEAN, tipo INTEGER)
RETURNS INTEGER AS $usuarioInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO usuario (id_usuario, nome, login, senha, inativo, fk_tipo)
		VALUES (id, nome, login, senha, inativo, tipo);
		RETURN confirm;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE 'Check violation: Parametros de entrada 
			nao correspondem as exigencias dos atributos.';
		RETURN 0;
END;
$usuarioInsert$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION usuarioInsert (nome VARCHAR, login VARCHAR, senha VARCHAR, inativo BOOLEAN, tipo INTEGER)
RETURNS INTEGER AS $usuarioInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO usuario (nome, login, senha, inativo, fk_tipo)
		VALUES (nome, login, senha, inativo, tipo);
		RETURN confirm;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE 'Check violation: Parametros de entrada 
			nao correspondem as exigencias dos atributos.';
		RETURN 0;
END;
$usuarioInsert$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION usuarioInsert (nome VARCHAR, login VARCHAR, senha VARCHAR, tipo INTEGER)
RETURNS INTEGER AS $usuarioInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO usuario (nome, login, senha, fk_tipo)
		VALUES (nome, login, senha, tipo);
		RETURN confirm;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE 'Check violation: Parametros de entrada 
			nao correspondem as exigencias dos atributos.';
		RETURN 0;
END;
$usuarioInsert$ LANGUAGE PLPGSQL;



CREATE OR REPLACE FUNCTION usuarioUpdate (id INTEGER, nome VARCHAR, login VARCHAR, senha VARCHAR, inativo BOOLEAN, tipo INTEGER)
RETURNS INTEGER AS $usuarioUpdate$
DECLARE
	confirm INT;
BEGIN 
UPDATE usuario SET nome = nome, login = login, senha = senha, inativo = inativo, fk_tipo = tipo WHERE id_usuario = (id);
		RETURN confirm;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE 'Check violation: Parametros de entrada 
			nao correspondem as exigencias dos atributos.';
		RETURN 0;
END;
$usuarioUpdate$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION usuarioUpdate (id INTEGER, inativo BOOLEAN)
RETURNS INTEGER AS $usuarioUpdate$
DECLARE
	confirm INT;
BEGIN 
UPDATE usuario SET inativo = inativo WHERE id_usuario = (id);
		RETURN confirm;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE 'Check violation: Parametros de entrada 
			nao correspondem as exigencias dos atributos.';
		RETURN 0;
END;
$usuarioUpdate$ LANGUAGE PLPGSQL;



CREATE OR REPLACE FUNCTION usuarioDelete (id INTEGER)
RETURNS INTEGER AS $usuarioDel$
DECLARE
	confirm INT;
BEGIN 
	DELETE FROM usuario WHERE id_usuario = (id);
		RETURN confirm;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE 'Check violation: Parametros de entrada 
			nao correspondem as exigencias dos atributos.';
		RETURN 0;
END;
$usuarioDel$ LANGUAGE PLPGSQL;