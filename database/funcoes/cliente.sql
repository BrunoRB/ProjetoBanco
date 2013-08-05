CREATE OR REPLACE FUNCTION clienteInsert (id INTEGER, usuario INTEGER)
RETURNS INTEGER AS $clienteInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO cliente (id_cliente, fk_usuario)
		VALUES (id, usuario);
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


CREATE OR REPLACE FUNCTION clienteInsert (usuario INTEGER)
RETURNS INTEGER AS $clienteInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO cliente (fk_usuario)
		VALUES (usuario);
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

CREATE OR REPLACE FUNCTION clienteUpdate (id INTEGER, usuario INTEGER)
RETURNS INTEGER AS $clienteUpdate$
DECLARE
	confirm INT;
BEGIN 
UPDATE cliente SET fk_usuario = usuario WHERE id_cliente = (id);
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

CREATE OR REPLACE FUNCTION cienteDelete (id INTEGER)
RETURNS INTEGER AS $clienteDel$
DECLARE
	confirm INT;
BEGIN 
	DELETE FROM cliente WHERE id_cliente = (id);
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

CREATE OR REPLACE FUNCTION clienteCadastra (nome VARCHAR, login VARCHAR, senha VARCHAR)
RETURNS VOID AS $clienteCadastra$
DECLARE
	tipo_id INT;
	usuario_id INT;
	confirm_usuario INT;
	confirm_cliente INT;
BEGIN 
	SET ROLE retrieve;
	SELECT INTO tipo_id id_tipo FROM tipo WHERE tipo = 'cliente';
	SET ROLE insert;
	confirm_usuario := usuarioInsert (nome, login, senha, FALSE, tipo_id);
	IF confirm_usuario = 0 THEN
		RAISE NOTICE 'Erro ao cadastrar cliente';
	ELSE
		SET ROLE retrieve;
		SELECT INTO usuario_id last_value FROM usuario_id_usuario_seq;
		SET ROLE insert;
		confirm_cliente := clienteInsert (usuario_id);
		IF confirm_cliente = 0 THEN
			RAISE NOTICE 'Erro ao cadastrar cliente';
		ELSE
			RAISE NOTICE 'Cliente atualizado com sucesso!';
		END IF;
	END IF;
END;
$clienteCadastra$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION clienteExclui (login VARCHAR)
RETURNS VOID AS $clienteExclui$
DECLARE
	usuario_id INT;
	cliente_id INT;
	confirm_usuario INT;
BEGIN 
	SET ROLE retrieve;
	SELECT INTO usuario_id id_usuario FROM usuario WHERE login = login;
	SET ROLE delete;
	confirm_usuario := usuarioUpdate (usuario_id, TRUE);
	IF confirm_usuario = 0 THEN
		RAISE NOTICE 'Erro ao excluir cliente';
	ELSE
		RAISE NOTICE 'Cliente exclu�do com sucesso!';
	END IF;
END;
$clienteExclui$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION clienteAtualiza (nome VARCHAR, login VARCHAR, senha VARCHAR)
RETURNS VOID AS $clienteAtualiza$
DECLARE
	tipo_id INT;
	usuario_id INT;
	confirm_usuario INT;
	confirm_cliente INT;
BEGIN 
	SET ROLE retrieve;
	SELECT INTO tipo_id id_tipo FROM tipo WHERE tipo = 'cliente';
	SELECT INTO usuario_id id_usuario FROM usuario WHERE login = login;
	SET ROLE update;
	confirm_usuario := usuarioUpdate (usuario_id, nome, login, senha, FALSE, tipo_id);
	IF confirm_usuario = 0 THEN
		RAISE NOTICE 'Erro ao atualizar cliente';
	ELSE
		RAISE NOTICE 'Cliente atualizado com sucesso!';
	END IF;
END;
$clienteAtualiza$ LANGUAGE PLPGSQL;