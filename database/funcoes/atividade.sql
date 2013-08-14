--INSERTS;

--todos
CREATE OR REPLACE FUNCTION atividadeCadastrar(inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), descricao TEXT, predecessora INTEGER, fase INTEGER) 		RETURNS INTEGER AS $$

	DECLARE
		id_gerada INTEGER;
	BEGIN
		INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, descricao_atividade, fk_predecessora, fk_fase) 
			VALUES (inicio, limite, nome, descricao, predecessora, fase) RETURNING id_atividade INTO id_gerada;
		IF (NOT FOUND) THEN
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--sem predecessora
CREATE OR REPLACE FUNCTION atividadeCadastrar(inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), descricao TEXT, fase INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, descricao_atividade, fk_fase) 
			VALUES (inicio, limite, nome, descricao, fase) RETURNING id_atividade INTO id_gerada;
		IF (NOT FOUND) THEN
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--sem descrição
CREATE OR REPLACE FUNCTION atividadeCadastrar(inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), predecessora INTEGER, fase INTEGER) RETURNS INTEGER 
	AS $$
	
	DECLARE
		id_gerada INTEGER;
	BEGIN
		INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, fk_predecessora, fk_fase) 
			VALUES (inicio, limite, nome, predecessora, fase) RETURNING id_atividade INTO id_gerada;
		IF (NOT FOUND) THEN
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--sem descricao e predecessora
CREATE OR REPLACE FUNCTION atividadeCadastrar(inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100),fase INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, fk_fase) 
			VALUES (inicio, limite, nome, fase) RETURNING id_atividade INTO id_gerada;
		IF (NOT FOUND) THEN
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;

--UPDATES;

--END UPDATES;

--DELETES;

CREATE OR REPLACE FUNCTION atividadeExcluir(id_exclusao INTEGER) RETURNS INTEGER AS $$
	BEGIN
		DELETE FROM atividade WHERE id_atividade = id_exclusao;
		
		IF (FOUND) THEN
			RETURN 1;
		END IF;
		
		RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETES;

