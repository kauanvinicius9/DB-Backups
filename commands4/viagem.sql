CREATE DATABASE IF NOT EXISTS viagem;

USE viagem;

-- Tabela de Cliente
CREATE TABLE Cliente (
	idCliente INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    CPF VARCHAR(11) NOT NULL,
    email VARCHAR(50) NOT NULL,
    telefone VARCHAR(15) NOT NULL
    
);

-- Tabela de Destino
CREATE TABLE Destino (
	idDestino INT AUTO_INCREMENT  PRIMARY KEY,
    cidade VARCHAR(50) NOT NULL,
    pais VARCHAR(50) NOT NULL,
    descricao TEXT
    
);

-- Tabela do Pacote de Viagem
CREATE TABLE Pacote_Viagem (
	idPacote INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(15) NOT NULL,
    preco DECIMAL(10,2),
    data_inicio DATE,
    data_retorno DATE,
    idDestino INT,
    FOREIGN KEY (idDestino) REFERENCES Destino(idDestino)
    
);

-- Tabela de Reserva
CREATE TABLE Reserva (
	idReserva INT AUTO_INCREMENT PRIMARY KEY,
    idCliente INT NOT NULL,
    idPacote INT NOT NULL,
    data_reserva DATE,
    pessoas INT,
    FOREIGN KEY (idCliente) REFERENCES Cliente(idCliente),
    FOREIGN KEY (idPacote) REFERENCES Pacote_Viagem(idPacote)
    
);

-- Exibição e Utilização
SHOW DATABASES;
USE viagem;
SHOW TABLES;





