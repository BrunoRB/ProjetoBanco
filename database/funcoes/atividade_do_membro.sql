
--INSERTS;

CREATE OR REPLACE FUNCTION atividade_do_membroCadastrar(id_membro INTEGER, id_atividade INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
		trash BOOLEAN;
	BEGIN
		SET ROLE insert;
		INSERT INTO atividade_do_membro (fk_membro_do_projeto, fk_atividade)
			VALUES (id_membro, id_atividade);

		SET ROLE retrieve;
		SELECT INTO id_gerada currval('atividade_do_membro_id_atividade_do_membro_seq');
		trash := mensagemDeSucesso('Atividade', 'atribuida');
		RETURN id_gerada;
	EXCEPTION
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION '[Erro] A relação já existe!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERT;

--UPDATE;

--CREATE OR REPLACE FUNCTION atividade_do_membroAtualizar()
--RETURNS INTEGER AS $$
--	DECLARE
--		trash BOOLEAN;
--	BEGIN
--		
--	END:
--$$ LANGUAGE PLPGSQL;

--END UPDATE;

--DELETES;
CREATE OR REPLACE FUNCTION atividade_do_membroExcluir(id_membro INTEGER, id_atividade INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		trash BOOLEAN;
	BEGIN
		SET ROLE delete;
		DELETE FROM atividade_do_membro WHERE fk_membro=id_membro AND fk_atividade=id_atividade;
		IF (FOUND) THEN
			trash := mensagemDeSucesso('Atribuição', 'excluida');
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

