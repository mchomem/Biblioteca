-- Inserir Autores para Livros.

declare @maxRows int = 100

declare @livros table (id int identity (1, 1), livroID int)
declare @autores table (id int identity (1, 1), autorID int)

insert into @livros
select LivroID from Livro

insert into @autores
select AutorID from Autor

while @maxRows > 0
begin
	set @maxRows = @maxRows - 1

	declare @livroID int = (select livroId from @livros where id = floor(rand() * (select count(1) from @livros) + 1))
	declare @autorID int = (select autorId from @autores where id = floor(rand() * (select count(1) from @autores) + 1))

	insert into LivroAutor (LivroID, AutorID)
	values(@livroID, @autorID)

	print 'LivroID: ' + cast(@livroID as varchar) + ' AutorID: ' + cast(@autorID as varchar)
end
go
