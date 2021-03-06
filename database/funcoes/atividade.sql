﻿--INSERTS;

--todos
CREATE OR REPLACE FUNCTION atividadeCadastrar(
	idUsuario INTEGER, idProjeto INTEGER, inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), descricao TEXT, predecessora INTEGER, fase INTEGER
) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;
	
		SET ROLE insert;
		INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, descricao_atividade, fk_predecessora, fk_fase, 				fk_projeto) VALUES (inicio, limite, nome, descricao, predecessora, fase, idProjeto);

		SET ROLE retrieve;
		SELECT INTO id_gerada currval('atividade_id_atividade_seq');
		EXECUTE mensagemDeSucesso('Atividade', 'cadastrada');
		RETURN id_gerada;
	END;
$$ LANGUAGE PLPGSQL;

--sem predecessora
CREATE OR REPLACE FUNCTION atividadeCadastrar(
	idUsuario INTEGER, idProjeto INTEGER, inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), descricao TEXT, fase INTEGER) 
RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;
		SET ROLE insert;
		INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, descricao_atividade, fk_fase, fk_projeto) 
			VALUES (inicio, limite, nome, descricao, fase, idProjeto);

		SET ROLE retrieve;
		SELECT INTO id_gerada currval('atividade_id_atividade_seq');
		EXECUTE mensagemDeSucesso('Atividade', 'cadastrada');
		RETURN id_gerada;
	END;
$$ LANGUAGE PLPGSQL;

--sem descrição
CREATE OR REPLACE FUNCTION atividadeCadastrar(
	idUsuario INTEGER, idProjeto INTEGER, inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100), predecessora INTEGER, fase INTEGER)
 RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN	
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;
		SET ROLE insert;
		INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, fk_predecessora, fk_fase, fk_projeto) 
			VALUES (inicio, limite, nome, predecessora, fase, idProjeto);

		SET ROLE retrieve;
		SELECT INTO id_gerada currval('atividade_id_atividade_seq');
		EXECUTE mensagemDeSucesso('Atividade', 'cadastrada');
		RETURN id_gerada;
	END;
$$ LANGUAGE PLPGSQL;

--sem descricao e predecessora
CREATE OR REPLACE FUNCTION atividadeCadastrar(
	idUsuario INTEGER, idProjeto INTEGER, inicio TIMESTAMP, limite TIMESTAMP, nome VARCHAR(100),fase INTEGER) 
RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;
		SET ROLE insert;
		INSERT INTO atividade (inicio_atividade, limite_atividade, nome_atividade, fk_fase, fk_projeto) 
		VALUES (inicio, limite, nome, fase, idProjeto);

		SET ROLE retrieve;
		SELECT INTO id_gerada currval('atividade_id_atividade_seq');
		EXECUTE mensagemDeSucesso('Atividade', 'cadastrada');
		RETURN id_gerada;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;

--UPDATES;


