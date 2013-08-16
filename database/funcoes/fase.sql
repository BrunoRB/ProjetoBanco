
--INSERTS;

--todos
CREATE OR REPLACE FUNCTION faseCadastrar(nome_p VARCHAR(100), descricao_p TEXT, id_predecessora INTEGER) RETURNS INTEGER AS $$
	DECLARE
		cod_fase INTEGER;
	BEGIN
		INSERT INTO fase (nome, descricao, fk_predecessora) 
		VALUES (nome_p, descricao_p, id_predecessora) RETURNING id_fase INTO cod_fase;
		RETURN cod_fase;
	END;
$$ LANGUAGE PLPGSQL;

--sem predecessora
CREATE OR REPLACE FUNCTION faseCadastrar(nome_p VARCHAR(100), descricao_p TEXT) RETURNS INTEGER AS $$
	DECLARE
		cod_fase INTEGER;
	BEGIN
		INSERT INTO fase (nome, descricao) 
		VALUES (nome_p, descricao_p) RETURNING id_fase INTO cod_fase;
		RETURN cod_fase;
	END;
$$ LANGUAGE PLPGSQL;

--sem descricao
CREATE OR REPLACE FUNCTION faseCadastrar(nome_p VARCHAR(100), id_predecessora INTEGER) RETURNS INTEGER AS $$
	DECLARE
		cod_fase INTEGER;
	BEGIN
		INSERT INTO fase (nome, fk_predecessora) 
		VALUES (nome_p, id_predecessora) RETURNING id_fase INTO cod_fase;
		RETURN cod_fase;
	END;
$$ LANGUAGE PLPGSQL;

--sem descricao e predecessora
CREATE OR REPLACE FUNCTION faseCadastrar(nome_p VARCHAR(100)) RETURNS INTEGER AS $$
	DECLARE
		cod_fase INTEGER;
	BEGIN
		INSERT INTO fase (nome) 
		VALUES (nome_p) RETURNING id_fase INTO cod_fase;
		RETURN cod_fase;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;

--DELETES;

CREATE OR REPLACE FUNCTION faseExcluir (id INTEGER) RETURNS INTEGER AS $$
	BEGIN
		DELETE FROM fase WHERE id_fase = id;
		IF (FOUND) THEN
			RETURN 1;
		END IF;
		
		RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETES;


