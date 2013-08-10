
--INSERTS;

CREATE OR REPLACE FUNCTION atividadeAtribuir(id_membro INTEGER, id_atividade INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		INSERT INTO atividade_do_membro VALUES (id_membro, id_atividade);
		IF (FOUND) THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--DELETES;
CREATE OR REPLACE FUNCTION atividadeDesatribuir(id_membro INTEGER, id_atividade INTEGER)
RETURNS INTEGER AS $$
BEGIN
	DELETE FROM atividade_do_membro WHERE fk_membro=id_membro AND fk_atividade=id_atividade;
	IF (FOUND) THEN
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;
END;
$$ LANGUAGE PLPGSQL;

