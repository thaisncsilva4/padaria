drop database dbpadaria;
create database dbPadaria;
use dbPadaria;
 
create table tbFuncionarios(
codFunc int not null auto_increment,
nome varchar(100) not null,
telefone char(14),
cpf char(14) not null unique,
cargo varchar(100),
salario decimal(9,2) default 0 check(salario >=0),
primary key (codFunc)
);
 
create table tbFornecedores(
codForn int not null auto_increment,
endereco varchar(100),
numero char(10),
cep char(9),
bairro varchar(100),
cidade varchar(100),
estado char(2),
telefone char(14),
nome varchar(100),
primary key (codForn)
);
 
create table tbProdutos(
codProd int not null auto_increment,
quantidade int not null check (quantidade >=0 ),
nome varchar(100),
preco decimal(9,2) not null check (preco >=0 ),
codForn int not null,
primary key (codProd),
foreign key (codForn) references tbFornecedores (codForn)
);
 
create table tbEstoques(
codEst int not null auto_increment,
dataEntr date not null,
horaEntr time not null,
horaSaid time,
quantidade int not null check (quantidade >= 0),
preco decimal(9, 2) not null check (preco >= 0),
codProd int not null,
primary key (codEst),
foreign key (codProd) references tbProdutos (codProd)
);

create table tbReposicoes(
codRep int not null auto_increment,
produto varchar(100) not null,
fornec varchar(100) not null,
codEst int not null,
primary key (codRep),
foreign key (codEst) references tbEstoques (codEst)
);

create table tbCargos(
codCar int not null auto_increment,
nomeCarg varchar (100) not null,
codFunc int not null,
primary key (codCar),
foreign key (codFunc) references tbFuncionarios (codFunc)
);
 
create table tbClientes(
codCli int not null auto_increment,
nome varchar(100),
telefone char(14),
primary key (codCli)
);
 
create table tbComandas(
codCom int not null auto_increment,
datas date not null,
prodRegist varchar(100),
funcRegist varchar(100) not null,
valorTot decimal(9,2) default 0 check (valorTot >= 0),
valorUni decimal(9,2) default 0 check (valorUni >= 0),
quantidade int,
statuss varchar(100),
codCli int not null,
primary key (codCom),
foreign key (codCli) references tbClientes (codCli)
);
 
create table tbCaixas(
codCaixas int not null auto_increment,
formaPag varchar(100) not null check (formaPag in ('Dinheiro', 'Pix', 'Débito', 'Crédito')),
troco decimal (9,2) not null default 0 check (troco >= 0),
primary key (codCaixas)
);
 
create table tbVendas(
codVend int not null auto_increment,
dataVend date not null,
prodVend varchar(100),
quantidade int not null,
preco decimal(9,2) not null check (preco >=0),
funcRegist varchar(100) not null,
funcPagam varchar(100),
codFunc int not null,
codCom int not null,
codCaixas int not null,
codProd int not null,
primary key (codVend),
foreign key (codFunc) references tbFuncionarios (codFunc),
foreign key (codCom) references tbComandas (codCom),
foreign key (codCaixas) references tbCaixas (codCaixas),
foreign key (codProd) references tbProdutos (codProd)
);
 
desc tbFuncionarios;
desc tbCargos;
desc tbClientes;
desc tbComandas;
desc tbVendas;
desc tbCaixas;
desc tbProdutos;
desc tbEstoques;
desc tbReposicoes;
desc tbFornecedores;
 
-- INSERT INTO
insert into tbFuncionarios (nome, telefone, cpf, cargo, salario)
values ('Bruno Silva', '11-91234-5678', '123.456.789-01', 'Atendente', 1450.00);
insert into tbFuncionarios (nome, telefone, cpf, cargo, salario)
values ('Maria Oliveira', '11-98765-4321', '987.654.321-00', 'Gerente', 3200.00);
insert into tbFuncionarios (nome, telefone, cpf, cargo, salario)
values ('Carlos Souza', '16-95678-1234', '456.123.789-09', 'Padeiro', 1800.00);
insert into tbFuncionarios (nome, telefone, cpf, cargo, salario)
values ('Ana Pereira', '11-93456-7890', '789.012.345-67', 'Caixa', 1670.00);
insert into tbFuncionarios (nome, telefone, cpf, cargo, salario)
values ('Fernanda Lima', '11-92345-6789', '321.654.987-02', 'Auxiliar de Limpeza', 1750.00);


select * from tbFuncionarios;

