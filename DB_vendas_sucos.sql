CREATE DATABASE vendas_sucos;
use vendas_sucos;

CREATE TABLE produtos (
codigo varchar(10) NOT NULL,
descritor varchar(100),
sabor varchar(50),
tamanho varchar(50),
embalagem varchar(50),
preco_lista float,
PRIMARY KEY (codigo)
);

CREATE TABLE vendedores (
matricula varchar(5) NOT NULL,
nome varchar (100),
bairro varchar(50),
comissao float,
data_admissao date,
ferias bit(1),
PRIMARY KEY (matricula)
);

CREATE TABLE vendas (
numero varchar(5) NOT NULL,
data_venda date NOT NULL,
cpf varchar(11) NOT NULL,
matricula varchar(5) NOT NULL,
imposto float NOT NULL,
PRIMARY KEY (numero)
);

ALTER TABLE vendas ADD CONSTRAINT fk_clientes
FOREIGN KEY (cpf) REFERENCES clientes(cpf);

ALTER TABLE vendas ADD CONSTRAINT fk_vendedores
FOREIGN KEY (matricula) REFERENCES vendedores(matricula);

ALTER TABLE itens_notas ADD CONSTRAINT fk_produtos
FOREIGN KEY (codigo) REFERENCES produtos(codigo);

ALTER TABLE itens_notas ADD CONSTRAINT fk_vendas
FOREIGN KEY (numero) REFERENCES vendas(numero);

ALTER TABLE vendas RENAME notas;

INSERT INTO produtos (codigo, descritor, sabor, tamanho, embalagem, preco_lista)
VALUES ('1040107', 'Light - 350ml - Melancia', 'Melancia', '350 ml', 'Lata', 4.56);

select * from produtos;

INSERT INTO produtos (codigo, descritor, sabor, tamanho, embalagem, preco_lista)
VALUES ('1040108', 'Light - 350ml - Graviola', 'Graviola', '350 ml', 'Lata', 4.00);

INSERT INTO produtos
VALUES ('1040109', 'Light - 350ml - Açaí', 'Açaí', '350 ml', 'Lata', 5.60);

INSERT INTO produtos
VALUES ('1040110', 'Light - 350ml - Jaca', 'Jaca', '350 ml', 'Lata', 6.00), 
('1040111', 'Light - 350ml - Manga', 'Manga', '350 ml', 'Lata', 3.50);

INSERT INTO clientes
VALUES ('1471156710', 'Érica Carvalho', 'R. Iriquitia', 'Jardins', 'São Paulo', 'SP', '80012212', '1990-09-01', '33', 'F', 170000, 24500, 0),
('19290992743', 'Fernando Cavalcante', 'R. Dois de Fevereiro', 'Água Santa', 'Rio de Janeiro', 'RJ', '22000000', '2000-02-12', 18, 'M', 100000, 20000, 1),
('2600586709', 'César Teixeira', 'Rua Conde de Bonfim', 'Tijuca', 'Rio de Janeiro', 'RJ', '22020001', '2000-03-12', 18, 'M', 120000, 22000, 0);

select * from clientes;

SELECT codigo_do_produto AS CODIGO, NOME_DO_PRODUTO AS DESCRITOR,
EMBALAGEM, TAMANHO, SABOR, PRECO_DE_LISTA AS PRECO_LISTA
FROM sucos_vendas.tabela_de_produtos
WHERE CODIGO_DO_PRODUTO NOT IN (SELECT CODIGO FROM produtos);

INSERT INTO produtos
SELECT codigo_do_produto AS CODIGO, NOME_DO_PRODUTO AS DESCRITOR,
SABOR, TAMANHO, EMBALAGEM, PRECO_DE_LISTA AS PRECO_LISTA
FROM sucos_vendas.tabela_de_produtos
WHERE CODIGO_DO_PRODUTO NOT IN (SELECT CODIGO FROM produtos);

SELECT * FROM PRODUTOS;

