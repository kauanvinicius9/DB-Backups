CREATE DATABASE Livraria;

USE Livraria;

-- Criação Tabela Livro
CREATE TABLE Livro (
    iD_Livro INT PRIMARY KEY AUTO_INCREMENT,
    Código INT NOT NULL,
    Autor VARCHAR(30) NOT NULL,
    Titulo VARCHAR(30) NOT NULL,
    Ano_Publicacao DATETIME,
    Preco_Venda INT NOT NULL,
    Categoria ENUM('TERROR', 'TÉCNICO', 'FICTÍCIO', 'ROMANCE', 'FIC'),
    Status_Livro ENUM('DISPONÍVEL', 'ESGOTADO', 'EMPRESTADO', 'VENDIDO', 'PENDENTE PARA ENTREGA'),
    ID_Autores INT,
    FOREIGN KEY (ID_Autores) REFERENCES  Autores (ID_Autor),
    FOREIGN KEY (ID_Produtos) REFERENCES Produtos (ID_Produto)

);

-- Criação Tabela Produtos
CREATE TABLE Produtos (
    ID_Produto INT PRIMARY KEY AUTO_INCREMENT,
    Data_Compra DATETIME,
    Data_Empresimo DATETIME,
    Data_Devolucao DATETIME,
    Valor_Total INT NOT NULL,
    Qtd_Adquirida INT NOT NULL,
    ID_Item INT,
    Titulo_Produto VARCHAR(50) NOT NULL,
    Nome_Cliente VARCHAR(50) NOT NULL,
    Descricao VARCHAR(50) NOT NULL,
    Tamanho  INT NOT NULL,
    FOREIGN KEY (ID_Item) REFERENCES Clientes (ID_Cliente)

);

-- Criação Tabela Autores
CREATE TABLE Autores (
    ID_Autores INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Completo VARCHAR(75) NOT NULL,
    Nascionalidade VARCHAR(75) NOT NULL,
    Credenciais ENUM('CERTIFICADOS',  'TÍTULOS', 'PATROCÍNIOS')
    Qualidade ENUM('IMAGINAÇÃO', 'CRIATIVIDADE', 'LEALDADE', 'BOA ATUAÇÃO'),
    FOREIGN KEY (ID_Autores) REFERENCES Livro (ID_Livro)

);

-- Criação Tabela Clientes
CREATE TABLE Clientes (
    ID_Cliente INT PRIMARY KEY AUTO_INCREMENT,
    Nome_Completo VARCHAR(100) NOT NULL,
    Email VARCHAR(45) NOT NULL,
    Telefone VARCHAR(13)  NOT NULL,
    Frequencia_Compra ENUM('RARAMENTE', 'DE VEZ EM QUANDO', 'SEMPRE'),
    Interesses ENUM('LIVROS TÉCNICOS', 'LIVROS EDUCATIVOS', 'LIVROS ILUSTRATIVOS'),
    FOREIGN KEY (ID_Cliente) REFERENCES Produtos (ID_Produto)
    
);

-- Seleção do Nome da Tabela dos Autores
SELECT Nome_Completo 
FROM Autores;

-- Seleção do Título, e Preço da Tabela dos Livros e Definindo um Valor ACIMA de R$50,00
SELECT Titulo, Preco_Venda
FROM Livros
WHERE Preco_Venda > 50;

-- Seleção do Nome e Telefone da Tabela dos Clientes
SELECT Nome_Completo, Telefone 
FROM Clientes;

-- Seleção da Quantidade Comprada da Tabela dos Produtos
SELECT Qtd_Adquirida
FROM Produtos;

-- Seleção da Data de Compra da Tabela dos Produtos, e Selecionando um Valor para 4 Atributos
SELECT  Data_Compra 
FROM Produtos
WHERE ID_Item = 2, Nome_Cliente = 'JOSÉ',  Titulo_Produto = "Programação Descomplicada", Qtd_Adquirida = 398;
