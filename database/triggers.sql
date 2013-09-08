

--TRIGGER membro_do_projeto

CREATE FUNCTION validateUniqueManagerOnProject() RETURNS TRIGGER AS $$
	DECLARE
		membro membro_do_projeto.funcao%TYPE;
	BEGIN
		SET ROLE retrieve;

		SELECT INTO membro funcao 
		FROM membro_do_projeto 
		WHERE NEW.fk_projeto = membro_do_projeto.fk_projeto 
		AND LOWER(membro_do_projeto.funcao) = 'gerente';
		
		IF membro IS NOT NULL AND LOWER(NEW.funcao) = 'gerente'  THEN
			RAISE EXCEPTION '[ERRO] É permitido apenas um gerente por projeto.';
		END IF;
		
		RETURN NEW; 	
	END;
$$ LANGUAGE PLPGSQL;

CREATE TRIGGER validateUniqueManagerOnProject BEFORE INSERT OR UPDATE ON membro_do_projeto FOR EACH ROW EXECUTE PROCEDURE validateUniqueManagerOnProject();

--END TRIGGER membro_do_projeto



--TRIGGER mensagem_enviada

CREATE FUNCTION validaMensagemEnviada() RETURNS TRIGGER AS $$
	DECLARE
		usuario mensagem.fk_usuario%TYPE;
		idMsg integer;
	BEGIN
		SET ROLE retrieve;

		SELECT fk_usuario, fk_mensagem 
		FROM mensagem 
		INNER JOIN mensagem_enviada
		ON NEW.fk_mensagem = mensagem.id_mensagem 
		INTO usuario, idMsg;
		
		IF (NEW.fk_destinatario = usuario) THEN
			RAISE EXCEPTION '[ERRO] Não é permitido mandar mensagem para si mesmo.';
		END IF;

		RETURN NEW; 
	END;
$$LANGUAGE PLPGSQL;

CREATE TRIGGER validaMensagemEnviada BEFORE INSERT OR UPDATE ON mensagem_enviada FOR EACH ROW EXECUTE PROCEDURE validaMensagemEnviada();

--END TRIGGER mensagem_enviada



--TRIGGER despesa
/*
CREATE FUNCTION verificaValorDespesa() RETURNS TRIGGER AS $$
	DECLARE
		orcamento2 projeto.orcamento%TYPE;
		projId integer;
	BEGIN
		projId = NEW.fk_projeto;

		IF (NEW.valor IS NOT NULL) THEN
			SET ROLE retrieve;

			SELECT orcamento
			FROM projeto 
			WHERE projId = projeto.id_projeto 
			INTO orcamento2;
			
			RAISE 

			SET ROLE update;

			UPDATE projeto
			SET orcamento = orcamento2 - NEW.valor
			WHERE projId = projeto.id_projeto;
		END IF;

		RETURN NEW; 
	END;
$$LANGUAGE PLPGSQL;

CREATE TRIGGER verificaValorDespesa BEFORE INSERT ON despesa FOR EACH ROW EXECUTE PROCEDURE verificaValorDespesa();



CREATE FUNCTION verificaValorDespesa2() RETURNS TRIGGER AS $$
	DECLARE
		orcamento2 projeto.orcamento%TYPE;
		projId integer;
	BEGIN
		IF (NEW.valor IS NOT NULL) THEN
			SET ROLE retrieve;

			SELECT orcamento, fk_projeto 
			FROM projeto 
			INNER JOIN despesa 
			ON projeto.id_projeto = despesa.fk_projeto  
			INTO orcamento2, projId;

			SET ROLE update;

			UPDATE projeto
			SET orcamento = orcamento2 - NEW.valor + OLD.valor
			WHERE projeto.id_projeto = projId;
		END IF;
		RETURN NEW; 
	END;
$$LANGUAGE PLPGSQL;

CREATE TRIGGER verificaValorDespesa2 BEFORE UPDATE ON despesa FOR EACH ROW EXECUTE PROCEDURE verificaValorDespesa2();
*/
--END TRIGGER despesa



--TRIGGER atividade

CREATE FUNCTION verificaAtividadePredecessora() RETURNS TRIGGER AS $$
	DECLARE
		fim atividade.fim_atividade%TYPE;
		finaliza atividade.finalizada%TYPE;
		fase atividade.fk_fase%TYPE;
	BEGIN
		IF (NEW.fk_predecessora IS NOT NULL) THEN
			SET ROLE retrieve;

			SELECT fim_atividade, finalizada, fk_fase 
			FROM atividade 
			WHERE id_atividade = NEW.fk_predecessora 
			INTO fim, finaliza, fase;

			IF (finaliza = true) THEN			
				IF (NEW.inicio_atividade < fim) THEN
					RAISE EXCEPTION '[ERRO] Não é permitido iniciar uma atividade sem antes terminar a atividade predecessora.';
				END IF;

				IF (NEW.fk_fase < fase) THEN
					RAISE EXCEPTION '[ERRO] A fase da atividade deve ser maior ou igual a fase da atividade predecessora.';
				END IF;
			END IF;
		END IF;

		RETURN NEW; 
	END;
$$LANGUAGE PLPGSQL;

CREATE TRIGGER verificaAtividadePredecessora BEFORE INSERT OR UPDATE ON atividade FOR EACH ROW EXECUTE PROCEDURE verificaAtividadePredecessora();



CREATE FUNCTION verificaAtividadeConcluida() RETURNS TRIGGER AS $$
	DECLARE
		porcentagem artefato_atividade.porcentagem_gerada%TYPE;
		soma artefato.porcentagem_concluida%TYPE;
		artefat artefato_atividade.fk_artefato%TYPE;
		idAtiv integer;
	BEGIN
		IF (NEW.finalizada = true) THEN
			SET ROLE retrieve;

			SELECT porcentagem_gerada, fk_artefato, id_atividade 
			FROM artefato_atividade 
			INNER JOIN atividade 
			ON artefato_atividade.fk_atividade = atividade.id_atividade 
			INTO porcentagem, artefat, idAtiv;

			SELECT porcentagem_concluida 
			FROM artefato 
			INNER JOIN artefato_atividade 
			ON artefato.id_artefato = artefato_atividade.fk_artefato 
			INTO soma;

			SET ROLE update;

			UPDATE artefato
			SET porcentagem_concluida = soma + porcentagem
			WHERE artefato.id_artefato = artefat;
		END IF;

		RETURN NEW; 
	END;
$$LANGUAGE PLPGSQL;

CREATE TRIGGER verificaAtividadeConcluida BEFORE UPDATE ON atividade FOR EACH ROW EXECUTE PROCEDURE verificaAtividadeConcluida();

--END TRIGGER atividade
