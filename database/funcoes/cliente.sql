CREATE OR REPLACE FUNCTION clienteInsert (INTEGER, INTEGER)
RETURNS INTEGER AS $clienteInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO cliente (id_usuario, fk_usuario)
		VALUES ($1, $2);
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
$clienteInsert$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION clienteInsert (INTEGER)
RETURNS INTEGER AS $clienteInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO cliente (fk_usuario)
		VALUES ($1);
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
$clienteInsert$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION clienteUpdate (INTEGER, VARCHAR, INTEGER)
RETURNS INTEGER AS $clienteUpdate$
DECLARE
	confirm INT;
BEGIN 
UPDATE cliente SET fk_tipo = $2 WHERE id_cliente = ($1);
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
$clienteUpdate$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION cienteDelete (INTEGER)
RETURNS INTEGER AS $clienteDel$
DECLARE
	confirm INT;
BEGIN 
	DELETE FROM cliente WHERE id_cliente = ($1);
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
$clienteDel$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION clienteCadastra (VARCHAR, VARCHAR, VARCHAR)
RETURNS VOID AS $clienteCadastra$
DECLARE
	tipo_id INT;
	usuario_id INT;
BEGIN 
	SELECT INTO tipo_id id_tipo FROM tipo WHERE tipo = 'cliente';
	PERFORM usuarioInsert ($1, $2, $3, tipo_id);
	SELECT INTO usuario_id last_value FROM usuario_id_usuario_seq;
PERFORM clienteInsert (usuario_id);
RAISE NOTICE 'Cliente cadastrado com sucesso!';
END;
$clienteCadastra$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION clienteExclui (VARCHAR)
RETURNS VOID AS $clienteExclui$
DECLARE
	usuario_id INT;
	cliente_id INT;
BEGIN 
	SELECT INTO usuario_id id_usuario FROM usuario WHERE login = $1;
SELECT INTO cliente_id id_cliente FROM cliente WHERE fk_usuario = usuario_id;
PERFORM cienteDelete (cliente_id);
PERFORM usuarioDelete (usuario_id);
RAISE NOTICE 'Cliente excluído com sucesso!';
END;
$clienteExclui$ LANGUAGE PLPGSQL;