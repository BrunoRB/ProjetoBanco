CREATE OR REPLACE FUNCTION usuarioInsert (INTEGER, VARCHAR, VARCHAR, VARCHAR, INTEGER)
RETURNS INTEGER AS $usuarioInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO usuario (id_usuario, nome, login, senha, fk_tipo)
		VALUES ($1, $2, $3, $4, $5);
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


CREATE OR REPLACE FUNCTION usuarioInsert (VARCHAR, VARCHAR, VARCHAR, INTEGER)
RETURNS INTEGER AS $usuarioInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO usuario (nome, login, senha, fk_tipo)
		VALUES ($1, $2, $3, $4);
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

CREATE OR REPLACE FUNCTION usuarioUpdate (INTEGER, VARCHAR, VARCHAR, VARCHAR, INTEGER)
RETURNS INTEGER AS $usuarioUpdate$
DECLARE
	confirm INT;
BEGIN 
UPDATE usuario SET nome = $2, login = $3, senha = $4, fk_tipo = $5 WHERE id_usuario = ($1);
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

CREATE OR REPLACE FUNCTION usuarioDelete (INTEGER)
RETURNS INTEGER AS $usuarioDel$
DECLARE
	confirm INT;
BEGIN 
	DELETE FROM usuario WHERE id_usuario = ($1);
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