
--INSERTS;

CREATE OR REPLACE FUNCTION atividadeCadastrar (inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), descricao TEXT, id_projeto INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_gerada  INTEGER;
	BEGIN
		IF (inicio > limite) THEN
			RAISE NOTICE 'Data de limite da atividade deve ser maior que data de início !';
			RETURN 0;
		ELSE
			INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, descricao_atividade, fk_projeto) 
				VALUES (inicio, limite, nome, descricao, id_projeto) RETURNING id_atividade INTO id_gerada ;
			RETURN id_gerada;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION atividadeCadastrar (inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), id_projeto INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_gerada  INTEGER;
	BEGIN
		IF (inicio > limite) THEN
			RAISE NOTICE 'Data de limite da atividade deve ser maior que data de início !';
			RETURN 0;
		ELSE
			INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, fk_projeto) 
				VALUES (inicio, limite, nome, id_projeto) RETURNING id_atividade  INTO id_gerada ;
			RETURN id_gerada;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;

--UPDATES;

CREATE OR REPLACE FUNCTION atividadeUpdate (id INTEGER, inicio TIMESTAMP, limite TIMESTAMP, fim TIMESTAMP, nome VARCHAR(100), descricao TEXT, finished BOOLEAN) 
	RETURNS INTEGER AS $$
	BEGIN
		IF (inicio > limite) THEN
			RAISE NOTICE 'Data de limite da atividade deve ser maior que data de início !';
			RETURN 0;
		ELSEIF (inicio > fim) THEN
			RAISE NOTICE 'Data de fim da atividade deve ser maior que data de início !';
			RETURN 0;
		ELSE
			UPDATE atividade SET inicio_atividade=inicio, limite_atividade=limite, fim_atividade=fim, nome_atividade=nome, descricao_atividade=descricao, 					finalizada=finished WHERE id_atividade = id;
			IF (FOUND) THEN
				RETURN 1;
			ELSE
				RETURN 0;
			END IF;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END UPDATES;

--DELETES;

CREATE OR REPLACE FUNCTION atividadeDelete(id_projeto INTEGER) RETURNS INTEGER AS $$
BEGIN
	DELETE FROM atividade WHERE fk_projeto = id_projeto;
	IF (FOUND) THEN
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;
END;
$$ LANGUAGE PLPGSQL;

--END DELETES;

