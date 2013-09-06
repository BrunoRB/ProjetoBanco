-- INSERTS

CREATE OR REPLACE FUNCTION artefato_atividadeCadastrar (idUsuario INTEGER, idProjeto INTEGER, id_artefato INTEGER, id_atividade INTEGER, porcentagem_p INTEGER)
RETURNS BOOLEAN AS $$
	DECLARE
		codigos RECORD;
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;		

		SET ROLE insert;
		INSERT INTO artefato_atividade (fk_atividade, fk_artefato, porcentagem_gerada) 
		VALUES (id_atividade, id_artefato, porcentagem_p);
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Relação Artefato/Atividade', 'inserida');
			RETURN true;
		ELSE
			RETURN false;
		END IF;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'O valor da porcengem informado é inválido!';
			codigos := 0;
			RETURN codigos;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS

--UPDATES

CREATE OR REPLACE FUNCTION artefato_atividadeAtualizar (idUsuario INTEGER, idProjeto INTEGER, id_atividade INTEGER, id_artefato INTEGER, porcentagem_p INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;

		SET ROLE update;
		UPDATE artefato_atividade SET porcentagem_gerada = porcentagem_p WHERE fk_atividade = id_atividade AND fk_artefato = id_artefato;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Relação artefato/atividade', 'atualizada');
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

CREATE OR REPLACE FUNCTION artefato_atividadeExcluir(idUsuario INTEGER, idProjeto INTEGER, id_atividade INTEGER, id_artefato INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;

		SET ROLE delete;
		DELETE FROM artefato_atividade WHERE fk_atividade = id_atividade AND fk_artefato = id_artefato;
		IF (FOUND) THEN
			RETURN 1;
			EXECUTE mensagemDeSucesso('Relação artefato/atividade', 'excluida');
		ELSE
			RETURN 0;
			RAISE NOTICE 'Falha ao excluir relação atividade e artefato!';
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETES;


