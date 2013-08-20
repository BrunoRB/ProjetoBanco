\c postgres

DROP DATABASE projectfree;

CREATE DATABASE projectfree;

\c projectfree

CREATE TABLE usuario
(
  id_usuario SERIAL NOT NULL,
  nome CHARACTER VARYING(100) NOT NULL, 
  senha CHARACTER VARYING(255) NOT NULL,
  email CHARACTER VARYING(255) NOT NULL,
  imagem CHARACTER VARYING(255),
  inativo BOOLEAN NOT NULL DEFAULT FALSE,
  data_inatividade DATE,
  CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),
  CONSTRAINT unique_imagem UNIQUE (imagem),
  CONSTRAINT unique_email UNIQUE (email),
  CONSTRAINT check_login_length CHECK (login ~ '\w{5,100}'),
  CONSTRAINT check_senha_length CHECK (senha ~ '\w{5,255}'),
  CONSTRAINT check_email_length CHECK (email ~* '^[A-Za-z0-9._%-]+@[A-Za-z0-9.-]+[.][A-Za-z]+$')
);

CREATE TABLE projeto
(
   id_projeto SERIAL NOT NULL, 
   nome CHARACTER VARYING(100) NOT NULL, 
   orcamento NUMERIC(11,2), 
   data_de_cadastro DATE NOT NULL DEFAULT CURRENT_DATE,
   data_de_termino DATE,
   descricao TEXT,
   CONSTRAINT pk_projeto PRIMARY KEY (id_projeto),
   CONSTRAINT check_nome CHECK (nome ~ '\w{4,100}'),
   CONSTRAINT check_orcamento CHECK (orcamento::TEXT ~* '^\d+')
);

CREATE TABLE membro_do_projeto
(
	id_membro_do_projeto SERIAL,
	fk_projeto INTEGER NOT NULL,
	fk_usuario INTEGER NOT NULL,
	funcao VARCHAR(100) NOT NULL DEFAULT 'Não especificada',
	CONSTRAINT pk_membro_do_projeto PRIMARY KEY (id_membro_do_projeto),
	CONSTRAINT fk_projeto_membro_do_projeto FOREIGN KEY (fk_projeto) REFERENCES projeto (id_projeto),
	CONSTRAINT fk_usuario_membro_do_projeto FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario),
	CONSTRAINT unique_membro_projeto UNIQUE (fk_projeto, fk_usuario)
);

CREATE TABLE despesa
(
  id_despesa SERIAL NOT NULL,
  nome CHARACTER VARYING(100) NOT NULL,
  valor NUMERIC(11,2) NOT NULL,
  descricao TEXT,
  fk_projeto INTEGER NOT NULL,
  CONSTRAINT pk_despesa PRIMARY KEY (id_despesa),
  CONSTRAINT fk_projeto_desp FOREIGN KEY (fk_projeto) REFERENCES projeto (id_projeto),
  CONSTRAINT check_nome CHECK (nome ~* '\w{4,100}'),
  CONSTRAINT check_valor CHECK (valor::TEXT ~ '^\d+$|^\d+\.\d+$')
);

CREATE TABLE recurso
(
  id_recurso SERIAL NOT NULL,
  nome CHARACTER VARYING(100) NOT NULL,
  descricao TEXT,
  fk_projeto INTEGER NOT NULL,
  fk_despesa INTEGER,
  CONSTRAINT pk_recurso PRIMARY KEY (id_recurso),
  CONSTRAINT fk_despesa_recur FOREIGN KEY (fk_despesa) REFERENCES despesa (id_despesa),
  CONSTRAINT fk_projeto_recur FOREIGN KEY (fk_projeto) REFERENCES projeto (id_projeto),
  CONSTRAINT check_nome CHECK (nome ~ '\w{5,100}')
);

CREATE TABLE fase
(
	id_fase SERIAL,
	nome VARCHAR(100) NOT NULL,
	descricao TEXT,
	fk_predecessora INTEGER,
	CONSTRAINT pk_fase PRIMARY KEY (id_fase),
	CONSTRAINT fk_predecessora FOREIGN KEY (fk_predecessora) REFERENCES fase (id_fase)
);

CREATE TABLE atividade
(
  id_atividade SERIAL,
  inicio_atividade TIMESTAMP NOT NULL,
  limite_atividade TIMESTAMP NOT NULL,
  fim_atividade TIMESTAMP,
  nome_atividade CHARACTER VARYING(100) NOT NULL,
  descricao_atividade TEXT,
  fk_predecessora INTEGER,
  fk_fase INTEGER NOT NULL,
  finalizada BOOLEAN NOT NULL DEFAULT FALSE,
  CONSTRAINT pk_atividade PRIMARY KEY (id_atividade),
  CONSTRAINT fk_predecessora FOREIGN KEY (fk_predecessora) REFERENCES atividade(id_atividade),
  CONSTRAINT fk_fase FOREIGN KEY (fk_fase) REFERENCES fase(id_fase)
);

