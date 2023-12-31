<h1 align="center"> <img src="https://github.com/adnilsomar/Modelagem-dados-E1/blob/main/assets/images__2_-removebg-preview.png" width=30/> Modelagem de dados </h1>

## Caso: Clínica Médica

## Objetivo:
Criar um modelo lógico dimensional para poder responder as tarefas de negocio do setor hospitalario, a partir do modelo logico transacional.

## Introdução:

A Clínica Médica é uma entidade fictícia estabelecida com o propósito de demonstrar a transformação de dados transacionais em informações estratégicas por meio da implementação de um modelo dimensional. Este exercício teve como ponto de partida um modelo transacional e evoluiu para conceber um modelo dimensional robusto, capaz de enfrentar e solucionar diversas questões de negócios.

O modelo dimensional é uma abordagem sofisticada e eficaz de modelagem de dados que se destaca no campo da Business Intelligence (BI) e análise de dados. Nesse contexto, os dados são organizados em duas categorias principais de tabelas: tabelas de fatos e tabelas de dimensões.

As tabelas de fatos armazenam medidas quantitativas, como faturamento, número de consultas, ou outras métricas relevantes. Elas se relacionam com as tabelas de dimensões por meio de chaves estrangeiras.

Já as tabelas de dimensões contêm informações descritivas e contextuais que enriquecem os dados nas tabelas de fatos. Elas podem incluir detalhes sobre pacientes, médicos, procedimentos médicos, datas e outras dimensões relevantes para a clínica.

Por meio da implementação do modelo dimensional, a Clínica Médica estará melhor equipada para analisar seus dados transacionais de maneira mais eficiente. Isso permitirá que os tomadores de decisão gerem relatórios e análises de negócios de alta qualidade, possibilitando a obtenção de insights estratégicos essenciais para aprimorar as operações e o sucesso da clínica. O modelo dimensional representa uma ferramenta valiosa para a transformação de dados em informações estratégicas sólidas, promovendo decisões informadas e baseadas em dados.


## Modelo transacional Clínica Médica
 <img src="https://github.com/adnilsomar/Modelagem_dados/blob/main/modelagem_trans_clinica.png" width=2000 height=auto/>

## Relações:

* Um paciente pode ter várias consultas, históricos médicos, receitas e exames.
* Um médico pode estar envolvido em várias consultas, históricos médicos, receitas e exames.
* Cada consulta, histórico médico, receita e exame pertence a um único paciente e médico.

## Tarefas de negocio:

##### **:green_circle: Quantas atividades médicas foram realizadas para cada gênero de pacientes, separadas por especialidade de médicos?**

##### **:green_circle: Qual é a média de atividades médicas em que cada médico participou por mês no último ano?**

##### **:green_circle: Como as atividades médicas estão distribuídas ao longo dos meses do ano?**



## Criação do Modelo Lógico Dimensional
 <img src="https://github.com/adnilsomar/Modelagem_dados/blob/main/modelagem_dim_clinica.png" width=2000 height=auto/>

Para a construção deste modelo, identificamos as dimensões que serão pertinentes para responder às perguntas. Além disso, identificamos os eventos (fatos) que desejamos analisar com base nas questões propostas. Também abordamos aspectos como granularidade, hierarquia e relações para aprimorar a compreensão e a representação dos dados. 

 ## Criação do modelo físico

Após a criação do modelo lógico dimensional, o próximo passo consistiu na implementação do modelo físico por meio da linguagem SQL com MySQL.

```
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

```

## Respondendo as tarefas de negocio

### Aqui estão alguns exemplos de como as perguntas poderiam ser respondidas usando combinações de tabelas:



1. Quantas atividades médicas foram realizadas para cada gênero de pacientes, separadas por especialidade de médicos?
   Para responder a essa pergunta, pode se utilizar a tabela de fatos de atividades médicas  para contar o número de atividades. Além disso, pode se combinar as informações das dimensões de pacientes (dim_pacientes) e médicos (dim_medicos) para obter o gênero do paciente e a especialidade do médico.

2. Qual é a média de atividades médicas em que cada médico participou por mês no último ano?
   Para abordar essa questão, pode se usar a tabela de fatos de atividades médicas (fato_atividade_medica) para contar as atividades. Combinar as informações das dimensões de médicos (dim_medicos) e tempo (dim_tempo) para filtrar as atividades pelo último ano. Em seguida, agrupar por médico e mês, e calcule a média de atividades.

3. Como as atividades médicas estão distribuídas ao longo dos meses do ano?
Para responder a essa pergunta, pode se utilizar a tabela de fatos de atividades médicas (fato_atividade_medica) para contar as atividades. Combinar as informações da dimensão de tempo (dim_tempo) para obter os meses do ano. Em seguida, agrupar por mês e ano para visualizar a distribuição das atividades médicas ao longo do tempo.

## :computer: Tecnologias usadas

<div>
  
  <img src="https://img.shields.io/badge/MySQL-00000F?style=for-the-badge&logo=mysql&logoColor=white" alt="Mysql"/>
  < <img src="https://img.shields.io/badge/DbSchema-00000F?style=for-the-badge&logo=mysql&logoColor=white" alt="DbSchema"/>
<div/>
