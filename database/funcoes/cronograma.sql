
-- Função para chamar a view do cronograma validando se o usuário é um gerente do projeto em questão

CREATE OR REPLACE FUNCTION cronogramaListar(
	idUsuario INTEGER, idProjeto INTEGER, OUT codigo INTEGER, OUT atividade VARCHAR, 
	OUT data_inicio TIMESTAMP, OUT data_limite TIMESTAMP, OUT data_fim TIMESTAMP, OUT predecessora INTEGER, OUT fase VARCHAR ,
	OUT qtdade_membros BIGINT, OUT qutdade_artefatos BIGINT		
) RETURNS SETOF RECORD AS $$
	BEGIN		
		IF NOT isGerente(idUsuario, idProjeto) THEN
			RETURN;
		END IF;
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT codigo, atividade, data_inicio, data_limite, data_fim, predecessora, fase, qtd_membro, qtd_artefato 
			FROM cronogramaView WHERE projeto =' || idProjeto;
	END;
$$ LANGUAGE PLPGSQL;
