CREATE OR REPLACE FUNCTION membroInsert (id INTEGER, nasc DATE, func VARCHAR, usuario INTEGER)
RETURNS INTEGER AS $membroInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO membro (id_membro, data_de_nascimento, funcao, fk_usuario)
		VALUES (id, nasc, func, usuario);
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
$membroInsert$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION membroInsert (nasc DATE, func VARCHAR, usuario INTEGER)
RETURNS INTEGER AS $membroInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO membro (data_de_nascimento, funcao, fk_usuario)
		VALUES (nasc, func, usuario);
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
$membroInsert$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION membroInsert (func VARCHAR, usuario INTEGER)
RETURNS INTEGER AS $membroInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO membro (funcao, fk_usuario)
		VALUES (func, usuario);
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
$membroInsert$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION membroInsert (nasc DATE, usuario INTEGER)
RETURNS INTEGER AS $membroInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO membro (data_de_nascimento, fk_usuario)
		VALUES (nasc, usuario);
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
$membroInsert$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION membroUpdate (id INTEGER, nasc DATE, func VARCHAR, usuario INTEGER)
RETURNS INTEGER AS $membroUpdate$
DECLARE
	confirm INT;
BEGIN 
UPDATE membro SET data_de_nascimento = nasc, funcao = func, fk_tipo = usuario WHERE id_membro = (id);
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
$membroUpdate$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION membroDelete (id INTEGER)
RETURNS INTEGER AS $membroDel$
DECLARE
	confirm INT;
BEGIN 
	DELETE FROM membro WHERE id_membro = (id);
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
$membroDel$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION membroCadastra (nome VARCHAR, login VARCHAR, senha VARCHAR, nasc DATE, func VARCHAR)
RETURNS VOID AS $membroCadastra$
DECLARE
	tipo_id INT;
	usuario_id INT;
	confirm_usuario INT;
	confirm_membro INT;
BEGIN 
	SET ROLE retrieve;
	SELECT INTO tipo_id id_tipo FROM tipo WHERE tipo = 'membro';
	SET ROLE insert;
	confirm_usuario := usuarioInsert (nome, login, senha, tipo_id);
	IF confirm_usuario = 0 THEN
		RAISE NOTICE 'Erro ao cadastrar membro';
	ELSE 
		SET ROLE retrieve;
		SELECT INTO usuario_id last_value FROM usuario_id_usuario_seq;
		SET ROLE insert;
		confirm_membro := membroInsert (nasc, func, usuario_id);
		IF confirm_membro = 0 THEN
			RAISE NOTICE 'Erro ao cadastrar membro';
		ELSE
			RAISE NOTICE 'Membro cadastrado com sucesso!';
		END IF;
	END IF;
END;
$membroCadastra$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION membroExclui (login VARCHAR)
RETURNS VOID AS $membroExclui$
DECLARE
	usuario_id INT;
	membro_id INT;
	confirm_usuario INT;
	confirm_membro INT;
BEGIN 
	SET ROLE retrieve;
	SELECT INTO usuario_id id_usuario FROM usuario WHERE login = login;
	SELECT INTO membro_id id_membro FROM membro WHERE fk_usuario = usuario_id;
	SET ROLE delete;
	confirm_membro := membroDelete (membro_id);
	IF confirm_cliente = 0 THEN
		RAISE NOTICE 'Erro ao excluir Membro';~
	ELSE
		confirm_usuario := usuarioDelete (usuario_id);
		IF confirm_usuario = 0 THEN
			RAISE NOTICE 'Erro ao excluir Membro';
		ELSE
			RAISE NOTICE 'Membro excluído com sucesso!';
		END IF;
	END IF;
END;
$membroExclui$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION membroAtualiza (nome VARCHAR, login VARCHAR, senha VARCHAR, nasc DATE, func VARCHAR)
RETURNS VOID AS $clienteAtualiza$
DECLARE
	tipo_id INT;
	usuario_id INT;
	membro_id INT;
	confirm_usuario INT;
	confirm_membro INT;
BEGIN 
	SET ROLE retrieve;
	SELECT INTO tipo_id id_tipo FROM tipo WHERE tipo = 'membro';
	SELECT INTO usuario_id id_usuario FROM usuario WHERE login = login;
	SELECT INTO membro_id id_membro FROM membro WHERE fk_usuario = usuario_id;
	SET ROLE update;
	confirm_membro := membroUpdate (membro_id, nasc, func, usuario_id);
	IF confirm_membro = 0 THEN
		RAISE NOTICE 'Erro ao atualizar Membro';
	ELSE
		confirm_usuario := usuarioUpdate (usuario_id, nome, login, senha, tipo_id);
		IF confirm_usuario = 0 THEN
			RAISE NOTICE 'Erro ao atualizar Membro';
		ELSE
			RAISE NOTICE 'Membro atualizado com sucesso!';
		END IF;
	END IF;
END;
$membroAtualiza$ LANGUAGE PLPGSQL;