

CREATE OR REPLACE FUNCTION cronogramaInsert (inicio_projeto DATE, limite_projeto DATE, id_projeto INTEGER) RETURNS INTEGER AS $$
DECLARE
	id_cronograma INTEGER;
BEGIN
	IF (inicio_projeto > limite_projeto) THEN
		RAISE NOTICE 'Data de limite do projeto deve ser maior que data de início !';
		RETURN 0;
	ELSE
		INSERT INTO cronograma (data_inicio_projeto, data_limite_projeto, fk_projeto) VALUES (inicio_projeto, limite_projeto, id_projeto) RETURNING id_cronograma INTO 				id_cronograma;
		RETURN id_cronograma;
	END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION cronogramaUpdate (inicio_projeto DATE, limite_projeto DATE, fim DATE, id_projeto INTEGER) RETURNS INTEGER AS $$
BEGIN
	IF (inicio_projeto > limite_projeto) THEN
		RAISE NOTICE 'Data de limite do projeto deve ser maior que data de início !';
		RETURN 0;
	ELSEIF (inicio_projeto > fim) THEN
		RAISE NOTICE 'Data de fim do projeto deve ser maior que data de início !';
		RETURN 0;
	ELSE
		UPDATE cronograma SET data_inicio_projeto=inicio_projeto, data_limite_projeto=limite_projeto, data_fim=fim WHERE fk_projeto = id_projeto;
		RETURN 1;
	END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION cronogramaDelete(id_projeto INTEGER) RETURNS INTEGER AS $$
BEGIN
	DELETE FROM cronograma WHERE fk_projeto = id_projeto;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION cronogramaSelect(id_projeto INTEGER) RETURNS SETOF cronograma AS $$
BEGIN
	RETURN QUERY EXECUTE 'SELECT data_inicio_projeto, data_limite_projeto, data_fim FROM cronograma WHERE fk_projeto = id_projeto';
END;
$$ LANGUAGE PLPGSQL;
