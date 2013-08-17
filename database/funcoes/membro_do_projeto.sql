

CREATE OR REPLACE FUNCTION membroCadastrarEmProjeto(projeto_p INTEGER, membro_p INTEGER, funcao_p VARCHAR(100)) 
RETURNS INTEGER AS $$
	DECLARE 
		cod_membroDoProjeto INTEGER;
	BEGIN
		INSERT INTO membro_do_projeto (fk_projeto, fk_usuario, funcao) 
		VALUES (projeto_p, membro_p, funcao_p) RETURNING id_membro_do_projeto INTO cod_membroDoProjeto;
		RETURN cod_membroDoProjeto;
	END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION membroRemoverDeProjeto(projeto INTEGER, membro INTEGER) RETURNS INTEGER AS $$
	BEGIN
		DELETE FROM Mmembro_do_projeto WHERE fk_projeto = projeto AND fk_membro = membro;
		IF (FOUND) THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;
