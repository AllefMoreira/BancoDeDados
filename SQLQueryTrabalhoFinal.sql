CREATE DATABASE Davi;
USE Davi;

create table notas(
id_matricula varchar(7) primary key,
cd_disciplina int,
media decimal not null,
constraint chk_media check (media>=0 and media<=10)
);

create table aluno(
cd_aluno varchar(7) Not null primary key,
nome_aluno Varchar(30) Not null,
media_aluno decimal not null
constraint fk_media foreign key (cd_aluno) references notas (id_matricula)
);

Create table sistema_log(
acao char(40) not null,
nome_usuário varchar(40) not null,
nome_tabela varchar(40) not null,
qtd_acao int not null
)

CREATE TRIGGER trg_notas
ON notas
after UPDATE, INSERT, DELETE

as
declare @acao char(20), @nome_usuário varchar(40), @nome_tabela varchar(20), @matricula int, @nome_aluno char(40), @updatecount int
if exists(SELECT * from inserted) and exists (SELECT * from deleted)
begin
    SET @acao = 'Update';
    SET @nome_usuário = Current_user;
	SET @nome_tabela = 'notas';
    set @updatecount = (select count(acao) from sistema_log where acao = 'Update') +1;

	Insert into sistema_log(acao, nome_usuário, nome_tabela, qtd_acao) values(@acao,@nome_usuário,@nome_tabela, @updatecount);
end

If exists (Select * from inserted) and not exists(Select * from deleted)
begin
    SET @acao = 'Insert';
    SET @nome_usuário = Current_user;
	SET @nome_tabela = 'notas';
    set @updatecount = (select count(acao) from sistema_log where acao = 'Insert') +1;

	Insert into sistema_log(acao, nome_usuário, nome_tabela, qtd_acao) values(@acao,@nome_usuário,@nome_tabela, @updatecount);
end

If exists(select * from deleted) and not exists(Select * from inserted)
begin 
    SET @acao = 'Delete';
    SET @nome_usuário = Current_user;
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
    SET @nome_usuário = Current_user;
	SET @nome_tabela = 'aluno';
    set @updatecount = (select count(acao) from sistema_log where acao = 'Update') +1;

	Insert into sistema_log(acao, nome_usuário, nome_tabela, qtd_acao) values(@acao,@nome_usuário,@nome_tabela, @updatecount);
	

end

If exists (Select * from inserted) and not exists(Select * from deleted)
begin
    SET @acao = 'Insert';
    SET @nome_usuário = Current_user;
	SET @nome_tabela = 'aluno';
    set @updatecount = (select count(acao) from sistema_log where acao = 'Insert') +1;

	Insert into sistema_log(acao, nome_usuário, nome_tabela, qtd_acao) values(@acao,@nome_usuário,@nome_tabela, @updatecount);
end

If exists(select * from deleted) and not exists(Select * from inserted)
begin 
    SET @acao = 'Delete';
    SET @nome_usuário = Current_user;
	SET @nome_tabela = 'aluno';
	set @updatecount = (select count(acao) from sistema_log where acao = 'Delete') +1 ;

	Insert into sistema_log(acao, nome_usuário, nome_tabela, qtd_acao) values(@acao,@nome_usuário,@nome_tabela, @updatecount);
END

ALTER TABLE notas
DROP CONSTRAINT check_media;INSERT INTO notas (id_matricula,cd_disciplina,media) values (416962, 3, 7);INSERT INTO aluno (cd_aluno,nome_aluno,media_aluno) values (416962, 'Moura', 7);Select * from notas;Select * from aluno;
Select * from sistema_log;create procedure prc_drop_table
as
drop trigger trg_notas
drop trigger trg_aluno

drop table aluno
drop table notas
drop table sistema_log

exec prc_drop_table
