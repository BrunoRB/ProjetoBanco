
/**
* @author BrunoRB
*
* Verifica se o valor passado é numérico (tanto inteiro quanto flutuante)
*
* @param valor a ser checado
* @return BOOLEAN true se valor for númerico, false para qualquer outr
*/
CREATE OR REPLACE FUNCTION isNumeric(text) RETURNS boolean AS '
	SELECT $1 ~ ''^\d+.?\d*$''
' LANGUAGE 'SQL';

/**
* @author BrunoRB
*
* Função genérica para update de tabela
*
* @param VARCHAR(100) nome_tabela Nome da tabela a ser atualizada
* @param INTEGER id_atualizar A id a ser utilizada como delimitador da tabela a ser atualizada
* @param TEXT campos Campos a serem atualizados, deve ser separados por espaço
* @param TEXT valores Valores a serem utilizados para atualização dos campos, devem ser separados por espaço e estarem na mesma ordem dos campos
* @return INTEGER quantidade de campos atualizados
*/
CREATE OR REPLACE FUNCTION generalUpdate(nome_tabela TEXT, id_atualizar INTEGER, campos TEXT, valores TEXT) RETURNS INTEGER AS $$
	DECLARE
		arrayCampos VARCHAR(255) ARRAY;
		arrayValores VARCHAR(255) ARRAY;
		countCamposAlterados INTEGER := 0;
		tempVal TEXT;
	BEGIN
		arrayCampos := regexp_split_to_array(campos, '\s+'); -- Dividem as variáveis TEXT campos e valores em um array onde cada posição é um valor
		arrayValores := regexp_split_to_array(valores, '\s+');
		
		IF (array_length(arrayCampos, 1) == array_length(arrayValores, 1)) THEN
			FOR i IN 1..array_length(arrayCampos, 1) LOOP -- Itera de 1 até a quantidade de campos existentes
			
				IF (NOT isNumeric(arrayValores[i])) THEN -- Se o valor contido em arrayValores[i] NÃO for númerico (inteiro ou real)
					tempVal = E'\'' || arrayValores[i] || E'\''; --"E" significa "Escape" é mandatório, apenas utilizar contrabarra não gera um escape.
				ELSE
					tempVal = arrayValores[i];
				END IF;
				
				EXECUTE 'UPDATE ' || nome_tabela || ' SET ' || arrayCampos[i] || ' = ' || tempVal || ' WHERE id_' || nome_tabela || '=' || id_atualizar;
				
				countCamposAlterados = countCamposAlterados + 1; -- "countCamposAlterados++"
			END LOOP;
			
			RETURN countCamposAlterados;
		END IF;
		
		RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