insert into tbFornecedores (endereco, numero, cep, bairro, cidade, estado, telefone, nome)
values ('Rua Adolfo Pinheiro', '123', '04040-804', 'Santo Amaro', 'São Paulo', 'SP', '11-99999-9999', 'Padaria Central');
insert into tbFornecedores (endereco, numero, cep, bairro, cidade, estado, telefone, nome)
values ('Avenida João Dias', '456', '04030-804', 'Morumbi', 'São Paulo', 'SP', '11-98888-8888', 'Fornecedora Pães');
insert into tbFornecedores (endereco, numero, cep, bairro, cidade, estado, telefone, nome)
values ('Rua Rua José de Alencar', '789', '04010-804', 'Largo Treze', 'São Paulo', 'SP', '11-97777-7777', 'Doces & Bolos');
insert into tbFornecedores (endereco, numero, cep, bairro, cidade, estado, telefone, nome)
values ('Rua Sete de Setembro', '101', '04070-804', 'Jardim Primavera', 'São Paulo', 'SP', '11-96666-6666', 'Laticínios SP');
insert into tbFornecedores (endereco, numero, cep, bairro, cidade, estado, telefone, nome)
values ('Rua Dr. Antonio Bento' , '202', '04080-804', 'Brooklin', 'São Paulo', 'SP', '11-95555-5555', 'Café Premium');


select * from tbFornecedores;
 
insert into tbProdutos (quantidade, nome, preco, codForn)
values (100, 'Pao Frances', 0.50, 1);
insert into tbProdutos (quantidade, nome, preco, codForn)
values (50, 'Croissant', 3.00, 2);
insert into tbProdutos (quantidade, nome, preco, codForn)
values (20, 'Bolo de Cenoura', 15.00, 3);
insert into tbProdutos (quantidade, nome, preco, codForn)
values (30, 'Leite Integral', 4.50, 4);
insert into tbProdutos (quantidade, nome, preco, codForn)
values (40, 'Cafe Expresso', 5.00, 5);
 
select * from tbProdutos;
 
insert into tbEstoques (dataEntr, horaEntr, horaSaid, quantidade, preco, codProd)
values ('2024-11-01', '08:00:00', null, 50, 25.00, 1);
insert into tbEstoques (dataEntr, horaEntr, horaSaid, quantidade, preco, codProd)
values ('2024-11-02', '09:00:00', null, 20, 60.00, 2);
insert into tbEstoques (dataEntr, horaEntr, horaSaid, quantidade, preco, codProd)
values ('2024-11-03', '10:00:00', '16:40:00' , 10, 150.00, 3);
insert into tbEstoques (dataEntr, horaEntr, horaSaid, quantidade, preco, codProd)
values ('2024-11-04', '11:00:00', null, 30, 40.00, 4);
insert into tbEstoques (dataEntr, horaEntr, horaSaid, quantidade, preco, codProd)
values ('2024-11-05', '12:00:00', null, 15, 80.00, 5);


select * from tbEstoques;


insert into tbReposicoes (codEst, produto, fornec)
values (1, 'pão', 'padaria central');
insert into tbReposicoes (codEst, produto, fornec)
values (2, 'croissant', 'fornecedora pães');
insert into tbReposicoes (codEst, produto, fornec)
values (3, 'bolo', 'doces & bolos');
insert into tbReposicoes (codEst, produto, fornec)
values (4, 'queijo', 'laticínios sp');
insert into tbReposicoes (codEst, produto, fornec)
values (5, 'café', 'café premium');

 
select * from tbReposicoes;
 
insert into tbCargos (nomeCarg, codFunc)
values ('Atendente', 1);
insert into tbCargos (nomeCarg, codFunc)
values ('Gerente', 2);
insert into tbCargos (nomeCarg, codFunc)
values ('Padeiro', 3);
insert into tbCargos (nomeCarg, codFunc)
values ('Caixa', 4);
insert into tbCargos (nomeCarg, codFunc)
values ('Auxiliar de Limpeza', 5);



select * from tbCargos;
 
insert into tbClientes (nome, telefone)
values ('Lucas Martins', '11-91122-3344');
insert into tbClientes (nome, telefone)
values ('Gabriela Souza', '11-92233-4455');
insert into tbClientes (nome, telefone)
values ('Thiago Santos', '11-93344-5566');
insert into tbClientes (nome, telefone)
values ('Mariana Costa', '11-94455-6677');
insert into tbClientes (nome, telefone)
values ('Fernando Alves', '11-95566-7788');

 
select * from tbClientes;
 
