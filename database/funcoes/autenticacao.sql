

CREATE OR REPLACE FUNCTION isGerente(idUsuario INTEGER, idProjeto INTEGER) RETURNS BOOLEAN AS $$
	DECLARE
		flag INTEGER;
	BEGIN
		SET ROLE retrieve;
	
		IF NOT isUsuario(idUsuario) THEN
			RAISE NOTICE 'Não é um usuário válido!';
			RETURN false;
		END IF;
	
		SELECT INTO flag id_projeto FROM projeto 
			INNER JOIN membro_do_projeto ON id_projeto = fk_projeto  
			INNER JOIN usuario ON id_usuario = fk_usuario 
			WHERE idUsuario = id_usuario AND LOWER(funcao) = 'gerente' AND idProjeto = id_projeto;
		
		IF NOT FOUND THEN
			RAISE NOTICE 'Não é o gerente deste projeto!';
			RETURN false;
		END IF;
		
		RETURN true;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION isMembro(idUsuario INTEGER, idProjeto INTEGER) RETURNS BOOLEAN AS $$
	DECLARE
		flag INTEGER;
	BEGIN
		SET ROLE retrieve;
	
		IF NOT isUsuario(idUsuario) THEN
			RAISE NOTICE 'Não é um usuário válido!';
			RETURN false;
		END IF;
		
		IF NOT isLogado(idUsuario) THEN
			RETURN false;
		END IF;
		
		SELECT INTO flag id_projeto FROM projeto 
			INNER JOIN membro_do_projeto ON id_projeto = fk_projeto  
			INNER JOIN usuario ON id_usuario = fk_usuario 
			WHERE idUsuario = id_usuario AND LOWER(funcao) = 'membro' AND idProjeto = id_projeto;
		
		IF NOT FOUND THEN
			RAISE NOTICE 'Não é um membro válido deste projeto!';
			RETURN false;
		END IF;
		
		RETURN true;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION isLogado(idUsuario INTEGER) RETURNS BOOLEAN AS $$
	DECLARE
		session TIMESTAMP;
	BEGIN
		SET ROLE retrieve;
		
		IF NOT isUsuario(idUsuario) THEN
			RAISE NOTICE 'Não é um usuário válido!';
			RETURN false;
		END IF;
		
		SELECT INTO session sessao FROM usuario WHERE idUsuario = id_usuario;
		
		IF session IS NOT NULL AND session > NOW() THEN
			RETURN TRUE;
		END IF;
		
		RAISE NOTICE 'Não está logado/tempo de sessão expirou!';
		
		RETURN FALSE;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION isUsuario(idUsuario INTEGER) RETURNS BOOLEAN AS $$
	DECLARE
		flag INTEGER;
	BEGIN
		SET ROLE retrieve;
		SELECT INTO flag id_usario FROM usuario WHERE id_usuario = idUsuario;
		RETURN FOUND;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION mensagemDeSucesso(entity VARCHAR(100), operation VARCHAR(100)) RETURNS VOID AS $$
	BEGIN
		entity := INITCAP(LOWER(entity));
		operation := LOWER(operation);
		RAISE NOTICE '% % com sucesso!', entity, operation;
	END;
$$ LANGUAGE PLPGSQL;

CREATE OR REPLACE FUNCTION logar (login VARCHAR, password VARCHAR)
RETURNS INTEGER AS $$
	DECLARE
		id INT;
		name VARCHAR;
		inatividade BOOLEAN;
	BEGIN 
		SET ROLE retrieve;
		SELECT INTO id, name id_usuario, nome FROM usuario WHERE email = login AND senha = md5(password);
		IF (FOUND) THEN
			SELECT INTO inatividade inativo FROM usuario WHERE id_usuario = id;
			IF (inatividade = TRUE) THEN
				SET ROLE update;
				UPDATE usuario SET inativo = FALSE, data_inatividade = NULL, sessao = NOW() + 30 WHERE id_usuario = (id);
				RAISE NOTICE 'Sua conta foi reativada!';
			END IF;	
			RAISE NOTICE 'Olá, %', name;
			RETURN id;
		ELSE
			RAISE EXCEPTION '[Erro] Email ou senha inválidos!';
			RETURN 0;
		END IF;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION '[Erro] Dados inválidos inseridos!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;


