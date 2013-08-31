--INSERTS;

--todos
CREATE OR REPLACE FUNCTION atividadeCadastrar(inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), descricao TEXT, predecessora INTEGER, fase INTEGER) 		
RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		SET ROLE insert;
		INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, descricao_atividade, fk_predecessora, fk_fase) 
			VALUES (inicio, limite, nome, descricao, predecessora, fase);

		SET ROLE retrieve;
		SELECT INTO id_gerada currval('atividade_id_atividade_seq');
		RETURN id_gerada;
	END;
$$ LANGUAGE PLPGSQL;

--sem predecessora
CREATE OR REPLACE FUNCTION atividadeCadastrar(inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), descricao TEXT, fase INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		SET ROLE insert;
		INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, descricao_atividade, fk_fase) 
		VALUES (inicio, limite, nome, descricao, fase);

		SET ROLE retrieve;
		SELECT INTO id_gerada currval('atividade_id_atividade_seq');
		RETURN id_gerada;
	END;
$$ LANGUAGE PLPGSQL;

--sem descrição
CREATE OR REPLACE FUNCTION atividadeCadastrar(inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), predecessora INTEGER, fase INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN	
		SET ROLE insert;
		INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, fk_predecessora, fk_fase) 
			VALUES (inicio, limite, nome, predecessora, fase);

		SET ROLE retrieve;
		SELECT INTO id_gerada currval('atividade_id_atividade_seq');
		RETURN id_gerada;
	END;
$$ LANGUAGE PLPGSQL;

--sem descricao e predecessora
CREATE OR REPLACE FUNCTION atividadeCadastrar(inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100),fase INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		SET ROLE insert;
		INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, fk_fase) 
		VALUES (inicio, limite, nome, fase);

		SET ROLE retrieve;
		SELECT INTO id_gerada currval('atividade_id_atividade_seq');
		RETURN id_gerada;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;

--UPDATES;

CREATE OR REPLACE FUNCTION atividadeAtualizar(id INTEGER, inicio TIMESTAMP, limete TIMESTAMP, nome VARCHAR(100), descricao TEXT, predecessora INTEGER, fase INTEGER)
RETURNS INTEGER AS $$
	BEGIN	
		SET ROLE update;	
		UPDATE atividade SET inicio_atividade = inicio, limite_atividade = limite, nome_atividade = nome, descricao_atividade = 				descricao, fk_predecessora = predecessora, fk_fase = fase WHERE id_atividade = id;
		IF (FOUND) THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END UPDATES;

--DELETES;

CREATE OR REPLACE FUNCTION atividadeExcluir(id_exclusao INTEGER) RETURNS INTEGER AS $$
	BEGIN
		SET ROLE delete;
		DELETE FROM atividade WHERE id_atividade = id_exclusao;
		
		IF (FOUND) THEN
			RETURN 1;
		END IF;
		
		RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETES;
