
CREATE TEMPORARY TABLE temp (codigo INTEGER);

CREATE OR REPLACE FUNCTION testes () RETURNS INTEGER AS $$
BEGIN
	IF (false) THEN
		INSERT INTO temp VALUES (10);
		RETURN 1;
	ELSE
		RAISE EXCEPTION 'Check violation: Parametros de entrada 
			nao correspondem as exigencias dos atributos.';
		RETURN 0;
	END IF;
END;
$$ LANGUAGE PLPGSQL;
