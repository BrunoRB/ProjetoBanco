--INSERTS

CREATE OR REPLACE FUNCTION recursoCadastrar (nome_p VARCHAR(100), descricao_p TEXT, id_projeto INTEGER, id_despesa INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		cod_recurso INTEGER;
	BEGIN
		INSERT INTO recurso (nome, descricao, fk_projeto, fk_despesa) 
		VALUES (nome_p, descricao_p, id_projeto, id_despesa) RETURNING id_recurso INTO cod_recurso;
		RETURN cod_recurso;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION recursoCadastrar (nome_p VARCHAR(100), descricao_p TEXT, id_projeto INTEGER)
RETURNS INTEGER AS $$
	DECLARE 
		cod_recurso INTEGER;
	BEGIN
		INSERT INTO recurso (nome, descricao, fk_projeto)
		VALUES (nome_p, descricao_p, id_projeto) RETURNING id_recurso INTO cod_recurso;
		RETURN cod_recurso;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION recursoCadastrar (nome_p VARCHAR(100), id_projeto INTEGER, id_despesa INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		cod_recurso INTEGER;
	BEGIN
		INSERT INTO recurso (nome, fk_projeto, fk_despesa)
		VALUES (nome_p, id_projeto, id_despesa) RETURNING id_recurso INTO cod_recurso;
		RETURN cod_recurso;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION recursoCadastrar (nome_p VARCHAR(100), id_projeto INTEGER)
RETURNS INTEGER AS $$
	DECLARE 
		cod_recurso INTEGER;
	BEGIN
		INSERT INTO recurso (nome, fk_projeto)
		VALUES (nome_p, id_projeto) RETURNING id_recurso INTO cod_recurso;
		RETURN cod_recurso;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS

--UPDATE

CREATE OR REPLACE FUNCTION recursoAtualizar (id INTEGER, campos TEXT, valores TEXT)
RETURNS INTEGER AS $$
	DECLARE 
		retorno INTEGER;
	BEGIN
		retorno := generealUpdate(recurso, id, campos, valores);
		RETURN retorno;
	END;
$$ LANGUAGE PLPGSQL;

--END UPDATE

--DELETE

CREATE OR REPLACE FUNCTION recursoExcluir(id INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		DELETE FROM recurso WHERE id_recurso = id;
		IF (FOUND) THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETE
