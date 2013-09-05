
REVOKE ALL PRIVILEGES ON SCHEMA public FROM GROUP public;
REVOKE ALL PRIVILEGES ON DATABASE projectfree FROM GROUP public;

DROP ROLE admin;
CREATE ROLE admin SUPERUSER LOGIN PASSWORD 'admin';

/*DROP ROLE nao_logado;
CREATE ROLE nao_logado;
GRANT EXECUTE ON FUNCTION usuarioCadastrar(VARCHAR, VARCHAR, VARCHAR), logar(login VARCHAR, password VARCHAR) TO nao_logado;

DROP ROLE logado_membro;
CREATE ROLE logado_membro;
GRANT EXECUTE ON FUNCTION alterarSenha(INTEGER, VARCHAR, VARCHAR), recuperarSenha(VARCHAR), 
	 usuarioAtualizar(id INTEGER, nome_p VARCHAR(100), email_p VARCHAR(100), senha_p VARCHAR(255), imagem_p VARCHAR(255)),
	 usuarioAtualizar(id INTEGER, nome_p VARCHAR(100), email_p VARCHAR(100), senha_p VARCHAR(255)),
	 
TO logado_membro;


DROP ROLE logado_gerente;
CREATE ROLE logado_gerente;
GRANT logado_membro TO logado_gerente;*/


DROP ROLE insert;
CREATE ROLE insert;
GRANT INSERT ON ALL TABLES IN SCHEMA public TO insert;
GRANT UPDATE ON ALL SEQUENCES IN SCHEMA public TO insert;

DROP ROLE retrieve;
CREATE ROLE retrieve;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO retrieve;
GRANT SELECT ON ALL SEQUENCES IN SCHEMA public TO retrieve;

DROP ROLE update;
CREATE ROLE update;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO update;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO update;

DROP ROLE delete;
CREATE ROLE delete;
GRANT DELETE ON ALL TABLES IN SCHEMA public TO delete;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO delete;

GRANT USAGE ON SCHEMA public TO insert, retrieve, update, delete, nao_logado, logado_membro, logado_gerente;