CREATE TABLE atividade_do_membro
(
	id_atividade_do_membro SERIAL,
	data_horario_atribuicao TIMESTAMP NOT NULL DEFAULT NOW(),
	fk_membro_do_projeto INTEGER NOT NULL,
	fk_atividade INTEGER NOT NULL,
	CONSTRAINT pk_atividade_do_membro PRIMARY KEY (id_atividade_do_membro),
	CONSTRAINT fk_membro_do_projeto FOREIGN KEY (fk_membro_do_projeto) REFERENCES membro_do_projeto (id_membro_do_projeto),
	CONSTRAINT fk_atividade FOREIGN KEY (fk_atividade) REFERENCES atividade (id_atividade),
	CONSTRAINT unique_atividade_membro UNIQUE (fk_membro_do_projeto, fk_atividade)
);

CREATE TABLE comentario
(
	id_comentario SERIAL,
	descricao VARCHAR(255) NOT NULL,
	data_horario_envio TIMESTAMP NOT NULL DEFAULT NOW(),
	fk_atividade_do_membro INTEGER NOT NULL,
	CONSTRAINT pk_comentario PRIMARY KEY (id_comentario),
	CONSTRAINT fk_atividade_do_membro FOREIGN KEY (fk_atividade_do_membro) REFERENCES atividade_do_membro (id_atividade_do_membro)
);

CREATE TABLE artefato
(
	id_artefato SERIAL,
	nome VARCHAR(100) NOT NULL,
	tipo VARCHAR(100),
	descricao TEXT,
	porcentagem_concluida INTEGER NOT NULL DEFAULT 0,
	CONSTRAINT check_porcentagem_concluida CHECK (porcentagem_concluida::TEXT ~ '^[0-9]$|^[0-9]{2}$|^100$')
);

CREATE TABLE artefato_atividade
(
	fk_atividade INTEGER NOT NULL,
	fk_artefato INTEGER NOT NULL,
	porcentagem_gerada INTEGER NOT NULL DEFAULT 0,
	CONSTRAINT pk_artefato_atividade PRIMARY KEY (fk_atividade, fk_artefato),
	CONSTRAINT check_porcentagem_gerada CHECK (porcentagem_gerada::TEXT ~ '^[0-9]$|^[0-9]{2}$|^100$')
);

CREATE TABLE tentativa_de_login
(
  fk_usuario INTEGER NOT NULL,
  tempo VARCHAR(30),	
  CONSTRAINT pk_tentativas_de_login PRIMARY KEY (fk_usuario),
  CONSTRAINT fk_usuario_tentativas_de_login FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario)
);

CREATE TABLE fale_conosco
(
	id_fale_conosco SERIAL,
	data_e_hora TIMESTAMP NOT NULL DEFAULT NOW(),
	assunto VARCHAR(100) NOT NULL,
	mensagem TEXT NOT NULL,
	email VARCHAR(100) NOT NULL,
	fk_usuario INTEGER NOT NULL,
	CONSTRAINT pk_fale_conosco PRIMARY KEY (id_fale_conosco),
	CONSTRAINT fk_usuario FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario)
);

CREATE TABLE doacao
(
	id_doacao SERIAL,
	quantia NUMERIC(11, 2) NOT NULL,
	data_e_hora TIMESTAMP NOT NULL DEFAULT NOW(),
	fk_doador INTEGER NOT NULL,
	CONSTRAINT pk_doacao PRIMARY KEY (id_doacao),
	CONSTRAINT fk_usuario FOREIGN KEY (fk_doador) REFERENCES usuario (id_usuario)
);

CREATE TABLE log_de_erro
(
  id_log_de_erro SERIAL NOT NULL,
  nome_tabela CHARACTER VARYING(100) NOT NULL,
  erro TEXT,
  CONSTRAINT pk_log_de_erro PRIMARY KEY (id_log_de_erro)
);

CREATE TABLE forma_de_contato
(
  id_forma_de_contato SERIAL NOT NULL,
  tipo CHARACTER VARYING(100) NOT NULL,
  valor CHARACTER VARYING(100) NOT NULL,
  fk_usuario INTEGER NOT NULL,
  CONSTRAINT pk_forma_de_contato PRIMARY KEY (id_forma_de_contato),
  CONSTRAINT fk_usuario_forma FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario)
);

CREATE TABLE nota
(
	id_nota SERIAL,
	titulo VARCHAR(100) NOT NULL,
	texto text NOT NULL,
	data DATE NOT NULL DEFAULT CURRENT_DATE,
	fk_usuario INTEGER NOT NULL,
	CONSTRAINT pk_nota PRIMARY KEY (id_nota),
	CONSTRAINT fk_usuario_nota FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario)
);

CREATE TABLE imagem
(
	id_imagem SERIAL,
	sumario VARCHAR(100),
	path VARCHAR(255) NOT NULL,
	fk_comentario INTEGER,
	CONSTRAINT pk_imagem PRIMARY KEY (id_imagem),
	CONSTRAINT fk_comentario_imagem FOREIGN KEY (fk_comentario) REFERENCES comentario(id_comentario)
);

--TODO MENSAGEM;
--TODO MENSAGEM_ENVIADA;
