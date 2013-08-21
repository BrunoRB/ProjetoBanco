-- INSERTS

CREATE OR REPLACE FUNCTION artefato_atividadeCadastrar (id_artefato INTEGER, id_atividade INTEGER, porcentagem_p INTEGER)
RETURNS RECORD AS $$
	DECLARE
		codigos RECORD;
	BEGIN
		--verificar se a porcentagem passada somada as porcentagens das outras atividades não passa de 100%
		INSERT INTO artefato_atividade (fk_atividade, fk_artefato, porcentagem_gerada) 
		VALUES (id_atividade, id_artefato, porcentagem_p) RETURNING id_atividade, id_artefato INTO codigos;
		RAISE NOTICE 'Atividade vinculada ao artefato com sucesso!';
		RETURN codigos;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'O valor da porcengem informado é inválido!';
			codigos := 0;
			RETURN codigos;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS

--UPDATES

CREATE OR REPLACE FUNCTION artefato_atividadeAtualizar (id_atividade INTEGER, id_artefato INTEGER, porcentagem_p INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		UPDATE artefato_atividade SET porcentagem_gerada = porcentagem_p
		WHERE fk_atividade = id_atividade AND fk_artefato = id_artefato;
		IF (FOUND) THEN
			RAISE NOTICE 'Relação entre atividade e artefato atualizada com sucesso!';
			RETURN 1;
		ELSE
			RAISE NOTICE 'Falha ao atulizar relação entre atividade e artefato!';
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

CREATE OR REPLACE FUNCTION artefato_atividadeExcluir (id_atividade INTEGER, id_artefato INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		DELETE FROM artefato_atividade WHERE fk_atividade = id_atividade AND fk_artefato = id_artefato;
		IF (FOUND) THEN
			RETURN 1;
			RAISE NOTICE 'Relação atividade e artefato excluida com sucesso!';
		ELSE
			RETURN 0;
			RAISE NOTICE 'Falha ao excluir relação atividade e artefato!';
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETES;


