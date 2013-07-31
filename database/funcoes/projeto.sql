
--INSERTS;

CREATE OR REPLACE FUNCTION projetoInsert (id INTEGER, nome VARCHAR(100), orcamento NUMERIC(10, 2), data_de_cadastro DATE, descricao TEXT, fk_gerente INTEGER)
RETURNS INTEGER AS $$
BEGIN
	IF id > 0 THEN
		INSERT INTO projeto VALUES (id, nome, orcamento, data_de_cadastro, descricao, fk_gerente);
		RETURN 1;
	END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION projetoInsert (nome VARCHAR(100), orcamento NUMERIC(10, 2), data_de_cadastro DATE, descricao TEXT, fk_gerente INTEGER)
RETURNS INTEGER AS $$
BEGIN
	INSERT INTO projeto (nome, orcamento, data_de_cadastro, descricao, fk_gerente) VALUES (nome, orcamento, data_de_cadastro, descricao, fk_gerente);
	RETURN 1;
END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION projetoInsert (nome VARCHAR(100), data_de_cadastro DATE, descricao TEXT, fk_gerente INTEGER)
RETURNS INTEGER AS $$
BEGIN
	INSERT INTO projeto (nome, data_de_cadastro, descricao, fk_gerente) VALUES (id, nome, data_de_cadastro, descricao, fk_gerente);
	RETURN 1;
END;
$$ LANGUAGE PLPGSQL;


CREATE OR REPLACE FUNCTION projetoInsert (nome VARCHAR(100), orcamento NUMERIC(10, 2), data_de_cadastro DATE, fk_gerente INTEGER)
RETURNS INTEGER AS $$
BEGIN
	INSERT INTO projeto (nome, orcamento, data_de_cadastro, fk_gerente) VALUES (nome, orcamento, data_de_cadastro, fk_gerente);
	RETURN 1;
END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;


--UPDATES;

CREATE OR REPLACE FUNCTION projetoUpdate (id INTEGER, nome VARCHAR(100), orcamento NUMERIC(10, 2), data_de_cadastro DATE, descricao TEXT, fk_gerente INTEGER)
RETURNS INTEGER AS $$
BEGIN
	IF id > 0 THEN
		UPDATE projeto SET projeto.nome=nome, projeto.orcamento = orcamento, 
			projeto.data_de_cadastro = data_decadastro, projeto.descricao = descricao, 
			projeto.fk_gerente = fk_gerente WHERE id_projeto = id;
		RETURN 1;
	END IF;
END;
$$ LANGUAGE PLPGSQL;

--DELETES;

CREATE OR REPLACE FUNCTION projetoDelete (id INTEGER)
RETURNS INTEGER AS $$
BEGIN
	IF id > 0 THEN
		DELETE FROM projeto WHERE projeto.id = id;
		RETURN 1;
	END IF;
END;
$$ LANGUAGE PLPGSQL;

--SELECTS;

CREATE OR REPLACE FUNCTION projetoSelect (fk_gerente INTEGER)
RETURNS SETOF projeto AS $$
BEGIN
	IF fk_gerente > 0 THEN
		RETURN QUERY EXECUTE 'SELECT nome, data_de_cadastro, descricao FROM projeto INNER JOIN membro ON projeto.fk_gerente = membro.id_membro';
	END IF;
END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION projetoSelect (id INTEGER)
RETURNS SETOF projeto AS $$
BEGIN
	IF id > 0 THEN
		RETURN QUERY EXECUTE 'SELECT nome, orcamento, data_de_cadastro, descricao FROM projeto WHERE projeto.id_projeto = id';
	END IF;
END;
$$ LANGUAGE PLPGSQL;
