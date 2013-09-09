--Cadastra o gerente
SET ROLE retrieve;
SELECT usuarioCadastrar('Ebara', 'ebara@projectfree.com', 'admin');--Nome, email/login, senha

--erro ao gerente logar no sistema
SELECT logar('gerente@gerente.com', 'ebara');
--Gerente loga no sistema
SELECT logar('ebara@projectfree.com', 'admin');

--Gerente cria um projeto
SELECT projetoCadastrar(1, 'Sistemas de bancos de dados', 10.000, 'terceiro projeto integrador');--usuário/gerente, nome, orçamento, descrição

--Cadastro de membros
SELECT usuarioCadastrar('Roberto', 'roberto@projectfree.com', 'roberto');
SELECT usuarioCadastrar('Maikon', 'maikon@projectfree.com', 'maikon');
SELECT usuarioCadastrar('bruno', 'bruno@projectfree.com', 'bruno');
SELECT usuarioCadastrar('fabricio', 'fabricio@projectfree.com', 'fabricio');
SELECT usuarioCadastrar('outro_usuário', 'outro@projectfree.com', 'outro');

SELECT * from buscarUsuarios('rob');
SELECT * from buscarUsuarios('maik');
SELECT * from buscarUsuarios('br');
SELECT * from buscarUsuarios('fab');
SELECT * from buscarUsuarios('outro');

--gerente convida os membros
SELECT membro_do_projetoCadastrar(1, 1, 2, 'programador');--gerente, projeto, usuário, função
SELECT membro_do_projetoCadastrar(1, 1, 3, 'design');
SELECT membro_do_projetoCadastrar(1, 1, 4, 'analista');
SELECT membro_do_projetoCadastrar(1, 1, 5, 'programador');

SELECT membro_do_projetoCadastrar(1, 1, 6, 'analista');

--membros logam no sistema
SELECT logar('roberto@projectfree.com', 'roberto');
SELECT logar('maikon@projectfree.com', 'maikon');
SELECT logar('bruno@projectfree.com', 'bruno');
SELECT logar('fabricio@projectfree.com', 'fabricio');

SELECT logar('outro@projectfree.com', 'outro');

--usuários aceitam o convite do gerente
SELECT membro_do_projetoAceita(2, 1);--usuário, projeto
SELECT membro_do_projetoAceita(3, 1);
SELECT membro_do_projetoAceita(4, 1);
SELECT membro_do_projetoAceita(5, 1);

--usuario recusa o convite
SELECT membro_do_projetoRejeita(6, 1);

--gerente escreve mensagem para os membros de boas vindas
SELECT mensagemEscreve(1, 'mensagem do gerente', 'Bem vindo ao projeto');--usuario, assunto, mensagem

--mensagens são enviadas aos membros
SELECT mensagem_enviadaEnvia(1, 2, 1, CURRENT_DATE);--remetente, destinatario, mensagem, dataEnvio
SELECT mensagem_enviadaEnvia(1, 3, 1, CURRENT_DATE);
SELECT mensagem_enviadaEnvia(1, 4, 1, CURRENT_DATE);
SELECT mensagem_enviadaEnvia(1, 5, 1, CURRENT_DATE);

--membro escreve mensagem para o gerente
SELECT mensagemEscreve(3, 'Aviso sobre falta', 'Ebara, precisarei faltar na próxima segunda, pois tenho um compromisso');

--mensagem é enviada ao gerente
SELECT mensagem_enviadaEnvia(3, 1, 2, CURRENT_DATE);

--gerente lista suas mensagens
SET ROLE retrieve;
SELECT mensagemListar(1);

--gerente visualiza a mensagem
 

--gerente cria as fases do projeto
SELECT faseCadastrar(1, 1, 'Fase 1', 'Primeira fase do projeto');
SELECT faseCadastrar(1, 1, 'Fase 2', 'Segunda fase do projeto', 1);
SELECT faseCadastrar(1, 1, 'Fase 3', 'Terceira fase do projeto', 2);

