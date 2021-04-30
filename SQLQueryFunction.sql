CREATE DATABASE Media
USE Media

go
CREATE FUNCTION MediaP(@p1 float, @p2 float, @p3 float, @p4 float)
RETURNS FLOAT
AS
BEGIN
	DECLARE @retorno float

	SET @retorno = (@p1+@p2+@p3+@p4)/4

	RETURN @retorno;
END

go

create FUNCTION Aprov(@media float)
RETURNS varchar(20)
AS
BEGIN
	DECLARE @aprov varchar(20)

	IF(@media >= 6)
	set @aprov = 'Aprovado'
	ELSE
	set @aprov = 'Reprovado'

	RETURN @aprov ;
END

go

select dbo.Aprov(dbo.mediap(6.0, 6.0, 6.0, 6.0))

--drop function Aprov;
--drop function MediaP;