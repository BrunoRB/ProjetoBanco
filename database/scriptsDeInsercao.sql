
INSERT INTO tipo (tipo) VALUES ('administrador'), ('membro'), ('cliente');

INSERT INTO usuario VALUES (2, 'gerente do projeto', 'gerente 1', 'gerente', (SELECT id_tipo FROM tipo WHERE tipo = 'membro'));

INSERT INTO membro VALUES (1, '05/05/2012', 2);

INSERT INTO projeto VALUES (1, 'Sistema gerenciador de projetos', 30.000, now(), 'descrição do projeto', 1);

INSERT INTO despesa VALUES (1, 'salario', 10.000, 'Descrição da despesa', 1);

INSERT INTO recurso VALUES (1, 'pc_de_programacao', 'computador de mesa', 1, 1);

INSERT INTO cronograma VALUES (1, '05-05-2012', '05-12-2012', '05-05-2012', 1);

INSERT INTO atividade VALUES (1, '05-05-2012', '05-12-2012', '05-05-2012', 'Atividade X', 'descrição da atividade', 1, 1);

INSERT INTO atividade_do_membro VALUES (1, 1); 

INSERT INTO comentario VALUES (1, 'comantario teste', '23-05-2013', 1);

INSERT INTO usuario VALUES (1, 'administrador', 'admin', 'admin', (SELECT id_tipo FROM tipo WHERE tipo = 'administrador'));

INSERT INTO administrador VALUES (1, 1);

INSERT INTO log_de_erro VALUES (1, 'administrador', 'teste de erro');

INSERT INTO usuario VALUES (4, 'cliente', 'cliente', 'adm', (SELECT id_tipo FROM tipo WHERE tipo = 'cliente'));

INSERT INTO cliente VALUES (1, 4);

INSERT INTO projeto_cliente VALUES (1, 1);

INSERT INTO forma_de_contato VALUES (1, 'celular', '343434-3434', 1);

INSERT INTO mensagem VALUES (1, 'assunto da mensagem', 'Texto da mensagem');

INSERT INTO usuario_mensagem VALUES (1, '05-05-2012', 1, 1, 2);

INSERT INTO membro_do_projeto VALUES (1, 1, 'gerente de desenvolvimento');

