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


--SELECTS;

CREATE OR REPLACE FUNCTION mensagemListar(
	idUsuario INTEGER, OUT idMensagem INTEGER, OUT remetente VARCHAR, OUT assunto VARCHAR, OUT data_hora_envio TIMESTAMP		
) RETURNS SETOF RECORD AS $$
	BEGIN		
		IF NOT isLogado(idUsuario) THEN
			RETURN;
		END IF;
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT idMensagem, remetente, assunto, data_hora_envio
				FROM mensagem_recebidaView WHERE usuario =' || idUsuario;
	END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION mensagemExibirUsuario(
	idUsuario INTEGER, idMensagem INTEGER, OUT remetente VARCHAR, OUT assunto VARCHAR, OUT data_hora_envio TIMESTAMP, 
	OUT mensagem TEXT
) RETURNS SETOF RECORD AS $$
	BEGIN
		IF NOT isLogado(idUsuario) THEN
			RETURN;
		END IF;
		
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT usuario.nome AS remetente, mensagem.assunto, 
			mensagem_enviada.data_hora_envio, mensagem.texto AS mensagem 
		FROM mensagem 
		INNER JOIN usuario ON mensagem.fk_usuario = usuario.id_usuario
		INNER JOIN mensagem_enviada ON mensagem.id_mensagem = mensagem_enviada.fk_mensagem 
		WHERE mensagem_enviada.fk_destinatario =' || idUsuario || ' AND mensagem.id_mensagem =' || idMensagem;
	END;
$$ LANGUAGE PLPGSQL;