insert into tbComandas (datas, prodRegist, funcRegist, valorTot, valorUni, quantidade, statuss, codCli)
values ('2024-11-01', 'pão', 'atendente', 50.00, 2.50, 5, 'finalizado', 1);
insert into tbComandas (datas, prodRegist, funcRegist, valorTot, valorUni, quantidade, statuss, codCli)
values ('2024-11-02', 'bolo', 'padeiro', 120.00, 6.00, 7, 'em andamento', 2);
insert into tbComandas (datas, prodRegist, funcRegist, valorTot, valorUni, quantidade, statuss, codCli)
values ('2024-11-03', 'queijo', 'gerente', 80.00, 4.00, 3, 'finalizado', 3);
insert into tbComandas (datas, prodRegist, funcRegist, valorTot, valorUni, quantidade, statuss, codCli)
values ('2024-11-04', 'café', 'caixa', 30.00, 1.50, 1, 'em andamento', 4);
insert into tbComandas (datas, prodRegist, funcRegist, valorTot, valorUni, quantidade, statuss, codCli)
values ('2024-11-05', 'pão doce', 'atendente', 60.00, 3.00, 10, 'finalizado', 5);

 
select * from tbComandas;
 
insert into tbCaixas (formaPag, troco)
values ('Dinheiro', 2.50);
insert into tbCaixas (formaPag, troco)
values ('Pix', 0.00);
insert into tbCaixas (formaPag, troco)
values ('Pix', 0.00);
insert into tbCaixas (formaPag, troco)
values ('Débito', 0.00);
insert into tbCaixas (formaPag, troco)
values ('Crédito', 0.00);


select * from tbCaixas;
 
insert into tbVendas (dataVend, prodVend, quantidade, preco, funcRegist, funcPagam, codFunc, codCom, codCaixas, codProd)
values ('2024-11-26', 'Leite integral', 10, 3.50, 'atendente', 'Pix', 1, 1, 1, 1);
insert into tbVendas (dataVend, prodVend, quantidade, preco, funcRegist, funcPagam, codFunc, codCom, codCaixas, codProd)
values ('2024-11-27', 'Bolo de cenoura', 5, 25.00, 'Padeiro', 'Dinheiro', 2, 2, 2, 2);
insert into tbVendas (dataVend, prodVend, quantidade, preco, funcRegist, funcPagam, codFunc, codCom, codCaixas, codProd)
values ('2024-11-26', 'Pão francês', 8, 1.50, 'atendente', 'Débito', 3, 3, 3, 3);
insert into tbVendas (dataVend, prodVend, quantidade, preco, funcRegist, funcPagam, codFunc, codCom, codCaixas, codProd)
values ('2024-11-26', 'Café express', 15, 5.00, 'Gerente', 'Crédito', 4, 4, 4, 2);
insert into tbVendas (dataVend, prodVend, quantidade, preco, funcRegist, funcPagam, codFunc, codCom, codCaixas, codProd)
values ('2024-11-26', 'Croissant', 12, 4.00, 'Caixa', 'Pix', 5, 5, 5, 5);


select * from tbVendas;

-- UPDATES 

update tbFuncionarios set telefone = '11-94520-3344', cargo = 'Caixa', salario = 1670.00 where nome = 'Bruno Silva';
update tbFuncionarios set cargo = 'Gerente Geral', salario = 3660.00 where cpf = '987.654.321-00';
update tbFuncionarios set salario = 2000.00 where cargo = 'Padeiro';
update tbFuncionarios set cargo = 'Lider de Caixa', salario = 1850.00 where telefone = '11-93456-7890';
update tbFuncionarios set telefone = '11-92378-9500' where salario = 1750.00;
 
select * from tbFuncionarios;

update tbFornecedores set telefone = '11-91178-9052', endereco = 'Avenida Morumbi, 321' where nome = 'Padaria Central';
update tbFornecedores set endereco = 'Avenida Interlagos, 654' where telefone = '11-98888-8888';
update tbFornecedores set nome = 'Doces & Bolos & Salgados' where endereco = 'Rua Rua José de Alencar, 789';
update tbFornecedores set endereco = 'Rua Sete de Setembro, 105' where nome = 'Laticínios SP';
update tbFornecedores set telefone = '11-92215-7403' where nome = 'Café Premium';

select * from tbFornecedores;

