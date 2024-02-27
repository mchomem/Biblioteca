create table Autor
(
	AutorID int identity(1,1) not null
	, Nome varchar(100) not null
)
go

alter table Autor add constraint PK_Autor primary key (AutorID)
go




create table Editora
(
	EditoraID int identity(1,1) not null
	, RazaoSocial varchar(100) not null
	, NomeFantasia varchar(100) null
	, CNPJ varchar(16) null,
)
go

alter table Editora add constraint PK_Editora primary key (EditoraID)
go

alter table Editora add constraint UK_Editora_RazaoSocial_CNPJ unique(RazaoSocial, CNPJ)
go




create table Livro
(
	LivroID int identity(1,1) not null
	, EditoraID int not null
	, Titulo varchar(100) not null
	, ISBN varchar(20) not null
	, Ano int not null
	, Edicao int not null
	, Capa varbinary(max) null
)
go

alter table Livro add constraint PK_Livro primary key(LivroID)
go

alter table Livro add constraint FK_Livro_editora foreign key (EditoraID) references Editora(EditoraID)
go




create table Acervo
(
	AcervoID int identity(1,1) not null
	, LivroID int not null
	, Quantidade int not null
	, DataEntrada datetime not null
)
go

alter table Acervo add constraint PK_Acervo primary key (AcervoID)
go

alter table Acervo add constraint FK_Acervo_Livro foreign key (LivroID) references Livro(LivroID)
go

alter table Acervo add constraint DF_Acervo_Quantidade default 0 for Quantidade
go



create table LivroAutor
(
	LivroID int not null
	, AutorID int not null
)
go

alter table LivroAutor add constraint PK_LivroAutor primary key(LivroID, AutorID)
go

alter table LivroAutor add constraint FK_LivroAutor_Livro foreign key (LivroID) references Livro (LivroID)
go

alter table LivroAutor add constraint FK_LivroAutor_Autor foreign key (AutorID) references Autor (AutorID)
go



create table Locatario
(
	LocatarioID int identity(1,1) not null
	, Nome varchar(100) not null
	, CPF varchar(11) not null
	, Telefone varchar(11) not null
	, Email varchar(200) not null
	, Ativo bit not null
)
go

alter table Locatario add constraint PK_Locatario primary key(LocatarioID)
go

alter table Locatario add constraint UK_Locatario_Nome unique(Nome)
go

alter table Locatario add constraint UK_Locatario_Email unique(Email)
go



create table Locacao
(
	LocacaoID int identity(1,1) not null
	, LocatarioID int not null
)
go

alter table Locacao add constraint PK_Locacao primary key(LocacaoID)
go

alter table Locacao add constraint FK_Locacao_Locatario foreign key (LocatarioID) references Locatario (LocatarioID)
go



create table LocacaoLivro
(
	LocacaoID int not null
	, LivroID int not null
	, DataRetirada datetime not null
	, DataLimite datetime not null
	, DataEntrega datetime not null
	, Valor decimal(5, 2) not null
)
go

alter table LocacaoLivro add constraint PK_LocacaoLivro primary key(LocacaoID, LivroID)
go

alter table LocacaoLivro add constraint FK_LocacaoLivro_Locacao foreign key (LocacaoID) references Locacao (LocacaoID)
go

alter table LocacaoLivro add constraint FK_LocacaoLivro_Livro foreign key (LivroID) references Livro (LivroID)
go

alter table LocacaoLivro add constraint DF_LocacaoLivro_Valor default 0.0 for Valor
go



create table Reserva
(
	ReservaID int identity(1,1) not null
	, LocatarioID int not null
	, DataReserva datetime not null
	, DataExpiracao datetime not null
)
go

alter table Reserva add constraint PK_Reserva primary key(ReservaID)
go

alter table Reserva add constraint FK_Reserva_Locatario foreign key(LocatarioID) references Locatario (LocatarioID)
go


create table ReservaLivro
(
	ReservaID int not null
	, LivroID int not null
)
go

alter table ReservaLivro add constraint PK_ReservaLivro primary key (ReservaID, LivroID)
go

alter table ReservaLivro add constraint FK_ReservaLivro_Reserva foreign key (ReservaID) references Reserva (ReservaID)
go

alter table ReservaLivro add constraint FK_ReservaLivro_Livro foreign key (LivroID) references Livro (LivroID)
go



