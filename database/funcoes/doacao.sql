--INSERT;

CREATE OR REPLACE FUNCTION doacaoRegistraDoacao (quantia_d NUMERIC(11,2), data_hora_d TIMESTAMP, fk_doador_d INTEGER)
RETURNS INTEGER AS $$
DECLARE
	cod_doacao INTEGER;
BEGIN
	INSERT INTO doacao (quantia, data_e_hora, fk_doador) VALUES (quantia_d, data_hora_d, fk_doador_d) RETURNING id_doacao INTO cod_doacao;
	RETURN cod_doacao;
END;
$$ LANGUAGE PLPGSQL;
