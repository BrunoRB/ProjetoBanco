CREATE OR REPLACE FUNCTION mensagem_enviadaEnvia (id_destinatario INTEGER, id_mensagem INTEGER, data TIMESTAMP) 
RETURNS RECORD AS $$
	DECLARE
		cod_mensagemE RECORD;
	BEGIN
		INSERT INTO mensagem_enviada (fk_destinatario, fk_mensagem, data_hora_envio)
		VALUES (id_destinatario, id_mensagem, data) RETURNING id_destinatario, id_mensagem INTO cod_mensagemE;
		RAISE NOTICE 'Mensagem enviada ao usuário com sucesso!';
		RETURN cod_mensagemE;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION 'O valor da porcengem informado é inválido!';
			cod_mensagemE := 0;
			RETURN cod_mensagemE;
	END;
$$ LANGUAGE PLPGSQL;
