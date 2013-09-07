--INSERTS

CREATE OR REPLACE FUNCTION recursoCadastrar (idUsuario INTEGER, id_projeto INTEGER, nome_p VARCHAR(100), descricao_p TEXT, id_despesa INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		cod_recurso INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, id_projeto) THEN
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO recurso (nome, descricao, fk_projeto, fk_despesa) 
		VALUES (nome_p, descricao_p, id_projeto, id_despesa);

		SET ROLE retrieve;
		SELECT INTO cod_recurso currval('recurso_id_recurso_seq');
		EXECUTE mensagemDeSucesso('Recurso', 'Cadastrado');
		RETURN cod_recurso;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'Falha ao cadastrar recurso!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION recursoCadastrar (idUsuario INTEGER, id_projeto INTEGER, nome_p VARCHAR(100), descricao_p TEXT)
RETURNS INTEGER AS $$
	DECLARE 
		cod_recurso INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, id_projeto) THEN
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO recurso (nome, descricao, fk_projeto)
		VALUES (nome_p, descricao_p, id_projeto);

		SET ROLE retrieve;
		SELECT INTO cod_recurso currval('recurso_id_recurso_seq');
		EXECUTE mensagemDeSucesso('Recurso', 'Cadastrado');
		RETURN cod_recurso;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'Falha ao cadastrar recurso!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION recursoCadastrar (idUsuario INTEGER, id_projeto INTEGER, nome_p VARCHAR(100), id_despesa INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		cod_recurso INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, id_projeto) THEN
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO recurso (nome, fk_projeto, fk_despesa)
		VALUES (nome_p, id_projeto, id_despesa);

		SET ROLE retrieve;
		SELECT INTO cod_recurso currval('recurso_id_recurso_seq');
		EXECUTE mensagemDeSucesso('Recurso', 'Cadastrado');
		RETURN cod_recurso;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'Falha ao cadastrar recurso!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION recursoCadastrar (idUsuario INTEGER, id_projeto INTEGER, nome_p VARCHAR(100))
RETURNS INTEGER AS $$
	DECLARE 
		cod_recurso INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, id_projeto) THEN
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO recurso (nome, fk_projeto)
		VALUES (nome_p, id_projeto);

		SET ROLE retrieve;
		SELECT INTO cod_recurso currval('recurso_id_recurso_seq');
		EXECUTE mensagemDeSucesso('Recurso', 'Cadastrado');
		RETURN cod_recurso;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'Falha ao cadastrar recurso!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS

--UPDATE

CREATE OR REPLACE FUNCTION recursoAtualizar (idUsuario INTEGER, id_projeto INTEGER, id INTEGER, nome_p VARCHAR(100), descricao TEXT, id_despesa INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		IF NOT isGerente(idUsuario, id_projeto) THEN
			RETURN 0;
		END IF;

		SET ROLE update;
		UPDATE recuso SET nome = nome_p, descricao = descricao_p, fk_projeto = id_projeto, fk_despesa = id_despesa
		WHERE id_recuso = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Recurso', 'atualizado');
			RETURN 1;
		ELSE
			RAISE NOTICE 'Falha ao atualizar recurso';
			RETURN 0;
		END IF;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'Falha ao atualizar recurso!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END UPDATE

--DELETE

--delete por id
CREATE OR REPLACE FUNCTION recursoExcluir(idUsuario INTEGER, idProjeto INTEGER, id INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;

		SET ROLE delete;
		DELETE FROM recurso WHERE id_recurso = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('recurso', 'excluido');
			RETURN 1;
		ELSE
			RAISE NOTICE 'Falha ao excluir o recurso!';
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;
--END DELETE
