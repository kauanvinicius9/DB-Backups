CREATE DATABASE Sistema;

USE Sistema;

-- Tabela do Usuario
CREATE TABLE usuario (
	idUsuario INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL,
    senha_hash CHAR(65) NOT NULL,
    tipo ENUM('ALUNO', 'MENTOR', 'ADMIN'),
    data_cadastro DATETIME
	
) ENGINE = InnoDB;

-- Tabela do Curso
CREATE TABLE curso (
	idCurso INT AUTO_INCREMENT PRIMARY KEY,
    titulo VARCHAR(100),
    descricao TEXT,
    nivel ENUM('AVANCADO', 'INTERMEDIARIO', 'INICIANTE'),
    data_cadastro DATETIME
	
) ENGINE = InnoDB;

-- Tabela de Incrição
CREATE TABLE inscricao (
	idInscricao INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    id_curso INT NOT NULL,
    status ENUM('ATIVA', 'CONCLUIDA', 'CANCELADA'),
    data_inscricao DATETIME,
    FOREIGN KEY (id_usuario) REFERENCES usuario(idUsuario),
    FOREIGN KEY (id_curso) REFERENCES curso(idCurso)
	
) ENGINE = InnoDB;

-- Tabela de Auditoria
CREATE TABLE auditoria (
	id_auditoria INT AUTO_INCREMENT PRIMARY KEY,
    id_usuario INT NOT NULL,
    data_envio DATETIME,
    link_repositorio VARCHAR(255),
    versao INT,
    observacoes TEXT,
    operacao ENUM('INSERT', 'UPDATE', 'DELETE'),
    FOREIGN KEY (id_usuario) REFERENCES usuario(idUsuario)
	
) ENGINE = InnoDB;




