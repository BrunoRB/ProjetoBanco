

CREATE OR REPLACE FUNCTION membroCadastrarEmProjeto(idGerente INTEGER, projeto_p INTEGER, membro_p INTEGER, funcao_p VARCHAR(100)) 
RETURNS INTEGER AS $$
	DECLARE 
		cod_membroDoProjeto INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, projeto_p) THEN
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO membro_do_projeto (fk_projeto, fk_usuario, funcao) 
		VALUES (projeto_p, membro_p, funcao_p);

		SET ROLE retrieve;
		SELECT INTO cod_membroDoProjeto currval('membro_do_projeto_id_membro_do_projeto_seq');
		EXECUTE mensagemDeSucesso('Membro', 'inserido');
		RETURN cod_membroDoProjeto;
	END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION membroRemoverDeProjeto(projeto INTEGER, membro INTEGER) RETURNS INTEGER AS $$
	BEGIN
		SET ROLE delete;
		DELETE FROM Mmembro_do_projeto WHERE fk_projeto = projeto AND fk_membro = membro;
		EXECUTE mensagemDeSucesso('Relação membro/projeto', 'excluida');
		IF (FOUND) THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;
