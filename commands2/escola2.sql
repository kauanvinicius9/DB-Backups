CREATE DATABASE IF NOT EXISTS Escola;

USE Escola;

-- Tabela de Alunos
CREATE TABLE Alunos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(250),
    idade INT,
    cidade VARCHAR(100)

);

-- Inserindo Dados à Tabela
INSERT INTO Alunos (nome, idade, cidade) VALUES
('HAMILTON, 19, ESTADOS UNIDOS'),
('PÉREZ, 20, ALEMANHA'),
('VERSTAPPEN, 29, ITÁLIA'),
('SENNA, 30, BRASIL'),
('LECLERC, 31, ESTADOS UNIDOS');

-- Inserindo Dados de Alunos para rodar o Script 100 vezes
INSERT INTO Alunos (nome, idade, cidade)

SELECT  
        CONCAT('Aluno', FLOOR(RAND() * 100)),
        FLOOR(RAND() * 10) + 20,
        CASE
                WHEN RAND() < 0.7 THEN 'BRASIL'
                ELSE 'ALEMANHA'
        END
FROM
        (SELECT 1 FROM INFORMATION_SCHEMA.COLUMNS LIMIT 100) AS t1;