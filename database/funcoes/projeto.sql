
--INSERTS;

CREATE OR REPLACE FUNCTION projetoCadastrar (idUsuario INTEGER, nome VARCHAR(100), orcamento NUMERIC(10, 2), descricao TEXT) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
		idMembroDoProjeto INTEGER;
	BEGIN
		IF NOT isLogado(idUsuario) THEN
			RETURN 0;
		END IF;
	
		SET ROLE insert;
		INSERT INTO projeto (nome, orcamento, descricao) VALUES 
			(nome, orcamento, descricao);
		SET ROLE retrieve;
		SELECT INTO id_gerada currval('projeto_id_projeto_seq');
		
		--Seta esse ususario como gerente deste projeto
		SET ROLE insert;
		INSERT INTO membro_do_projeto (fk_projeto, fk_usuario, funcao, aceito) 
		VALUES (id_gerada, idUsuario, 'Gerente', true);
		
		EXECUTE mensagemDeSucesso('PROJETO', 'CADASTRADO'); -- raise notice, ver zFuncoesGerais
		
		RETURN id_gerada;

		EXCEPTION
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION '[Erro] Dados inválidos inseridos !';
			RETURN 0;
	END;
	
	
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION projetoCadastrar (idUsuario INTEGER, nomeProjeto VARCHAR(100), descricao TEXT) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
		idMembroDoProjeto INTEGER;
	BEGIN
		IF NOT isLogado(idUsuario) THEN
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO projeto (nome, descricao) VALUES (nomeProjeto, descricao);

		SET ROLE retrieve;
		SELECT INTO id_gerada currval('projeto_id_projeto_seq');
		
		idMembroDoProjeto := membro_do_projetoCadastrar(id_gerada, idUsuario, 'Gerente');
		
		EXECUTE mensagemDeSucesso('PROJETO', 'cadastrado'); -- raise notice, ver zFuncoesGerais
		
		RETURN id_gerada;
		
		EXCEPTION
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION '[Erro] Dados inválidos inseridos !';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION projetoCadastrar (idUsuario INTEGER, nomeProjeto VARCHAR(100), orcamento NUMERIC(10, 2)) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
		idMembroDoProjeto INTEGER;
	BEGIN
		IF NOT isLogado(idUsuario) THEN
			RETURN 0;
		END IF;
	
		SET ROLE insert;
		INSERT INTO projeto (nome, orcamento) VALUES (nomeProjeto, orcamento);
		
		SET ROLE retrieve;
		SELECT INTO id_gerada currval('projeto_id_projeto_seq');
		
		idMembroDoProjeto := membro_do_projetoCadastrar(id_gerada, idUsuario, 'Gerente');
		
		EXECUTE mensagemDeSucesso('projeto', 'CADASTRADO'); -- raise notice, ver zFuncoesGerais
		
		RETURN id_gerada;
		
		EXCEPTION
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION '[Erro] Dados inválidos inseridos !';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;

--UPDATE

CREATE OR REPLACE FUNCTION projetoAtualizar (
	idUsuario INTEGER, idProjeto INTEGER, nome_p VARCHAR(100), orcamento_p NUMERIC(11,2), dataCadastro DATE, descricao_p TEXT, dataTermino DATE
) RETURNS INTEGER AS $$
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;
	
		SET ROLE update;
		UPDATE projeto SET nome = nome_p, orcamento = orcamento_p, data_de_cadastro = dataCadastro, descricao = descricao_p, data_de_termino = dataTermino
			WHERE id_projeto = idProjeto;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('PROJETO', 'atualizado'); -- raise notice, ver zFuncoesGerais
			RETURN 1;
		ELSE
			RAISE NOTICE 'Erro ao atualizar projeto!';
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION ProjetoFinalizar(idUsuario INTEGER, idProjeto INTEGER) RETURNS INTEGER AS $$
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;

		SET ROLE update;
		UPDATE projeto SET data_de_termino = now() WHERE id_projeto = idProjeto;

		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('PROJETO', 'finalizado'); -- raise notice, ver zFuncoesGerais
			RETURN 1;
		ELSE
			RAISE NOTICE 'Erro ao finalizar projeto!';
			RETURN 0;
		END IF;
		
	END;
