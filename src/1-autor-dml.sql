-- Inserir Nomes de autores aleatórios.

declare @maxRows int = 100
declare @firstName table  (id int identity(1, 1), [name] varchar(20))
declare @secondName table (id int identity(1, 1), [name] varchar(20))
declare @thirdName table  (id int identity(1, 1), [name] varchar(20))
declare @fullName varchar(100)
declare @rows int = 0

set nocount on

insert into @firstName values
('Andre')
, ('Adriano')
, ('Daniel')
, ('Fernando')
, ('Gabrie')
, ('João')
, ('Julio')
, ('Leandro')
, ('Leonardo')
, ('Rafael')

insert into @secondName values
('Ariovaldo')
, ('Diniz')
, ('Julian')
, ('Jeffrey')
, ('Leal')


insert into @thirdName values
('da Rocha')
, ('da Silva')
, ('da Luz')



while (@maxRows > 0)
begin
	set @fullName = 
		(select [name] from @firstName where id = floor(rand() * (select  count(1) from @firstName) ) + 1)
		+ ' ' + (select [name] from @secondName where id = floor(rand() * (select  count(1) from @secondName) ) + 1)
		+ ' ' + (select [name] from @thirdName where id = floor(rand() * (select  count(1) from @thirdName) ) + 1)

	if exists(select Nome from Autor where Nome = @fullName)
		continue

	set @maxRows = @maxRows - 1
	set @rows = @rows + 1

	insert into Autor(Nome)
	select @fullName

	print cast(@rows as varchar) + ' ' + @fullName
end
go
