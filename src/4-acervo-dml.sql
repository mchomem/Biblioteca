declare @maxRows int = 500
declare @livros table (id int identity(1, 1), LivroID int)

insert into @livros
select LivroID from Livro

while @maxRows > 0
begin
	set @maxRows = @maxRows - 1

	declare @livroID int = 0
	declare @quantidade int = floor(rand() * 10) + 1
	declare @dataEntrada datetime = getdate()

	set @livroID = 
		(select
			LivroID
		from
			@livros
		where
			id = floor(rand() * (select count(1) from @livros) + 1))

	declare @day int = floor(rand() * 28) + 1
	declare @month int = floor(rand() * 12) + 1
	declare @year int = floor(rand() * 24) + 2000
	declare @hour int = floor(rand() * 23)
	declare @minute int = floor(rand() * 59)
	declare @second int = floor(rand() * 59)

	set @dataEntrada =
		cast(@year as varchar)
		+ '-' + right(replicate('0',2) + convert(VARCHAR, @month), 2) 
		+ '-' + right(replicate('0',2) + convert(VARCHAR, @day), 2) 
		+ ' ' + right(replicate('0',2) + convert(VARCHAR, @hour), 2) 
		+ ':' + right(replicate('0',2) + convert(VARCHAR, @minute), 2) 
		+ ':' + right(replicate('0',2) + convert(VARCHAR, @second), 2)
	
	insert into Acervo(LivroID, Quantidade, DataEntrada)
	select
		@livroID
		, @quantidade
		, @dataEntrada

	print 'LivroID: ' + cast(@livroID as varchar)
		+ ' Quantidade: ' + cast(@quantidade as varchar)
		+ ' Data Entrada: ' + cast(@dataEntrada as varchar)
end
go
