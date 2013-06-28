
CREATE OR REPLACE FUNCTION atribuirAtividade (fk_membro INTEGER, fk_atividade INTEGER)
RETURNS INTEGER AS $$
BEGIN
	INSERT INTO atividade_membro VALUES (fk_membro, fk_atividade);
	RETURN 1;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION desatribuirAtividade (fk_membro INTEGER, fk_atividade INTEGER)
RETURN INTEGER AS $$
BEGIN
	DELETE FROM atividade_membro WHERE atividade_membro.fk_membro = fk_membro AND atividade_membro.fk_atividade = fk_atividade;
	RETURN 1;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION buscarAtividadesAtribuidas (fk_membro INTEGER)
RETURN SETOF atividade_membro AS $$
BEGIN
	
END;
$$ LANGUAGE PLPGSQL;
