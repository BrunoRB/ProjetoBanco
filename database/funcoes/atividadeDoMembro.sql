
--INSERTS;

CREATE OR REPLACE FUNCTION atribuirAtividade (id_membro INTEGER, id_atividade INTEGER)
	RETURNS INTEGER AS $$
BEGIN
	INSERT INTO atividade_membro VALUES (id_membro, id_atividade);
	RETURN 1;
END;
$$ LANGUAGE PLPGSQL;

--UPDATES;
CREATE OR REPLACE FUNCTION desatribuirAtividade (id_membro INTEGER, id_atividade INTEGER)
RETURNS INTEGER AS $$
BEGIN
	DELETE FROM atividade_membro WHERE fk_membro=id_membro AND fk_atividade=id_atividade;
	RETURN 1;
END;
$$ LANGUAGE PLPGSQL;

--SELECTS;
CREATE OR REPLACE FUNCTION buscarAtividadesAtribuidas (id_membro INTEGER)
RETURNS SETOF atividade_do_membro AS $$	
BEGIN
	RETURN QUERY EXECUTE 'SELECT inicio_atividade, limite_atividade, nome_atividade, descricao_atividade FROM atividade 
	INNER JOIN atividade_do_membro
		ON atividade.id_atividade = atividade_do_membro.fk_atividade 
	WHERE atividade_do_membro.fk_membro = id_membro';
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION buscarAtividadesDoProjeto (id_membro INTEGER, id_projeto INTEGER)
RETURNS SETOF atividade_do_membro AS $$	
BEGIN
	RETURN QUERY EXECUTE 'SELECT inicio_atividade, limite_atividade, nome_atividade, descricao_atividade FROM atividade 
	INNER JOIN atividade_do_membro
		ON atividade.id_atividade = atividade_do_membro.fk_atividade
	WHERE atividade_do_membro.fk_membro = id_membro AND atividade.fk_projeto=id_projeto';
END;
$$ LANGUAGE PLPGSQL;

