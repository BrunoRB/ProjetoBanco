CREATE TABLE postgres_log (
log_time timestamp(3) with time zone, user_name text,
database_name text,
process_id integer,
connection_from text,
session_id text,
session_line_num bigint,
command_tag text,
session_start_time timestamp with time zone,
virtual_transaction_id text,
transaction_id bigint,
error_severity text,
sql_state_code text,
message text,
detail text,
hint text,
internal_query text,
internal_query_pos integer,
context text,
query text,
query_pos integer,
location text,
application_name text,
PRIMARY KEY (session_id, session_line_num)
);

CREATE OR REPLACE FUNCTION tmpLog() RETURNS BOOLEAN AS $$
DECLARE
BEGIN
	CREATE temporary TABLE erros_log (
	log_time timestamp(3) with time zone, user_name text,
	database_name text,
	process_id integer,
	connection_from text,
	session_id text,
	session_line_num bigint,
	command_tag text,
	session_start_time timestamp with time zone,
	virtual_transaction_id text,
	transaction_id bigint,
	error_severity text,
	sql_state_code text,
	message text,
	detail text,
	hint text,
	internal_query text,
	internal_query_pos integer,
	context text,
	query text,
	query_pos integer,
	location text,
	application_name text,
	PRIMARY KEY (session_id, session_line_num)
	);
	RETURN FOUND;
END;	
$$ LANGUAGE plpgsql;

--DROP FUNCTION atualiza_log();
CREATE OR REPLACE FUNCTION atualiza_log() RETURNS text AS $$
DECLARE
	resultado1 BOOLEAN;
	resultado2 text;
BEGIN
	PERFORM tmpLog();						--cria tabela temporário erros_log
	SET CLIENT_ENCODING TO 'latin1'; 
	COPY erros_log FROM 'C:\Dell\arquivoDeLog.csv' WITH csv;	--importa os erros para tabela temporaria
	SELECT INTO resultado1 carregaLog();				--verifica se já não está gravado o erro
	DROP TABLE erros_log;						--deleta tabela temporaria
	SELECT INTO resultado2 consultaLog();				--mostra mensagem
RETURN resultado2;
END; 
$$ LANGUAGE plpgsql;


--DROP FUNCTION carregaLog();
CREATE OR REPLACE FUNCTION carregaLog() RETURNS BOOLEAN as $$
DECLARE
BEGIN
	IF (SELECT session_id || session_line_num FROM erros_log ORDER BY log_time DESC LIMIT 1) <>
		(SELECT session_id || session_line_num FROM postgres_log ORDER BY log_time DESC LIMIT 1) THEN
		INSERT INTO postgres_log SELECT * FROM erros_log ORDER BY log_time DESC LIMIT 1;
	END IF;
	RETURN FOUND;
END;
$$ LANGUAGE plpgsql;

--DROP FUNCTION consultaLog();
CREATE TYPE logerro AS (cont Text, mess text);
CREATE OR REPLACE FUNCTION consultaLog() RETURNS TEXT AS $$
DECLARE
	reterro logerro%ROWTYPE;
BEGIN
	SELECT INTO reterro context, message FROM  postgres_log ORDER BY log_time DESC LIMIT 1;	
	RETURN 'Ocorreu o erro: ' || reterro.message;
END;
$$ LANGUAGE plpgsql;	


SELECT atualiza_log();
SELECT * FROM erros_log;
SELECT * FROM postgres_log order BY log_time DESC ;
SELECT * FROM postgres_log ORDER BY log_time DESC LIMIT 1;	
SELECT context, message FROM  postgres_log ORDER BY log_time DESC LIMIT 1;	
SELECT * from consultaLog();
