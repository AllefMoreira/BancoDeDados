CREATE DATABASE Apuração;
USE Apuração;

--REGIAO!!!!!!!!
CREATE TABLE Regiao(
cd_regiao int NOT NULL,
nome_regiao char(20) NOT NULL,
primary key (cd_regiao)
);
-- SELECT
create procedure prc_sel_Regiao
as
select * from Regiao;
exec prc_sel_Regiao
-- INSERT
create procedure prc_ins_regiao (@cd_regiao int, @nome_regiao char(20))
as
insert into Regiao values (@cd_regiao, @nome_regiao);
exec prc_ins_regiao 1, 'São Paulo'
-- UPDATE
create procedure prc_update_regiao (@cd_regiao int, @nome_regiao varchar(20))
as
update Regiao
set cd_regiao = @cd_regiao, nome_regiao = @nome_regiao where cd_regiao =
@cd_regiao;
-- DELETE
create procedure prc_delete_regiao (@cd_regiao int)
as
delete from Regiao where cd_regiao = @cd_regiao;
exec prc_delete_regiao 1

--SECAO!!!!!!
Create Table Secao(
cd_regiao int NOT NULL,
cd_secao int Not Null,
primary key (cd_secao),
constraint fk_regiao foreign key (cd_regiao) references Regiao (cd_regiao)
);
-- SELECT
create procedure prc_sel_secao
as
select * from Secao;
exec prc_sel_secao
-- INSERT
create procedure prc_ins_secao (@cd_regiao int, @cd_secao int)
as
insert into Secao values (@cd_regiao, @cd_secao);
exec prc_ins_secao 1, 1
-- UPDATE
create procedure prc_update_secao (@cd_regiao int, @cd_secao varchar(20))
as
update Secao
set cd_regiao = @cd_regiao, cd_secao = @cd_secao where cd_regiao =
@cd_regiao;
-- DELETE
create procedure prc_delete_secao (@cd_secao int)
as
delete from Secao where cd_secao = @cd_secao;
exec prc_delete_secao 1

--ZONA!!!!!!!!!!!!
Create Table Zona(
cd_secao int Not Null,
cd_zona int NOT NULL,
primary key (cd_zona),
constraint fk_secao foreign key (cd_secao) references Secao (cd_secao)
);
-- SELECT
create procedure prc_sel_zona
as
select * from Zona;
exec prc_sel_zona
-- INSERT
create procedure prc_ins_zona (@cd_secao int, @cd_zona int)
as
insert into Zona values (@cd_secao, @cd_zona);
exec prc_ins_zona 1, 1
-- UPDATE
create procedure prc_update_zona (@cd_secao int, @cd_zona varchar(20))
as
update Zona
set cd_secao = @cd_secao, cd_zona = @cd_zona where cd_zona = @cd_zona;
-- DELETE
create procedure prc_delete_zona (@cd_zona int)
as
delete from Zona where cd_zona = @cd_zona;
exec prc_delete_zona 1

--PARTIDO!!!!!!!!
CREATE TABLE Partido(
cd_partido int NOT NULL,
partido_nome varchar(20) NOT NULL,
Primary Key (cd_partido)
);
-- SELECT
create procedure prc_sel_partido
as
select * from Partido;
exec prc_sel_partido
-- INSERT
create procedure prc_ins_partido (@cd_partido int, @partido_nome varchar(20))
as
insert into Partido values (@cd_partido, @partido_nome);
exec prc_ins_partido 1, 'PTdoB'
-- UPDATE
create procedure prc_update_partido (@cd_partido int, @partido_nome varchar(20))
as
update Partido
set cd_partido = @cd_partido, partido_nome = @partido_nome where cd_partido =
@cd_partido;
-- DELETE
create procedure prc_delete_partido (@cd_partido int)
as
delete from Partido where cd_partido = @cd_partido;
exec prc_delete_partido 1

