

CREATE OR REPLACE FUNCTION membroCadastrarEmProjeto(funcao VARCHAR(100), projeto INTEGER, membro INTEGER) RETURNS INTEGER AS $$
	BEGIN
		INSERT INTO membro_do_projeto VALUES (funcao, projeto, membro);
		IF (FOUND) THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
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
