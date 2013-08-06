
--INSERTS;

CREATE OR REPLACE FUNCTION projetoCadastrar (nome VARCHAR(100), orcamento NUMERIC(10, 2), descricao TEXT, id_gerente INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		INSERT INTO projeto (nome, orcamento, descricao, fk_gerente) VALUES 
			(nome, orcamento, descricao, id_gerente) RETURNING id_projeto INTO id_gerada;
		RETURN id_gerada;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION projetoCadastrar (nome VARCHAR(100), descricao TEXT, id_gerente INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		INSERT INTO projeto (nome, descricao, fk_gerente) VALUES (nome, descricao, id_gerente) RETURNING id_projeto INTO id_gerada;
		RETURN id_gerada;
	END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION projetoCadastrar (nome VARCHAR(100), orcamento NUMERIC(10, 2), id_gerente INTEGER) RETURNS INTEGER AS $$
	DECLARE
		id_gerada INTEGER;
	BEGIN
		INSERT INTO projeto (nome, orcamento, fk_gerente) VALUES (nome, orcamento, id_gerente) RETURNING id_projeto INTO id_gerada;
		RETURN id_gerada;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;

--UPDATES;

CREATE OR REPLACE FUNCTION projetoAtualizar (id INTEGER, nome VARCHAR(100), orcamento NUMERIC(10, 2), descricao TEXT, id_gerente INTEGER) RETURNS INTEGER AS $$
	BEGIN
		UPDATE projeto SET projeto.nome=nome, projeto.orcamento = orcamento, projeto.descricao = descricao, projeto.fk_gerente = id_gerente WHERE id_projeto = id;
		IF (FOUND) THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
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