--CANDIDATO!!!!!!!
CREATE TABLE Candidato(
cd_regiao int Not Null,
cd_candidato int NOT NULL,
cd_partido int Not null,
cand_nome char(20) NOT NULL,
primary key (cd_candidato),
constraint fk_candi_partido foreign key (cd_partido) references Partido (cd_partido),
constraint fk_candi_regiao foreign key (cd_regiao) references Regiao (cd_regiao)
);
-- SELECT
create procedure prc_sel_candidato
as
select * from Candidato;
exec prc_sel_candidato
-- INSERT
create procedure prc_ins_candidato (@cd_regiao int, @cd_candidato int,
@cd_partido int, @cand_nome char(20))
as
insert into Candidato values (@cd_regiao, @cd_candidato, @cd_partido,
@cand_nome);
exec prc_ins_candidato 1, 1, 1, 'Mouro'
-- UPDATE
create procedure prc_update_candidato (@cd_regiao int, @cd_candidato int,
@cd_partido int, @cand_nome char(20))
as
update Candidato
set cd_regiao = @cd_regiao, cd_candidato = @cd_candidato, @cd_partido =
@cd_partido, cand_nome = @cand_nome where cd_candidato = @cd_candidato;
-- DELETE
create procedure prc_delete_candidato (@cd_candidato int)
as
delete from Candidato where cd_candidato = @cd_candidato;
exec prc_delete_candidato 1

--VOTOS!!!!!!!!
Create table Votos (
cd_candidato int NOT NULL,
qtd_votos int NOT NULL,
primary key (qtd_votos),
constraint fk_votos_candi foreign key (cd_candidato) references Candidato
(cd_candidato)
);
-- SELECT
create procedure prc_sel_votos
as
select * from Votos;
exec prc_sel_votos
-- INSERT
create procedure prc_ins_votos (@cd_candidato int, @qtd_votos int)
as
insert into Votos values (@cd_candidato, @qtd_votos);
exec prc_ins_votos 1, 1

-- UPDATE
create procedure prc_update_votos (@cd_candidato int, @qtd_votos varchar(20))
as
update Votos
set cd_candidato = @cd_candidato, qtd_votos = @qtd_votos where cd_candidato =
@cd_candidato;
-- DELETE
create procedure prc_delete_votos (@cd_candidato int)
as
delete from Votos where cd_candidato = @cd_candidato;
exec prc_delete_votos 1

--ELEITOR!!!!!!
CREATE TABLE Eleitor(
titulo int Not Null,
cd_regiao int NOT NULL,
cd_secao int NOT NULL,
cd_zona int NOT NULL,
cd_candidato int not null,
Primary Key (titulo),
constraint fk_elei_candi foreign key (cd_candidato) references Candidato
(cd_candidato),
constraint fk_elei_regiao foreign key (cd_regiao) references Regiao (cd_regiao),
constraint fk_elei_secao foreign key (cd_secao) references Secao (cd_secao),
constraint fk_elei_zona foreign key (cd_zona) references Zona (cd_zona)
);
-- SELECT
create procedure prc_sel_eleitor
as
select * from Eleitor;
exec prc_sel_eleitor
-- INSERT
create procedure prc_ins_eleitor (@titulo int, @cd_regiao int, @cd_secao int,
@cd_zona int, @cd_candidato int)
as
insert into Eleitor values (@titulo, @cd_regiao, @cd_secao, @cd_zona,
@cd_candidato);
exec prc_ins_eleitor 1, 1, 1, 1, 1
-- UPDATE
create procedure prc_update_eleitor (@titulo int, @cd_regiao int, @cd_secao int,
@cd_zona int, @cd_candidato int)
as
update Eleitor
set titulo = @titulo, cd_regiao = @cd_regiao, cd_secao = @cd_secao, cd_zona =
@cd_zona, cd_candidato = @cd_candidato where titulo = @titulo;

-- DELETE
create procedure prc_delete_eleitor (@cd_secao int)
as
delete from Eleitor where cd_secao = @cd_secao;
exec prc_delete_eleitor 1

--Insert into Regiao(cd_regiao, nome_regiao) Values(1, 'São Vicente');
--Insert into Secao(cd_regiao, cd_secao) Values(1, 002);
--Insert into Zona(cd_secao, cd_zona) Values(002, 174);
--Insert into Partido(cd_partido, partido_nome) Values (1, 'DSA');
--Insert into Candidato(cd_candidato, cand_nome, cd_regiao, cd_partido)Values (1,'Marcos', 1, 1);
--Insert into Votos(cd_candidato, qtd_votos) Values (1, 331);
--Insert into Eleitor(titulo, cd_regiao, cd_secao, cd_zona, cd_candidato) Values(1111, 1, 002, 174, 1);

--SELECT * FROM Regiao;
--SELECT * FROM Secao;
--SELECT * FROM Zona;
--SELECT * FROM Partido;
--SELECT * FROM Candidato;
--SELECT * FROM Votos;
--SELECT * FROM Eleitor;

--Drop Table Eleitor;
--Drop Table Votos;
--Drop Table Candidato;
--Drop Table Partido;
--Drop Table Zona;
--Drop Table Secao;
--Drop Table Regiao;
--Drop Database Apuração;