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
	SELECT id_usuario, projeto.nome AS Nome, membro_do_projeto.funcao AS funcao FROM projeto 
		INNER JOIN membro_do_projeto ON projeto.id_projeto = membro_do_projeto.fk_projeto
		INNER JOIN usuario ON membro_do_projeto.fk_usuario = usuario.id_usuario;
