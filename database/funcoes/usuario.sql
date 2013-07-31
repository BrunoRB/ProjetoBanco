CREATE OR REPLACE FUNCTION usuarioInsert (id INTEGER, nome VARCHAR, login VARCHAR, senha VARCHAR, tipo INTEGER)
RETURNS INTEGER AS $usuarioInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO usuario (id_usuario, nome, login, senha, fk_tipo)
		VALUES (id, nome, login, senha, tipo);
		GET DIAGNOSTICS confirm = ROW_COUNT;
		RETURN confirm;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE 'Check violation: Parametros de entrada 
			nao correspondem as exigencias dos atributos.';
		RETURN 0;
	WHEN UNDEFINED_COLUMN THEN
		RAISE NOTICE 'Undefined column: Coluna solicitada 
			nao corresponde aos campos da tabela.';
		RETURN 0;
	WHEN OTHERS THEN
		RAISE NOTICE 'Others: Erro ao inserir.';
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
		GET DIAGNOSTICS confirm = ROW_COUNT;
		RETURN confirm;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE 'Check violation: Parametros de entrada 
			nao correspondem as exigencias dos atributos.';
		RETURN 0;
	WHEN UNDEFINED_COLUMN THEN
		RAISE NOTICE 'Undefined column: Coluna solicitada 
			nao corresponde aos campos da tabela.';
		RETURN 0;
	WHEN OTHERS THEN
		RAISE NOTICE 'Others: Erro ao inserir.';
		RETURN 0;
END;
$usuarioInsert$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION usuarioUpdate (id INTEGER, nome VARCHAR, login VARCHAR, senha VARCHAR, tipo INTEGER)
RETURNS INTEGER AS $usuarioUpdate$
DECLARE
	confirm INT;
BEGIN 
UPDATE usuario SET nome = nome, login = login, senha = senha, fk_tipo = tipo WHERE id_usuario = (id);
		GET DIAGNOSTICS confirm = ROW_COUNT;
		RETURN confirm;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE 'Check violation: Parametros de entrada 
			nao correspondem as exigencias dos atributos.';
		RETURN 0;
	WHEN UNDEFINED_COLUMN THEN
		RAISE NOTICE 'Undefined column: Coluna solicitada 
			nao corresponde aos campos da tabela.';
		RETURN 0;
	WHEN OTHERS THEN
		RAISE NOTICE 'Others: Erro ao inserir.';
		RETURN 0;
END;
$usuarioUpdate$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION usuarioDelete (id INTEGER)
RETURNS INTEGER AS $usuarioDel$
DECLARE
	confirm INT;
BEGIN 
	DELETE FROM usuario WHERE id_usuario = (id);
		GET DIAGNOSTICS confirm = ROW_COUNT;
		RETURN confirm;
EXCEPTION 
	WHEN CHECK_VIOLATION THEN
		RAISE NOTICE 'Check violation: Parametros de entrada 
			nao correspondem as exigencias dos atributos.';
		RETURN 0;
	WHEN UNDEFINED_COLUMN THEN
		RAISE NOTICE 'Undefined column: Coluna solicitada 
			nao corresponde aos campos da tabela.';
		RETURN 0;
	WHEN OTHERS THEN
		RAISE NOTICE 'Others: Erro ao deletar.';
		RETURN 0;
END;
$usuarioDel$ LANGUAGE PLPGSQL;