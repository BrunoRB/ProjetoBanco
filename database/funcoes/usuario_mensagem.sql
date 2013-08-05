CREATE OR REPLACE FUNCTION usuario_mensagemInsert (TIMESTAMP, INTEGER, INTEGER, INTEGER)
RETURNS INTEGER AS $$
BEGIN
	INSERT INTO usuario_mensagem (data_hora_envio, fk_destinatario, fk_mensagem, fk_usuario) VALUES ($1, $2, $3, $4);
	RETURN 1;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION usuario_mensagemDelete (id INTEGER)
RETURNS INTEGER AS $$
BEGIN
	IF id > 0 THEN
		DELETE FROM usuario_mensagem WHERE id_usu_men = id;
	ELSE
		RETURN 0;
	END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION usuario_mensagemUpdate (INTEGER, TIMESTAMP, INTEGER, INTEGER, INTEGER)
RETURNS INTEGER AS $$
BEGIN
	IF $1 > 0 THEN
		UPDATE usuario_mensagem SET data_hora_envio = $2, fk_destinatario = $3, fk_mensagem = $4, fk_usuario = $5;
		RETURN 1;
	ELSE
		RETURN 0;
	END IF;
END;
$$ LANGUAGE PLPGSQL;
