CREATE DATABASE IndexAtv;

USE IndexAtv;

-- Tabela Clientes
CREATE TABLE Clientes (
    id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(255) NOT NULL,
    cadastro ENUM('CADASTRADO', 'NÃO CADASTRADO') NOT NULL
    
);

-- 1
CREATE INDEX email ON Clientes(email);

-- 2
SELECT * FROM Clientes;

-- 3
SELECT * FROM Clientes WHERE email = 'email123@gmail.com';

-- 4, Tabela Pedidos Criada
CREATE TABLE Pedidos (
    id_pedido INT AUTO_INCREMENT PRIMARY KEY,
    id_cliente INT NOT NULL,
    data_pedido DATE,
    valor_total DECIMAL(10,2),
    status VARCHAR(30),
    FOREIGN KEY (id_cliente) REFERENCES Clientes(id_cliente)
    
);

CREATE INDEX idx_cliente_data ON Pedidos (id_cliente, data_pedido);

-- 5
SELECT * FROM Clientes
JOIN Pedidos ON Clientes.id_cliente = Pedidos.id_cliente
WHERE Clientes.id_cliente = 1 
AND Pedidos.data_pedido = '2025-01-01';

-- 6 Tabela Produtos
CREATE TABLE Produtos (
    id_produto INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100),
    categoria VARCHAR(120),
    preco DECIMAL(10,2) NOT NULL

);

CREATE INDEX idx_nome_categoria ON Produtos (nome, categoria);

-- 7 Tabelas Criadas
SELECT * FROM Clientes 
JOIN Pedidos ON Clientes.id_cliente = Pedidos.id_cliente
WHERE Pedidos.id_pedido > 1000;

-- 8
SELECT nome FROM Clientes ORDER BY nome ASC;

CREATE INDEX idx_nome ON Clientes (nome);

-- 9
ALTER TABLE Clientes DROP INDEX idx_email;

-- 10, Tabela Venda
CREATE TABLE Vendas (
    id_venda INT PRIMARY KEY AUTO_INCREMENT,
    data_venda DATE,
    valor_venda DECIMAL(10,2) NOT NULL
    
);

CREATE INDEX id_data_venda ON Vendas (data_venda);

SELECT id_venda 
FROM Vendas 
WHERE data_venda BETWEEN '2025-10-01' AND '2025-10-04';

-- 11
SELECT id_pedido FROM Pedidos WHERE id_pedido > 500;
 
EXPLAIN SELECT id_pedido FROM Pedidos WHERE valor_total > 500;

-- 12
INSERT INTO Clientes (nome, email, cadastro) VALUES ('Judas', 'judastraidor123@email.com', 'CADASTRADO');
 
INSERT INTO Pedidos (id_cliente, valor_total, status) VALUES (1, 250.00, 'PENDENTE');
 
CREATE INDEX id_status ON Pedidos(status);
 
EXPLAIN SELECT valor_total, status FROM Pedidos WHERE status = 'PENDENTE' AND valor_total = 300.00;
 
-- DROP DATABASE Atividade_Index;
-- DROP TABLE Clientes;
-- DROP TABLE Pedidos;
-- DROP TABLE Produtos;