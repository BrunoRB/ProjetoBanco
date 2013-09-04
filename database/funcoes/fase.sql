
--INSERTS;

--todos
CREATE OR REPLACE FUNCTION faseCadastrar(nome_p VARCHAR(100), descricao_p TEXT, id_projeto INTEGER, id_predecessora INTEGER) RETURNS INTEGER AS $$
	DECLARE
		cod_fase INTEGER;
	BEGIN
		SET ROLE insert;
		INSERT INTO fase (nome, descricao, fk_projeto, fk_predecessora) 
		VALUES (nome_p, descricao_p, id_projeto, id_predecessora);

		SET ROLE retrieve;
		SELECT INTO cod_fase currval('fase_id_fase_seq');
		EXECUTE mensagemDeSucesso('fase', 'cadastrada');
		RETURN cod_fase;
	END;
$$ LANGUAGE PLPGSQL;

--sem predecessora
CREATE OR REPLACE FUNCTION faseCadastrar(nome_p VARCHAR(100), descricao_p TEXT, id_projeto INTEGER) RETURNS INTEGER AS $$
	DECLARE
		cod_fase INTEGER;
	BEGIN
		SET ROLE insert;
		INSERT INTO fase (nome, descricao, fk_projeto) 
		VALUES (nome_p, descricao_p, id_projeto);

		SET ROLE retrieve;
		SELECT INTO cod_fase currval('fase_id_fase_seq');
		EXECUTE mensagemDeSucesso('fase', 'cadastrada');
		RETURN cod_fase;
	END;
$$ LANGUAGE PLPGSQL;

--sem descricao
CREATE OR REPLACE FUNCTION faseCadastrar(nome_p VARCHAR(100), id_projeto INTEGER, id_predecessora INTEGER) RETURNS INTEGER AS $$
	DECLARE
		cod_fase INTEGER;
	BEGIN
		SET ROLE insert;
		INSERT INTO fase (nome, fk_projeto, fk_predecessora) 
		VALUES (nome_p, id_projeto, id_predecessora);

		SET ROLE retrieve;
		SELECT INTO cod_fase currval('fase_id_fase_seq');
		EXECUTE mensagemDeSucesso('fase', 'cadastrada');		
		RETURN cod_fase;
	END;
$$ LANGUAGE PLPGSQL;

--sem descricao e predecessora
CREATE OR REPLACE FUNCTION faseCadastrar(nome_p VARCHAR(100), id_projeto INTEGER) RETURNS INTEGER AS $$
	DECLARE
		cod_fase INTEGER;
	BEGIN
		SET ROLE insert;
		INSERT INTO fase (nome, fk_projeto) 
		VALUES (nome_p, id_projeto);

		SET ROLE retrieve;
		SELECT INTO cod_fase currval('fase_id_fase_seq');
		EXECUTE mensagemDeSucesso('fase', 'cadastrada');
		RETURN cod_fase;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;

--UPDATE;

--tudo
CREATE OR REPLACE FUNCTION faseAtualizar(id INTEGER, nome_p VARCHAR(100), descricao_p TEXT, id_projeto INTEGER, id_predecessora INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		SET ROLE update;
		UPDATE fase SET nome = nome_p, descricao = descricao_p, fk_projeto = id_projeto, fk_predecessora = id_predecessora WHERE id_fase = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('fase', 'atualizada');
			RETURN 1;
		ELSE
			RAISE NOTICE 'Falha ao atualizar fase!';
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--sem descrição
CREATE OR REPLACE FUNCTION faseAtualizar(id INTEGER, nome_p VARCHAR(100), id_projeto INTEGER, id_predecessora INTEGER)
RETURNS INTEGER AS $$
	BEGIN	
		SET ROLE update;
		UPDATE fase SET nome = nome_p, fk_projeto = id_projeto, fk_predecessora = id_predecessora WHERE id_fase = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('fase', 'atualizada');
			RETURN 1;
		ELSE
			RAISE NOTICE 'Falha ao atualizar fase!';
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--sem predecedora
CREATE OR REPLACE FUNCTION faseAtualizar(id INTEGER, nome_p VARCHAR(100), descricao_p TEXT, id_projeto INTEGER)
RETURNS INTEGER AS $$
	BEGIN	
		SET ROLE update;
		UPDATE fase SET nome = nome_p, descricao = descricao_p, fk_projeto = id_projeto WHERE id_fase = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('fase', 'atualizada');
			RETURN 1;
		ELSE
			RAISE NOTICE 'Falha ao atualizar fase!';
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--sem predecedora e descricao
CREATE OR REPLACE FUNCTION faseAtualizar(id INTEGER, nome_p VARCHAR(100), id_projeto INTEGER)
RETURNS INTEGER AS $$
	BEGIN	
		SET ROLE update;
		UPDATE fase SET nome = nome_p, fk_projeto = id_projeto WHERE id_fase = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('fase', 'atualizada');
			RETURN 1;
		ELSE
			RAISE NOTICE 'Falha ao atualizar fase!';
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END UPDATE;

--DELETES;

CREATE OR REPLACE FUNCTION faseExcluir (id INTEGER) RETURNS INTEGER AS $$
	BEGIN
		SET ROLE update;
		UPDATE fase SET fk_predecessora = null WHERE fk_predecessora = id;
		UPDATE atividade SET fk_fase = null WHERE fk_fase = id;

		SET ROLE delete;
		DELETE FROM fase WHERE id_fase = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('fase', 'excluida');
			RETURN 1;
		END IF;
		
		RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETES;


