CREATE OR REPLACE FUNCTION insertData() RETURNS BOOLEAN AS $$
	DECLARE
		id_gerente INTEGER;
		id_projeto INTEGER;
		id_membro1 INTEGER;
		id_membro2 INTEGER;
		id_membro3 INTEGER;
		id_atividade1 INTEGER;
		id_atividade2 INTEGER;
		id_atividade3 INTEGER;
		
	BEGIN
		--cria gerente
		id_gerente := membroCadastra ('Gerente ', 'gerente'||random(), 'admin', CURRENT_DATE);

	 	--cria projeto
		id_projeto := projetoCadastrar ('Sistemas de bancos de dados', 10.000, 'terceiro projeto integrador', id_membro);
		
		--cria membros
		id_membro1 := membroCadastra ('Membro1 ', 'Membro'||random(), 'admin', CURRENT_DATE); --cria membro 1
		id_membro2 := membroCadastra ('Membro2 ', 'Membro'||random(), 'admin', CURRENT_DATE); --cria membro 2
		id_membro3 := membroCadastra ('Membro3 ', 'Membro'||random(), 'admin', CURRENT_DATE); --cria membro 3
		
		--cria atividades
		id_atividade1 := atividadeCadastrar(CURRENT_DATE, CURRENT_DATE + TRUNC(20*random()), 'Testes unitários', 'descrição desta atividade', id_projeto);
		id_atividade2 := atividadeCadastrar(CURRENT_DATE, CURRENT_DATE + TRUNC(20*random()), 'Codificação', id_projeto);
		id_atividade3 := atividadeCadastrar(CURRENT_DATE, CURRENT_DATE + TRUNC(20*random()), 'Refatoração', id_projeto);
		
		 --atribui atividades
		--atividadeAtribuir();
		--atividadeAtribuir();
		--atividadeAtribuir();
		--atividadeAtribuir();
		
		
		RETURN 'TRUE';
	END;
$$ LANGUAGE PLPGSQL;

SELECT insertData();



CREATE OR REPLACE FUNCTION deleteData() RETURNS BOOLEAN AS $$
	BEGIN
		DELETE FROM usuario;
		IF (NOT FOUND) THEN
			RETURN 'FALSE';
		END IF;
		
		DELETE FROM membro;
		IF (NOT FOUND) THEN
			RETURN 'FALSE';
		END IF;
		
		DELETE FROM projeto;
		IF (NOT FOUND) THEN
			RETURN 'FALSE';
		END IF;
		
		DELETE FROM atividade;
		IF (NOT FOUND) THEN
			RETURN 'FALSE';
		END IF;
		
		DELETE FROM cronograma;
		IF (NOT FOUND) THEN
			RETURN 'FALSE';
		END IF;
		
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