--Gerente cria as atividades do projeto
SELECT atividadeCadastrar(1, 1, '09/09/2013', '16/09/2013', 'Requisitos', 1);--gerente, Projeto, dataInicio, dataLimite, nome, fase
SELECT atividadeCadastrar(1, 1, '11/09/2013', '18/09/2013', 'Codificação', 1, 1);--gerente, Projeto, dataInicio, dataLimite, nome, pred., fase
SELECT atividadeCadastrar(1, 1, '19/09/2013', '23/09/2013', 'Refatoração', 2);
SELECT atividadeCadastrar(1, 1, '24/09/2013', '30/09/2013', 'Testes unitários', 3, 2);
SELECT atividadeCadastrar(1, 1, '01/10/2013', '07/10/2013', 'Codificação', 3);
SELECT atividadeCadastrar(1, 1, '06/10/2013', '10/10/2013', 'Refatoração', 5, 3);

--membro tenta criar uma atividade
SELECT atividadeCadastrar(4, 1, '12/10/2013', '22/10/2013', 'Outra atividade', 6, 3);

--membro tenta alterar uma atividade
SELECT atividadeAtualizar(2, 1, 4, '24/09/2013', '02/10/2013', 'Testes unitários', 3, 2);--usuário, projeto, atividade...

--gerente atribui atividades aos membros	--Gerente, Projeto, Convite, Atividade
SELECT atividade_do_membroCadastrar(1, 1, 2, 1); --atividade 1 ao membro Roberto
SELECT atividade_do_membroCadastrar(1, 1, 2, 2); --atividade 2 ao membro Roberto
SELECT atividade_do_membroCadastrar(1, 1, 3, 3); --atividade 3 ao membro Maikon
SELECT atividade_do_membroCadastrar(1, 1, 3, 4); --atividade 4 ao membro Maikon
SELECT atividade_do_membroCadastrar(1, 1, 4, 5); --atividade 5 ao membro Bruno
SELECT atividade_do_membroCadastrar(1, 1, 4, 6); --atividade 6 ao membro Bruno
SELECT atividade_do_membroCadastrar(1, 1, 5, 5); --atividade 5 ao membro Fabricio

--gerente cria artefatos
SELECT artefatoCadastrar(1, 1, 'artefato 1', 'Tipo 1', 'Primeiro artefato');
SELECT artefatoCadastrar(1, 1, 'artefato 2', 'Tipo 2', 'Segundo artefato');

--gerente vincula atividades aos artefatos	   --gerente, projeto, artefato, atividade, porcentagem
SELECT artefato_atividadeCadastrar(1, 1, 1, 1, 35);--Artefato 1 a atividade 1 (35%)
SELECT artefato_atividadeCadastrar(1, 1, 1, 2, 35);--Artefato 1 a atividade 2 (35%)
SELECT artefato_atividadeCadastrar(1, 1, 1, 3, 30);--Artefato 1 a atividade 3 (30%)
SELECT artefato_atividadeCadastrar(1, 1, 2, 4, 40);--Artefato 2 a atividade 4 (40%)
SELECT artefato_atividadeCadastrar(1, 1, 2, 5, 25);--Artefato 2 a atividade 5 (25%)
SELECT artefato_atividadeCadastrar(1, 1, 2, 6, 35);--Artefato 2 a atividade 6 (35%)

--membro conclui atividade e é atualizada a porcentagem (35%) do artefato 1
SELECT atividadeFinalizar(2, 1, 2);--Membro, Projeto, Atividade

--membro tenta finalizar uma atividade que não lhe foi atribuida
SELECT atividadeFinalizar(2, 1, 6);

--gerente cria despesas do projeto
SELECT despesaCadastrar(1, 1, 'despesa 1', 100);--gerente, projeto, nome, valor
SELECT despesaCadastrar(1, 1, 'despesa 2', 450.67, 'Despesa referente a um recurso');

--gerente cria recursos do projeto
SELECT recursoCadastrar(1, 1, 'recurso 1', 'descricao do recurso 1', 2);--gerente, projeto, nome, descrição, despesa
SELECT recursoCadastrar(1, 1, 'recurso 2');

--gerente visualiza o cronogra
SELECT * FROM cronogramaListar(1, 1);

--gerente finaliza o projeto
SELECT projetoFinalizar(1, 1);










