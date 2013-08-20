--INSERTS

CREATE OR REPLACE FUNCTION artefatoCadastrar (nome_p VARCHAR(100), tipo_p VARCHAR(100), descricao_p TEXT, porcentagem_concluida_p INTEGER) 
RETURNS INTEGER AS $$
	DECLARE 
		cod_artefato INTEGER;
	BEGIN
		INSERT INTO artefato (nome, tipo, descricao, porcentagem_concluida)
		VALUES (nome_p, tipo_p, descricao_p, porcentagem_concluida_p) RETURNING id_artefato INTO cod_artefato;
		RETURN cod_artefato;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION artefatoCadastrar (nome_p VARCHAR(100), tipo_p VARCHAR(100), descricao_p TEXT)
RETURNS INTEGER AS $$
	DECLARE 
		cod_artefato INTEGER;
	BEGIN
		INSERT INTO artefato (nome, tipo, descricao)
		VALUES (nome_p, tipo_p, descricao_p) RETURNING id_artefato INTO cod_artefato;
		RETURN cod_artefato;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION artefatoCadastrarSemDescPorc (nome_p VARCHAR(100), tipo_p VARCHAR(100))
RETURNS INTEGER AS $$
	DECLARE
		cod_artefato INTEGER;
	BEGIN
		INSERT INTO artefato (nome, tipo)
		VALUES (nome_p, tipo_p) RETURNING id_artefato INTO cod_artefato;
		RETURN cod_artefato;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION artefatoCadastrarSemDesc (nome_p VARCHAR(100), tipo_p VARCHAR(100), porcentagem_concluida_p INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		cod_artefato INTEGER;
	BEGIN
		INSERT INTO artefato (nome, tipo, porcentagem_concluida)
		VALUES (nome_p, tipo_p, porcen) RETURNING id_artefato INTO cod_artefato;
		RETURN cod_artefato;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION artefatoCadastrarSemTipo (nome_p VARCHAR(100), descricao_p TEXT, porcentagem_concluida_p INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		cod_artefato INTEGER;
	BEGIN
		INSERT INTO artefato (nome, descricao, porcentagem_concluida)
		VALUES (nome_p, descricao_p, porcentagem_concluida_p) RETURNING id_artefato INTO cod_artefato;
		RETURN cod_artefato;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION artefatoCadastrarSemTipoPorc (nome_p VARCHAR(100), descricao_p TEXT)
RETURNS INTEGER AS $$
	DECLARE
		cod_artefato INTEGER;
	BEGIN
		INSERT INTO artefato (nome, descricao)
		VALUES (nome_p, descricao_p) RETURNING id_artefato INTO cod_artefato;
		RETURN cod_artefato;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION artefatoCadastrarSemTipoDesc (nome_p VARCHAR(100), porcentagem_concluida_p INTEGER)
RETURNS INTEGER AS $$
	DECLARE
		cod_artefato INTEGER;
	BEGIN
		INSERT INTO artefato (nome, porcentagem_concluida)
		VALUES (nome_p, porcentagem_concluida_p) RETURNING id_artefato INTO cod_artefato;
		RETURN cod_artefato;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS

--UPDATES

CREATE OR REPLACE FUNCTION artefatoAtualizarPorcentagem (id INTEGER, porcentagem INTEGER)
RETURNS INTEGER AS $$
	BEGIN	
		UPDATE artefato SET porcentagem_concluida = (porcentagem_concluida + porcentagem)
		WHERE id_artefato = id;
		IF (FOUND) THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION artefatoAtualizar (id INTEGER, nome_p VARCHAR(100), tipo_p VARCHAR(100), descricao_p TEXT, porc INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		UPDATE artefato SET nome = nome_p, tipo = tipo_p, descricao = descricao_p, porcentagem_concluida = porc
		WHERE id_artefato = id;
		IF (FOUND) THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;

--END UPDATES

--DELETES

CREATE OR REPLACE FUNCTION artefatoExcluir (id INTEGER)
RETURNS INTEGER AS $$
	BEGIN
		DELETE FROM artefato WHERE id_artefato = id;
		IF (FOUND) THEN
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	END;
$$ LANGUAGE PLPGSQL;
--END DELETES


