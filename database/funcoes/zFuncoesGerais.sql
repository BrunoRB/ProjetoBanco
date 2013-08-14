
/**
* Verifica se um valor é numérico
*
* @param valor a ser checado
* @return BOOLEAN true se valor for númerico (inteiro ou ponto flutuante), false para qualquer outr
*/
CREATE OR REPLACE FUNCTION isNumeric(text) RETURNS boolean AS '
	SELECT $1 ~ ''^\d+.?\d*$''
' LANGUAGE 'SQL';

/**
* Função genérica para update de tabela
*
* @param VARCHAR(100) nome_tabela Nome da tabela a ser atualizada
* @param INTEGER id_atualizar A id a ser utilizada como delimitador da tabela a ser atualizada
* @param TEXT campos Campos a serem atualizados, deve ser separados por espaço
* @param TEXT valores Valores a serem utilizados para atualização dos campos, devem ser separados por espaço e estarem na mesma ordem dos campos
*/
CREATE OR REPLACE FUNCTION generalUpdate(nome_tabela TEXT, id_atualizar INTEGER, campos TEXT, valores TEXT) RETURNS INTEGER AS $$
	DECLARE
		arrayCampos VARCHAR(255) ARRAY;
		arrayValores VARCHAR(255) ARRAY;
		countCamposAlterados INTEGER := 0;
		tempVal TEXT;
	BEGIN
		arrayCampos := regexp_split_to_array(campos, '\s+');
		arrayValores := regexp_split_to_array(valores, '\s+');
		
		IF (array_length(arrayCampos, 1) <> array_length(arrayValores, 1)) THEN
			RETURN 0;
		ELSE
			FOR i IN 1..array_length(arrayCampos, 1) LOOP
			
				IF NOT isNumeric(arrayValores[i]) THEN
					tempVal = E'\'' || arrayValores[i] || E'\''; 
				ELSE
					tempVal = arrayValores[i];
				END IF;
				
				EXECUTE 'UPDATE ' || nome_tabela || ' SET ' || arrayCampos[i] || ' = ' || tempVal || ' WHERE id_' || nome_tabela || '=' || id_atualizar;
				countCamposAlterados = countCamposAlterados + 1;
			END LOOP;
			
			
			RETURN countCamposAlterados;
		END IF;
		
	END;
$$ LANGUAGE PLPGSQL;

