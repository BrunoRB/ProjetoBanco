-- View do Cronograma

CREATE OR REPLACE VIEW cronogramView AS
	SELECT
	"public".membro_do_projeto.fk_projeto AS projeto,  -- ID para identificar o projeto a qual pertencem essas atividades, utilizado para filtar as atividades por projeto
	"public".atividade.id_atividade AS codigo, 
	"public".atividade.nome_atividade AS atividade,
	"public".atividade.inicio_atividade AS data_inicio,
	"public".atividade.limite_atividade AS data_limite,
	"public".atividade.fim_atividade AS data_fim,
	"public".atividade.fk_predecessora AS predecessora,
	"public".fase.nome AS fase,
	Count("public".atividade_do_membro.fk_membro_do_projeto) AS qtd_membro, -- Conta a quantidade de membros na atividade
	Count("public".artefato_atividade.fk_artefato) AS qtd_artefato          -- Conta a quantidade de artefatos gerados pela atividade
	FROM "public".atividade
		INNER JOIN "public".atividade_do_membro ON "public".atividade_do_membro.fk_atividade = "public".atividade.id_atividade
		INNER JOIN "public".artefato_atividade ON "public".artefato_atividade.fk_atividade = "public".atividade.id_atividade
		INNER JOIN "public".membro_do_projeto ON "public".atividade_do_membro.fk_membro_do_projeto = "public".membro_do_projeto.id_membro_do_projeto
		INNER JOIN "public".fase ON "public".atividade.fk_fase = "public".fase.id_fase
			GROUP BY "public".membro_do_projeto.fk_projeto, "public".atividade.id_atividade, "public".fase.id_fase 
			ORDER BY fase.id_fase; -- Ordenando as atividade pela sua fase


--View Listagem de projetos
CREATE OR REPLACE VIEW projetoView AS 
	SELECT projeto.id_projeto, projeto.nome, membro_do_projeto.funcao, usuario.id_usuario FROM projeto 
		INNER JOIN membro_do_projeto ON projeto.id_projeto = membro_do_projeto.fk_projeto
		INNER JOIN usuario ON membro_do_projeto.fk_usuario = usuario.id_usuario;


-- View Listagem dos membros de um projeto
CREATE OR REPLACE VIEW membro_projetoView AS
	SELECT membro_do_projeto.fk_projeto AS projeto, usuario.nome AS membro, membro_do_projeto.funcao, Count(atividade_do_membro.fk_atividade) AS qtd_atividade 
	FROM membro_do_projeto
		INNER JOIN usuario ON membro_do_projeto.fk_usuario = usuario.id_usuario
		INNER JOIN atividade_do_membro ON atividade_do_membro.fk_membro_do_projeto = membro_do_projeto.id_membro_do_projeto
		INNER JOIN atividade ON atividade_do_membro.fk_atividade = atividade.id_atividade
			WHERE atividade.finalizada = FALSE AND usuario.inativo = FALSE
			GROUP BY atividade_do_membro.fk_membro_do_projeto, membro_do_projeto.id_membro_do_projeto, usuario.id_usuario;


-- View Listagem dos artefatos de uma atividade
CREATE OR REPLACE VIEW artefato_atividadeView AS
	SELECT artefato_atividade.fk_atividade AS atividade, artefato.nome AS artefato, artefato.tipo, artefato.porcentagem_concluida 
	FROM artefato
		INNER JOIN artefato_atividade ON artefato.id_artefato = artefato_atividade.fk_artefato;


-- View Listagem das fases de um projeto
CREATE OR REPLACE VIEW fase_projetoView AS
	SELECT projeto.id_projeto AS projeto, fase.nome AS fase, fase_1.nome AS predecessora 
	FROM ((fase INNER JOIN fase fase_1 ON fase.fk_predecessora = fase_1.id_fase) 
		INNER JOIN projeto ON fase.fk_projeto = projeto.id_projeto);


-- View Listagem das atividades completas de um projeto
CREATE OR REPLACE VIEW atividade_completa_projetoView AS
	SELECT projeto.id_projeto AS projeto, atividade.nome_atividade AS atividade, atividade.inicio_atividade AS inicio, atividade.limite_atividade AS limite,
	atividade_1.nome_atividade AS predecessora, fase.nome AS fase
	FROM (((atividade INNER JOIN atividade atividade_1 ON atividade.fk_predecessora = atividade_1.id_atividade) 
		INNER JOIN fase ON atividade.fk_fase = fase.id_fase)
		INNER JOIN projeto ON atividade.fk_projeto = projeto.id_projeto)
			WHERE atividade.finalizada = TRUE;


-- View Listagem das atividades em andamento de um projeto
CREATE OR REPLACE VIEW atividade_incompleta_projetoView AS
	SELECT projeto.id_projeto AS projeto, atividade.nome_atividade AS atividade, atividade.inicio_atividade AS inicio, atividade.limite_atividade AS limite,
	atividade_1.nome_atividade AS predecessora, fase.nome AS fase
	FROM (((atividade INNER JOIN atividade atividade_1 ON atividade.fk_predecessora = atividade_1.id_atividade) 
		INNER JOIN fase ON atividade.fk_fase = fase.id_fase)
		INNER JOIN projeto ON atividade.fk_projeto = projeto.id_projeto)
			WHERE atividade.finalizada = FALSE;


-- View Listagem das notas de um usu�rio
CREATE OR REPLACE VIEW notaView AS
	SELECT fk_usuario AS usuario, titulo, texto, data FROM nota;


-- View Listagem das mensagens recebidas
CREATE OR REPLACE VIEW mensagem_recebidaView AS
	SELECT mensagem_enviada.fk_destinatario AS usuario, usuario.nome AS remetente, mensagem.assunto FROM mensagem 
		INNER JOIN usuario ON mensagem.fk_usuario = usuario.id_usuario
		INNER JOIN mensagem_enviada ON mensagem.id_mensagem = mensagem_enviada.fk_mensagem;