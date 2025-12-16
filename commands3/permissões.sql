-- Criação do Banco 
CREATE DATABASE Kauan;

-- Utilização do Banco
USE Kauan;

-- Criação da Tabela Produtos
CREATE TABLE Produtos (
	id INT AUTO_INCREMENT PRIMARY KEY NOT NULL,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(10,2),
    estoque INT
    
);

-- Criação de Usuários
CREATE USER 'kauanSales'@'localhost' IDENTIFIED BY 'senhaAdm';
CREATE USER 'batman'@'localhost' IDENTIFIED BY 'senhaVend';
CREATE USER 'astolfo'@'localhost' IDENTIFIED BY 'senhaCasal';

-- Definição de Permissões
GRANT ALL PRIVILEGES ON Kauan.* TO 'kauanSales'@'localhost';
GRANT SELECT, INSERT ON Kauan.Produtos TO 'batman'@'localhost';
GRANT SELECT ON Kauan.Produos TO 'astolfo'@'localhost';

FLUSH PRIVILEGES