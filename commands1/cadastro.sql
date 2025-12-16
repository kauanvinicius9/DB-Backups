CREATE DATABASE nome;

USE nome;

DROP DATABASE nome; 

-- Rename de Tabela
CREATE DATABASE code_example;
RENAME TABLE nome.usuario TO exemplo.usuario;

-- Deletar uma tabela e criar uma tabela
DROP TABLE nome.usuario;
CREATE TABLE usuario (
  
  id_usuario INT AUTO_INCREMENT PRIMARY KEY, 
  nome VARCHAR(19) NOT NULL,
  endereco VARCHAR(15) NOT NULL,
  idade INT,
  email VARCHAR(50) NOT NULL

);
