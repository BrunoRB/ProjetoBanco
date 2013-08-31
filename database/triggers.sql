

--TRIGGER membro_do_projeto

CREATE FUNCTION validateUniqueManagerOnProject() RETURNS TRIGGER AS $$
	DECLARE
		membro membro_do_projeto.funcao%TYPE;
	BEGIN
		SELECT INTO membro funcao FROM membro_do_projeto WHERE NEW.fk_projeto = membro_do_projeto.fk_projeto AND LOWER(membro_do_projeto.funcao) = 'gerente';
		
		IF membro IS NOT NULL AND LOWER(NEW.funcao) = 'gerente'  THEN
			RAISE EXCEPTION '[ERRO] apenas um gerente é permitido no projeto.';
		END IF;
		
		RETURN NEW; 
	END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER validateUniqueManagerOnProject BEFORE INSERT OR UPDATE ON membro_do_projeto FOR EACH ROW EXECUTE PROCEDURE validateUniqueManagerOnProject();

--END TRIGGER membro_do_projeto

