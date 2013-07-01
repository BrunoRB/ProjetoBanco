
CREATE OR REPLACE FUNCTION atribuirAtividade (fk_membro INTEGER, fk_atividade INTEGER)
RETURNS BOOLEAN AS $$
BEGIN
	INSERT INTO atividade_membro VALUES (fk_membro, fk_atividade);
	RETURN FOUND;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION desatribuirAtividade (fk_membro INTEGER, fk_atividade INTEGER)
RETURN BOOLEAN AS $$
BEGIN
	DELETE FROM atividade_membro WHERE atividade_membro.fk_membro = fk_membro AND atividade_membro.fk_atividade = fk_atividade;
	RETURN FOUND;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION buscarAtividadesAtribuidas (fk_membro INTEGER)
RETURN SETOF atividade_membro AS $$
BEGIN
	RETURN SELECT inicio_atividade, limite_atividade, nome_atividade, descricao_atividade FROM atividade 
	INNER JOIN atividade_do_membro 
		ON atividade.id_atividade = atividade_do_membro.fk_atividade 
	WHERE atividade_do_membro.fk_membro = fk_membro;
END;
$$ LANGUAGE PLPGSQL;
