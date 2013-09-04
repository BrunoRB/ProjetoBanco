CREATE OR REPLACE FUNCTION mensagem_enviadaEnvia (id_destinatario INTEGER, id_mensagem INTEGER, data TIMESTAMP) 
RETURNS BOOLEAN AS $$
	BEGIN
		SET ROLE insert;
		INSERT INTO mensagem_enviada (fk_destinatario, fk_mensagem, data_hora_envio)
		VALUES (id_destinatario, id_mensagem, data);
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Mensagem', 'enviada');
			RETURN true;
		ELSE
			RETURN false;
		END IF;
		
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'Erro ao enviar mensagem!';
			RETURN false;
	END;
$$ LANGUAGE PLPGSQL;
