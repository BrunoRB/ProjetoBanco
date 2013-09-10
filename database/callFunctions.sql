--Chame por "\\i funcoes/callFunctions.sql" no psql. É necessário estar na pasta "ProjetoBanco";

﻿\c postgres
; --DO NOT REMOVE (tem algum pau no \c postgres, esse ; é uma gambs mas funciona)

DROP DATABASE projectfree;
CREATE DATABASE projectfree;
\c projectfree

--BEGIN CREATE TABLES
\i database/scriptsDeCriacao.sql
--END CREATE TABLES

--CREATE VIEWS
\i database/views.sql
--END CREATE VIES

--BEGIN CREATE FUNCTIONS/PROCEDURES
\i database/funcoes/autenticacao.sql
\i database/funcoes/zFuncoesGerais.sql

SET CLIENT_ENCODING = 'latin1'; --SCRIPT usuario.sql gera algum problema de encoding para UTF8
\i database/funcoes/usuario.sql
SET CLIENT_ENCODING = 'utf8';
\i database/funcoes/projeto.sql
\i database/funcoes/membro_do_projeto.sql
\i database/funcoes/fase.sql
\i database/funcoes/atividade.sql
\i database/funcoes/atividade_do_membro.sql
\i database/funcoes/artefato.sql
\i database/funcoes/artefato_atividade.sql
\i database/funcoes/recurso.sql
\i database/funcoes/despesa.sql
\i database/funcoes/mensagem.sql
\i database/funcoes/mensagem_enviada.sql
\i database/funcoes/cronograma.sql

--INSERTS
\i database/scriptsDeInsercao.sql

--INDEX
\i database/indices.sql

--TRIGGERS
\i database/triggers.sql

	--TODO faltando arquivos

--END CREATE FUNCTIONS/PROCEDURES

-- BEGIN ROLES
\i database/roles.sql
--END ROLES
