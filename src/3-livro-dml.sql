-- Inserir registros de livros aleatórios.

declare @firstName table (id int identity(1, 1), [name] varchar(20))
declare @secondName table (id int identity(1, 1), [name] varchar(20))
declare @thirdName table (id int identity(1, 1), [name] varchar(20))
declare @editoras table (id int identity(1, 1), EditoraID int)
declare @maxRows int = 100
declare @fullName varchar(100)
declare @rows int = 0

set nocount on

insert into @firstName values
('As aventuras')
, ('Batalhas')
, ('Contos')
, ('Diário')
, ('História')
, ('Lamentos')
, ('Obelisco')
, ('Poemas')
, ('Raizes')
, ('Romance')

insert into @secondName values
('da Mulher')
, ('de Inverno')
, ('de Verão')
, ('do Druida')
, ('do Homem')
, ('do Mundo')
, ('de Verão')
, ('do Cavaleiro')
, ('do Norte')
, ('do Sul')
, ('da Raposa')

insert into @thirdName values
('Fantamas')
, ('de Outra Dimensão')
, ('Valente')
, ('Verde')
, ('Voraz')
, ('Noturno')
, ('de Ouro')
, ('de Diamante')
, ('Escarlate')
, ('Selvagem')

insert into @editoras (EditoraID)
select EditoraID from Editora



while (@maxRows > 0)
begin
	set @fullName = 
		(select [name] from @firstName where id = floor(rand() * (select  count(1) from @firstName) ) + 1)
		+ ' ' + (select [name] from @secondName where id = floor(rand() * (select  count(1) from @secondName) ) + 1)
		+ ' ' + (select [name] from @thirdName where id = floor(rand() * (select  count(1) from @thirdName) ) + 1)

	if exists(select Titulo from Livro where Titulo = @fullName)
		continue

	set @maxRows = @maxRows - 1
	set @rows = @rows + 1

	-- Gerar ISBN fake.
	declare @maxDigits int = 13
	declare @document varchar(13) = ''

	while @maxDigits > 0
	begin
		set @maxDigits = @maxDigits - 1
		set @document = @document + cast(floor(rand() * 10) as varchar)
	end

	declare @ano int = floor(rand() * 50) + 1970
	declare @EditoraID int = floor(rand() * (select  count(1) from @editoras) + 1)

	insert into Livro(Titulo, ISBN, Ano, Edicao, EditoraID)
	select
		@fullName
		, @document
		, @ano
		, floor(rand() * 10) + 1
		, (select EditoraID from @editoras where id = @EditoraID)

	print cast(@rows as varchar) + ' Título: ' + @fullName + ' ISBN: ' + @document +  ' Ano: ' + cast(@ano as varchar) + ' EditoraID: ' + cast(@EditoraID as varchar)
end
go
