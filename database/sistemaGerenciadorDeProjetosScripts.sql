CREATE DATABASE Sistemagdp
  WITH OWNER = postgres
       ENCODING = 'UTF8'
       TABLESPACE = pg_default
       LC_COLLATE = 'pt_BR.UTF-8'
       LC_CTYPE = 'pt_BR.UTF-8'
       CONNECTION LIMIT = -1;





CREATE TABLE tipo
(
  id_tipo serial NOT NULL,
  tipo character varying(100) NOT NULL,
  CONSTRAINT pk_tipo PRIMARY KEY (id_tipo)
) 
WITH (
  OIDS = FALSE
)
;
ALTER TABLE tipo OWNER TO postgres;



CREATE TABLE usuario
(
  id_usuario serial NOT NULL,
  nome character varying(100) NOT NULL, 
  login character varying(100) NOT NULL,
  senha character varying(255) NOT NULL,
  fk_tipo integer NOT NULL,
  CONSTRAINT pk_usuario PRIMARY KEY (id_usuario),
  CONSTRAINT fk_tipo_usu FOREIGN KEY (fk_tipo) REFERENCES tipo (id_tipo) ON UPDATE NO ACTION ON DELETE NO ACTION
) 
WITH (
  OIDS = FALSE
)
;
ALTER TABLE usuario OWNER TO postgres;



CREATE TABLE gerente_de_projeto
(
   id_gerente serial NOT NULL, 
   data_de_aniversario date, 
   fk_usuario integer NOT NULL,
   CONSTRAINT pk_gerente_de_projeto PRIMARY KEY (id_gerente),
   CONSTRAINT fk_gerente_de_projeto FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario) ON UPDATE NO ACTION ON DELETE NO ACTION
) 
WITH (
  OIDS = FALSE
)
;

ALTER TABLE gerente_de_projeto OWNER TO postgres;





CREATE TABLE projeto
(
   id_projeto serial NOT NULL, 
   nome character varying(100) NOT NULL, 
   orcamento double precision, 
   data_de_cadastro date NOT NULL, 
   descricao text, 
   fk_gerente integer NOT NULL, 
   CONSTRAINT pk_projeto PRIMARY KEY (id_projeto), 
   CONSTRAINT fk_gerente_de_projeto FOREIGN KEY (fk_gerente) REFERENCES gerente_de_projeto (id_gerente) ON UPDATE NO ACTION ON DELETE NO ACTION
) 
WITH (
  OIDS = FALSE
)
;

ALTER TABLE projeto OWNER TO postgres;



CREATE TABLE membro
(
  id_membro serial NOT NULL,
  data_de_nascimento date,
  funcao character varying(100) NOT NULL,
  fk_usuario integer NOT NULL,
  CONSTRAINT pk_membro PRIMARY KEY (id_membro),
  CONSTRAINT fk_membro FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario) ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

ALTER TABLE membro OWNER TO postgres;





