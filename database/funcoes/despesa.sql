--INSERT

CREATE OR REPLACE FUNCTION despesaCadastrar (nome_p VARCHAR(100), valor_p NUMERIC(19,0), descricao_p TEXT, id_projeto INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		cod_despesa INTEGER;
	BEGIN
		SET ROLE insert;
		INSERT INTO despesa (nome, valor, descricao, fk_projeto)
			VALUES (nome_p, valor_p, descricao_p, id_projeto);
		
		SET ROLE retrieve;
		SELECT INTO cod_despesa currval('despesa_id_despesa_seq');
		EXECUTE mensagemDeSucesso('Despesa', 'cadastrada');
		RETURN cod_despesa;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'Falha ao cadastrar despesa!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION despesaCadastrar (nome_p VARCHAR(100), valor_p NUMERIC(19,0), id_projeto INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		cod_despesa INTEGER;
	BEGIN
		SET ROLE insert;
		INSERT INTO despesa (nome, valor, fk_projeto)
		VALUES (nome_p, valor_p, id_projeto);

		SET ROLE retrieve;
		SELECT INTO cod_despesa currval('despesa_id_despesa_seq');
		EXECUTE mensagemDeSucesso('Despesa', 'cadastrada');
		RETURN cod_despesa;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'Falha ao cadastrar despesa!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERT

--UPDATE

CREATE OR REPLACE FUNCTION despesaAtualizar(id INTEGER, nome_p VARCHAR(100), valor_p NUMERIC(19,0), descricao_p TEXT, id_projeto INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		SET ROLE update;
		UPDATE despesa SET nome = nome_p, calor = valor_p, descricao = descricao_p, fk_projeto = id_projeto WHERE id_despesa = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Despesa', 'atualizada');
			RETURN 1;
		ELSE
			RAISE NOTICE 'Falha ao atualizar despesa!';
			RETURN 0;
		END IF; 
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'Falha ao atualizar despesa, dados inválidos!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END UPDATE

--DELETE

CREATE OR REPLACE FUNCTION despesaExcluir (id INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		SET ROLE delete;
		DELETE FROM recurso WHERE fk_despesa = id;
		DELETE FROM despesa WHERE id_despesa = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('despesa', 'excluida');
			RETURN 1;
		ELSE
			RAISE NOTICE 'Falha ao excluir despesa!';
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETE
