﻿--INSERTS

CREATE OR REPLACE FUNCTION artefatoCadastrar (idUsuario INTEGER, idProjeto INTEGER, nome_p VARCHAR(100), tipo_p VARCHAR(100), descricao_p TEXT, porcentagem_concluida_p INTEGER) 
RETURNS INTEGER AS $$
	DECLARE 
		cod_artefato INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO artefato (nome, tipo, descricao, porcentagem_concluida, fk_projeto)
			VALUES (nome_p, tipo_p, descricao_p, porcentagem_concluida_p, idProjeto);
		
		SET ROLE retrieve;
		SELECT INTO cod_artefato currval('artefato_id_artefato_seq');

		EXECUTE mensagemDeSucesso('Artefato', 'Cadastrado');
		RETURN cod_artefato;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'O valor da porcengem informado é inválido!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION artefatoCadastrar (idUsuario INTEGER, idProjeto INTEGER, nome_p VARCHAR(100), tipo_p VARCHAR(100), descricao_p TEXT)
RETURNS INTEGER AS $$
	DECLARE 
		cod_artefato INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;		

		SET ROLE insert;
		INSERT INTO artefato (nome, tipo, descricao, fk_projeto)
			VALUES (nome_p, tipo_p, descricao_p, idProjeto);

		SET ROLE retrieve;
		SELECT INTO cod_artefato currval('artefato_id_artefato_seq');

		EXECUTE mensagemDeSucesso('Artefato', 'Cadastrado');
		RETURN cod_artefato;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION artefatoCadastrarSemDescPorc (idUsuario INTEGER, idProjeto INTEGER, nome_p VARCHAR(100), tipo_p VARCHAR(100))
RETURNS INTEGER AS $$
	DECLARE
		cod_artefato INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO artefato (nome, tipo, fk_projeto)
			VALUES (nome_p, tipo_p, idProjeto);

		SET ROLE retrieve;
		SELECT INTO cod_artefato currval('artefato_id_artefato_seq');

		EXECUTE mensagemDeSucesso('Artefato', 'Cadastrado');
		RETURN cod_artefato;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION artefatoCadastrarSemDesc (idUsuario INTEGER, idProjeto INTEGER, nome_p VARCHAR(100), tipo_p VARCHAR(100), porcentagem_concluida_p INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		cod_artefato INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO artefato (nome, tipo, porcentagem_concluida, fk_projeto)
			VALUES (nome_p, tipo_p, porcen, idProjeto);
		
		SET ROLE retrieve;
		SELECT INTO cod_artefato currval('artefato_id_artefato_seq');		

		EXECUTE mensagemDeSucesso('Artefato', 'Cadastrado');
		RETURN cod_artefato;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'O valor da porcengem informado é inválido!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION artefatoCadastrarSemTipo (idUsuario INTEGER, idProjeto INTEGER, nome_p VARCHAR(100), descricao_p TEXT, porcentagem_concluida_p INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		cod_artefato INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO artefato (nome, descricao, porcentagem_concluida, fk_Projeto)
			VALUES (nome_p, descricao_p, porcentagem_concluida_p, idProjeto);

		SET ROLE retrieve;
		SELECT INTO cod_artefato currval('artefato_id_artefato_seq');

		EXECUTE mensagemDeSucesso('Artefato', 'Cadastrado');
		RETURN cod_artefato;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'O valor da porcengem informado é inválido!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION artefatoCadastrarSemTipoPorc (idUsuario INTEGER, idProjeto INTEGER, nome_p VARCHAR(100), descricao_p TEXT)
RETURNS INTEGER AS $$
	DECLARE
		cod_artefato INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO artefato (nome, descricao, fk_Projeto)
			VALUES (nome_p, descricao_p, idProjeto);

		SET ROLE retrieve;
		SELECT INTO cod_artefato currval('artefato_id_artefato_seq');

		EXECUTE mensagemDeSucesso('Artefato', 'Cadastrado');
		RETURN cod_artefato;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION artefatoCadastrarSemTipoDesc (idUsuario INTEGER, idProjeto INTEGER, nome_p VARCHAR(100), porcentagem_concluida_p INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		cod_artefato INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO artefato (nome, porcentagem_concluida, fk_projeto)
			VALUES (nome_p, porcentagem_concluida_p, idProjeto);

		SET ROLE retrieve;
		SELECT INTO cod_artefato currval('artefato_id_artefato_seq');

		EXECUTE mensagemDeSucesso('Artefato', 'Cadastrado');
		RETURN cod_artefato;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'O valor da porcengem informado é inválido!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS

--UPDATES

CREATE OR REPLACE FUNCTION artefatoAtualizarPorcentagem (id INTEGER, porcentagem INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		SET ROLE update;	
		UPDATE artefato SET porcentagem_concluida = (porcentagem_concluida + porcentagem)
		WHERE id_artefato = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Artefato', 'atualizado');
			RETURN 1;
		ELSE
			RAISE NOTICE 'Falha ao atulizar porcentagem!';
			RETURN 0;
		END IF;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'O valor da porcengem informado é inválido!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION artefatoAtualizar (idUsuario INTEGER, idProjeto INTEGER, id INTEGER, nome_p VARCHAR(100), tipo_p VARCHAR(100), descricao_p TEXT, porc INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;

		SET ROLE update;
		UPDATE artefato SET nome = nome_p, tipo = tipo_p, descricao = descricao_p, porcentagem_concluida = porc, fk_projeto = idProjeto
		WHERE id_artefato = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Artefato', 'atualizado');
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'O valor da porcengem informado é inválido!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END UPDATES

--DELETES

CREATE OR REPLACE FUNCTION artefatoExcluir (idUsuario INTEGER, idProjeto INTEGER, id INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;

		SET ROLE delete;
		DELETE FROM artefato_atividade WHERE fk_artefato = id;
		DELETE FROM artefato WHERE id_artefato = id;

		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Artefato', 'excluido');
			RETURN 1;
		ELSE
			RAISE NOTICE 'Falha ao excluir o artefato!';
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;
--END DELETES


--SELECTS;

CREATE OR REPLACE FUNCTION artefatoListar(
	idUsuario INTEGER, idProjeto INTEGER, OUT id_artefato INTEGER, OUT nome VARCHAR, OUT tipo VARCHAR, 
	OUT porcentagem_concluida INTEGER		
) RETURNS SETOF RECORD AS $$
	BEGIN		
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN;
		END IF;
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT idArtefato, artefato, tipo, porcentagem_concluida 
			FROM artefato_projetoView WHERE projeto =' || idProjeto;
	END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION artefatoExibirGerente(
	idUsuario INTEGER, idProjeto INTEGER, idArtefato INTEGER, OUT nome VARCHAR, OUT tipo VARCHAR, 
	OUT descricao TEXT, OUT porcentagem_concluida INTEGER
) RETURNS SETOF RECORD AS $$
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN;
		END IF;
		
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT nome, tipo, descricao, porcentagem_concluida 
			FROM artefato WHERE fk_projeto =' || idProjeto || 'AND id_artefato =' || idArtefato;
	END;
$$ LANGUAGE PLPGSQL;
