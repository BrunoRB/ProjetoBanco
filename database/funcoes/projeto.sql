
--INSERTS;

CREATE OR REPLACE FUNCTION projetoCadastrar (idUsuario INTEGER, nome VARCHAR(100), orcamento NUMERIC(10, 2), descricao TEXT) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
		idMembroDoProjeto INTEGER;
		trash BOOLEAN;
	BEGIN
		SET ROLE insert;
		INSERT INTO projeto (nome, orcamento, descricao) VALUES 
			(nome, orcamento, descricao);
		SET ROLE retrieve;
		SELECT INTO id_gerada currval('projeto_id_projeto_seq');
		
		idMembroDoProjeto := membroCadastrarEmProjeto(id_gerada, idUsuario, 'Gerente');
		
		trash := mensagemDeSucesso('PROJETO', 'CADASTRADO'); -- raise notice, ver zFuncoesGerais
		
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
		trash BOOLEAN;
	BEGIN
		SET ROLE insert;
		INSERT INTO projeto (nome, descricao) VALUES (nomeProjeto, descricao);

		SET ROLE retrieve;
		SELECT INTO id_gerada currval('projeto_id_projeto_seq');
		
		idMembroDoProjeto := membroCadastrarEmProjeto(id_gerada, idUsuario, 'Gerente');
		
		trash := mensagemDeSucesso('PROJETO', 'cadastrado'); -- raise notice, ver zFuncoesGerais
		
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
		trash BOOLEAN;
	BEGIN
		SET ROLE insert;
		INSERT INTO projeto (nome, orcamento) VALUES (nomeProjeto, orcamento);
		
		SET ROLE retrieve;
		SELECT INTO id_gerada currval('projeto_id_projeto_seq');
		
		idMembroDoProjeto := membroCadastrarEmProjeto(id_gerada, idUsuario, 'Gerente');
		
		trash := mensagemDeSucesso('projeto', 'CADASTRADO'); -- raise notice, ver zFuncoesGerais
		
		RETURN id_gerada;
		
		EXCEPTION
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION '[Erro] Dados inválidos inseridos !';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;

--UPDATE

CREATE OR REPLACE FUNCTION projetoAtualizar (id INTEGER, nome_p VARCHAR(100), orcamento_p NUMERIC(11,2), dataCadastro DATE, descricao_p TEXT, dataTermino DATE)
	RETURNS INTEGER AS $$
	DECLARE
		trash BOOLEAN;
	BEGIN
		SET ROLE update;
		UPDATE projeto SET nome = nome_p, orcamento = orcamento_p, data_de_cadastro = dataCadastro, descricao = descricao_p, data_de_termino = dataTermino
		WHERE id_projeto = id;
		IF (FOUND) THEN
			trash := mensagemDeSucesso('PROJETO', 'atualizado'); -- raise notice, ver zFuncoesGerais
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END UPDATE

--DELETES;

CREATE OR REPLACE FUNCTION projetoExcluir (id INTEGER)	RETURNS INTEGER AS $$
	DECLARE
		trash BOOLEAN;
	BEGIN
		SET ROLE delete;
		DELETE FROM projeto WHERE id_projeto = id;
		IF (FOUND) THEN
			trash := mensagemDeSucesso('PROJETO', 'excluído'); -- raise notice, ver zFuncoesGerais
			RETURN 1;
		END IF;
		
		RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETES;

--SELECTS;

CREATE OR REPLACE FUNCTION projetoListar (idUsuario INTEGER, OUT id_projeto INTEGER, OUT nome VARCHAR, OUT funcao VARCHAR) RETURNS SETOF RECORD AS $$
	SET ROLE retrieve;
	SELECT id_projeto, nome, funcao FROM projetoView WHERE id_usuario = $1;
$$ LANGUAGE SQL;

CREATE OR REPLACE FUNCTION projetoExibir (idUsuario INTEGER, OUT id INTEGER, OUT nome VARCHAR, OUT funcao VARCHAR) RETURNS SETOF RECORD AS $$
	DECLARE
		funcao VARCHAR(100);
	BEGIN
		SET ROLE retrieve;
		SELECT INTO funcao funcao FROM membro_do_projeto INNER JOIN usuario ON membro_do_projeto.fk_usuario = usuario.id_usuario; 

		IF LOWER(funcao) = 'gerente' THEN
			SELECT projeto.nome, projeto.orcamento, projeto.data_de_cadastro, projeto.descricao, projeto.data_de_termino, usuario.nome AS gerente 
				FROM projeto INNER JOIN membro_do_projeto ON projeto.id_projeto = membro_do_projeto.fk_projeto 
				INNER JOIN usuario ON membro_do_projeto.fk_usuario = usuario.id_usuario 
1				WHERE usuario.id_usuario = idUsuario AND LOWER(membro_do_projeto.funcao) = 'gerente';
		ELSE
			SELECT projeto.nome AS projeto, projeto.descricao, projeto.data_de_termino, usuario.nome AS gerente
				FROM projeto INNER JOIN membro_do_projeto ON projeto.id_projeto = membro_do_projeto.fk_projeto 
				INNER JOIN usuario ON membro_do_projeto.fk_usuario = usuario.id_usuario 
				WHERE usuario.id_usuario = idUsuario AND LOWER(membro_do_projeto.funcao) = 'gerente';
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