CREATE TABLE despesa
(
  id_despesa serial NOT NULL,
  nome character varying(100) NOT NULL,
  valor double precision NOT NULL,
  descricao text,
  fk_projeto integer NOT NULL,
  fk_membro integer NOT NULL,
  CONSTRAINT pk_despesa PRIMARY KEY (id_despesa),
  CONSTRAINT fk_projeto_desp FOREIGN KEY (fk_projeto) REFERENCES projeto (id_projeto) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_membro_desp FOREIGN KEY (fk_membro) REFERENCES membro (id_membro) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

ALTER TABLE despesa OWNER TO postgres;




CREATE TABLE recurso
(
  id_recurso serial NOT NULL,
  nome character varying(100) NOT NULL,
  descricao text,
  fk_projeto integer NOT NULL,
  fk_despesa integer NOT NULL,
  CONSTRAINT pk_recurso PRIMARY KEY (id_recurso),
  CONSTRAINT fk_despesa_recur FOREIGN KEY (fk_despesa) REFERENCES despesa (id_despesa) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_projeto_recur FOREIGN KEY (fk_projeto) REFERENCES projeto (id_projeto) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

ALTER TABLE recurso OWNER TO postgres;





CREATE TABLE cronograma
(
   id_cronograma serial NOT NULL, 
   data_inicio_projeto date NOT NULL, 
   data_limite_projeto date NOT NULL, 
   data_fim date, 
   fk_projeto integer NOT NULL, 
   CONSTRAINT pk_cronograma PRIMARY KEY (id_cronograma), 
   CONSTRAINT fk_projeto_crono FOREIGN KEY (fk_projeto) REFERENCES projeto (id_projeto) ON UPDATE NO ACTION ON DELETE NO ACTION
) 
WITH (
  OIDS = FALSE
)
;

ALTER TABLE cronograma OWNER TO postgres;




CREATE TABLE atividade
(
  id_atividade serial NOT NULL,
  data_inicio_atividade date NOT NULL,
  data_limite_atividade date NOT NULL,
  data_fim_atividade date,
  nome_atividade date NOT NULL,
  descricao_atividade text NOT NULL,
  fk_projeto integer NOT NULL,
  fk_cronograma integer NOT NULL,
  CONSTRAINT pk_atividade PRIMARY KEY (id_atividade),
  CONSTRAINT fk_cronograma_atividade FOREIGN KEY (fk_cronograma) REFERENCES cronograma (id_cronograma) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_projeto_atividade FOREIGN KEY (fk_projeto) REFERENCES projeto (id_projeto) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

ALTER TABLE atividade OWNER TO postgres;





CREATE TABLE nota
(
  id_nota serial NOT NULL,
  nota text NOT NULL,
  data_horario_envio timestamp,
  fk_atividade integer NOT NULL,
  CONSTRAINT pk_nota PRIMARY KEY (id_nota),
  CONSTRAINT pk_atividade_nota FOREIGN KEY (fk_atividade) REFERENCES atividade (id_atividade) ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

ALTER TABLE nota OWNER TO postgres;





CREATE TABLE administrador
(
  id_administrador serial NOT NULL,
  fk_usuario integer NOT NULL,
  CONSTRAINT pk_administrador PRIMARY KEY (id_administrador),
  CONSTRAINT pk_usuario_admin FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario) ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);

ALTER TABLE administrador OWNER TO postgres;





CREATE TABLE log_de_erro
(
  id_log_de_erro serial NOT NULL,
  tabela character varying(100) NOT NULL,
  descricao_erro text,
  CONSTRAINT pk_log_de_erro PRIMARY KEY (id_log_de_erro)
)
WITH (
  OIDS=FALSE
);

ALTER TABLE log_de_erro OWNER TO postgres;





CREATE TABLE cliente
(
  id_cliente serial NOT NULL,
  nome character varying(100) NOT NULL,
  fk_usuario integer NOT NULL,
  CONSTRAINT pk_cliente PRIMARY KEY (id_cliente),
  CONSTRAINT fk_usuario_cli FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario) ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE cliente OWNER TO postgres;



CREATE TABLE projeto_cliente
(
  id_projeto_cliente serial NOT NULL,
  fk_projeto integer NOT NULL,
  fk_cliente integer NOT NULL,
  CONSTRAINT pk_projeto_cliente PRIMARY KEY (id_projeto_cliente),
  CONSTRAINT fk_cliente_proj_cli FOREIGN KEY (fk_cliente) REFERENCES cliente (id_cliente) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION,
  CONSTRAINT fk_projeto_proj_cli FOREIGN KEY (fk_projeto) REFERENCES projeto (id_projeto) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE projeto_cliente OWNER TO postgres;




CREATE TABLE forma_de_contato
(
  id_forma_de_contato	 serial NOT NULL,
  tipo character varying(100) NOT NULL,
  valor character varying(100) NOT NULL,
  fk_usuario integer NOT NULL,
  CONSTRAINT pk_forma_de_contato PRIMARY KEY (id_forma_de_contato),
  CONSTRAINT fk_usuario_forma FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario) MATCH SIMPLE ON UPDATE NO ACTION ON DELETE NO ACTION
)
WITH (
  OIDS=FALSE
);
ALTER TABLE forma_de_contato OWNER TO postgres;



CREATE TABLE mensagem
(
   id_mensagem serial NOT NULL, 
   assunto character varying(100), 
   texto text NOT NULL, 
   CONSTRAINT pk_mensagem PRIMARY KEY (id_mensagem)
) 
WITH (
  OIDS = FALSE
)
;
ALTER TABLE mensagem OWNER TO postgres;



CREATE TABLE usuario_mensagem
(
   id_usuario_mensagem serial NOT NULL, 
   data_hora_envio date NOT NULL, 
   fk_destinatario integer NOT NULL, 
   fk_mensagem integer NOT NULL, 
   fk_usuario integer NOT NULL, 
   CONSTRAINT pk_usuario_mensagem PRIMARY KEY (id_usuario_mensagem), 
   CONSTRAINT fk_usuario_ger_mens FOREIGN KEY (fk_usuario) REFERENCES usuario (id_usuario) ON UPDATE NO ACTION ON DELETE NO ACTION, 
   CONSTRAINT fk_mensagem_ger_mens FOREIGN KEY (fk_mensagem) REFERENCES mensagem (id_mensagem) ON UPDATE NO ACTION ON DELETE NO ACTION
) 
WITH (
  OIDS = FALSE
)
;
ALTER TABLE usuario_mensagem OWNER TO postgres;




CREATE TABLE membro_atividade
(
   id_membro_atividade serial NOT NULL, 
   fk_membro integer NOT NULL, 
   fk_atividade integer NOT NULL, 
   CONSTRAINT pk_membro_atividade PRIMARY KEY (id_membro_atividade), 
   CONSTRAINT fk_membro_mem_ativ FOREIGN KEY (fk_membro) REFERENCES membro (id_membro) ON UPDATE NO ACTION ON DELETE NO ACTION, 
   CONSTRAINT fk_atividade_mem_ativ FOREIGN KEY (fk_atividade) REFERENCES atividade (id_atividade) ON UPDATE NO ACTION ON DELETE NO ACTION
) 
WITH (
  OIDS = FALSE
)
;
ALTER TABLE membro_atividade OWNER TO postgres;




CREATE TABLE projeto_membro
(
   id_projeto_membro serial NOT NULL, 
   fk_projeto integer NOT NULL, 
   fk_membro integer NOT NULL, 
   CONSTRAINT pk_projeto_membro PRIMARY KEY (id_projeto_membro), 
   CONSTRAINT fk_projeto_proj_mem FOREIGN KEY (fk_projeto) REFERENCES projeto (id_projeto) ON UPDATE NO ACTION ON DELETE NO ACTION, 
   CONSTRAINT fk_membro_proj_membro FOREIGN KEY (fk_membro) REFERENCES membro (id_membro) ON UPDATE NO ACTION ON DELETE NO ACTION
) 
WITH (
  OIDS = FALSE
)
;
ALTER TABLE projeto_membro OWNER TO postgres;
