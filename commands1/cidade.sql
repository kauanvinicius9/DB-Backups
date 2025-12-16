CREATE TABLE Pessoas (
    id INT PRIMARY KEY AUTO_INCREMENT;
    nome VARCHAR(150) NOT NULL,
    idade INT NOT NULL,
    endereco VARCHAR(400),
    email VARCHAR(100) NOT NULL,
    cpf VARCHAR(11) NOT NULL,
    statusPessoa ENUM('FUNCIONÁRIO, EMPRESÁRIO, PAI, MÃE, EMPREENDEDOR, ENGENHEIRO, ESTUDANTE, ATLETA, OUTRO')  NOT NULL

);

-- Criação da Index(índice) da Cidade
CREATE INDEX idx_Cidade ON Pessoas(Cidade);

-- Seleciona uma Pessoa da Tabela de Pessoas que Seja da Cidade de Campinas
SELECT * FROM Pessoas WHERE Cidade = 'Campinas';

-- Explanação
EXPLAIN SELECT * FROM Pessoas WHERE Cidade = "Florianópolis";
