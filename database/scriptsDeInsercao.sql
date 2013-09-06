--funções necessarias para rodar o insertData:

-- projeto.sql
-- usuario.sql
-- membro_do_projeto.sql
-- fase.sql
-- atividade.sql
-- atividade_do_membro
-- artefato.sql
-- artefato_atividade.sql
-- recurso.sql
-- despesa.sql
-- mensagem.sql
-- mensagem_enviada.sql

CREATE OR REPLACE FUNCTION insertData() RETURNS BOOLEAN AS $$
	DECLARE
		randVal INTEGER := ROUND(RANDOM()*40);
		id_gerente INTEGER;
		id_projeto INTEGER;
		id_membro1 INTEGER;
		id_membro2 INTEGER;
		id_membro3 INTEGER;
		id_atividade1 INTEGER;
		id_atividade2 INTEGER;
		id_atividade3 INTEGER;
		id_atividade4 INTEGER;
		id_atividade5 INTEGER;
		id_atividade6 INTEGER;
		id_trash INTEGER;
		confirm BOOLEAN;
		id_fase1 INTEGER;
		id_fase2 INTEGER;
		id_fase3 INTEGER;
		membro_projeto1 INTEGER;
		membro_projeto2 INTEGER;
		membro_projeto3 INTEGER;
		email VARCHAR; email1 VARCHAR; email2 VARCHAR; email3 VARCHAR;
		id_artefato1 INTEGER;
		id_artefato2 INTEGER;
		id_despesa1 INTEGER;
		id_despesa2 INTEGER;
		id_mensagem INTEGER;
	BEGIN
		FOR i IN 1..10 LOOP
			--cria gerente
			email := ('gerente' || i || '@gerente.com');
			--descrição paremetros->	  nome	   login   senha
			id_gerente := usuarioCadastrar ('Gerente', email, 'admin');

			--cria membros
			email1 := 'membro' || i || 'a@membro.com';
			id_membro1 := usuarioCadastrar ('Membro1', email1, 'membro'); --cria membro 1
			email2 := 'membro' || i || 'b@membro.com';
			id_membro2 := usuarioCadastrar ('Membro2', email2, 'membro'); --cria membro 2
			email3 := 'membro' || i || 'c@membro.com';
			id_membro3 := usuarioCadastrar ('Membro3', email3, 'membro'); --cria membro 3

			--gerente loga no sistema
			id_trash := logar(email, 'admin');

	 		--cria projeto com gerente já definido
			--descrição paremetros->			     nome		  orçamento		descrição
			id_projeto := projetoCadastrar (id_gerente, 'Sistemas de bancos de dados', 10.000, 'terceiro projeto integrador');

			--gerente convida membros ao projeto
			--descrição paremetros->							   função  
			membro_projeto1 := membro_do_projetoCadastrar (id_gerente, id_projeto, id_membro1, 'membro');	
			membro_projeto2 := membro_do_projetoCadastrar (id_gerente, id_projeto, id_membro2, 'membro');
			membro_projeto3 := membro_do_projetoCadastrar (id_gerente, id_projeto, id_membro3, 'membro');		
			
			--membros logam
			id_trash := logar(email1, 'membro');
			id_trash := logar(email2, 'membro');
			id_trash := logar(email3, 'membro');

			--membros aceitam os convites
			id_trash := membro_do_projetoAceita(id_membro1, id_projeto);
			id_trash := membro_do_projetoAceita(id_membro2, id_projeto);
			id_trash := membro_do_projetoAceita(id_membro3, id_projeto);

			--cria fases
			--descrição paremetros->   		nome          descrição		    id_proj    fase predecessora
			id_fase1 := faseCadastrar(id_gerente, 'Fase 1', 'Primeira fase do projeto', id_projeto);
			id_fase2 := faseCadastrar(id_gerente, 'Fase 2', 'Segunda fase do projeto', id_projeto, id_fase1);
			id_fase3 := faseCadastrar(id_gerente, 'Fase 3', 'Terceira fase do projeto', id_projeto, id_fase2);

			--cria atividades
			id_atividade1 := atividadeCadastrar(id_gerente, CURRENT_DATE, (CURRENT_DATE + randVal), 'Testes unitários', 'descrição desta atividade', id_fase1, id_projeto);
			id_atividade2 := atividadeCadastrar(id_gerente, (CURRENT_DATE + randval + i), (CURRENT_DATE + randVal + (i*2)), 'Codificação', id_atividade1, id_fase1, id_projeto);
			id_atividade3 := atividadeCadastrar(id_gerente, CURRENT_DATE, (CURRENT_DATE + randVal), 'Refatoração', id_fase2, id_projeto);
			id_atividade4 := atividadeCadastrar(id_gerente, (CURRENT_DATE + randval + i), (CURRENT_DATE + randVal + (i*2)), 'Testes unitários', 'descrição desta atividade', id_atividade3, id_fase2, id_projeto);
			id_atividade5 := atividadeCadastrar(id_gerente, CURRENT_DATE, (CURRENT_DATE + randVal), 'Codificação', id_fase3, id_projeto);
			id_atividade6 := atividadeCadastrar(id_gerente, (CURRENT_DATE + randval + i), (CURRENT_DATE + randVal + (i*2)), 'Refatoração', id_atividade5, id_fase3, id_projeto);		

			 --atribui atividades
			id_trash := atividade_do_membroCadastrar(id_gerente, id_projeto, membro_projeto1, id_atividade1);
			id_trash := atividade_do_membroCadastrar(id_gerente, id_projeto, membro_projeto1, id_atividade3);
			id_trash := atividade_do_membroCadastrar(id_gerente, id_projeto, membro_projeto2, id_atividade2);
			id_trash := atividade_do_membroCadastrar(id_gerente, id_projeto, membro_projeto2, id_atividade4);
			id_trash := atividade_do_membroCadastrar(id_gerente, id_projeto, membro_projeto3, id_atividade5);
			id_trash := atividade_do_membroCadastrar(id_gerente, id_projeto, membro_projeto3, id_atividade6);
		
			--cria artefatos
			id_artefato1 := artefatoCadastrar (id_gerente, id_projeto, 'artefato 1', 'Tipo 1', 'Primeiro artefato'); --artefato
			id_artefato2 := artefatoCadastrar (id_gerente, id_projeto, 'artefato 2', 'Tipo 2', 'Segundo artefato');

			--vincula atividades aos artefatos
			confirm := artefato_atividadeCadastrar(id_gerente, id_projeto, id_artefato1, id_atividade1, 35);
			confirm := artefato_atividadeCadastrar(id_gerente, id_projeto, id_artefato1, id_atividade2, 35);
			confirm := artefato_atividadeCadastrar(id_gerente, id_projeto, id_artefato1, id_atividade3, 30);
			confirm := artefato_atividadeCadastrar(id_gerente, id_projeto, id_artefato2, id_atividade4, 40);
			confirm := artefato_atividadeCadastrar(id_gerente, id_projeto, id_artefato2, id_atividade5, 25);
			confirm := artefato_atividadeCadastrar(id_gerente, id_projeto, id_artefato2, id_atividade6, 35);

			--cria despesas
			id_despesa1 := despesaCadastrar (id_gerente, 'despesa 1', 100, id_projeto);
			id_despesa2 := despesaCadastrar (id_gerente, 'despesa 2', 450.67, 'Despesa referente a um recurso', id_projeto);

			--cria recursos
			id_trash := recursoCadastrar(id_gerente, 'recurso 1', 'descricao do recurso 1', id_projeto, id_despesa2);
			id_trash := recursoCadastrar(id_gerente, 'recurso 2', id_projeto);
			
			--escreve mensagem do gerente
			id_mensagem := mensagemEscreve(id_projeto, 'mensagem do gerente', 'Bem vindo ao projeto', id_gerente);
			--envia mensagem do gerente para os membros
			confirm := mensagem_enviadaEnvia(id_membro1, id_projeto, id_mensagem, CURRENT_DATE);
			confirm := mensagem_enviadaEnvia(id_membro2, id_projeto, id_mensagem, CURRENT_DATE);		
			confirm := mensagem_enviadaEnvia(id_membro3, id_projeto, id_mensagem, CURRENT_DATE);
			
			--escreve mensagem de um membro
			id_mensagem := mensagemEscreve(id_projeto, 'Prazo para a atividade X', 'Acho que não será possível terminar essa atividade no prazo', id_membro2);
			--envia mensagem para o gerente
			confirm := mensagem_enviadaEnvia(id_gerente, id_projeto, id_mensagem, CURRENT_DATE);
		END LOOP;
		RETURN 'TRUE';
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION updateData() RETURNS INTEGER AS $$
	DECLARE
		resposta INTEGER;
		data1 DATE;
		data2 DATE;
	BEGIN
		--pega as datas do projeto
		SET ROLE retrieve;
		SELECT INTO data1 data_de_cadastro FROM projeto WHERE id_projeto = 1;
		SELECT INTO data2 data_de_termino FROM projeto WHERE id_projeto = 1;
		
		SET ROLE function;
		--atulizar projeto
		resposta := projetoAtualizar(1, 'Projeto alterado', 15.500, data1, 'nova descrição', data2);

		--atualiza gerente e membros do projeto
		resposta := usuarioAtualizar(1, 'Novo_gerente', 'novo_email_gerente@gerente.com', 'novasenhag');
		resposta := usuarioAtualizar(2, 'Novo_membro1', 'novo_email_membro1@gerente.com', 'novasenham');
		resposta := usuarioAtualizar(3, 'Novo_membro2', 'novo_email_membro2@gerente.com', 'novasenham', 'caminho_imagem');
		resposta := usuarioAtualizar(4, 'Novo_membro3', 'novo_email_membro3@gerente.com', 'novasenham');

		--atualiza as fases
		resposta := faseAtualizar(1, 'Nova_fase_1', 1);
		resposta := faseAtualizar(2, 'Nova_fase_2', 'Nova_descrição', 1, 1);
		resposta := faseAtualizar(3, 'Nova_fase_3', 1, 2);
		
		--atualiza as atividades

		--pega as datas da atividade 1
		SET ROLE retrieve;
		SELECT INTO data1 inicio_atividade FROM atividade WHERE id_atividade = 1;
		SELECT INTO data2 limite_atividade FROM atividade WHERE id_atividade = 1;
		SET ROLE function;
		resposta := atividadeAtualizar(1, data1, data2, 'novo_nome_atividade1', 'nova_descricao', 1);
		
		SET ROLE retrieve;
		SELECT INTO data1 inicio_atividade FROM atividade WHERE id_atividade = 2;
		SELECT INTO data2 limite_atividade FROM atividade WHERE id_atividade = 2;
		SET ROLE function;
		resposta := atividadeAtualizar(2, data1, data2, 'novo_nome_atividade2', 'adicionando_descricao', 1, 1);

		SET ROLE retrieve;
		SELECT INTO data1 inicio_atividade FROM atividade WHERE id_atividade = 3;
		SELECT INTO data2 limite_atividade FROM atividade WHERE id_atividade = 3;
		SET ROLE function;
		resposta := atividadeAtualizar(3, data1, data2, 'novo_nome_atividade3', 'adicionando_descricao', 2);

		SET ROLE retrieve;
		SELECT INTO data1 inicio_atividade FROM atividade WHERE id_atividade = 4;
		SELECT INTO data2 limite_atividade FROM atividade WHERE id_atividade = 4;
		SET ROLE function;
		resposta := atividadeAtualizar(4, data1, data2, 'novo_nome_atividade4', 'nova_descricao', 3, 2);

		SET ROLE retrieve;
		SELECT INTO data1 inicio_atividade FROM atividade WHERE id_atividade = 5;
		SELECT INTO data2 limite_atividade FROM atividade WHERE id_atividade = 5;
		SET ROLE function;
		resposta := atividadeAtualizar(5, data1, data2, 'novo_nome_atividade5', 'adicionando_descricao', 3);

		SET ROLE retrieve;
		SELECT INTO data1 inicio_atividade FROM atividade WHERE id_atividade = 6;
		SELECT INTO data2 limite_atividade FROM atividade WHERE id_atividade = 6;
		SET ROLE function;
		resposta := atividadeAtualizar(6, data1, data2, 'novo_nome_atividade6', 'adicionando_descricao', 5, 3);

		--atribui usuario a outra atividade
		--reposta := 

		--Atualiza os artefatos
		resposta := artefatoAtualizar(1, 'novo_nome_artefato1', 'novo_tipo1', '', 0);
		resposta := artefatoAtualizar(2, 'novo_nome_artefato2', 'novo_tipo2', 'nova_descricao', 0);

		RETURN resposta;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION deleteData() RETURNS BOOLEAN AS $$
	BEGIN			

		DELETE FROM artefato_atividade;

		DELETE FROM artefato;		

		DELETE FROM atividade_do_membro;
		
		DELETE FROM atividade;

		DELETE FROM fase;

		DELETE FROM membro_do_projeto;

		DELETE FROM recurso;

		DELETE FROM despesa;

		DELETE FROM projeto;

		DELETE FROM usuario;
		
		--TODO complete deletes;
		
		RETURN 'TRUE';
	END;
$$ LANGUAGE PLPGSQL;
