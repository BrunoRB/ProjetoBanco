--INSERT;

CREATE OR REPLACE FUNCTION mensagemEscreve(id_usuario INTEGER, assunto_mens VARCHAR(100), texto_mens TEXT)
RETURNS INTEGER AS $$
	DECLARE
		cod_mensagem INTEGER;
	BEGIN
		IF NOT isLogado(id_usuario) THEN	
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO mensagem (assunto, texto, fk_usuario)
		VALUES (assunto_mens, texto_mens, id_usuario);

		SET ROLE retrieve;
		SELECT INTO cod_mensagem currval('mensagem_id_mensagem_seq');
		EXECUTE mensagemDeSucesso('Mensagem', 'inserida');
		RETURN cod_mensagem;
	END;
$$ LANGUAGE PLPGSQL;

--DELETE;

CREATE OR REPLACE FUNCTION mensagemDelete (idUsuario INTEGER, idProjeto INTEGER, id INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		IF NOT isGerente(idUsuario, idProjeto) THEN
			IF NOT isMembro(idUsuario, idProjeto) THEN
				RETURN 0;
			END IF;
		END IF;

		SET ROLE delete;
		DELETE FROM mensagem WHERE id_mensagem = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Mensagem', 'excluida');
			RETURN 1;
		ELSE
			RETURN 2;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;
