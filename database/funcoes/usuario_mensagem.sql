--INSERT;

CREATE OR REPLACE FUNCTION usuario_mensagemInsert (data_hora TIMESTAMP, dest INTEGER, msg INTEGER, usu INTEGER)
RETURNS INTEGER AS $$
DECLARE
	cod_usu_men INTEGER;
BEGIN
	INSERT INTO usuario_mensagem (data_hora_envio, fk_destinatario, fk_mensagem, fk_usuario) VALUES (data_hora, dest, msg, usu) RETURNG id_usu_men INTO cod_usu_men;
	RETURN cod_usu_men;
END;
$$ LANGUAGE PLPGSQL;

--DELETE;

CREATE OR REPLACE FUNCTION usuario_mensagemDelete (id INTEGER)
RETURNS INTEGER AS $$
BEGIN
	DELETE FROM usuario_mensagem WHERE id_usu_men = id;
END;
$$ LANGUAGE PLPGSQL;
