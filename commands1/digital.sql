CREATE DATABASE Biblioteca_Digital;

USE Biblioteca_Digital;

-- Tabela dos Livros
CREATE TABLE Livros (
	id_livros INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(25) NOT NULL,
    autor VARCHAR(30) NOT NULL,
    ano_de_publi DATETIME,
    genero TEXT,
    quantidade INT NOT NULL,
    status_livro ENUM('DISPONIVEL', 'RESERVADO', 'EMPRESADO')
    
) ENGINE = InnoDB;

-- Tabela dos Usuários
CREATE TABLE Usuarios (
	id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(30) NOT NULL,
    email VARCHAR(50) NOT NULL,
    endereco VARCHAR(55) NOT NULL,
    telefone VARCHAR(19) NOT NULL,
    tipo ENUM('CLIENTE', 'BIBLIOTECARIO')

) ENGINE = InnoDB;

-- Tabela dos Empréstimos
CREATE TABLE Emprestimos (
	id_emprestimo INT PRIMARY KEY AUTO_INCREMENT,
    data_emprestimo DATETIME,
    data_devolucao 	DATETIME,
    id_usuario INT,
    id_livros INT,
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_livros) REFERENCES Livros(id_livros)

) ENGINE = InnoDB;

-- Tabela das Reservas
CREATE TABLE Reservas (
	id_reserva INT PRIMARY KEY AUTO_INCREMENT,
    data_reserva DATETIME,
    id_usuario INT,
    id_livros INT,
    status_reserva ENUM('PENDENTE', 'CONFIRMADA'),
    FOREIGN KEY (id_usuario) REFERENCES Usuarios(id_usuario),
    FOREIGN KEY (id_livros) REFERENCES Livros(id_livros)
    
) ENGINE = InnoDB;


