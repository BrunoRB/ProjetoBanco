CREATE OR REPLACE FUNCTION membroInsert (INTEGER, DATE, VARCHAR, INTEGER)
RETURNS INTEGER AS $membroInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO membro (id_membro, data_de_nascimento, funcao, fk_usuario)
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
$membroInsert$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION membroInsert (DATE, VARCHAR, INTEGER)
RETURNS INTEGER AS $membroInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO membro (data_de_nascimento, funcao, fk_usuario)
		VALUES ($1, $2, $3);
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


CREATE OR REPLACE FUNCTION membroInsert (VARCHAR, INTEGER)
RETURNS INTEGER AS $membroInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO membro (funcao, fk_usuario)
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
$membroInsert$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION membroInsert (DATE, INTEGER)
RETURNS INTEGER AS $membroInsert$
DECLARE
	confirm INT;
BEGIN 
	INSERT INTO membro (data_de_nascimento, fk_usuario)
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
$membroInsert$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION membroUpdate (INTEGER, DATE, VARCHAR, INTEGER)
RETURNS INTEGER AS $membroUpdate$
DECLARE
	confirm INT;
BEGIN 
UPDATE membro SET data_de_nascimento = $2, funcao = $3, fk_tipo = $4 WHERE id_membro = ($1);
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

CREATE OR REPLACE FUNCTION membroDelete (INTEGER)
RETURNS INTEGER AS $membroDel$
DECLARE
	confirm INT;
BEGIN 
	DELETE FROM membro WHERE id_membro = ($1);
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

CREATE OR REPLACE FUNCTION membroCadastra (VARCHAR, VARCHAR, VARCHAR, DATE, VARCHAR)
RETURNS VOID AS $membroCadastra$
DECLARE
	tipo_id INT;
	usuario_id INT;
	confirm_usuario INT;
	confirm_membro INT;
	nome ALIAS FOR $1;
login ALIAS FOR $2;
	senha ALIAS FOR $3;
data_nascimento ALIAS FOR $4;
funcao ALIAS FOR $5;

BEGIN 
	SELECT INTO tipo_id id_tipo FROM tipo WHERE tipo = 'membro';
	confirm_usuario := usuarioInsert (nome, login, senha, tipo_id);
	IF confirm_usuario = 0 THEN
RAISE NOTICE 'Erro ao cadastrar membro';
	ELSE 
SELECT INTO usuario_id last_value FROM usuario_id_usuario_seq;
confirm_membro := membroInsert (data_nascimento, funcao, usuario_id);
IF confirm_membro = 0 THEN
		RAISE NOTICE 'Erro ao cadastrar membro';
	ELSE
RAISE NOTICE 'Membro cadastrado com sucesso!';
		END IF;
END IF;
END;
$membroCadastra$ LANGUAGE PLPGSQL;