/* Inclua todos os clientes na tabela CLIENTES baseados nos registros da tabela TABELA_DE_CLIENTES da base SUCOS_VENDAS.

Cuidado com o nome dos campos e lembre-se que já incluímos 3 clientes na nossa tabela, pelo exercício anterior. */

SELECT CPF, NOME, ENDERECO_1 AS ENDERECO, BAIRRO, CIDADE, ESTADO, CEP,
DATA_DE_NASCIMENTO, IDADE, SEXO, LIMITE_DE_CREDITO AS LIMITE_CREDITO, VOLUME_DE_COMPRA AS VOLUME_COMPRA, PRIMEIRA_COMPRA 
FROM sucos_vendas.tabela_de_clientes
WHERE CPF NOT IN (SELECT CPF FROM CLIENTES);

INSERT INTO CLIENTES
SELECT CPF, NOME, ENDERECO_1 AS ENDERECO, BAIRRO, CIDADE, ESTADO, CEP,
DATA_DE_NASCIMENTO, IDADE, SEXO, LIMITE_DE_CREDITO AS LIMITE_CREDITO, VOLUME_DE_COMPRA AS VOLUME_COMPRA, PRIMEIRA_COMPRA 
FROM sucos_vendas.tabela_de_clientes
WHERE CPF NOT IN (SELECT CPF FROM CLIENTES);

SELECT * FROM CLIENTES;

SELECT * FROM PRODUTOS;

/*ALTERAR PREÇO DE LISTA DE UM PRODUTO */
UPDATE produtos SET PRECO_LISTA = 5 
WHERE CODIGO = '1000889';

/*ALTERAR DIVERSOS CAMPOS */
UPDATE produtos SET embalagem = 'PET', tamanho = '1 Litro', descritor = 'Sabor da Montanha - 1 Litro - Uva'
WHERE CODIGO = '1000889';

/* ALTERAR O PREÇO DE UM SABOR ESPECÍFICO */
UPDATE produtos SET PRECO_LISTA = PRECO_LISTA * 1.10
WHERE SABOR = 'Maracujá';

/* Atualize o endereço do cliente com cpf 19290992743 para R. Jorge Emílio 23 o bairro para Santo Amaro, a cidade para São Paulo, o estado para SP e o CEP para 8833223. */
UPDATE clientes SET endereco = 'R. Jorge Emílio, 23', bairro = 'Santo Amaro', cidade = 'São Paulo', estado = 'SP', cep = '8833223'
WHERE CPF = '19290992743';

/* UTILIZAR O UPDATE COM FROM */
SELECT * FROM VENDEDORES A
INNER JOIN sucos_vendas.tabela_de_vendedores B
ON A.MATRICULA = substr(B.MATRICULA, 3,3);

UPDATE VENDEDORES A 
INNER JOIN sucos_vendas.tabela_de_vendedores B
ON A.MATRICULA = substr(B.MATRICULA, 3,3)
SET A.FERIAS = B.DE_FERIAS;

/* Podemos observar que os vendedores possuem bairro associados a eles. Vamos aumentar em 30% o volume de compra dos clientes que possuem, 
em seus endereços bairros onde os vendedores possuam escritórios. */

UPDATE CLIENTES A
INNER JOIN VENDEDORES B
ON A.BAIRRO = B.BAIRRO
SET VOLUME_COMPRA = VOLUME_COMPRA * 1.3;

/* INCLUINDO NOVOS DADOS NA TABELA PRODUTOS */