$$ LANGUAGE PLPGSQL;

--END UPDATE

--DELETES;

CREATE OR REPLACE FUNCTION projetoExcluir (idUsuario INTEGER, idProjeto INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_mdp INTEGER;
		id_atdm INTEGER;
		id_com INTEGER;
		id_ati INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;
		
		
		--SELECT INTO id_ati id_atividade FROM atividade WHERE fk_projeto = idProjeto;

		SET ROLE delete;

		DELETE FROM recurso WHERE fk_projeto = idProjeto;
		DELETE FROM despesa WHERE fk_projeto = idProjeto;

		

		FOR id_mdp IN SELECT id_membro_do_projeto FROM membro_do_projeto WHERE fk_projeto = idProjeto LOOP
			SET ROLE retrieve;
			SELECT INTO id_atdm id_atividade_do_membro FROM atividade_do_membro WHERE fk_membro_do_projeto = id_mdp;
			SELECT INTO id_com id_comentario FROM comentario WHERE fk_atividade_do_membro = id_atdm;

			SET ROLE delete;			

			DELETE FROM imagem WHERE fk_comentario = id_com;
			DELETE FROM comentario WHERE fk_atividade_do_membro = id_atdm;

			DELETE FROM atividade_do_membro WHERE fk_membro_do_projeto = id_mdp;
		END LOOP;
		
		SET ROLE delete;
		DELETE FROM membro_do_projeto WHERE fk_projeto = idProjeto;

		FOR id_ati IN SELECT id_atividade FROM atividade WHERE fk_projeto = idProjeto LOOP
			DELETE FROM artefato_atividade WHERE fk_atividade = id_ati;
		END LOOP;

		DELETE FROM atividade WHERE fk_projeto = idProjeto;

		DELETE FROM fase WHERE fk_projeto = idProjeto;

		DELETE FROM artefato WHERE fk_projeto = idProjeto;

		DELETE FROM projeto WHERE id_projeto = idProjeto;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('PROJETO', 'excluído'); -- raise notice, ver zFuncoesGerais
			RETURN 1;
		END IF;
		
		RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETES;

--SELECTS;

--TODO
CREATE OR REPLACE FUNCTION projetoListar(idUsuario INTEGER, OUT id_projeto INTEGER, OUT nome VARCHAR, OUT funcao VARCHAR) RETURNS SETOF RECORD AS $$
	BEGIN		
		IF NOT isLogado(idUsuario) THEN
			RETURN;
		END IF;
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT id_projeto, nome, funcao FROM projetoView WHERE id_usuario =' || idUsuario;
	END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION projetoExibirGerente(
	idUsuario INTEGER, idProjeto INTEGER, OUT nome VARCHAR, OUT orcamento NUMERIC, 
	OUT data_de_cadastro DATE, OUT descricao TEXT, OUT data_de_termino DATE
) RETURNS SETOF RECORD AS $$
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN;
		END IF;
		
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT nome, orcamento, data_de_cadastro, descricao, data_de_termino 
			FROM projeto WHERE id_projeto =' || idProjeto;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION projetoExibirMembro(
	idUsuario INTEGER, idProjeto INTEGER, OUT nome VARCHAR, OUT DESCRICAO TEXT, OUT data_de_termino DATE
) RETURNS SETOF RECORD AS $$
	BEGIN
		IF NOT isMembro(idUsuario, idProjeto) THEN
			RETURN;
		END IF;
		
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT nome, descricao, data_de_termino 
			FROM projeto WHERE id_projeto =' || idProjeto;
	END;
$$ LANGUAGE PLPGSQL;
