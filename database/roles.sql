
REVOKE ALL PRIVILEGES ON SCHEMA public FROM GROUP public;
REVOKE ALL PRIVILEGES ON DATABASE projectfree FROM GROUP public;

CREATE ROLE admin SUPERUSER;

CREATE ROLE insert;
GRANT CREATE ON ALL TABLES TO insert;
GRANT INSERT ON ALL TABLES IN SCHEMA public TO insert;
GRANT UPDATE ON artefato_id_artefato_seq TO insert;
GRANT UPDATE ON atividade_do_membro_id_atividade_do_membro_seq TO insert;
GRANT UPDATE ON atividade_id_atividade_seq TO insert;
GRANT UPDATE ON comentario_id_comentario_seq TO insert;
GRANT UPDATE ON despesa_id_despesa_seq TO insert;
GRANT UPDATE ON doacao_id_doacao_seq TO insert;

CREATE ROLE retrieve;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO retrieve;

CREATE ROLE update;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO update;

CREATE ROLE delete;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO delete;





