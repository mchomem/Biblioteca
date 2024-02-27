declare @maxRows int = 600
declare @firstNames table  (id int identity(1, 1), [name] varchar(20))
declare @secondNames table (id int identity(1, 1), [name] varchar(20))
declare @thirdNames table  (id int identity(1, 1), [name] varchar(20))
declare @fullName varchar(100)
declare @ddds table(id int identity(1, 1), ddd int)

insert into @firstNames values
('Adroaldo')
, ('Andrius')
, ('Dan')
, ('Fausto')
, ('Guilherme')
, ('João')
, ('Julius')
, ('Lailton')
, ('Luciano')
, ('Ramon')

insert into @secondNames values
('Anderson')
, ('Ariovaldo')
, ('Diniz')
, ('Ferreira')
, ('Galop')
, ('Inácio')
, ('Jeffrey')
, ('Julian')
, ('Leal')
, ('Royal')

insert into @thirdNames values
('de Alcantara')
, ('Camões')
, ('da Joia')
, ('da Luz')
, ('de Dantes')
, ('d'' Farenguis')
, ('de Gilbraltar')
, ('de Jalvez')
, ('de Limões')
, ('de Ratz')

insert into @ddds values
  (11), (12), (13), (14), (15), (16), (17), (18), (19), (21)
, (22), (24), (27), (28), (31), (32), (33), (34), (35), (37)
, (38), (41), (42), (43), (44), (45), (46), (47), (48), (49)
, (51), (53), (54), (55), (61), (62), (63), (64), (65), (66)
, (67), (68), (69), (71), (73), (74), (75), (77), (79), (81)
, (82), (83), (84), (85), (86), (87), (88), (89), (91), (92)
, (93), (94), (95), (96), (97), (98), (99)



while @maxRows > 0
begin

	-- Gerar nome e sobrenome
	declare @firstName varchar(20) = (select [name] from @firstNames where id = floor(rand() * (select  count(1) from @firstNames) ) + 1)
	declare @secondName varchar(20) = (select [name] from @secondNames where id = floor(rand() * (select  count(1) from @secondNames) ) + 1)
	declare @thirdName varchar(20) = (select [name] from @thirdNames where id = floor(rand() * (select  count(1) from @thirdNames) ) + 1)
	
	-- Seleção de quantidade de sobrenome (2 ou 3 sobrenomes).
	if (floor(rand() * 10) + 1) > 5
	begin
		set @fullName = @firstName + ' ' + @secondName + ' ' + @thirdName
	end
	else
	begin
		set @fullName = @firstName + ' ' + @secondName
	end
	-- Gerar nome e sobrenome



	if exists(select * from Locatario where Nome = @fullName)
		continue

	set @maxRows = @maxRows - 1




	-- Gerar CPF fake.
	declare @maxDigitsDocument int = 11
	declare @document varchar(11) = ''

	while @maxDigitsDocument > 0
	begin
		set @maxDigitsDocument = @maxDigitsDocument - 1
		set @document = @document + cast(FLOOR(rand() * 10) as varchar)
	end
	-- Gerar CPF fake.



	-- Gerar número de telefone fake.
	declare @maxDigitsPhone int = 8
	declare @phone varchar(11) = '9' -- Sempre um número de celular.
	declare @ddd varchar(2) = ''

	while @maxDigitsPhone > 0
	begin
		set @maxDigitsPhone = @maxDigitsPhone - 1
		set @phone = @phone + cast(FLOOR(rand() * 10) as varchar)
	end

	select @ddd = d.ddd from @ddds d
	where
		id = floor(rand() * (select count(1) from @ddds)) + 1

	set @phone = @ddd + @phone
	-- Gerar número de telefone fake.




	-- Gerar e-mail fake.
	declare @email varchar(200) = ''
	declare @num int = floor(rand() * 30) + 1
	declare @divisor varchar(1) = ''
	/*Padrões:
		1.primeiros dois nomes divididos por "_"
		2.primeiros dois nomes divididos por "."
		3.sem divisão
		4.com número aleatório no final de 1 a 3 dígitos
	*/

	select
		@divisor =
		case
			when @num between 1 and 10 then '_'
			when @num between 11 and 20 then '.'
			when @num between 21 and 30 then ''
		end

	if (floor(rand() * 10) + 1) > 5
	begin
		set @email = lower(@firstName) + @divisor + lower(@secondName) + '@email.com'
	end
	else
	begin
		set @email = lower(@firstName) + @divisor + lower(@secondName) + cast(floor(rand() * 999) + 1 as varchar) + '@email.com'
	end
	-- Gerar e-mail fake.


	declare @ativo int = iif( (floor(rand() * 10) + 1) <= 8, 1 , 0) -- 80% de registros ativos.

	insert into Locatario
	select
		@fullName
		, @document
		, @phone
	    , @email
		, @ativo

	print 'Nome: ' + @fullName + ' CPF: ' + @document + ' Telefone: ' + @phone + ' e-mail: ' + @email + ' Ativo: ' + cast(@ativo as varchar)
end
go
