

--TRIGGER membro_do_projeto

CREATE FUNCTION validateUniqueManagerOnProject() RETURNS TRIGGER AS $$
	DECLARE
		membro membro_do_projeto.funcao%TYPE;
	BEGIN
		SELECT INTO membro funcao FROM membro_do_projeto WHERE NEW.fk_projeto = membro_do_projeto.fk_projeto AND LOWER(membro_do_projeto.funcao) = 'gerente';
		
		IF membro IS NOT NULL AND LOWER(NEW.funcao) = 'gerente'  THEN
			RAISE EXCEPTION '[ERRO] apenas um gerente é permitido no projeto.';
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
	BEGIN
		SELECT fk_usuario FROM mensagem WHERE NEW.fk_mensagem = mensagem.id_mensagem INTO usuario;
		
		IF (NEW.fk_destinatario = usuario) THEN
			RAISE EXCEPTION '[ERRO] Não é permitido mandar mensagem para si mesmo.';
		END IF;

		RETURN NEW; 
	END;
$$LANGUAGE PLPGSQL;

CREATE TRIGGER validaMensagemEnviada BEFORE INSERT OR UPDATE ON mensagem_enviada FOR EACH ROW EXECUTE PROCEDURE validaMensagemEnviada();

--END TRIGGER mensagem_enviada



--TRIGGER despesa

CREATE FUNCTION verificaValorDespesa() RETURNS TRIGGER AS $$
	DECLARE
		orcamento2 projeto.orcamento%TYPE;
	BEGIN
		IF (OLD.valor IS NOT NULL) THEN
			SELECT orcamento FROM projeto WHERE fk_projeto = projeto.id_projeto INTO orcamento2;

			UPDATE projeto
			SET orcamento = orcamento2 - NEW.valor + OLD.valor
			WHERE fk_projeto = projeto.id_projeto;
		END IF;
		IF (OLD.valor IS NULL) THEN
			UPDATE projeto
			SET orcamento = orcamento2 - NEW.valor
			WHERE fk_projeto = projeto.id_projeto;
		END IF;

		RETURN NEW; 
	END;
$$LANGUAGE PLPGSQL;

CREATE TRIGGER verificaValorDespesa BEFORE INSERT OR UPDATE ON despesa FOR EACH ROW EXECUTE PROCEDURE verificaValorDespesa();

--END TRIGGER despesa




