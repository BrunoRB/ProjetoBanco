CREATE OR REPLACE FUNCTION inserirMensagem (destinatario INTEGER, ce_mensagem INTEGER, ce_usuario INTEGER)
RETURNS BOOLEAN AS $$
BEGIN
	IF destinatario > 0 THEN
		INSERT INTO mensagem (fk_destinatario, fk_mensagem, fk_usuario) VALUES (destinatario, ce_mensagem, ce_usuario);
		RETURN FOUND;
	END IF;
END;
$$ LANGUAGE PLPGSQL;
