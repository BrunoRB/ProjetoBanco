--INSERT;

CREATE OR REPLACE FUNCTION mensagemEscreve (assunto_mens VARCHAR(100), texto_mens TEXT, id_usuario INTEGER)
RETURNS INTEGER AS $$
DECLARE
	cod_mensagem INTEGER;
BEGIN
	INSERT INTO mensagem (assunto, texto, fk_usuario)
	VALUES (assunto_mens, texto_mens, id_usuario) RETURNING id_mensagem INTO cod_mensagem;
	RAISE NOTICE 'Mensagem inserida com sucesso!';
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
