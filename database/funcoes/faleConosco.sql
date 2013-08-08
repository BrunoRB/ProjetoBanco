--INSERT;

CREATE OR REPLACE function enviarEmailFaleConosco(data_hora_falec TIMESTAMP, assunto_falec VARCHAR(100), mensagem_falec CLOB, email_falec VARCHAR(100), fk_usu INTEGER) 
RETURNS INTEGER AS $$
DECLARE
	cod_fale_conosco INTEGER;
BEGIN
	INSERT INTO fale_conosco (data_e_hora, assunto, mensagem, email, fk_usuario) VALUES (data_hora_falec, assunto_falec, mensagem_falec, email_falec, fk_usu) RETURNING id_fale_conosco INTO cod_fale_conosco;
	RETURN cod_fale_conosco;
END;
$$ LANGUAGE PLPGSQL;