INSERT INTO PRODUTOS (
    CODIGO, DESCRITOR, SABOR, TAMANHO, EMBALAGEM, PRECO_LISTA
) VALUES 
    ('1001001','Sabor dos Alpes 700 ml - Manga','Manga','700 ml','Garrafa',7.50),
    ('1001000','Sabor dos Alpes 700 ml - Melão','Melão','700 ml','Garrafa',7.50),
    ('1001002','Sabor dos Alpes 700 ml - Graviola','Graviola','700 ml','Garrafa',7.50),
    ('1001003','Sabor dos Alpes 700 ml - Tangerina','Tangerina','700 ml','Garrafa',7.50),
    ('1001004','Sabor dos Alpes 700 ml - Abacate','Abacate','700 ml','Garrafa',7.50),
    ('1001005','Sabor dos Alpes 700 ml - Açai','Açai','700 ml','Garrafa',7.50),
    ('1001006','Sabor dos Alpes 1 Litro - Manga','Manga','1 Litro','Garrafa',7.50),
    ('1001007','Sabor dos Alpes 1 Litro - Melão','Melão','1 Litro','Garrafa',7.50),
    ('1001008','Sabor dos Alpes 1 Litro - Graviola','Graviola','1 Litro','Garrafa',7.50),
    ('1001009','Sabor dos Alpes 1 Litro - Tangerina','Tangerina','1 Litro','Garrafa',7.50),
    ('1001010','Sabor dos Alpes 1 Litro - Abacate','Abacate','1 Litro','Garrafa',7.50),
    ('1001011','Sabor dos Alpes 1 Litro - Açai','Açai','1 Litro','Garrafa',7.50);

SELECT * FROM PRODUTOS WHERE SUBSTRING(DESCRITOR, 1, 15) = 'Sabor dos Alpes';


/* DELETANDO DADOS DA TABELA */

DELETE FROM PRODUTOS
WHERE CODIGO = ‘1001000’;

DELETE FROM PRODUTOS
WHERE TAMANHO = '1 Litro' AND
SUBSTRING(DESCRITOR, 1, 15) = 'Sabor dos Alpes';

/* DELETANDO DADOS COM BASE EM OUTRA TABELA */

SELECT CODIGO_DO_PRODUTO FROM SUCOS_VENDAS.TABELA_DE_PRODUTOS;

SELECT CODIGO FROM PRODUTOS
WHERE CODIGO NOT IN (SELECT CODIGO_DO_PRODUTO FROM SUCOS_VENDAS.TABELA_DE_PRODUTOS);

DELETE FROM PRODUTOS
WHERE CODIGO NOT IN (SELECT CODIGO_DO_PRODUTO FROM SUCOS_VENDAS.TABELA_DE_PRODUTOS);

/* Desafio: Vamos excluir as notas fiscais (Apenas o cabeçalho) cujos clientes tenham a idade menor ou igual a 18 anos. */

DELETE A FROM NOTAS A
INNER JOIN CLIENTES B ON A.CPF = B.CPF
WHERE B.IDADE <= 18;


/* Apague todos os dados da tabela NOTAS e ITENS_NOTAS. */

DELETE FROM ITENS_NOTAS;
DELETE FROM NOTAS;

/* COMEÇAR UMA TRANSAÇÃO*/

START TRANSACTION;

SELECT * FROM VENDEDORES;

UPDATE VENDEDORES SET COMISSAO = COMISSAO * 1.15;

ROLLBACK; /* NÃO SERÁ ATUALIZADA */

START TRANSACTION;

SELECT * FROM VENDEDORES;

UPDATE VENDEDORES SET COMISSAO = COMISSAO * 1.15;

COMMIT; /* SERÁ ATUALIZADA*/

/* UTILIZAR AUTO INCREMENTO */

CREATE TABLE TAB_IDENTITY (ID  int auto_increment, DESCRITOR VARCHAR(20), primary key (ID));

INSERT INTO TAB_IDENTITY (DESCRITOR)
VALUES ('Cliente 1');

SELECT * FROM TAB_IDENTITY;


INSERT INTO TAB_IDENTITY (DESCRITOR)
VALUES ('Cliente 2'), ('Cliente 3');

/* CRIANDO PADRÕES PARA OS CAMPOS */
CREATE TABLE TAB_PADRAO
(ID INT AUTO_INCREMENT,
DESCRITOR VARCHAR(20),
ENDERECO VARCHAR(100) NULL,
CIDADE VARCHAR(50) DEFAULT 'Rio de Janeiro',
DATA_CRIACAO timestamp DEFAULT current_timestamp(),
PRIMARY KEY (ID)
);

INSERT INTO TAB_PADRAO (DESCRITOR, ENDERECO, CIDADE, DATA_CRIACAO)
VALUES ('CLIENTE X', 'RUA PROJETADA A', 'SÃO PAULO', '2019-01-01');

