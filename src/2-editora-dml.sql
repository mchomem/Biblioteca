-- Inserir registros de Editoras Aleatórias

declare @firstName table (id int identity(1, 1), [name] varchar(20))
declare @secondName table (id int identity(1, 1), [name] varchar(20))
declare @typesCompany table (id int identity(1, 1), [name] varchar(20))
declare @maxRows int = 50
declare @fullName varchar(100)
declare @typeCompany varchar(10)
declare @rows int = 0

set nocount on

insert into @firstName values
('Alfarrábio')
, ('Cálamo')
, ('Diário')
, ('Escrito')
, ('Escritura')
, ('Folha')
, ('Impresso')
, ('Opúsculo')
, ('Pena')
, ('Pergaminho')

insert into @secondName values
('do Norte')
, ('do Poder')
, ('da Humanidade')
, ('de Ouro')
, ('do Mundo')
, ('do Povo')
, ('do Sul')
, ('Essencial')
, ('Livros')
, ('Livros de Cultura')

insert into @typesCompany values
('ME')
, ('EPP')
, ('LTDA')
, ('S/A')


while (@maxRows > 0)
begin

	set @fullName = 
		(select [name] from @firstName where id = floor(rand() * (select  count(1) from @firstName) ) + 1)
		+ ' ' + (select [name] from @secondName where id = floor(rand() * (select  count(1) from @secondName) ) + 1)

	set @typeCompany = (select [name] from @typesCompany where id = floor(rand() * (select  count(1) from @typesCompany) ) + 1)

	if exists(select RazaoSocial from Editora where RazaoSocial = @fullName)
		continue

	set @maxRows = @maxRows - 1
	set @rows = @rows + 1

	-- Gerar CNPJ fake.
	declare @maxDigits int = 14
	declare @document varchar(14) = ''

	while @maxDigits > 0
	begin
		set @maxDigits = @maxDigits - 1
		set @document = @document + cast(FLOOR(rand() * 10) as varchar)
	end

	insert into Editora(RazaoSocial, NomeFantasia, CNPJ)
	select
		@fullName + ' ' + @typeCompany
		, @fullName
		, @document

	print cast(@rows as varchar) + ' ' + @fullName

end
go
