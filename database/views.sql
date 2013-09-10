-- View do Cronograma

CREATE OR REPLACE VIEW cronogramaView AS
	SELECT
		membro_do_projeto.fk_projeto AS projeto,  -- ID para identificar o projeto a qual pertencem essas atividades, utilizado para filtar as atividades por projeto
		atividade.id_atividade AS codigo, 
		atividade.nome_atividade AS atividade,
		atividade.inicio_atividade AS data_inicio,
		atividade.limite_atividade AS data_limite,
		atividade.fim_atividade AS data_fim,
		atividade.fk_predecessora AS predecessora,
		fase.nome AS fase,
		Count(atividade_do_membro.fk_membro_do_projeto) AS qtd_membro, -- Conta a quantidade de membros na atividade
		Count(artefato_atividade.fk_artefato) AS qtd_artefato          -- Conta a quantidade de artefatos gerados pela atividade
	FROM atividade
		INNER JOIN atividade_do_membro ON atividade_do_membro.fk_atividade = atividade.id_atividade
		INNER JOIN artefato_atividade ON artefato_atividade.fk_atividade = atividade.id_atividade
		INNER JOIN membro_do_projeto ON atividade_do_membro.fk_membro_do_projeto = membro_do_projeto.id_membro_do_projeto
		INNER JOIN fase ON atividade.fk_fase = fase.id_fase
			GROUP BY membro_do_projeto.fk_projeto, atividade.id_atividade, fase.id_fase 
			ORDER BY fase.id_fase; -- Ordenando as atividade pela sua fase




--View Listagem de projetos
CREATE OR REPLACE VIEW projetoView AS 
	SELECT projeto.id_projeto, projeto.nome, membro_do_projeto.funcao, usuario.id_usuario FROM projeto 
		INNER JOIN membro_do_projeto ON projeto.id_projeto = membro_do_projeto.fk_projeto
		INNER JOIN usuario ON membro_do_projeto.fk_usuario = usuario.id_usuario;


-- View Listagem dos membros de um projeto
CREATE OR REPLACE VIEW membro_projetoView AS
	SELECT membro_do_projeto.fk_projeto AS projeto, usuario.id_usuario AS idMembro, usuario.nome AS membro, membro_do_projeto.funcao, Count(atividade_do_membro.fk_atividade) AS qtd_atividade 
	FROM membro_do_projeto
		INNER JOIN usuario ON membro_do_projeto.fk_usuario = usuario.id_usuario
		INNER JOIN atividade_do_membro ON atividade_do_membro.fk_membro_do_projeto = membro_do_projeto.id_membro_do_projeto
		INNER JOIN atividade ON atividade_do_membro.fk_atividade = atividade.id_atividade
			WHERE atividade.finalizada = FALSE AND usuario.inativo = FALSE
			GROUP BY atividade_do_membro.fk_membro_do_projeto, membro_do_projeto.id_membro_do_projeto, usuario.id_usuario;


-- View Listagem dos artefatos de um projeto
CREATE OR REPLACE VIEW artefato_projetoView AS
	SELECT fk_projeto AS projeto, artefato.id_artefato AS idArtefato, artefato.nome AS artefato, artefato.tipo, artefato.porcentagem_concluida 
	FROM artefato;


-- View Listagem das fases de um projeto
CREATE OR REPLACE VIEW fase_projetoView AS
	SELECT fase.fk_projeto AS projeto, fase.id_fase AS idFase, fase.nome AS fase, fase_1.nome AS predecessora 
	FROM (fase LEFT JOIN fase fase_1 ON fase.fk_predecessora = fase_1.id_fase);



-- View Listagem das atividades completas de um projeto pelo gerente
CREATE OR REPLACE VIEW atividade_completa_gerenteView AS
	SELECT atividade.fk_projeto AS projeto, atividade.id_atividade AS idAtividade, 
		atividade.nome_atividade AS atividade, atividade.inicio_atividade AS inicio, 
		atividade.limite_atividade AS limite, atividade.fim_atividade AS fim,
		atividade_1.nome_atividade AS predecessora, fase.nome AS fase
	FROM ((atividade LEFT JOIN atividade atividade_1 ON atividade.fk_predecessora = atividade_1.id_atividade) 
		INNER JOIN fase ON atividade.fk_fase = fase.id_fase)
			WHERE atividade.finalizada = TRUE;


-- View Listagem das atividades em andamento de um projeto pelo gerente
CREATE OR REPLACE VIEW atividade_incompleta_gerenteView AS
	SELECT atividade.fk_projeto AS projeto, atividade.id_atividade AS idAtividade, 
		atividade.nome_atividade AS atividade, atividade.inicio_atividade AS inicio, 
		atividade.limite_atividade AS limite, atividade_1.nome_atividade AS predecessora, fase.nome AS fase
	FROM ((atividade LEFT JOIN atividade atividade_1 ON atividade.fk_predecessora = atividade_1.id_atividade) 
		INNER JOIN fase ON atividade.fk_fase = fase.id_fase)
			WHERE atividade.finalizada = FALSE;


-- View Listagem das atividades completas de um membro em um projeto
CREATE OR REPLACE VIEW atividade_completa_membroView AS
	SELECT atividade.fk_projeto AS projeto, atividade_do_membro.fk_membro_do_projeto AS membro, atividade.id_atividade AS idAtividade, 
		atividade.nome_atividade AS atividade, atividade.inicio_atividade AS inicio, 
		atividade.limite_atividade AS limite, atividade_1.nome_atividade AS predecessora, fase.nome AS fase
	FROM (((atividade LEFT JOIN atividade atividade_1 ON atividade.fk_predecessora = atividade_1.id_atividade) 
		INNER JOIN fase ON atividade.fk_fase = fase.id_fase) 
		INNER JOIN atividade_do_membro ON fk_atividade = atividade.id_atividade)
			WHERE atividade.finalizada = TRUE;


-- View Listagem das atividades em andamento de um membro em um projeto
CREATE OR REPLACE VIEW atividade_incompleta_membroView AS
	SELECT atividade.fk_projeto AS projeto, atividade_do_membro.fk_membro_do_projeto AS membro, atividade.id_atividade AS idAtividade, 
		atividade.nome_atividade AS atividade, atividade.inicio_atividade AS inicio, 
		atividade.limite_atividade AS limite, atividade_1.nome_atividade AS predecessora, fase.nome AS fase
	FROM (((atividade LEFT JOIN atividade atividade_1 ON atividade.fk_predecessora = atividade_1.id_atividade) 
		INNER JOIN fase ON atividade.fk_fase = fase.id_fase) 
		INNER JOIN atividade_do_membro ON fk_atividade = atividade.id_atividade)
			WHERE atividade.finalizada = FALSE;


-- View Listagem das notas de um usuário
CREATE OR REPLACE VIEW notaView AS
	SELECT fk_usuario AS usuario, titulo, texto, data FROM nota;


-- View Listagem das mensagens recebidas
CREATE OR REPLACE VIEW mensagem_recebidaView AS
	SELECT mensagem_enviada.fk_destinatario AS usuario, mensagem.id_mensagem AS idMensagem, 
		usuario.nome AS remetente, mensagem.assunto, mensagem_enviada.data_hora_envio
	FROM mensagem 
		INNER JOIN usuario ON mensagem.fk_usuario = usuario.id_usuario
		INNER JOIN mensagem_enviada ON mensagem.id_mensagem = mensagem_enviada.fk_mensagem;
