CREATE DATABASE Consulta;

USE Consulta;

-- Tabela de Livros
CREATE TABLE Livros (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(250) NOT NULL,
    preco DECIMAL(10,2),
    descricao TEXT

 ) ENGINE = InnoDB;

-- Tabela de Usuários
CREATE TABLE Usuarios (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(200) NOT NULL,
    senha VARCHAR(10) NOT NULL,
    idade INT,
    email VARCHAR(100) UNIQUE
    
) ENGINE = InnoDB;

-- Tabela de Empréstimos
CREATE TABLE Emprestimos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    livro_id INT,
    users_id INT,
    data_inicio DATE,
    data_devolucao_prevista DATE,
    FOREIGN KEY (livro_id) REFERENCES Livros(id),
    FOREIGN KEY (users_id) REFERENCES Usuarios(id)

) ENGINE = InnoDB;

-- Seleção de Livros
SELECT * FROM Livros; 

-- Seleção de  Usuários
SELECT * FROM Usuarios;

-- Seleção de Empréstimos
SELECT * FROM Emprestimos;

-- Seleção de todos os empréstimos com dados dos livros e dos usuários
SELECT
    Emprestimos.id,
    Livros.titulo,
    Usuarios.nome,
    Emprestimos.data_inicio,
    Emprestimos.data_devolucao_prevista
    
FROM Emprestimos
JOIN Livros ON Emprestimos.livro_id = Livros.id
JOIN Usuarios ON Emprestimos.users_id = Usuarios.id;

-- Seleção para lista de empréstimos feitos pelo usuário de ID número 1
SELECT
    Emprestimos.id,
    Livros.titulo,
    Usuarios.nome,
    Emprestimos.data_inicio,
    Emprestimos.data_devolucao_prevista

FROM Emprestimos
JOIN Livros ON Emprestimos.livro_id = Livros.id
WHERE Emprestimos.users_id = 1;

-- Seleção para lista de livros que ainda não estão emprestados atualmente
SELECT * FROM Livros
WHERE id NOT IN (
    SELECT livro_id FROM Emprestimos

);