CREATE OR REPLACE FUNCTION atividadeAtualizar(
	idUsuario INTEGER, idProjeto INTEGER, id INTEGER, inicio TIMESTAMP, limite TIMESTAMP, 
	nome VARCHAR(100), descricao TEXT, predecessora INTEGER, fase INTEGER
) RETURNS INTEGER AS $$
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;
			
		SET ROLE update;	
		UPDATE atividade SET inicio_atividade = inicio, limite_atividade = limite, 
			nome_atividade = nome, descricao_atividade = descricao, fk_predecessora = predecessora, fk_fase = fase, 
				fk_projeto = idProjeto WHERE id_atividade = id;
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
CREATE OR REPLACE FUNCTION atividadeAtualizar(
	idUsuario INTEGER, idProjeto INTEGER, id INTEGER, inicio TIMESTAMP, limite TIMESTAMP,
	nome VARCHAR(100), descricao TEXT, fase INTEGER
) RETURNS INTEGER AS $$
	BEGIN	
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;
		
		SET ROLE update;	
		UPDATE atividade SET inicio_atividade = inicio, limite_atividade = limite, nome_atividade = nome, descricao_atividade = 				descricao, fk_fase = fase, fk_projeto = idProjeto WHERE id_atividade = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Atividade', 'atualizada');
			RETURN 1;
		ELSE
			RAISE NOTICE 'Erro ao atualizar a atividade.';
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--sem descrição
CREATE OR REPLACE FUNCTION atividadeAtualizar(
	idUsuario INTEGER, idProjeto INTEGER, id INTEGER, inicio TIMESTAMP, limite TIMESTAMP,
	nome VARCHAR(100), predecessora INTEGER, fase INTEGER
) RETURNS INTEGER AS $$
	BEGIN	
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;
		
		SET ROLE update;	
		UPDATE atividade SET inicio_atividade = inicio, limite_atividade = limite, nome_atividade = nome, fk_predecessora = predecessora, fk_fase = fase, fk_projeto = idProjeto WHERE id_atividade = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Atividade', 'atualizada');
			RETURN 1;
		ELSE
			RAISE NOTICE 'Erro ao atualizar a atividade.';
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--sem descrição
CREATE OR REPLACE FUNCTION atividadeAtualizar(
	idUsuario INTEGER, idProjeto INTEGER, id INTEGER, inicio TIMESTAMP, limite TIMESTAMP,
	nome VARCHAR(100), predecessora INTEGER, fase INTEGER
) RETURNS INTEGER AS $$
	BEGIN	
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;
		
		SET ROLE update;	
		UPDATE atividade SET inicio_atividade = inicio, limite_atividade = limite, nome_atividade = nome, fk_predecessora = predecessora, fk_fase = fase, fk_projeto = idProjeto WHERE id_atividade = id;
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
CREATE OR REPLACE FUNCTION atividadeFinalizar(idUsuario INTEGER, idProjeto INTEGER, id INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		IF NOT isMembro(idUsuario, idProjeto) AND NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;	

		IF NOT isInAtividade(idUsuario, idProjeto, id) AND NOT isGerente(idUsuario, idProjeto)  THEN
			RETURN 0;
		END IF;

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

CREATE OR REPLACE FUNCTION atividadeExcluir(idUsuario INTEGER, idProjeto INTEGER, id INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_atdm INTEGER;
		id_com INTEGER;
		id_predecessora INTEGER;
		id_proxima INTEGER;
		trash BOOLEAN;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;
		
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


--SELECTS;

CREATE OR REPLACE FUNCTION atividadeIncompletaListarGerente (
	idUsuario INTEGER, idProjeto INTEGER, OUT id_atividade INTEGER, OUT nome_atividade VARCHAR, OUT inicio_atividade TIMESTAMP,
	OUT limite_atividade TIMESTAMP, OUT predecessora VARCHAR, OUT nome VARCHAR
) RETURNS SETOF RECORD AS $$
	BEGIN		
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN;
		END IF;
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT idAtividade, atividade, inicio, limite, predecessora, fase 
			FROM atividade_incompleta_gerenteView WHERE projeto =' || idProjeto || ' ORDER BY predecessora DESC';
	END;
$$ LANGUAGE PLPGSQL;



CREATE OR REPLACE FUNCTION atividadecompletaListarGerente (
	idUsuario INTEGER, idProjeto INTEGER, OUT id_atividade INTEGER, OUT nome_atividade VARCHAR, OUT inicio_atividade TIMESTAMP,
	OUT limite_atividade TIMESTAMP, OUT fim_atividade TIMESTAMP, OUT predecessora VARCHAR, OUT nome VARCHAR
) RETURNS SETOF RECORD AS $$
	BEGIN		
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN;
		END IF;
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT idAtividade, atividade, inicio, limite, fim, predecessora, fase 
			FROM atividade_completa_gerenteView WHERE projeto =' || idProjeto || ' ORDER BY predecessora DESC';
	END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION atividadeIncompletaListarMembro (
	idUsuario INTEGER, idProjeto INTEGER, OUT id_atividade INTEGER, OUT nome_atividade VARCHAR, OUT inicio_atividade TIMESTAMP,
	OUT limite_atividade TIMESTAMP, OUT predecessora VARCHAR, OUT nome VARCHAR
) RETURNS SETOF RECORD AS $$
	BEGIN		
		IF NOT isMembro(idUsuario, idProjeto) THEN
			RETURN;
		END IF;
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT idAtividade, atividade, inicio, limite, predecessora, fase 
			FROM atividade_incompleta_membroView WHERE projeto =' || idProjeto || 'AND membro =' || idUsuario;
	END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION atividadeCompletaListarMembro (
	idUsuario INTEGER, idProjeto INTEGER, OUT id_atividade INTEGER, OUT nome_atividade VARCHAR, OUT inicio_atividade TIMESTAMP,
	OUT limite_atividade TIMESTAMP, OUT predecessora VARCHAR, OUT nome VARCHAR
) RETURNS SETOF RECORD AS $$
	BEGIN		
		IF NOT isMembro(idUsuario, idProjeto) THEN
			RETURN;
		END IF;
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT projeto, atividade, inicio, limite, predecessora, fase 
			FROM atividade_completa_membroView WHERE projeto =' || idProjeto || 'AND membro =' || idUsuario;
	END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION atividadeExibirGerente (
	idUsuario INTEGER, idProjeto INTEGER, idAtividade INTEGER, OUT nome_atividade VARCHAR, OUT descricao_atividade TEXT, 
	OUT inicio_atividade TIMESTAMP, OUT limite_atividade TIMESTAMP, OUT predecessora VARCHAR, OUT fase VARCHAR
) RETURNS SETOF RECORD AS $$
	BEGIN		
		IF NOT isGerente(idUsuario, idProjeto) THEN
			IF NOT isInAtividade(idUsuario, idProjeto, idAtividade) THEN
				RETURN;
			END IF;
		END IF;
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT atividade.nome_atividade, atividade.descricao_atividade, 
			atividade.inicio_atividade, atividade.limite_atividade, 
			atividade_1.nome_atividade, fase.nome 
		FROM ((atividade LEFT JOIN atividade atividade_1 ON atividade.fk_predecessora = atividade_1.id_atividade) 
		INNER JOIN projeto ON atividade.fk_projeto = id_projeto  
		INNER JOIN fase ON atividade.fk_fase = fase.id_fase)
			WHERE id_projeto = ' || idProjeto || ' AND atividade.id_atividade = ' || idAtividade;
	END;
$$ LANGUAGE PLPGSQL;
