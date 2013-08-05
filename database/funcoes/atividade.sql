
--INSERTS;

CREATE OR REPLACE FUNCTION atividadeInsert (id INTEGER, inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), descricao TEXT, id_projeto INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_atividade INTEGER;
	BEGIN
		IF (inicio > limite) THEN
			RAISE NOTICE 'Data de limite da atividade deve ser maior que data de início !';
			RETURN 0;
		ELSE
			INSERT INTO atividade (id_atividade, inicio_atividade, limite_atividade, nome_atividade, descricao_atividade, fk_projeto) 
				VALUES (id, inicio, limite, nome, descricao, id_projeto) RETURNING id_atividade INTO id_atividade;
			RETURN id_atividade;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION atividadeInsert (inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), descricao TEXT, id_projeto INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_atividade INTEGER;
	BEGIN
		IF (inicio > limite) THEN
			RAISE NOTICE 'Data de limite da atividade deve ser maior que data de início !';
			RETURN 0;
		ELSE
			INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, descricao_atividade, fk_projeto) 
				VALUES (inicio, limite, nome, descricao, id_projeto) RETURNING id_atividade INTO id_atividade;
			RETURN id_atividade;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION atividadeInsert (inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), id_projeto INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_atividade INTEGER;
	BEGIN
		IF (inicio > limite) THEN
			RAISE NOTICE 'Data de limite da atividade deve ser maior que data de início !';
			RETURN 0;
		ELSE
			INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, fk_projeto) 
				VALUES (inicio, limite, nome, id_projeto) RETURNING id_atividade INTO id_atividade;
			RETURN id_atividade;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;

--UPDATES;

CREATE OR REPLACE FUNCTION atividadeUpdate (inicio TIMESTAMP, limite TIMESTAMP, fim TIMESTAMP, nome VARCHAR(100), descricao TEXT, finished BOOLEAN, id_projeto INTEGER) 
	RETURNS INTEGER AS $$
	BEGIN
		IF (inicio > limite) THEN
			RAISE NOTICE 'Data de limite da atividade deve ser maior que data de início !';
			RETURN 0;
		ELSEIF (inicio > fim) THEN
			RAISE NOTICE 'Data de fim da atividade deve ser maior que data de início !';
			RETURN 0;
		ELSE
			UPDATE atividade SET inicio_atividade=inicio, limite_atividade=limite, fim_atividade=fim, nome_atividade=nome, descricao_atividade=descricao, 					finalizada=finished WHERE fk_projeto = id_projeto;
			RETURN 1;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END UPDATES;

--DELETES;

CREATE OR REPLACE FUNCTION atividadeDelete(id_projeto INTEGER) RETURNS INTEGER AS $$
BEGIN
	DELETE FROM atividade WHERE fk_projeto = id_projeto;
END;
$$ LANGUAGE PLPGSQL;

--END DELETES;

--SELECTS;

CREATE OR REPLACE FUNCTION atividadeSelect(id_projeto INTEGER) RETURNS SETOF atividade AS $$
BEGIN
	RETURN QUERY EXECUTE 'SELECT dinicio_atividade, limite_atividade, fim_atividade, nome_atividade, descricao_atividade, finalizada FROM atividade WHERE fk_projeto = 			id_projeto';
END;
$$ LANGUAGE PLPGSQL;
