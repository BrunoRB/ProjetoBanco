--INSERTS;

CREATE OR REPLACE FUNCTION usuarioCadastrar (nome VARCHAR, email VARCHAR, senha VARCHAR)
RETURNS INTEGER AS $$
	DECLARE
		id_gerada INT;
	BEGIN 
		SET ROLE insert;
		INSERT INTO usuario (nome, email, senha)
			VALUES (nome, email, md5(senha));

		SET ROLE retrieve;
		SELECT INTO id_gerada currval('usuario_id_usuario_seq');
		EXECUTE mensagemDeSucesso('Usuario', 'cadastrado'); -- raise notice, ver zFuncoesGerais
		RETURN id_gerada;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION '[Erro] Dados inválidos inseridos!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END INSERTS;


--UPDATES;

CREATE OR REPLACE FUNCTION alterarSenha (id INTEGER, senha_antiga VARCHAR, senha_nova VARCHAR)
RETURNS INTEGER AS $$
	DECLARE
		password VARCHAR;
	BEGIN 
		SET ROLE retrieve;
		SELECT INTO password senha FROM usuario WHERE id_usuario = id;

		IF (password = md5(senha_antiga)) THEN
			SET ROLE update;
			UPDATE usuario SET senha = md5(senha_nova) WHERE id_usuario = (id);
			EXECUTE mensagemDeSucesso('Usuario', 'cadastrado'); -- raise notice, ver zFuncoesGerais	
			RETURN 1;
		ELSE
			RAISE EXCEPTION 'Senha atual incorreta!';
			RETURN 0;
		END IF;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION '[Erro] Dados inválidos inseridos!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;


--Gera uma nova senha randômica ao usuário e a retorna para que esta seja disponibilizada para ele por email
CREATE OR REPLACE FUNCTION recuperarSenha (login VARCHAR)
RETURNS VARCHAR AS $$
	DECLARE
		id INT;
		password VARCHAR;
	BEGIN
		password:= ROUND(RANDOM()*10000000); 
		SET ROLE retrieve;
		SELECT INTO id id_usuario FROM usuario WHERE email = login;
		IF (FOUND) THEN
			SET ROLE update;
			UPDATE usuario SET senha = md5(password) WHERE id_usuario = (id);
			RAISE NOTICE 'Nova senha enviada para o seu email! Altere a senha para uma de sua preferência quando logar novamente no sistema.';
			RETURN password;
		ELSE
			RAISE EXCEPTION '[Erro] Email não cadastrado no sistema!';
			RETURN 0;
		END IF;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION '[Erro] Dados inválidos inseridos!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--com imagem
CREATE OR REPLACE FUNCTION usuarioAtualizar(id INTEGER, nome_p VARCHAR(100), email_p VARCHAR(100), senha_p VARCHAR(255), imagem_p VARCHAR(255))
RETURNS INTEGER AS $$
	BEGIN
		SET ROLE update;
		UPDATE usuario SET nome = nome_p, email = email_p, senha = md5(senha_p), imagem = imagem_p WHERE id_usuario = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Usuario', 'atualizado');
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	EXCEPTION
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION '[Erro] Dados inválidos inseridos!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--sem imagem
CREATE OR REPLACE FUNCTION usuarioAtualizar(id INTEGER, nome_p VARCHAR(100), email_p VARCHAR(100), senha_p VARCHAR(255))
RETURNS INTEGER AS $$
	BEGIN
		SET ROLE update;
		UPDATE usuario SET nome = nome_p, email = email_p, senha = md5(senha_p) WHERE id_usuario = id;
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Usuario', 'atualizado');
			RETURN 1;
		ELSE
			RETURN 0;
		END IF;
	EXCEPTION
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION '[Erro] Dados inválidos inseridos!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;
--END UPDATES:


--DELETES;

--Inativa o usuário
CREATE OR REPLACE FUNCTION usuarioExcluir (id INTEGER) RETURNS INTEGER AS $$
	BEGIN 
		SET ROLE update;
		UPDATE usuario SET inativo = TRUE, data_inatividade = CURRENT_DATE WHERE id_usuario = (id);
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Usuario', 'inativado'); -- raise notice, ver zFuncoesGerais
			RETURN 1;
		ELSE
			RAISE EXCEPTION 'Usuário não inativado!';
			RETURN 0;
		END IF;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION '[Erro] Dados inválidos inseridos!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;


--Exclui todos usuários que estão inativos à um ano ou mais
CREATE OR REPLACE FUNCTION usuarioExcluir () RETURNS INTEGER AS $$
	BEGIN
		SET ROLE delete;
		DELETE FROM usuario WHERE inativo = TRUE AND age(data_inatividade) >= '1 year';
		IF (FOUND) THEN
			EXECUTE mensagemDeSucesso('Usuarios inativos', 'excluidos'); -- raise notice, ver zFuncoesGerais
			RETURN 1;
		ELSE
			RAISE EXCEPTION 'Usuários não excluídos!';
			RETURN 0;
		END IF;
	EXCEPTION 
		WHEN CHECK_VIOLATION THEN
			RAISE EXCEPTION '[Erro] Dados inválidos inseridos!';
			RETURN 0;
	END;
$$ LANGUAGE PLPGSQL;

--END DELETES;

CREATE OR REPLACE FUNCTION buscarUsuarios(letras TEXT, OUT id_usuario INTEGER, OUT nome VARCHAR, OUT email VARCHAR) RETURNS SETOF RECORD AS $$
	BEGIN
		IF (LENGTH(LETRAS) < 2) THEN
			RAISE NOTICE 'Ao menos 2 letras precisam ser utilizadas';
			RETURN;
		END IF;
		SET ROLE retrieve;
		RETURN QUERY EXECUTE 'SELECT id_usuario, nome, email FROM usuario WHERE inativo != true AND LOWER(nome) LIKE LOWER(' || E'\'' ||  letras || '%'') LIMIT 50';
	END;
$$ LANGUAGE PLPGSQL;

--LOGIN;

-- LOGIN MOVIDO PARA AUTENTICACAO.SQL !!!

--END LOGIN;
