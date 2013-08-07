--INSERT;

CREATE OR REPLACE FUNCTION mensagemEscreve (assunto_mens VARCHAR(100), texto_mens CLOB)
RETURNS INTEGER AS $$
DECLARE
	cod_mensagem INTEGER;
BEGIN
	INSERT INTO mensagem (assunto, texto_mens) VALUES (assunto_mens, texto_mens) RETURNING id_mensagem INTO cod_mensagem;
	RETURN cod_mensagem;
END;
$$ LANGUAGE PLPGSQL;

--DELETE;

CREATE OR REPLACE FUNCTION mensagemDelete (id INTEGER)
RETURNS INTEGER AS $$
BEGIN
	DELETE FROM mensagem WHERE id_mensagem = id;
	IF (FOUND) THEN
		RETURN 1;
	ELSE
		RETURN 2;
	END IF;
END;
$$ LANGUAGE PLPGSQL;
