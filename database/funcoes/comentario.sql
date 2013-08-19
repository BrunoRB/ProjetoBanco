-- Create
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
-- DROP FUNCTION consultaComentario(atividade int);
CREATE TYPE consComent AS (descr_com text, dt timestamp without time zone, nome_membro varchar(100));
CREATE OR REPLACE FUNCTION consultaComentario(atividade int) RETURNS SETOF consComent AS $$
DECLARE	 
	retorno consComent%ROWTYPE; 
BEGIN
	IF atividade <=0 or atividade > (select max(id_atividade) from atividade) THEN
		
		RAISE NOTICE 'Código de atividade inexistente: %', atividade;		
		RETURN;
	ELSE 
		FOR retorno IN SELECT c.descricao, c.data_horario_envio, u.nome 
			FROM comentario c INNER JOIN membro m ON c.fk_membro = m.id_membro
			INNER JOIN usuario u ON m.fk_usuario = u.id_usuario AND fk_atividade = atividade LOOP 
			RETURN NEXT retorno;
		END LOOP;
	END IF;	
	RETURN;
END;
$$ LANGUAGE plpgsql;
SELECT consultaComentario(1);

--Update
--
CREATE OR REPLACE FUNCTION atualizaComentario(atividade int, nrComentario int, descr text) RETURNS text AS $$
DECLARE
	mensagem TEXT;
BEGIN
	IF atividade <= 0  THEN
		mensagem = 'Informe o código de uma atividade.';
	ELSEIF nrComentario <= 0 THEN		
		mensagem = 'Informe o código de um comentáro.';
	ELSE
		UPDATE comentario SET descricao = descr WHERE id_comentario = comentario AND fk_atividade = atividade;
		RETURN FOUND;
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
SELECT * FROM comentario;