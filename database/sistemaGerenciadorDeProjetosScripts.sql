CREATE DATABASE projectfree;

CREATE TABLE tipo
(
  id_tipo SERIAL NOT NULL,
  tipo CHARACTER VARYING(100) NOT NULL,
  CONSTRAINT pk_tipo PRIMARY KEY (id_tipo), 
  CONSTRAINT unique_tipo UNIQUE (tipo),
  CONSTRAINT check_tipo CHECK (tipo ~* '^membro$' OR tipo ~* '^cliente$' OR tipo ~* 'administrador$')
);

CREATE TABLE usuario
(
  id_usuario SERIAL NOT NULL,
  nome CHARACTER VARYING(100) NOT NULL, 
  login CHARACTER VARYING(100) NOT NULL,
  senha CHARACTER VARYING(255) NOT NULL,
  fk_tipo INTEGER NOT NULL,
  CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),
  CONSTRAINT unique_login UNIQUE (login),
  CONSTRAINT fk_tipo_usu FOREIGN KEY (fk_tipo) REFERENCES tipo (id_tipo),
  CONSTRAINT check_login_length CHECK (login ~ '\d{5}'),
  CONSTRAINT check_senha_length CHECK (login ~ '\d{5}')
);

CREATE TABLE membro
(
  id_membro SERIAL NOT NULL,
  data_de_nascimento DATE,
  fk_usuario INTEGER NOT NULL,
  CONSTRAINT pk_membro PRIMARY KEY (id_membro),
  CONSTRAINT fk_membro FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario),
  CONSTRAINT check_data_de_nascimento CHECK (data_de_nascimento::text ~* '^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$')
);

CREATE TABLE projeto
(
   id_projeto SERIAL NOT NULL, 
   nome CHARACTER VARYING(100) NOT NULL, 
   orcamento NUMERIC(20,4), 
   data_de_cadastro DATE NOT NULL,
   descricao text, 
   fk_gerente INTEGER NOT NULL, 
   CONSTRAINT pk_projeto PRIMARY KEY (id_projeto), 
   CONSTRAINT fk_gerente_de_projeto FOREIGN KEY (fk_gerente) REFERENCES membro (id_membro),
   CONSTRAINT check_nome CHECK (length(nome) >= 5),
   CONSTRAINT check_orcamento CHECK (orcamento >= 0.0),
   CONSTRAINT check_data_de_cadastro CHECK (data_de_cadastro::text ~* '^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$')
);


CREATE TABLE despesa
(
  id_despesa SERIAL NOT NULL,
  nome CHARACTER VARYING(100) NOT NULL,
  valor NUMERIC(20,4) NOT NULL,
  descricao text,
  fk_projeto INTEGER NOT NULL,
  CONSTRAINT pk_despesa PRIMARY KEY (id_despesa),
  CONSTRAINT fk_projeto_desp FOREIGN KEY (fk_projeto) REFERENCES projeto (id_projeto),
  CONSTRAINT check_nome CHECK (length(nome) >= 5),
  CONSTRAINT check_valor CHECK (valor > 0.0)
);


CREATE TABLE recurso
(
  id_recurso SERIAL NOT NULL,
  nome CHARACTER VARYING(100) NOT NULL,
  descricao text,
  fk_projeto INTEGER NOT NULL,
  fk_despesa INTEGER,
  CONSTRAINT pk_recurso PRIMARY KEY (id_recurso),
  CONSTRAINT fk_despesa_recur FOREIGN KEY (fk_despesa) REFERENCES despesa (id_despesa),
  CONSTRAINT fk_projeto_recur FOREIGN KEY (fk_projeto) REFERENCES projeto (id_projeto),
  CONSTRAINT check_nome CHECK (length(nome) >= 5)
);


CREATE TABLE cronograma
(
   id_cronograma SERIAL NOT NULL, 
   data_inicio_projeto DATE NOT NULL,
   data_limite_projeto DATE NOT NULL,
   data_fim DATE,
   fk_projeto INTEGER NOT NULL, 
   CONSTRAINT pk_cronograma PRIMARY KEY (id_cronograma), 
   CONSTRAINT fk_projeto_crono FOREIGN KEY (fk_projeto) REFERENCES projeto (id_projeto),
   CONSTRAINT check_data_inicio_projeto CHECK (data_inicio_projeto::text ~* '^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$'),
   CONSTRAINT check_data_limite_projeto CHECK (data_limite_projeto::text ~* '^[0-9]{4}-(((0[13578]|(10|12))-(0[1-9]|[1-2][0-9]|3[0-1]))|(02-(0[1-9]|[1-2][0-9]))|((0[469]|11)-(0[1-9]|[1-2][0-9]|30)))$')
);

