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
		id_trash INTEGER;
	BEGIN
		--cria gerente
		id_gerente := membroCadastra ('Gerente ', 'gerente'||random(), 'admin', CURRENT_DATE);

	 	--cria projeto
		id_projeto := projetoCadastrar ('Sistemas de bancos de dados', 10.000, 'terceiro projeto integrador', id_gerente);
		
		--cria membros
		id_membro1 := membroCadastra ('Membro1 ', 'Membro'||random(), 'admin', CURRENT_DATE); --cria membro 1
		id_membro2 := membroCadastra ('Membro2 ', 'Membro'||random(), 'admin', CURRENT_DATE); --cria membro 2
		id_membro3 := membroCadastra ('Membro3 ', 'Membro'||random(), 'admin', CURRENT_DATE); --cria membro 3
		
		--cria atividades
		id_atividade1 := atividadeCadastrar(CURRENT_DATE, (CURRENT_DATE + randVal), 'Testes unitários', 'descrição desta atividade', id_projeto);
		id_atividade2 := atividadeCadastrar(CURRENT_DATE, (CURRENT_DATE + randVal), 'Codificação', id_projeto);
		id_atividade3 := atividadeCadastrar(CURRENT_DATE, (CURRENT_DATE + randVal), 'Refatoração', id_projeto);
		
		 --atribui atividades
		id_trash := atividadeAtribuir(id_membro1, id_atividade1);
		id_trash := atividadeAtribuir(id_membro1, id_atividade2);
		id_trash := atividadeAtribuir(id_membro2, id_atividade2);
		id_trash := atividadeAtribuir(id_membro3, id_atividade3);
		
		RETURN 'TRUE';
	END;
$$ LANGUAGE PLPGSQL;

SELECT insertData();



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
