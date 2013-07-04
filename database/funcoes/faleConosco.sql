CREATE OR REPLACE function enviarEmailFaleConosco(idR int, destinatarioR varchar, remetenteR varchar, mensagem varchar) RETURNS boolean AS $$
BEGIN
	INSERT INTO despesa(id, nome, descricao, valor) VALUES(idR, nomeR, descricaoR, valorR);
	RETURN FOUND;
END;
$fun$ LANGUAGE 'plpgsql';
