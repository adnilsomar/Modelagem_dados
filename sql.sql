CREATE SCHEMA dimensional_clinica_medica;

CREATE  TABLE dimensional_clinica_medica.dim_actividade_medica ( 
	id_atividade         VARCHAR(20)  NOT NULL  PRIMARY KEY,
	tipo_tividade        VARCHAR(20)       
 );

CREATE  TABLE dimensional_clinica_medica.dim_medicos ( 
	id_medico            INT  NOT NULL     PRIMARY KEY,
	nome                 VARCHAR(50)       ,
	especialidade        VARCHAR(20)       
 ) ;

CREATE  TABLE dimensional_clinica_medica.dim_pacientes ( 
	id_paciente          VARCHAR(20)  NOT NULL     PRIMARY KEY,
	nome                 VARCHAR(50)       ,
	sexo                 CHAR(1)       
 );

CREATE  TABLE dimensional_clinica_medica.dim_tempo ( 
	id_data_hota         DATETIME  NOT NULL     PRIMARY KEY,
	dia                  INT       ,
	mes                  INT       ,
	ano                  INT       
 );

CREATE  TABLE dimensional_clinica_medica.fato_atividae_medica ( 
	id_atividade         VARCHAR(20)       ,
	id_paciente          VARCHAR(20)       ,
	id_medico            INT       ,
	id_data_hora         DATETIME       ,
	outros_detahlhes    VARCHAR(100)       
 );

ALTER TABLE dimensional_clinica_medica.fato_atividae_medica ADD CONSTRAINT fk_fato_atividae_medica_dim_actividade_medica FOREIGN KEY ( id_atividade ) REFERENCES dimensional_clinica_medica.dim_actividade_medica( id_atividade ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE dimensional_clinica_medica.fato_atividae_medica ADD CONSTRAINT fk_fato_atividae_medica_dim_pacientes FOREIGN KEY ( id_paciente ) REFERENCES dimensional_clinica_medica.dim_pacientes( id_paciente ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE dimensional_clinica_medica.fato_atividae_medica ADD CONSTRAINT fk_fato_atividae_medica_dim_medicos FOREIGN KEY ( id_medico ) REFERENCES dimensional_clinica_medica.dim_medicos( id_medico ) ON DELETE CASCADE ON UPDATE CASCADE;

ALTER TABLE dimensional_clinica_medica.fato_atividae_medica ADD CONSTRAINT fk_fato_atividae_medica_dim_tempo FOREIGN KEY ( id_data_hora ) REFERENCES dimensional_clinica_medica.dim_tempo( id_data_hota ) ON DELETE CASCADE ON UPDATE CASCADE;

