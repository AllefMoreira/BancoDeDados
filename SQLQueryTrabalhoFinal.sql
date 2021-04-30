CREATE DATABASE Davi;
USE Davi;

--TABELAS 
create table prof(
id_prof int primary key,
nm_prof varchar(30),
);

create table disciplina(
id_curso int primary key,
nm_curso varchar(30) not null,
id_prof int not null, --chave estrangeira
constraint fk_id_prof foreign key(id_prof) references prof(id_prof),
);

create table aluno(
cd_aluno int Not null primary key,
nome_aluno Varchar(30) Not null,
id_curso int not null, --chave estrageira
constraint fk_id_curso foreign key (id_curso) references disciplina(id_curso),
);

create table notas(
cd_aluno int not null,
constraint fk_id_aluno foreign key(cd_aluno) references aluno(cd_aluno),
id_curso int not null,
constraint fk_id_curso2 foreign key(id_curso) references disciplina(id_curso),
nota1 float not null,
constraint chk_nota1 check (media>=0 and media<=10),
nota2 float not null,
constraint chk_nota2 check (media>=0 and media<=10),
nota3 float not null,
constraint chk_nota3 check (media>=0 and media<=10),
nota4 float not null,
constraint chk_nota4 check (media>=0 and media<=10),
media float not null,
);

Create table sistema_log(
acao char(40) not null,
nome_usuário varchar(40) not null,
nome_tabela varchar(40) not null,
qtd_acao int not null
);
--TABLEAS

CREATE FUNCTION MediaP(@nota1 float, @nota2 float, @nota3 float, @nota4 float)
RETURNS FLOAT
AS
BEGIN
 DECLARE @retorno float
 SET @retorno = (@nota1+@nota2+@nota3+@nota4)/4
 RETURN @retorno;
END
go
drop function MediaP


CREATE TRIGGER trg_notas
ON notas
after UPDATE, INSERT, DELETE

as
declare @acao char(20), @nome_usuário varchar(40), @nome_tabela varchar(20), @matricula int, @nome_aluno char(40), @updatecount int
if exists(SELECT * from inserted) and exists (SELECT * from deleted)
begin
    SET @acao = 'Update';
    SET @nome_usuário = SUSER_SNAME();
	SET @nome_tabela = 'notas';
    set @updatecount = (select count(acao) from sistema_log where acao = 'Update') +1;

	Insert into sistema_log(acao, nome_usuário, nome_tabela, qtd_acao) values(@acao,@nome_usuário,@nome_tabela, @updatecount);
end

If exists (Select * from inserted) and not exists(Select * from deleted)
begin
    SET @acao = 'Insert';
    SET @nome_usuário = SUSER_SNAME();
	SET @nome_tabela = 'notas';
    set @updatecount = (select count(acao) from sistema_log where acao = 'Insert') +1;

	Insert into sistema_log(acao, nome_usuário, nome_tabela, qtd_acao) values(@acao,@nome_usuário,@nome_tabela, @updatecount);
end

If exists(select * from deleted) and not exists(Select * from inserted)
begin 
    SET @acao = 'Delete';
    SET @nome_usuário = SUSER_SNAME();
	SET @nome_tabela = 'notas';
	set @updatecount = (select count(acao) from sistema_log where acao = 'Delete') +1 ;

	Insert into sistema_log(acao, nome_usuário, nome_tabela, qtd_acao) values(@acao,@nome_usuário,@nome_tabela, @updatecount);
END

CREATE TRIGGER trg_aluno
ON aluno
after UPDATE, INSERT, DELETE

as
declare @acao char(20), @nome_usuário varchar(40), @nome_tabela varchar(20), @matricula int, @nome_aluno char(40), @updatecount int
if exists(SELECT * from inserted) and exists (SELECT * from deleted)
begin
    SET @acao = 'Update';
    SET @nome_usuário = SUSER_SNAME();
	SET @nome_tabela = 'aluno';
    set @updatecount = (select count(acao) from sistema_log where acao = 'Update') +1;

	Insert into sistema_log(acao, nome_usuário, nome_tabela, qtd_acao) values(@acao,@nome_usuário,@nome_tabela, @updatecount);
	

end

If exists (Select * from inserted) and not exists(Select * from deleted)
begin
    SET @acao = 'Insert';
    SET @nome_usuário = SUSER_SNAME();
	SET @nome_tabela = 'aluno';
    set @updatecount = (select count(acao) from sistema_log where acao = 'Insert') +1;

	Insert into sistema_log(acao, nome_usuário, nome_tabela, qtd_acao) values(@acao,@nome_usuário,@nome_tabela, @updatecount);
end

