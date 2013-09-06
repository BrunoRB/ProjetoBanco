
--INSERTS;

CREATE OR REPLACE FUNCTION atividade_do_membroCadastrar(idUsuario INTEGER, idProjeto INTEGER, id_membro INTEGER, id_atividade INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO atividade_do_membro (fk_membro_do_projeto, fk_atividade)
			VALUES (id_membro, id_atividade);

		SET ROLE retrieve;
		SELECT INTO id_gerada currval('atividade_do_membro_id_atividade_do_membro_seq');
		EXECUTE mensagemDeSucesso('Atividade', 'atribuida ao usuário');
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
CREATE OR REPLACE FUNCTION atividade_do_membroExcluir(idUsuario INTEGER, idProjeto INTEGER, id_membro INTEGER, id_atividade INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		id_atdm INTEGER;
		id_com INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;

		SET ROLE retrieve;
		SELECT INTO id_atdm id_atividade_do_membro FROM atividade_do_membro WHERE fk_membro=id_membro AND fk_atividade=id_atividade;
		SELECT INTO id_com id_comentario FROM comentario WHERE fk_atividade_do_membro = id;

		SET ROLE delete;
		DELETE FROM imagem WHERE fk_comentario = id_com;
		DELETE FROM comentario WHERE fk_atividade_do_membro = id_atdm;
		DELETE FROM atividade_do_membro WHERE fk_membro=id_membro AND fk_atividade=id_atividade;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Atividade', 'excluida');
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

