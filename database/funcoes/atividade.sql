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
		EXECUTE mensagemDeSucesso('Atividade', 'cadastrada');
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
		EXECUTE mensagemDeSucesso('Atividade', 'cadastrada');
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
		EXECUTE mensagemDeSucesso('Atividade', 'cadastrada');
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
		EXECUTE mensagemDeSucesso('Atividade', 'cadastrada');
		RETURN id_gerada;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;

--UPDATES;


CREATE OR REPLACE FUNCTION atividadeAtualizar(id INTEGER, inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), descricao TEXT, predecessora INTEGER, fase INTEGER)
RETURNS INTEGER AS $$
	BEGIN	
		SET ROLE update;	
		UPDATE atividade SET inicio_atividade = inicio, limite_atividade = limite, nome_atividade = nome, descricao_atividade = 				descricao, fk_predecessora = predecessora, fk_fase = fase WHERE id_atividade = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Atividade', 'atualizada');
			RETURN 1;
		ELSE
			RAISE NOTICE 'Erro ao atualizar a atividade.';
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--sem predecessora
CREATE OR REPLACE FUNCTION atividadeAtualizar(id INTEGER, inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), descricao TEXT, fase INTEGER)
RETURNS INTEGER AS $$
	BEGIN	
		SET ROLE update;	
		UPDATE atividade SET inicio_atividade = inicio, limite_atividade = limite, nome_atividade = nome, descricao_atividade = 				descricao, fk_fase = fase WHERE id_atividade = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Atividade', 'atualizada');
			RETURN 1;
		ELSE
			RAISE NOTICE 'Erro ao atualizar a atividade.';
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--finaliza a atividade
CREATE OR REPLACE FUNCTION atividadeFinalizar(id INTEGER)
RETURNS INTEGER AS $$
	BEGIN	
		SET ROLE update;	
		UPDATE atividade SET fim_atividade = now(), finalizada = true WHERE id_atividade = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Atividade', 'finalizada');
			RETURN 1;
		ELSE
			RAISE NOTICE 'Erro ao finalizar a atividade.';
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END UPDATES;

--DELETES;

CREATE OR REPLACE FUNCTION atividadeExcluir(id INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_atdm INTEGER;
		id_com INTEGER;
		id_predecessora INTEGER;
		id_proxima INTEGER;
		trash BOOLEAN;
	BEGIN
		SET ROLE retrieve;
		SELECT INTO id_atdm id_atividade_do_membro FROM atividade_do_membro WHERE fk_atividade = id;
		SELECT INTO id_com id_comentario FROM comentario WHERE fk_atividade_do_membro = id_atdm;			
		
		SET ROLE update;
		UPDATE atividade SET fk_predecessora = null WHERE fk_predecessora = id;
		-- talvez tivesse que vincular a atividade predecessora a próxima atividade dessa atividade que está sendo excluida, se tivesse predecessora e próxima

		SET ROLE delete;
		DELETE FROM artefato_atividade WHERE fk_atividade = id; -- talvez tivesse que redividir a porcentagem das outras atividade para dar 100%
		DELETE FROM imagem WHERE fk_comentario = id_com;
		DELETE FROM comentario WHERE fk_atividade_do_membro = id_atdm;
		DELETE FROM atividade_do_membro WHERE fk_atividade = id;
		DELETE FROM atividade WHERE id_atividade = id;
		
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Atividade', 'excluida');
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
		
		RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETES;