If exists(select * from deleted) and not exists(Select * from inserted)
begin 
    SET @acao = 'Delete';
    SET @nome_usuário = SUSER_SNAME();
	SET @nome_tabela = 'aluno';
	set @updatecount = (select count(acao) from sistema_log where acao = 'Delete') +1 ;

	Insert into sistema_log(acao, nome_usuário, nome_tabela, qtd_acao) values(@acao,@nome_usuário,@nome_tabela, @updatecount);
END

ALTER TABLE notas DROP CONSTRAINT check_nota1;
ALTER TABLE notas DROP CONSTRAINT check_nota2;
ALTER TABLE notas DROP CONSTRAINT check_nota3;
ALTER TABLE notas DROP CONSTRAINT check_nota4;


Select * from aluno;
Select * from sistema_log;

--view notas
CREATE VIEW vwNotas AS
SELECT cd_aluno AS Prontuário,
 id_curso AS Matéria,
 nota1 as bimestre1,
 nota1 as bimestre2,
 nota3 as bimestre3,
 nota4 as bimestre4,
 media as Média
FROM notas
SELECT * FROM vwNotas

--procedure de drop das tabelas
create procedure prc_drop_alltables
as
drop trigger trg_notas
drop trigger trg_aluno
drop table notas
drop table aluno
drop table disciplina
drop table prof
drop table sistema_log
exec prc_drop_table

--procedures de insert
create procedure prc_insert_prof(@id_prof int,@nm_prof varchar(30))
as
insert into prof (id_prof,nm_prof) values (@id_prof,@nm_prof);
exec prc_insert_prof 1,'Davi'

create procedure prc_insert_disciplina(@id_curso int,@nm_curso varchar(30),@id_prof int)
as
insert into disciplina(id_curso,nm_curso,id_prof) values (@id_curso,@nm_curso,@id_prof);
exec prc_insert_disciplina 1,'Programação',1

create procedure prc_insert_aluno(@cd_aluno int,@nome_aluno varchar(30), @id_curso int)
as
INSERT INTO aluno (cd_aluno,nome_aluno,id_curso) values (@cd_aluno,@nome_aluno,@id_curso);
exec prc_insert_aluno 416962, 'Moura', 1

create procedure prc_insert_notas(@cd_aluno int,@id_curso int,@nota1 float,@nota2 float,@nota3 float,@nota4 float)
as
INSERT INTO notas (cd_aluno,id_curso,nota1,nota2,nota3,nota4,media) values (@cd_aluno,@id_curso,@nota1,@nota2,@nota3,@nota4,dbo.MediaP(6.0,5.0,8.0,6.0));
exec prc_insert_notas 416962,1,6.0,5.0,8.0,6.0

--procedures de update
create procedure update_prof (@id_prof int, @nm_prof varchar(30))
as
update prof set id_prof = @id_prof, nm_prof = @nm_prof where id_prof = @id_prof;
exec update_prof 1,'Davi'

create procedure update_disciplina(@id_curso int,@nm_curso varchar(30),@id_prof int)
as
update disciplina set id_curso = @id_curso,nm_curso=@nm_curso,id_prof=@id_prof where id_curso = @id_curso;
exec update_disciplina 1,'Banco de Dados',1

create procedure update_aluno(@cd_aluno int,@nome_aluno varchar(30), @id_curso int)
as
update aluno set cd_aluno= @cd_aluno,nome_aluno=@nome_aluno,id_curso=@id_curso where cd_aluno=@cd_aluno;
exec update_aluno 400289, 'Alisson', 1

create procedure update_notas(@cd_aluno int,@id_curso int,@nota1 float,@nota2 float,@nota3 float,@nota4 float)
as
update notas set cd_aluno=@cd_aluno,id_curso=@id_curso,nota1=@nota1,nota2=@nota2,nota3=@nota3,nota4=@nota4 where cd_aluno=@cd_aluno,id_curso=@id_curso; 
exec update_notas 400289,1,9.0,10.0,8.0,7.0


--procedures de delete
create procedure delete_prof (@id_prof int)
as
delete from prof where id_prof = @id_prof;
exec delete_prof 1

create procedure delete_disciplina (@id_curso int)
as
delete from disciplina where id_curso = @id_curso;
exec delete_disciplina 1

create procedure delete_aluno (@cd_aluno int)
as
delete from aluno where cd_aluno = @cd_aluno;
exec delete_aluno 1

create procedure delete_notas (@cd_aluno int,@id_curso int)
as
delete from notas where cd_aluno = @cd_aluno and id_curso=@id_curso;
exec delete_prof 1,1


-- role/grant/revoke
CREATE ROLE ADM AUTHORIZATION db_securityadmin;  
GO
GRANT SELECT,DELETE,UPDATE ON notas TO ADM;
revoke SELECT,DELETE,UPDATE ON notas TO ADM;
