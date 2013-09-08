

CREATE OR REPLACE FUNCTION membro_do_projetoCadastrar(idUsuario INTEGER, projeto_p INTEGER, membro_p INTEGER, funcao_p VARCHAR(100)) 
RETURNS INTEGER AS $$
	DECLARE 
		cod_membroDoProjeto INTEGER;
	BEGIN
		IF NOT isGerente(idUsuario, projeto_p) THEN
			RETURN 0;
		END IF;

		SET ROLE insert;
		INSERT INTO membro_do_projeto (fk_projeto, fk_usuario, funcao) 
		VALUES (projeto_p, membro_p, funcao_p);

		SET ROLE retrieve;
		SELECT INTO cod_membroDoProjeto currval('membro_do_projeto_id_membro_do_projeto_seq');
		EXECUTE mensagemDeSucesso('Membro', 'inserido');
		RETURN cod_membroDoProjeto;
	END;
$$ LANGUAGE PLPGSQL;

--Membro aceita convite do gerente
CREATE OR REPLACE FUNCTION membro_do_projetoAceita (idUsuario INTEGER, idProjeto INTEGER) RETURNS INTEGER AS $$
	BEGIN
		IF NOT isMembro(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;	

		SET ROLE update;
		UPDATE membro_do_projeto SET aceito = true WHERE fk_projeto = idProjeto AND fk_usuario = idUsuario; 
		EXECUTE mensagemDeSucesso('convite', 'aceito');		
		RETURN 1;
	END;
$$ LANGUAGE PLPGSQL;

--Membro recusa convite do gerente
CREATE OR REPLACE FUNCTION membro_do_projetoRejeita (idUsuario INTEGER, idProjeto INTEGER) RETURNS INTEGER AS $$
	BEGIN
		IF NOT isMembro(idUsuario, idProjeto) THEN
			RETURN 0;
		END IF;	

		SET ROLE delete;
		DELETE FROM membro_do_projeto WHERE fk_projeto = idProjeto AND fk_usuario = idUsuario;
		RAISE NOTICE 'Convite recusado!';
		RETURN 1;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION membroRemoverDeProjeto(idUsuario INTEGER, projeto INTEGER, membro INTEGER) RETURNS INTEGER AS $$
	BEGIN
		IF NOT isGerente(idUsuario, projeto) THEN
			RETURN 0;
		END IF;	

		SET ROLE delete;
		DELETE FROM membro_do_projeto WHERE fk_projeto = projeto AND fk_membro = membro;
		EXECUTE mensagemDeSucesso('Relação membro/projeto', 'excluida');
		IF (FOUND) THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;


--SELECTS;

CREATE OR REPLACE FUNCTION membrosListar(
	idUsuario INTEGER, idProjeto INTEGER, OUT membro VARCHAR, OUT funcao VARCHAR, OUT qtd_atividade INTEGER		
) RETURNS SETOF RECORD AS $$
	BEGIN		
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN;
		END IF;
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT membro, funcao, qtd_atividade FROM membro_projetoView 
						WHERE projeto =' || idProjeto;
	END;
$$ LANGUAGE PLPGSQL;