update tbProdutos set preco = 0.60, quantidade = 120 where nome = 'Pao Frances';
update tbProdutos set quantidade = 30 where codForn = 2;
update tbProdutos set preco = 17.00  where quantidade = 20;
update tbProdutos set nome = 'Leite Desnatado', quantidade = 40 where preco = 4.50;
update tbProdutos set preco = 6.50, quantidade = 52 where nome = 'Cafe Expresso';

 
select * from tbProdutos;

update tbEstoques set horaSaid = '12:00:00', quantidade = 98, preco = 26.00 where codProd = 1;
update tbEstoques set quantidade = 45, preco = 26.00 where dataEntr = '2024-11-02';
update tbEstoques set dataEntr = '2024-11-10', quantidade = 37, preco = 26.00 where horaSaid = '16:40:00';
update tbEstoques set preco = 35.00 where quantidade = 30;
update tbEstoques set horaSaid = '11:35:00', preco = 26.00 where codProd = 5;

select * from tbEstoques;

update tbReposicoes set produto = 'pão doce' where codEst = 1;
update tbReposicoes set fornec = 'Padaria ' where produto = 'croissant';
update tbReposicoes set produto = 'Coxinha' where fornec = 'doces & bolos';
update tbReposicoes set produto = 'Presunto' where codEst = 4;
update tbReposicoes set fornec = 'café ' where produto = 'café';

select * from tbReposicoes;

update tbCargos set nomeCarg = 'Supervisora' where codFunc = 1;
update tbCargos set nomeCarg = 'caixa' where codFunc = 2;
update tbCargos set nomeCarg = 'Atendente' where codFunc = 3;
update tbCargos set nomeCarg = 'Líder de caixa' where codFunc = 4;
update tbCargos set nomeCarg = 'Líder de Limpeza' where codFunc = 5;

select * from tbCargos;

update tbClientes set telefone = '11-90000-0004' where nome = 'Lucas Martins';
update tbClientes set nome = 'Gabriela Silva' where telefone = '11-92233-4455';
update tbClientes set telefone = '11-92011-0004' where nome = 'Thiago Santos';
update tbClientes set telefone = '11-98750-0004' where nome = 'Mariana Costa';
update tbClientes set telefone = '11-90000-5820' where nome = 'Fernando Alves';

select * from tbClientes;

update tbComandas set prodRegist = 'Leite Integral', quantidade = 2 where datas = '2024-11-01';
update tbComandas set datas = '2024-12-03', quantidade = 15 where prodRegist = 'bolo';
update tbComandas set valorTot = '50.00', valorUni = 4.50 where funcRegist = 'gerente';
update tbComandas set quantidade = 4  where codCli = 4;
update tbComandas set prodRegist = 'Pão de mel' where datas = '2024-11-05';

select * from tbComandas;

update tbCaixas set troco = '4.00' where formaPag = 'Dinheiro';
update tbCaixas set troco = '1.50' where formaPag = 'Pix';
update tbCaixas set troco = '0.50' where formaPag = 'Pix';
update tbCaixas set troco = '1.00' where formaPag = 'Débito';
update tbCaixas set troco = '5.00' where formaPag = 'Crédito';

select * from tbCaixas;

update tbVendas set dataVend = '2024-11-01', quantidade = 10 where codProd = 1;
update tbVendas set prodVend = 'Bolo de chocolate', quantidade = 2 where dataVend = '2024-11-27';
update tbVendas set quantidade = 12 where prodVend = 'Pão francês';
update tbVendas set funcRegist = 'Caixa' where codProd = 4;
update tbVendas set dataVend = '2024-12-03', quantidade = 10 where funcRegist = 'Caixa';

select * from tbVendas;

select distinct cargo, salario from tbFuncionarios;

select * from tbFuncionarios where cargo = 'Caixa';
select * from tbClientes where nome = 'Lucas Martins';

select dataVend as 'Data da venda', prodVend as 'Produto da venda', quantidade as 'Quantidade', 
preco as 'Preço', funcRegist as 'Funcionário Registrou', funcPagam as 'Funcionário Pagamento', codFunc as 'Código',
codCom as 'Código Comanda', codCaixas as 'Código Caixa', codProd as 'Código do Produto'  from tbVendas;

select * from tbVendas where dataVend = '2024-12-03' or funcPagam = 'Pix';
select * from tbVendas where prodVend in ('Leite integral', 'Bolo de chocolate');
select * from tbVendas where dataVend = '2024-12-03' and funcPagam = 'Pix';
select * from tbVendas where preco > 10.00;
select * from tbVendas where quantidade < 5;


select nome, numero, endereco from tbFornecedores where codForn = 1;
select nome, numero, endereco from tbFornecedores where bairro like '%a%';
