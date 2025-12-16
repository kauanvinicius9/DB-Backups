CREATE DATABASE RedeSocial;

USE RedeSocial;

-- Tabela Usuários
CREATE TABLE Usuarios (
    UsuarioID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(100),
    Idade INT,
    Cidade VARCHAR(100),
    Email VARCHAR(100) UNIQUE,
    NomeUser VARCHAR(50) UNIQUE,
    Senha VARCHAR(100),
    Tipo ENUM('Estudante', 'Adm')

);

-- Tabela Atividades
CREATE TABLE Atividades (
    AtividadeID AUTO_INCREMENT PRIMARY KEY,
    Titulo VARCHAR(100),
    Descricao TEXT,
    Datas DATE,
    Locas VARCHAR(100),
    CategoriaID INT,
    FOREIGN KEY (CategoriaID) REFERENCES Categorias(CategoriaID),
    CriadorID INT,
    FOREIGN KEY (CriadorID) REFERENCES Usuarios(UsuarioID)

);

-- Tabela Categorias
CREATE TABLE Categorias (
    CategoriaID INT AUTO_INCREMENT PRIMARY KEY,
    Nome VARCHAR(50) UNIQUE

);

-- Tabela Participações em Atividades 
CREATE TABLE Participacoes (
    ParticipacaoID INT AUTO_INCREMENT PRIMARY KEY,
    AtividadeID INT,
    UsuarioID INT,
    FOREIGN KEY (AtividadeID) REFERENCES Atividades(AtividadeID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)

);

-- Tabela de Conexões Entre Usuários
CREATE TABLE Conexoes (
    ConexaoID INT AUTO_INCREMENT PRIMARY KEY,
    UsuarioID1 INT,
    UsuarioID2 INT,
    FOREIGN KEY (UsuarioID1) REFERENCES Usuarios(UsuarioID),
    FOREIGN KEY (UsuarioID2) REFERENCES Usuarios(UsuarioID),
    UNIQUE(UsuarioID1, UsuarioID2)

);

-- Tabela de Comentários nas Atividades
CREATE TABLE Comentarios (
    ComentarioID INT AUTO_INCREMENT PRIMARY KEY,
    AtividadeID INT,
    UsuarioID INT, 
    Comentario TEXT,
    DataComentário TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (AtividadeID) REFERENCES Atividades(AtividadeID),
    FOREIGN KEY (UsuarioID) REFERENCES Usuarios(UsuarioID)

);

-- Insert dos 10 usuários
INSERT INTO Usuarios (Nome, Cidade, Idade, Email, NomeUsuario, Senha, Tipo)
 
VALUES 
('Joãozinho', 20, 'Campinas', 'jão@gmail.com', 'Joooãos', '456', 'Mestrado'),
('Amandinha', 23, 'Bahia', 'amanda12@gmail.com', 'EuAmanda', '123', 'Atriz'),
('Carlos Santos', 36, 'Fortaleza', 'CS@gmail.com', 'Carlito', '246', 'Estudante'),
('Enidy Batista', 18, 'São Paulo', 'enidyy33@gmail.com', 'Eniidy7', '111', 'Estudante'),
('Ayla Souza', 30, 'Campinas', 'ayla290@gmail.com', 'AylaUser', '942', 'Doutorado'),
('Ricardo Costa', 18, 'Itapira', 'ricardinho12@gmail.com', 'Ricardin25', '205', 'Bacharel'),
('Miguel Amendoim', 20, 'Acre', 'amendoim29@gmail.com', 'Amendoim8', '222', 'Estudante'),
('Renato Silva', 27, 'Campinas', 'silva@gmail.com', 'Renatinho', '278', 'Mestrado'),
('Marcos Sales', 29, 'Santa Catarina', 'marcos@gmail.com', 'Marcos10', '150', 'Estudante'),
('Helena Batista', 18, 'Campinas', 'batista@gmail.com', 'Heleeeena', '789', 'Estudante');

-- Insert das 7 categorias
INSERT INTO Categorias (Nome) VALUES
('Esportes'),
('Arte'),
('Tecnologia'),
('Voluntariado'),
('Aprendiz Técnico'),
('Educação'),
('Música'),
('Ciências da Natureza'),
('Ciências da Computação'),
('Ciências Humanas');

