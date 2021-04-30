Create DataBase Alunos
Use Alunos;

Create table aluno (
matricula int not null,
nome_aluno char(40) not null

primary key (matricula)
) 

Create table aluno_log(
acao char(40) not null,
nome_usuário varchar(40) not null,
nome_tabela varchar(40) not null,
qtd_acao int not null
)

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
    set @updatecount = (select count(acao) from aluno_log where acao = 'Update') +1;

	Insert into aluno_log(acao, nome_usuário, nome_tabela, qtd_acao) values(@acao,@nome_usuário,@nome_tabela, @updatecount);
	

end

If exists (Select * from inserted) and not exists(Select * from deleted)
begin
    SET @acao = 'Insert';
    SET @nome_usuário = Current_user;
	SET @nome_tabela = 'aluno';
    set @updatecount = (select count(acao) from aluno_log where acao = 'Insert') +1;

	Insert into aluno_log(acao, nome_usuário, nome_tabela, qtd_acao) values(@acao,@nome_usuário,@nome_tabela, @updatecount);
end

If exists(select * from deleted) and not exists(Select * from inserted)
begin 
    SET @acao = 'Delete';
    SET @nome_usuário = Current_user;
	SET @nome_tabela = 'aluno';
	set @updatecount = (select count(acao) from aluno_log where acao = 'Delete') +1 ;

	Insert into aluno_log(acao, nome_usuário, nome_tabela, qtd_acao) values(@acao,@nome_usuário,@nome_tabela, @updatecount);
end


Insert into aluno(matricula, nome_aluno) Values(2, 'aa');

delete from aluno where matricula = 4;

Update aluno set nome_aluno = 'Anderson' where matricula = '2';

Select * from aluno;
Select * from aluno_log;

drop trigger trg_aluno;

drop table aluno;
drop table aluno_log;


