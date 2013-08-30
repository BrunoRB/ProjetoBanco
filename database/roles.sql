
REVOKE ALL PRIVILEGES ON SCHEMA public FROM GROUP public;
REVOKE ALL PRIVILEGES ON DATABASE projectfree FROM GROUP public;

CREATE ROLE admin SUPERUSER;

DROP ROLE function;
CREATE ROLE function;
GRANT EXECUTE ON ALL FUNCTIONS IN SCHEMA public TO function;

DROP ROLE insert;
CREATE ROLE insert;
GRANT INSERT ON ALL TABLES IN SCHEMA public TO insert;
GRANT UPDATE ON artefato_id_artefato_seq TO insert;
GRANT UPDATE ON atividade_do_membro_id_atividade_do_membro_seq TO insert;
GRANT UPDATE ON atividade_id_atividade_seq TO insert;
GRANT UPDATE ON comentario_id_comentario_seq TO insert;
GRANT UPDATE ON despesa_id_despesa_seq TO insert;
GRANT UPDATE ON doacao_id_doacao_seq TO insert;
GRANT UPDATE ON fale_conosco_id_fale_conosco_seq TO insert;
GRANT UPDATE ON fase_id_fase_seq TO insert;
GRANT UPDATE ON forma_de_contato_id_forma_de_contato_seq TO insert;
GRANT UPDATE ON imagem_id_imagem_seq TO insert;
GRANT UPDATE ON log_de_erro_id_log_de_erro_seq TO insert;
GRANT UPDATE ON membro_do_projeto_id_membro_do_projeto_seq TO insert;
GRANT UPDATE ON mensagem_id_mensagem_seq TO insert;
GRANT UPDATE ON nota_id_nota_seq  TO insert;
GRANT UPDATE ON projeto_id_projeto_seq TO insert;
GRANT UPDATE ON recurso_id_recurso_seq TO insert;
GRANT UPDATE ON usuario_id_usuario_seq TO insert;

DROP ROLE retrieve;
CREATE ROLE retrieve;
GRANT SELECT ON ALL TABLES IN SCHEMA public TO retrieve;

DROP ROLE update;
CREATE ROLE update;
GRANT UPDATE ON ALL TABLES IN SCHEMA public TO update;

DROP ROLE delete;
CREATE ROLE delete;
GRANT DELETE ON ALL TABLES IN SCHEMA public TO delete;

GRANT USAGE ON SCHEMA public TO insert, retrieve, update, delete, function;





