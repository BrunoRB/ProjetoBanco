-- Insert
-- DROP FUNCTION inserirComentario(text, int);
CREATE OR REPLACE FUNCTION inserirComentario(descr text, atividade int, membro int) 
RETURNS boolean AS $$
DECLARE
BEGIN
	INSERT INTO comentario(descricao, data_horario_envio, fk_atividade, fk_membro)
	VALUES (descr, now(), atividade, membro);
	RETURN FOUND;
END;
$$ LANGUAGE plpgsql;

-- Read:
-- DROP FUNCTION consultaComentario(atividade int, nrComentario int);
CREATE OR REPLACE FUNCTION consultaComentario(atividade int) RETURNS SETOF text AS $$
DECLARE
	mensagem TEXT;
BEGIN
	IF atividade <= 0 THEN
		mensagem = 'Informe o código de uma atividade para consulta.';
	ELSEIF nrComentario <= 0 THEN
		SELECT INTO mensagem u.nome, * FROM comentario INNER JOIN 
		(SELECT u.nome, m.id_membro FROM usuario u INNER JOIN
		membro m ON u.id_usuario = m.fk_usuario) as subc ON m.id_membro = comentario.id_membro
		WHERE fk_atividade = atividade;		
		RETURN mensagem;
	ELSE
		SELECT INTO mensagem (data_horario_envio, descricao) FROM comentario
		WHERE fk_atividade = atividade and id_comentario = nrComentario;
	END IF;	
	RETURN mensagem;
END;
$$ LANGUAGE plpgsql;


-- Delete
-- DROP FUNCTION deletaComentario();
CREATE OR REPLACE FUNCTION deletaComentario(atividade int, nrComentario int) RETURNS text AS $$
DECLARE
	mensagem TEXT;
BEGIN
	IF atividade <= 0 THEN
		mensagem = 'Informe o código de uma atividade.';
	ELSEIF nrComentario <= 0 THEN		
		mensagem = 'Informe o código de um comentáro.';
	ELSE
		DELETE FROM comentario 
		WHERE fk_atividade = atividade and id_comentario = nrComentario;
		IF FOUND = 't' THEN
			mensagem = 'Exclusão efetuada com sucesso!';
		ELSE
			mensagem = 'Comentário não foi excluido.';
		END IF;
	END IF;	
	RETURN mensagem;
END;
$$ LANGUAGE plpgsql;