CREATE TABLE atividade
(
  id_atividade SERIAL NOT NULL,
  data_inicio_atividade TIMESTAMP NOT NULL, --TODO
  data_limite_atividade TIMESTAMP NOT NULL, --TODO
  data_fim_atividade TIMESTAMP, --TODO
  nome_atividade CHARACTER VARYING(100) NOT NULL,
  descricao_atividade text,
  fk_projeto INTEGER NOT NULL,
  fk_cronograma INTEGER NOT NULL,
  CONSTRAINT pk_atividade PRIMARY KEY (id_atividade),
  CONSTRAINT fk_cronograma_atividade FOREIGN KEY (fk_cronograma) REFERENCES cronograma (id_cronograma),
  CONSTRAINT fk_projeto_atividade FOREIGN KEY (fk_projeto) REFERENCES projeto (id_projeto),
  CONSTRAINT check_nome_atividade CHECK (length(nome_atividade) >= 5)
);



CREATE TABLE comentario
(
  id_comentario SERIAL NOT NULL,
  descricao text,
  data_horario_envio TIMESTAMP, --TODO
  fk_atividade INTEGER NOT NULL,
  CONSTRAINT pk_comentario PRIMARY KEY (id_comentario),
  CONSTRAINT pk_atividade_nota FOREIGN KEY (fk_atividade) REFERENCES atividade (id_atividade)
);

CREATE TABLE administrador
(
  id_administrador SERIAL NOT NULL,
  fk_usuario INTEGER NOT NULL,
  CONSTRAINT pk_administrador PRIMARY KEY (id_administrador),
  CONSTRAINT pk_usuario_admin FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario)
);


CREATE TABLE log_de_erro
(
  id_log_de_erro SERIAL NOT NULL,
  tabela CHARACTER VARYING(100) NOT NULL,
  descricao_erro text,
  CONSTRAINT pk_log_de_erro PRIMARY KEY (id_log_de_erro)
);


CREATE TABLE cliente
(
  id_cliente SERIAL NOT NULL,
  fk_usuario INTEGER NOT NULL,
  CONSTRAINT pk_cliente PRIMARY KEY (id_cliente),
  CONSTRAINT fk_usuario_cli FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario)
);



CREATE TABLE projeto_cliente
(
  fk_projeto INTEGER NOT NULL,
  fk_cliente INTEGER NOT NULL,
  CONSTRAINT pk_projeto_cliente PRIMARY KEY (fk_projeto, fk_cliente),
  CONSTRAINT fk_cliente_proj_cli FOREIGN KEY (fk_cliente) REFERENCES cliente (id_cliente),
  CONSTRAINT fk_projeto_proj_cli FOREIGN KEY (fk_projeto) REFERENCES projeto (id_projeto)
);


CREATE TABLE forma_de_contato
(
  id_forma_de_contato	 SERIAL NOT NULL,
  tipo CHARACTER VARYING(100) NOT NULL,
  valor CHARACTER VARYING(100) NOT NULL,
  fk_usuario INTEGER NOT NULL,
  CONSTRAINT pk_forma_de_contato PRIMARY KEY (id_forma_de_contato),
  CONSTRAINT fk_usuario_forma FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
);


CREATE TABLE mensagem
(
   id_mensagem SERIAL NOT NULL, 
   assunto CHARACTER VARYING(100), 
   texto text, 
   CONSTRAINT pk_mensagem PRIMARY KEY (id_mensagem)
);



CREATE TABLE usuario_mensagem
(
   id_usuario_mensagem SERIAL NOT NULL, 
   data_hora_envio TIMESTAMP NOT NULL, --TODO
   fk_destinatario INTEGER NOT NULL, 
   fk_mensagem INTEGER NOT NULL, 
   fk_usuario INTEGER NOT NULL, 
   CONSTRAINT pk_usuario_mensagem PRIMARY KEY (id_usuario_mensagem), 
   CONSTRAINT fk_usuario_ger_mens FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario),
   CONSTRAINT fk_mensagem_ger_mens FOREIGN KEY (fk_mensagem) REFERENCES mensagem (id_mensagem)
);




CREATE TABLE atividade_do_membro
(
   fk_membro INTEGER NOT NULL, 
   fk_atividade INTEGER NOT NULL, 
   CONSTRAINT pk_atividade_do_membro PRIMARY KEY (fk_membro, fk_atividade), 
   CONSTRAINT fk_membro_mem_ativ FOREIGN KEY (fk_membro) REFERENCES membro (id_membro) ON UPDATE NO ACTION ON DELETE NO ACTION, 
   CONSTRAINT fk_atividade_mem_ativ FOREIGN KEY (fk_atividade) REFERENCES atividade (id_atividade) ON UPDATE NO ACTION ON DELETE NO ACTION
);



CREATE TABLE membro_do_projeto
(
   fk_projeto INTEGER NOT NULL, 
   fk_membro INTEGER NOT NULL, 
   CONSTRAINT pk_membro_do_projeto PRIMARY KEY (fk_projeto, fk_membro), 
   CONSTRAINT fk_projeto_proj_mem FOREIGN KEY (fk_projeto) REFERENCES projeto (id_projeto),
   CONSTRAINT fk_membro_proj_membro FOREIGN KEY (fk_membro) REFERENCES membro (id_membro)
);


