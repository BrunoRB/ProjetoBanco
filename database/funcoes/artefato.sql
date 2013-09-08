--INSERTS

CREATE OR REPLACE FUNCTION artefatoCadastrar (idUsuario INTEGER, idProjeto INTEGER, nome_p VARCHAR(100), tipo_p VARCHAR(100), descricao_p TEXT, porcentagem_concluida_p INTEGER) 
RETURNS INTEGER AS $$
	DECLARE 
		cod_artefato INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO artefato (nome, tipo, descricao, porcentagem_concluida)
			VALUES (nome_p, tipo_p, descricao_p, porcentagem_concluida_p);
		
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
		INSERT INTO artefato (nome, tipo, descricao)
			VALUES (nome_p, tipo_p, descricao_p);

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
		INSERT INTO artefato (nome, tipo)
			VALUES (nome_p, tipo_p);

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
		INSERT INTO artefato (nome, tipo, porcentagem_concluida)
			VALUES (nome_p, tipo_p, porcen);
		
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
		INSERT INTO artefato (nome, descricao, porcentagem_concluida)
			VALUES (nome_p, descricao_p, porcentagem_concluida_p);

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
		INSERT INTO artefato (nome, descricao)
			VALUES (nome_p, descricao_p);

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
		INSERT INTO artefato (nome, porcentagem_concluida)
			VALUES (nome_p, porcentagem_concluida_p);

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
		UPDATE artefato SET nome = nome_p, tipo = tipo_p, descricao = descricao_p, porcentagem_concluida = porc
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


CREATE OR REPLACE FUNCTION artefatoExibirGerente(
	idUsuario INTEGER, idProjeto INTEGER, idAtividade INTEGER, idArtefato INTEGER, OUT nome VARCHAR, OUT tipo VARCHAR, 
	OUT descricao TEXT, OUT porcentagem_concluida INTEGER
) RETURNS SETOF RECORD AS $$
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN;
		END IF;
		
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT artefato.nome, artefato.tipo, artefato.descricao, artefato.porcentagem_concluida 
			FROM artefato
			INNER JOIN artefato_atividade ON artefato_atividade.fk_artefato = artefato.id_artefato
			INNER JOIN atividade ON atividade.id_atividade = artefato_atividade.fk_atividade
			INNER JOIN projeto ON atividade.fk_projeto = projeto.id_projeto
			WHERE projeto.id_projeto =' || idProjeto || 'AND atividade.id_atividade =' || idAtividade || 
				'AND artefato.id_artefato =' || idArtefato;
	END;
$$ LANGUAGE PLPGSQL;