SELECT * FROM TAB_PADRAO;

INSERT INTO TAB_PADRAO (DESCRITOR)
VALUES ('CLIENTE Y');

DROP TABLE TAB_PADRAO;

/* UTILIZANDO TRIGGERS */
CREATE TABLE FATURAMENTO
(DATA_VENDA DATE NULL,
TOTAL_VENDA FLOAT
);

INSERT INTO NOTAS (NUMERO, DATA_VENDA, CPF, MATRICULA, IMPOSTO)
VALUES ('0100', '2023-05-29', '1471156710', '235', '0.10');
INSERT INTO ITENS_NOTAS (NUMERO, CODIGO, QUANTIDADE, PRECO)
VALUES ('0100', '1000889', 100, 10);

INSERT INTO NOTAS (NUMERO, DATA_VENDA, CPF, MATRICULA, IMPOSTO)
VALUES ('0101', '2023-05-29', '1471156710', '235', '0.10');
INSERT INTO ITENS_NOTAS (NUMERO, CODIGO, QUANTIDADE, PRECO)
VALUES ('0101', '1000889', 100, 10);

INSERT INTO NOTAS (NUMERO, DATA_VENDA, CPF, MATRICULA, IMPOSTO)
VALUES ('0103', '2023-05-29', '1471156710', '235', '0.10');
INSERT INTO ITENS_NOTAS (NUMERO, CODIGO, QUANTIDADE, PRECO)
VALUES ('0103', '1000889', 100, 10);

SELECT * FROM itens_notas;

INSERT INTO FATURAMENTO
SELECT A.DATA_VENDA, SUM(B.QUANTIDADE * B.PRECO) AS TOTAL_VENDA 
FROM NOTAS A INNER JOIN ITENS_NOTAS B
ON A.NUMERO = B.NUMERO
group by A.DATA_VENDA;

SELECT * FROM FATURAMENTO;
DELETE FROM FATURAMENTO;

INSERT INTO NOTAS (NUMERO, DATA_VENDA, CPF, MATRICULA, IMPOSTO)
VALUES ('0104', '2023-05-29', '1471156710', '235', '0.10');
INSERT INTO ITENS_NOTAS (NUMERO, CODIGO, QUANTIDADE, PRECO)
VALUES ('0104', '1000889', 100, 10);

DELIMITER //
CREATE TRIGGER TG_CALCULA_FATURAMENTO
AFTER INSERT ON itens_notas
FOR EACH ROW BEGIN
	DELETE FROM FATURAMENTO;
	INSERT INTO FATURAMENTO
	SELECT A.DATA_VENDA, SUM(B.QUANTIDADE * B.PRECO) AS TOTAL_VENDA 
	FROM NOTAS A INNER JOIN ITENS_NOTAS B
	ON A.NUMERO = B.NUMERO
	group by A.DATA_VENDA;
END//

DELIMITER //
CREATE TRIGGER TG_CALCULA_FATURAMENTO_UPDATE
AFTER UPDATE ON itens_notas
FOR EACH ROW BEGIN
	DELETE FROM FATURAMENTO;
	INSERT INTO FATURAMENTO
	SELECT A.DATA_VENDA, SUM(B.QUANTIDADE * B.PRECO) AS TOTAL_VENDA 
	FROM NOTAS A INNER JOIN ITENS_NOTAS B
	ON A.NUMERO = B.NUMERO
	group by A.DATA_VENDA;
END//

DELIMITER //
CREATE TRIGGER TG_CALCULA_FATURAMENTO_DELETE
AFTER DELETE ON itens_notas
FOR EACH ROW BEGIN
	DELETE FROM FATURAMENTO;
	INSERT INTO FATURAMENTO
	SELECT A.DATA_VENDA, SUM(B.QUANTIDADE * B.PRECO) AS TOTAL_VENDA 
	FROM NOTAS A INNER JOIN ITENS_NOTAS B
	ON A.NUMERO = B.NUMERO
	group by A.DATA_VENDA;
END//