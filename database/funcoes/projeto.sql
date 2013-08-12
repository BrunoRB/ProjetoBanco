
--INSERTS;

CREATE OR REPLACE FUNCTION projetoCadastrar (nome VARCHAR(100), orcamento NUMERIC(10, 2), descricao TEXT) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		INSERT INTO projeto (nome, orcamento, descricao) VALUES 
			(nome, orcamento, descricao) RETURNING id_projeto INTO id_gerada;
		RETURN id_gerada;
	END;
	
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE NOTICE '[Erro] Dados inválidos inseridos !';
			RETURN 0;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION projetoCadastrar (nome VARCHAR(100), descricao TEXT) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		INSERT INTO projeto (nome, descricao) VALUES (nome, descricao) RETURNING id_projeto INTO id_gerada;
		RETURN id_gerada;
	END;
	
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE NOTICE '[Erro] Dados inválidos inseridos !';
			RETURN 0;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION projetoCadastrar (nome VARCHAR(100), orcamento NUMERIC(10, 2)) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		INSERT INTO projeto (nome, orcamento, fk_gerente) VALUES (nome, orcamento) RETURNING id_projeto INTO id_gerada;
		RETURN id_gerada;
	END;
	
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE NOTICE '[Erro] Dados inválidos inseridos !';
			RETURN 0;
$$ LANGUAGE PLPGSQL;

--END INSERTS;

--UPDATES;

CREATE OR REPLACE FUNCTION projetoAtualizar (id INTEGER, nome VARCHAR(100), orcamento NUMERIC(10, 2), descricao TEXT) RETURNS INTEGER AS $$
	BEGIN
		UPDATE projeto SET projeto.nome=nome, projeto.orcamento = orcamento, projeto.descricao = descricao WHERE id_projeto = id;
		IF (FOUND) THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
	
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE NOTICE '[Erro] Dados inválidos inseridos !';
			RETURN 0;
$$ LANGUAGE PLPGSQL;

--END UPDATES;

--DELETES;

CREATE OR REPLACE FUNCTION projetoExcluir (id INTEGER)	RETURNS INTEGER AS $$
	BEGIN
		DELETE FROM projeto WHERE id_projeto = id;
		IF (FOUND) THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETES;


