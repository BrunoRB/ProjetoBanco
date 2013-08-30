

--TRIGGER membro_do_projeto

CREATE FUNCTION validateUniqueManagerOnProject() RETURNS TRIGGER AS $$
	DECLARE
		membros RECORD;
	BEGIN
		FOR membros IN SELECT funcao FROM membro_do_projeto WHERE NEW.fk_projeto = membro_do_projeto.fk_projeto LOOP
			IF membros = NEW.funcao THEN
				RAISE EXCEPTION '[ERRO] apenas um gerente é permitido no projeto.';
			END IF;
		END LOOP;
		
		RETURN NEW; 
	END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER validateUniqueManagerOnProject BEFORE INSERT OR UPDATE ON membro_do_projeto FOR EACH ROW EXECUTE PROCEDURE validateUniqueManagerOnProject();

--END TRIGGER membro_do_projeto

