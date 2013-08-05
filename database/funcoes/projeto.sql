
--INSERTS;

CREATE OR REPLACE FUNCTION projetoInsert (id INTEGER, nome VARCHAR(100), orcamento NUMERIC(10, 2), descricao TEXT, fk_gerente INTEGER)
RETURNS INTEGER AS $$
DECLARE
	id_projeto INTEGER;
BEGIN
	INSERT INTO projeto (id_projeto, nome, orcamento, descricao, fk_gerente) 
		VALUES (id, nome, orcamento, descricao, fk_gerente) RETURNING id_projeto INTO id_projeto;
	RETURN id_projeto;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION projetoInsert (nome VARCHAR(100), orcamento NUMERIC(10, 2), descricao TEXT, fk_gerente INTEGER)
RETURNS INTEGER AS $$
DECLARE
	id_projeto INTEGER;
BEGIN
	INSERT INTO projeto (nome, orcamento, descricao, fk_gerente) VALUES 
		(nome, orcamento, descricao, fk_gerente) RETURNING id_projeto INTO id_projeto;
	RETURN id_projeto;
END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION projetoInsert (nome VARCHAR(100), descricao TEXT, fk_gerente INTEGER)
RETURNS INTEGER AS $$
DECLARE
	id_projeto INTEGER;
BEGIN
	INSERT INTO projeto (nome, descricao, fk_gerente) VALUES (id, nome, descricao, fk_gerente) RETURNING id_projeto INTO id_projeto;
	RETURN id_projeto;
END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION projetoInsert (nome VARCHAR(100), orcamento NUMERIC(10, 2), fk_gerente INTEGER)
RETURNS INTEGER AS $$
DECLARE
	id_projeto INTEGER;
BEGIN
	INSERT INTO projeto (nome, orcamento, fk_gerente) VALUES (nome, orcamento, fk_gerente) RETURNING id_projeto INTO id_projeto;
	RETURN id_projeto;
END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;

--UPDATES;

CREATE OR REPLACE FUNCTION projetoUpdate (id INTEGER, nome VARCHAR(100), orcamento NUMERIC(10, 2), descricao TEXT, fk_gerente INTEGER)
RETURNS INTEGER AS $$
BEGIN
	UPDATE projeto SET projeto.nome=nome, projeto.orcamento = orcamento, projeto.descricao = descricao, projeto.fk_gerente = fk_gerente WHERE id_projeto = id;
	RETURN 1;
END;
$$ LANGUAGE PLPGSQL;

--END UPDATES;

--DELETES;

CREATE OR REPLACE FUNCTION projetoDelete (id INTEGER)
RETURNS INTEGER AS $$
BEGIN
	DELETE FROM projeto WHERE projeto.id = id;
	RETURN 1;
END;
$$ LANGUAGE PLPGSQL;

--END DELETES;

--SELECTS;

CREATE OR REPLACE FUNCTION projetoSelectByGerente (fk_gerente INTEGER)
RETURNS SETOF projeto AS $$
BEGIN
	RETURN QUERY EXECUTE 'SELECT nome, orcamento, data_de_cadastro, descricao FROM projeto INNER JOIN membro ON projeto.fk_gerente = membro.id_membro';
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION projetoSelectById (id INTEGER)
RETURNS SETOF projeto AS $$
BEGIN
	RETURN QUERY EXECUTE 'SELECT nome, orcamento, data_de_cadastro, descricao FROM projeto WHERE projeto.id_projeto = id';
END;
$$ LANGUAGE PLPGSQL;

--END SELECTS;
