--INSERT

CREATE OR REPLACE FUNCTION despesaCadastrar (nome_p VARCHAR(100), valor_p NUMERIC(19,0), descricao_p TEXT, id_projeto INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		cod_despesa INTEGER.
	BEGIN
		INSERT INTO despesa (nome, valor, descricao, fk_projeto)
		VALUES (nome_p, valor_p, descricao_p, id_projeto) RETUNING id_despesa INTO cod_despesa
		RETURN cod_despesa;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION despesaCadastrarSemDescricao (nome_p VARCHAR(100), valor_p NUMERIC(19,0), id_projeto INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		cod_despesa INTEGER.
	BEGIN
		INSERT INTO despesa (nome, valor, fk_projeto)
		VALUES (nome_p, valor_p, id_projeto) RETUNING id_despesa INTO cod_despesa
		RETURN cod_despesa;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERT

--UPDATE

CREATE OR REPLACE FUNCTION despesaAtualizar(id INTEGER, campos TEXT, valores TEXT)
RETURNS INTEGER AS $$
	DECLARE
		retorno INTEGER;
	BEGIN
		RETURN (retorno := generalUpdate(despesa, id, campos, valores))
	END;
$$ LANGUAGE PLPGSQL;

--END UPDATE

--DELETE

CREATE OR REPLACE FUNCTION despesaExcluir (id INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		DELETE FROM despesa WHERE id_despesa = id;
		IF (FOUND) THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETE
