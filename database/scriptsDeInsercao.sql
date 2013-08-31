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
		email VARCHAR;
		id_artefato1 INTEGER;
		id_artefato2 INTEGER;
		id_despesa1 INTEGER;
		id_despesa2 INTEGER;
		id_mensagem INTEGER;
	BEGIN
		FOR i IN 1..11000 LOOP
			--cria gerente
			email := ('gerente' || i || '@gerente.com');
			id_gerente := usuarioCadastrar ('Gerente', email, 'admin');

	 		--cria projeto
			id_projeto := projetoCadastrar ('Sistemas de bancos de dados', 10.000, 'terceiro projeto integrador');
			--aloca gerente ao projeto
			id_trash := membroCadastrarEmProjeto (id_projeto, id_gerente, 'Gerente');		

			--cria membros
			email := 'membro' || i || 'a@membro.com';
			id_membro1 := usuarioCadastrar ('Membro1', email, 'membro'); --cria membro 1
			email := 'membro' || i || 'b@membro.com';
			id_membro2 := usuarioCadastrar ('Membro2', email, 'membro'); --cria membro 2
			email := 'membro' || i || 'c@membro.com';
			id_membro3 := usuarioCadastrar ('Membro3', email, 'membro'); --cria membro 3
			--aloca membros ao projeto
			membro_projeto1 := membroCadastrarEmProjeto (id_projeto, id_membro1, 'membro');	
			membro_projeto2 := membroCadastrarEmProjeto (id_projeto, id_membro2, 'membro');
			membro_projeto3 := membroCadastrarEmProjeto (id_projeto, id_membro3, 'membro');		
			
			--cria fases
			id_fase1 := faseCadastrar('Fase 1', 'Primeira fase do projeto', id_projeto);
			id_fase2 := faseCadastrar('Fase 2', 'Segunda fase do projeto', id_projeto, id_fase1);
			id_fase3 := faseCadastrar('Fase 3', 'Terceira fase do projeto', id_projeto, id_fase2);

			--cria atividades
			id_atividade1 := atividadeCadastrar(CURRENT_DATE, (CURRENT_DATE + randVal), 'Testes unitários', 'descrição desta atividade', id_fase1);
			id_atividade2 := atividadeCadastrar((CURRENT_DATE + randval + i), (CURRENT_DATE + randVal + (i*2)), 'Codificação', id_atividade1, id_fase1);
			id_atividade3 := atividadeCadastrar(CURRENT_DATE, (CURRENT_DATE + randVal), 'Refatoração', id_fase2);
			id_atividade4 := atividadeCadastrar((CURRENT_DATE + randval + i), (CURRENT_DATE + randVal + (i*2)), 'Testes unitários', 'descrição desta atividade', id_atividade3, id_fase2);
			id_atividade5 := atividadeCadastrar(CURRENT_DATE, (CURRENT_DATE + randVal), 'Codificação', id_fase3);
			id_atividade6 := atividadeCadastrar((CURRENT_DATE + randval + i), (CURRENT_DATE + randVal + (i*2)), 'Refatoração', id_atividade5, id_fase3);		

			 --atribui atividades
			id_trash := atividade_do_membroCadastrar(membro_projeto1, id_atividade1);
			id_trash := atividade_do_membroCadastrar(membro_projeto1, id_atividade3);
			id_trash := atividade_do_membroCadastrar(membro_projeto2, id_atividade2);
			id_trash := atividade_do_membroCadastrar(membro_projeto2, id_atividade4);
			id_trash := atividade_do_membroCadastrar(membro_projeto3, id_atividade5);
			id_trash := atividade_do_membroCadastrar(membro_projeto3, id_atividade6);
		
			--cria artefatos
			id_artefato1 := artefatoCadastrar ('artefato 1', 'Tipo 1', 'Primeiro artefato'); --artefato
			id_artefato2 := artefatoCadastrar ('artefato 2', 'Tipo 2', 'Segundo artefato');

			--vincula atividades aos artefatos
			confirm := artefato_atividadeCadastrar(id_artefato1, id_atividade1, 35);
			confirm := artefato_atividadeCadastrar(id_artefato1, id_atividade2, 35);
			confirm := artefato_atividadeCadastrar(id_artefato1, id_atividade3, 30);
			confirm := artefato_atividadeCadastrar(id_artefato2, id_atividade4, 40);
			confirm := artefato_atividadeCadastrar(id_artefato2, id_atividade5, 25);
			confirm := artefato_atividadeCadastrar(id_artefato2, id_atividade6, 35);

			--cria despesas
			id_despesa1 := despesaCadastrar ('despesa 1', 100, id_projeto);
			id_despesa2 := despesaCadastrar ('despesa 2', 450.67, 'Despesa referente a um recurso', id_projeto);

			--cria recursos
			id_trash := recursoCadastrar('recurso 1', 'descricao do recurso 1', id_projeto, id_despesa2);
			id_trash := recursoCadastrar('recurso 2', id_projeto);
			
			--escreve mensagem do gerente
			id_mensagem := mensagemEscreve('mensagem do gerente', 'Bem vindo ao projeto', id_gerente);
			--envia mensagem do gerente para os membros
			confirm := mensagem_enviadaEnvia(id_membro1, id_mensagem, CURRENT_DATE);
			confirm := mensagem_enviadaEnvia(id_membro2, id_mensagem, CURRENT_DATE);		
			confirm := mensagem_enviadaEnvia(id_membro3, id_mensagem, CURRENT_DATE);
			
			--escreve mensagem de um membro
			id_mensagem := mensagemEscreve('Prazo para a atividade X', 'Acho que não será possível terminar essa atividade no prazo', id_membro2);
			--envia mensagem para o gerente
			confirm := mensagem_enviadaEnvia(id_gerente, id_mensagem, CURRENT_DATE);
		END LOOP;
		RETURN 'TRUE';
	END;
$$ LANGUAGE PLPGSQL;

--SELECT insertData();



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

--TODO update data
CREATE OR REPLACE FUNCTION updateData() RETURNS BOOLEAN AS $$
	BEGIN
		RETURN 'TRUE';
	END;
$$ LANGUAGE PLPGSQL;