-- Insert das 8 atividades
INSERT INTO Atividades (Descricao, Titulo,  Datas, Locais, CategoriaID, CriadorID) VALUES
('Corridas', 'Evento de corrida de 10km', '10.09.2025', 'Parque Ibirapuera', 1, 1),
('Hackathon Universitário', 'Maratona de programação', '07.08.2025', 'UNIVESP', 2, 2),
('Oficinas', 'Aula gratuita artística', '18.09.2025', 'Centro Cultural', 3, 3),
('Ciências', 'Natureza, Humanas e Computação', '12.10.2025', 'UNICAMP', 4, 4),
('I.A', 'Inteligência Artificial.', '01.11.2025', 'Anfiteatro Mackenzie', 2, 5),
('Danças', 'Dança Iniciante ao Avançado', '21.12.2025', 'Ginásio Municipal', 4, 6),
('Combate Artes Marciais', 'Mix de Artes Marciais', '10.01.2026', 'Centro de Combate', 7, 7),
('Autoconfiança', 'O melhor para você', '17.01.2026', 'Praia de Guarujá', 6, 8);

-- Insert das 4 participações
INSERT INTO Participacoes (AtividadeID, UsuarioID) VALUES
(1, 2),
(2, 3),
(3, 1),
(4, 5);

-- Insert das 5 conexões
INSERT INTO Conexoes (UsuarioID1, UsuarioID2) VALUES
(1, 2),
(1, 3),
(2, 4),
(3, 5),
(4, 6);

-- Insert dos 9 comentários
INSERT INTO Comentarios (AtividadeID, UsuarioID, Comentario) VALUES
(1, 2, 'Estou ansioso pra correr!'),
(2, 3, 'Vai ser um evento muito legal!'),
(3, 4, 'Adoro desenhos e pinturas!'),
(4, 5, 'Esse show é imperdível!'),
(5, 6, 'Mal posso esperare pela palestra!'),
(6, 7, 'Sempre quis aprender a dançar, vai ser legal!'),
(7, 8, 'Levando o meu projeto!'),
(8, 9, 'Ótimo evento para desenolver habilidades!'),
(1, 10, 'Bora cuidar da nossa saúde mental!');

-- Insert de mais 10 usuários
INSERT INTO Usuarios (Nome, Idade, Cidade, Email, NomeUser, Senha, Tipo) VALUES
('Larissa Santos', 20, 'São Carlos', 'larissa@gmail.com', 'Larissam', 'senha9', 'Estudante'),
('Marcelo Perez', 33, 'Florianópolis', 'perez@gmail.com', 'Marceeeelo', 'senha10', 'Bacharel'),
('Tatiane Pereira', 26, 'Campinas', 'tatiane@gmail.com', 'Taty1', 'senha11', 'Admin'),
('Roberto Costa', 38, 'Itapira', 'roberto12@gmail.com', 'Robertol', 'senha12', 'Estudante'),
('Camila Andrade', 29, 'Campinas', 'camila@gmail.com', 'Andrade18', 'senha13', 'Pós-Graduação'),
('Bruno Meirelez', 30, 'Porto Seguro', 'bruno@gmail.com', 'Brunof', 'senha14', 'Graduação'),
('Helena Santos', 27, 'Campos do Jordão', 'helena@gmail.com', 'Helena5', 'senha15', 'Estudante'),
('Gustavo Azevedo', 34, 'Campinas', 'gustavo@gmail.com', 'Guto3', 'senha16', 'Admin'),
('Amanda Ferreira', 25, 'Maceió', 'amanda@gmail.com', 'Amanda19', 'senha17', 'Graduação'),
('Lucas de Oliveira', 32, 'Joinville', 'lucas@gmail.com', 'Luucaso', 'senha18', 'Bacharel');

-- Insert de mais 5 atividades com mais detalhes e criador específico
INSERT INTO Atividades (Titulo, Descricao, Datas, Locas, CategoriaID, CriadorID) VALUES
('Curso Front-End', 'Front-End do básico ao deploy', '19.09.2025', 'IFSP', 2, 5),
('Programação e Robótica', 'Lógica de programação e Robôs', '21.09.2025', 'UFSCAR', 1, 5),
('Oficina Mecânica', 'Mecânica para iniciantes', '05.10.2025', 'Escola SENAI', 2, 5),
('Festival de Bandas', 'Bandas locais', '18.11.2025', 'Praça Taquaral', 4, 5),
('Feira do Livro', 'Feira de troca e doação de livros', '09.12.2025', 'Biblioteca Campinas - Bosque', 5, 5);

-- Select de todos os registros da tabela das Participações
SELECT * FROM Participacoes;

-- Select de todas as conexões feitas entre os usuários
SELECT * FROM Conexoes;

-- Select de todos os comentários criados em atividades
SELECT * FROM Comentarios;

-- Nome e Cidade de todos os usuários
SELECT Nome, Cidade FROM Usuarios;

-- Título e Data de todas as atividades
SELECT Titulo, Datas FROM Atividades;
