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
		id_fase1 INTEGER;
		id_fase2 INTEGER;
		id_fase3 INTEGER;
		membro_projeto1 INTEGER;
		membro_projeto2 INTEGER;
		membro_projeto3 INTEGER;
	BEGIN
		--cria gerente
		id_gerente := usuarioCadastrar ('Gerente ', 'gerente'||random(), 'admin');

	 	--cria projeto
		id_projeto := projetoCadastrar ('Sistemas de bancos de dados', 10.000, 'terceiro projeto integrador');
		--aloca gerente ao projeto
		id_trash := membroCadastrarEmProjeto (id_projeto, id_gerente, 'Gerente');		

		--cria membros
		id_membro1 := usuarioCadastrar ('Membro1 ', 'Membro'||random(), 'admin'); --cria membro 1
		id_membro2 := usuarioCadastrar ('Membro2 ', 'Membro'||random(), 'admin'); --cria membro 2
		id_membro3 := usuarioCadastrar ('Membro3 ', 'Membro'||random(), 'admin'); --cria membro 3
		--aloca membros ao projeto
		membro_projeto1 := membroCadastrarEmProjeto (id_projeto, id_membro1, 'membro');	
		membro_projeto2 := membroCadastrarEmProjeto (id_projeto, id_membro2, 'membro');
		membro_projeto3 := membroCadastrarEmProjeto (id_projeto, id_membro3, 'membro');		
		
		--cria fases
		id_fase1 := faseCadastrar('Fase 1', 'Primeira fase do projeto');
		id_fase2 := faseCadastrar('Fase 2', 'Segunda fase do projeto', id_fase1);
		id_fase3 := faseCadastrar('Fase 3', 'Terceira fase do projeto', id_fase2);

		--cria atividades
		id_atividade1 := atividadeCadastrar(CURRENT_DATE, (CURRENT_DATE + randVal), 'Testes unitários', 'descrição desta atividade', id_fase1);
		id_atividade2 := atividadeCadastrar(CURRENT_DATE, (CURRENT_DATE + randVal), 'Codificação', id_atividade1, id_fase1);
		id_atividade3 := atividadeCadastrar(CURRENT_DATE, (CURRENT_DATE + randVal), 'Refatoração', id_fase2);
		id_atividade4 := atividadeCadastrar(CURRENT_DATE, (CURRENT_DATE + randVal), 'Testes unitários', 'descrição desta atividade', id_atividade3, id_fase2);
		id_atividade5 := atividadeCadastrar(CURRENT_DATE, (CURRENT_DATE + randVal), 'Codificação', id_fase3);
		id_atividade6 := atividadeCadastrar(CURRENT_DATE, (CURRENT_DATE + randVal), 'Refatoração', id_atividade5, id_fase3);		

		 --atribui atividades
		id_trash := atividadeAtribuir(membro_projeto1, id_atividade1);
		id_trash := atividadeAtribuir(membro_projeto1, id_atividade3);
		id_trash := atividadeAtribuir(membro_projeto2, id_atividade2);
		id_trash := atividadeAtribuir(membro_projeto2, id_atividade4);
		id_trash := atividadeAtribuir(membro_projeto3, id_atividade5);
		id_trash := atividadeAtribuir(membro_projeto3, id_atividade6);
		
		

		RETURN 'TRUE';
	END;
$$ LANGUAGE PLPGSQL;

--SELECT insertData();



CREATE OR REPLACE FUNCTION deleteData() RETURNS BOOLEAN AS $$
	BEGIN
		DELETE FROM atividade_do_membro;
		
		DELETE FROM atividade;
		
		DELETE FROM cronograma;
		
		DELETE FROM projeto;
		
		DELETE FROM membro;
		
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
