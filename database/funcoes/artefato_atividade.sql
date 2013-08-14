-- INSERTS

CREATE OR REPLACE FUNCTION artefato_atividadeCadastrar (id_artefato INTEGER, id_atividade INTEGER, porcentagem_p INTEGER)
RETURNS RECORD AS $$
	DECLARE
		codigos RECORD;
	BEGIN
		INSERT INTO artefato_atividade (fk_atividade, fk_artefato, porcentagem_gerada) 
		VALUES (id_atividade, id_artefato, porcentagem_p) RETURNING id_atividade, id_artefato INTO codigos;
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
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
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
		ELSE
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETES;


