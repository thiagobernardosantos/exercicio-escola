create database escola
use escola

create table tblAlocacao(
	cod_turma numeric(6) primary key,
	nome_sala varchar(10),
	dia date,
	inicio varchar(5),
	fim varchar(5),
)

create table tblAluno(
	cod_aluno numeric(6)primary key,
	nome_aluno varchar(30),
	endereço varchar(50),
	bairro varchar (20),
	cidade varchar(20),
	cep numeric(8),
	telefone varchar(20), 
	e_mail_aluno varchar(50)
)

create table tblContrato(
	cod_contrato numeric(6) primary key,
	nome_firma varchar (50),
	contato varchar(30),
	telefone_firma varchar(20),
	fax_firma varchar(20)
)

create table tblCurso(
	cod_curso numeric(6) primary key,
	nome_curso varchar(50),
	carga_horaria numeric(3),
	maximo_alunos numeric(2),
	minimo_alunos numeric(2),
	preco_turma dec(10,2),
	preco_aluno dec(10,2),
	equip_necessario varchar(80)
)

create table tblInscricao(
	cod_turma numeric(6) foreign key references tblAlocacao(cod_turma) ,
	cod_aluno numeric(6) foreign key references tblAluno(cod_aluno),
	valor_cobrado dec(10,2),
	cod_contrato numeric(6) foreign key references tblContrato(cod_contrato),
	conceito dec(4,2),
)

create table tblLaboratorio(
	nome_sala varchar(10) primary key,
	capacidade numeric(3),
	equip_disponivel varchar(80),
)

create table tblProfessor(
	cod_professor numeric(6) primary key,
	nome_professor varchar(30),
	area varchar(4),
	ramal numeric(4),
	e_mail_professor varchar(50),	
)

create table tblMinistra(
	cod_professor numeric(6) foreign key references tblProfessor(cod_professor),
	cod_curso numeric(6) foreign key references tblCurso(cod_curso),
)

insert tblAlocacao(cod_turma, nome_sala, dia, inicio, fim)
values ( 4, 'sala 1', '17/09/2022', '20/02', '10/12'),
       ( 5, 'sala 2', '17/09/2022', '20/02', '10/12'),
	   ( 6, 'sala 3', '17/09/2022', '20/02', '10/12')

insert tblAluno(cod_aluno, nome_aluno, endereço, bairro, cidade, cep, telefone, e_mail_aluno)
values(4, 'thiago', 'rua josefino','tijuca',' Rio de janeiro',11111111,' 00 11111-1111','thiago@gmail.com'),
	  (5, 'joao', 'rua fidelino',' vl. mariana',' Rio de janeiro',22222222, '00 22222-2222','joao@gmail.com'),
	  (6, 'maria', 'rua joaquim','tijuca', 'ponto dos volantes',33333333, '00 33333-3333','maria@gmail.com')

insert tblContrato(cod_contrato,nome_firma,contato, telefone_firma,fax_firma)
values(1,'globe', 'contato1',' 00 44444-4444',' 00 4444-4444'),
	  (2,'stb', 'contato2',' 00 55555-5555',' 00 5555-5555'),
	  (3,'retorc', 'contato3', '00 66666-6666',' 00 6666-6666')

insert tblCurso(cod_curso, nome_curso, carga_horaria, maximo_alunos,  minimo_alunos, preco_turma, preco_aluno, equip_necessario)
values(4,'desincolcimento de sistemas', 20, 30, 15, 300.00, 10.00, 'equip1'),
	  (5,'adm', 20, 30, 15, 500.00, 10.00, 'equip2'),
	  (6,'edi', 20, 30, 15, 800.00, 10.00,'equip3')

insert tblInscricao(cod_turma, cod_aluno, valor_cobrado, cod_contrato, conceito)
values(1,2,10.00, 1, 10.00),
	  (2,3,10.00, 2, 7.00),
	  (3,1,10.00, 3, 5.00)

insert tblLaboratorio (nome_sala, capacidade, equip_disponivel)
values('sala1', 30, 'equip1'),
	  ('sala2', 30, 'equip2'),
	  ('sala3', 30, 'equip3')

insert tblProfessor(cod_professor, nome_professor, area, ramal, e_mail_professor)
values(1,'jose', 'adm', 7777, 'jose@gmail.com'),
	  (2,'joana', 'bd', 8888, 'joana@gmail.com'),
	  (3,'angelo', 'pw', 9999, 'angelo@gmail.com')

insert tblMinistra(cod_professor,cod_curso)
values(1,4),
	  (2,5),
	  (3,6)

select * from tblAlocacao; --1 OK, CERTO!!
select nome_curso,preco_aluno from tblCurso ; --2 OK, CERTO!!
select nome_curso,preco_turma/minimo_alunos from tblCurso; --3 OK, CERTO!!
select valor_cobrado from tblInscricao; --4 OK, CERTO!!
select nome_aluno,  cidade ,bairro from tblAluno order by bairro; --5 OK, CERTO!!
select nome_aluno,  cidade ,bairro from tblAluno order by cidade, bairro; --6 OK, CERTO!!
select bairro from tblAluno; --7 OK, CERTO!!
select nome_aluno, bairro from tblAluno where bairro = 'tijuca'; --8 OK, CERTO!!
select nome_curso, preco_turma from tblCurso order by preco_turma desc; --9 OK, CERTO!!
select * from tblInscricao where conceito >= 7 and conceito <=10; --10 OK, CERTO!!
insert tblProfessor(cod_professor, nome_professor, area, ramal) values(6, 'thiago','EXTN',0000) --11 OK, CERTO!!

--IN - define uma lisa de valores como condição
select * from tblCurso where cod_curso in (2,5,9);

--BETWEEN - Define uma faixa de valores como condição
select * from tblInscricao where conceito between 7 and 10;

--IS NULL - identifica valores nulos dos atributos
select * from tblAluno where telefone is null;

--LIKE - serve para comparar strings
--% - 1 ou mais caracteres
--_ - 1 caracter
select * from tblProfessor where nome_professor like 'A%'
select * from tblProfessor where nome_professor like '%CE'
select * from tblProfessor where nome_professor like '_o__'
select * from tblProfessor where nome_professor like '[D-F]%'
select * from tblProfessor where nome_professor like '[^A-C]%'
select * from tblProfessor where nome_professor like '[A-C,F-G]%'

--UPDATE - atualiza valores de um campo
update tblCurso set nome_curso = 'ADS' where cod_curso in (5,8,9)
update tblCurso set preco_turma = preco_turma * 1.1 where nome_curso like 'edi'