-- Cria o banco de dados Mundo
CREATE DATABASE Mundo;

-- Usa o Banco Criado
USE Mundo;

-- Cria a tabela País
CREATE TABLE Pais (
  id_pais INT AUTO_INCREMENT PRIMARY KEY,
  continente VARCHAR(120) NOT NULL,
  populacao ENUM('alta', 'baixa', 'média'),
  pib DECIMAL(15,2),
  nome VARCHAR(100) NOT NULL,
  expect_vida DECIMAL(5,2)

);

-- Cria a tabela Cidade
CREATE TABLE Cidade (
  id_cidade INT AUTO_INCREMENT PRIMARY KEY,
  id_pais INT, -- Referência à tabela País
  pib DECIMAL(10,2),
  nome VARCHAR(100) NOT NULL,
  populacao ENUM('alta', 'baixa', 'média'),
  capital ENUM('tem', 'não tem') DEFAULT 'não tem',
  FOREIGN KEY (id_pais) REFERENCES Pais(id_pais)

);

-- Cria a tabela Rio
CREATE TABLE Rio (
  id_rio INT AUTO_INCREMENT PRIMARY KEY,
  id_pais INT, -- Referência à tabela País
  nascente VARCHAR(120),
  comprimento DECIMAL(10,2),
  FOREIGN KEY (id_pais) REFERENCES Pais(id_pais)

);

-- Inserindo dados na tabela País
INSERT INTO Pais (nome, continente, populacao, pib, expect_vida) VALUES
('Canada', 'America do Norte', 'baixa', 1.9, 82),
('Mexico', 'America do Norte', 'alta', 1.65, 75),
('Brasil', 'America do Sul', 'alta', 1.606, 75.5),
('Estados Unidos', 'America do Norte', 'média', 21.43, 76.1),
('Alemanha', 'Europa', 'alta', 4.1, 78.1);

-- Inserindo dados na tabela Cidade
INSERT INTO Cidade (id_pais, nome, pib, populacao, capital) VALUES
(3, 'Brasília', 490500.34, 'média', 'tem'),
(2, 'Campinas', 104329.94, 'alta', 'não tem'),
(5, 'Berlim', 499320.84, 'baixa', 'tem'),
(5, 'Munique', 843422.53, 'baixa', 'não tem'),
(2, 'Cidade do México', 200500.90, 'alta', 'tem');

-- Inserindo dados na tabela Rio 
INSERT INTO Rio (id_pais, nascente, comprimento) VALUES
(1, 'Serra Negra', 2300.84),
(2, 'Montes Urais', 8433.93),
(3, 'Montanhas do Atlas', 3233.22),
(4, 'Montes Himalaias', 3923.42),
(5, 'Cordilheira dos Andes', 8382.82);

-- Para cada continente, o PIB médio de seus países são exibidos com 
-- agrupamento de dados
SELECT continente, AVG(pib) AS pib_medio
FROM Pais
GROUP BY continente;

-- Continente no qual o rio mais extenso localiza-se, com comandos de JOIN
-- ordenação de dados e delimitador de retorno de quantidade de linhas
SELECT p.continente, r.nascente AS rio, r.comprimento
FROM Rio AS r
JOIN Pais AS p ON r.id_pais = p.id_pais
ORDER BY r.comprimento DESC LIMIT 1;

-- Criada uma trigger para ser ativada após excluir um país. Ela remove cidades e rios
-- relacionados com o país excluído.
DROP TRIGGER IF EXISTS trgg_delete_pais;

DELIMITER $$

CREATE TRIGGER trgg_delete_pais
BEFORE DELETE ON Pais
FOR EACH ROW
BEGIN
    DECLARE v_id_pais INT;

    SET v_id_pais = OLD.id_pais;

    DELETE FROM Cidade WHERE id_pais = v_id_pais;
    DELETE FROM Rio WHERE id_pais = v_id_pais;

END$$

DELIMITER ;

-- Função SearchPais para receber umcomo parâmetro uma string que pode ser usada como base
-- para pesquisar no DB um país que comece com esse parâmetro
DROP FUNCTION IF EXISTS SerchPais;

DELIMITER $$

CREATE FUNCTION SearchPais(p_prefixo VARCHAR(95))
RETURNS VARCHAR(250)
DETERMINISTIC
BEGIN
    DECLARE v_resultado VARCHAR(250);

    -- Nomes de países com o parâmetro iniciado
    SELECT GROUP_CONCAT(nome SEPARATOR ', ')
    INTO v_resultado
    FROM Pais
    WHERE nome LIKE CONCAT(p_prefixo, '%');

    -- Resultado concatenado (Juntado)
    RETURN v_resultado;

END$$

DELIMITER ;

-- Aleteração na tabela 'País', para adicionar o valor do 'pib_per_capita'
ALTER TABLE Pais
ADD COLUMN pib_per_capita DECIMAL(15,2);

-- Aplicação do cálculo
UPDATE Pais
SET pib_per_capita = CASE
    WHEN populacao = 'alta' THEN pib / 200000000
    WHEN populacao = 'media' THEN pib / 100000000
    WHEN populacao = 'baixa' THEN pib / 50000000

END;

-- Verificação do resultado
SELECT nome, pib, populacao, pib_per_capita
FROM Pais;

-- Listagem de atributos de uma tabela, 'Abaixo da Média', 'Acima da Média', 'Igual a Média'
SELECT
    c.nome AS Cidade,
    p.nome AS Pais,
    c.populacao AS Populacao,
    CASE
        WHEN
            (CASE c.populacao
                WHEN 'baixa' THEN 1
                WHEN 'média' THEN 2
                WHEN 'alta' THEN 3

            END) >

            (
                SELECT AVG(
                    CASE c2.populacao
                        WHEN 'baixa' THEN 1
                        WHEN 'média' THEN 2
                        WHEN 'alta' THEN 3
                    END

                )

                FROM Cidade c2
                WHERE c2.id_pais = c.id_pais

            )

        -- Acima da média
        THEN 'Acima da média'
        WHEN
            (CASE c.populacao
                WHEN 'baixa' THEN 1
                WHEN 'média' THEN 2
                WHEN 'alta' THEN 3
            END) <

            (

                SELECT AVG(
                    CASE c2.populacao
                        WHEN 'baixa' THEN 1
                        WHEN 'média' THEN 2
                        WHEN 'alta' THEN 3
                    END

                )

                FROM Cidade c2
                WHERE c2.id_pais = c.id_pais

            )
        
        -- Abaixo ou igual a média
        THEN 'Abaixo da média'
        ELSE 'Igual a média'
    END AS `Situação População`

FROM Cidade c
JOIN Pais p ON c.id_pais = p.id_pais;