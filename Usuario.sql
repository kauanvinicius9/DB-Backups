-- Script da aula
CREATE DATABASE Usuario;
USE Usuario;

-- Tabela de usuários
CREATE TABLE Usuarios (
    id_usuario SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE NOT NULL,
    senha_hash VARCHAR(255) NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de quadros Kanban
CREATE TABLE Quadros (
    id_quadro SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    descricao TEXT,
    criado_por INT REFERENCES Usuarios(id_usuario),
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de colunas (etapas do Kanban)
CREATE TABLE Colunas (
    id_coluna SERIAL PRIMARY KEY,
    id_quadro INT REFERENCES Quadros(id_quadro) ON DELETE CASCADE,
    nome VARCHAR(50) NOT NULL,
    posicao INT NOT NULL,  -- ordem da coluna (1=A Fazer, 2=Em Progresso, etc.)
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Tabela de tarefas (cartões Kanban)
CREATE TABLE Tarefas (
    id_tarefa SERIAL PRIMARY KEY,
    id_coluna INT REFERENCES Colunas(id_coluna) ON DELETE CASCADE,
    titulo VARCHAR(200) NOT NULL,
    descricao TEXT,
    responsavel INT REFERENCES Usuarios(id_usuario),
    prioridade VARCHAR(20) CHECK (prioridade IN ('Baixa', 'Média', 'Alta')) DEFAULT 'Média',
    status VARCHAR(30) DEFAULT 'Ativa',
    data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    data_conclusao TIMESTAMP
);

-- Tabela de comentários nas tarefas (opcional)
CREATE TABLE Comentarios (
    id_comentario SERIAL PRIMARY KEY,
    id_tarefa INT REFERENCES Tarefas(id_tarefa) ON DELETE CASCADE,
    id_usuario INT REFERENCES Usuarios(id_usuario),
    texto TEXT NOT NULL,
    criado_em TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Inserir usuários
INSERT INTO Usuarios (nome, email, senha_hash) VALUES
('nome1', 'nome1@bosch.com', 'hash1'),
('nome2', 'nome2@bosch.com', 'hash2'),
('nome3', 'nome3@bosch.com', 'hash4'),
('nome4', 'nome4@bosch.com', 'hash7'),
('nome5', 'nome5@bosch.com', 'hash8'),
('nome6', 'nome6@bosch.com', 'hash9'),
('nome7', 'nome7@bosch.com', 'hash10');

-- Inserir quadros Kanban
INSERT INTO Quadros (nome, descricao, criado_por) VALUES
('Projeto Apollo', 'Desenvolvimento do sistema Apollo', 1),
('Site Institucional', 'Criação do novo site da empresa', 2),
('Aplicativo Mobile', 'App para clientes corporativos', 3);

-- Inserir colunas (3 por quadro)
INSERT INTO Colunas (id_quadro, nome, posicao) VALUES
(1, 'A Fazer', 1),
(1, 'Em Progresso', 2),
(1, 'Concluído', 3),
(2, 'A Fazer', 1),
(2, 'Em Progresso', 2),
(2, 'Concluído', 3),
(3, 'A Fazer', 1),
(3, 'Em Progresso', 2),
(3, 'Concluído', 3);

-- Projeto Apollo (id_quadro=1 → colunas 1,2,3)

-- Tarefas "A Fazer" (id_coluna=1)
INSERT INTO Tarefas (id_coluna, titulo, descricao, responsavel, prioridade) VALUES
(1, 'Definir arquitetura de banco de dados', 'Planejar as tabelas e relacionamentos', 1, 'Alta'),
(1, 'Configurar repositório Git', 'Criar repositório Git para o projeto', 2, 'Alta'),
(1, 'Planejar fluxos de usuários', 'Definir os principais fluxos de usuários do sistema', 3, 'Média'),
(1, 'Criar wireframes', 'Desenhar os wireframes das principais telas', 4, 'Média'),
(1, 'Configurar CI/CD', 'Automatizar pipeline de integração e deploy contínuo', 5, 'Alta'),
(1, 'Estudar framework front-end', 'Avaliar e escolher framework para front-end', 6, 'Baixa'),
(1, 'Documentar requisitos do sistema', 'Escrever especificações detalhadas dos requisitos', 7, 'Alta'),
(1, 'Definir ferramentas de testes', 'Escolher frameworks e ferramentas para testes', 8, 'Média'),
(1, 'Realizar levantamento de requisitos', 'Entrevistar stakeholders e documentar requisitos', 9, 'Alta'),
(1, 'Desenvolver API de autenticação', 'Implementar a API de login e registro', 10, 'Alta');

-- Tarefas "Em Progresso" (id_coluna=2)
INSERT INTO Tarefas (id_coluna, titulo, descricao, responsavel, prioridade) VALUES
(2, 'Implementar API de autenticação', 'Desenvolver a lógica da API de login e registro de usuários', 3, 'Alta'),
(2, 'Criar layout da página de login', 'Desenvolver a interface de login e registro', 4, 'Média'),
(2, 'Desenvolver sistema de permissões', 'Implementar controle de permissões para usuários', 5, 'Alta'),
(2, 'Integrar front-end com back-end', 'Conectar a interface do usuário com a API', 6, 'Média'),
(2, 'Adicionar testes unitários na API', 'Criar testes para as funções da API', 7, 'Média'),
(2, 'Criar página de perfil de usuário', 'Desenvolver a interface para visualização e edição do perfil', 8, 'Baixa'),
(2, 'Integrar autenticação com banco de dados', 'Armazenar dados de usuários e autenticação no banco de dados', 9, 'Alta'),
(2, 'Refatorar código da API', 'Melhorar a legibilidade e performance do código da API', 10, 'Média'),
(2, 'Criar testes de integração', 'Desenvolver testes que integrem todas as partes do sistema', 1, 'Alta'),
(2, 'Implementar validação de dados de entrada', 'Garantir que os dados inseridos pelo usuário sejam válidos', 2, 'Alta');

-- Tarefas "Concluído" (id_coluna=3)
INSERT INTO Tarefas (id_coluna, titulo, descricao, responsavel, prioridade) VALUES
(3, 'Revisar documentação do projeto', 'Atualizar a documentação com os últimos avanços', 5, 'Baixa'),
(3, 'Configurar ferramentas de monitoramento', 'Integrar ferramentas de monitoramento do sistema', 6, 'Média'),
(3, 'Finalizar testes unitários', 'Garantir que todos os testes unitários sejam bem-sucedidos', 7, 'Alta'),
(3, 'Configurar ambiente de produção', 'Preparar o ambiente para deploy da versão final', 8, 'Alta'),
(3, 'Refatorar estrutura de diretórios', 'Reorganizar os arquivos e pastas do projeto', 9, 'Baixa'),
(3, 'Fazer deploy no ambiente de staging', 'Publicar o sistema em ambiente de testes', 10, 'Alta'),
(3, 'Ajustar responsividade da interface', 'Garantir que a interface funcione bem em diferentes dispositivos', 1, 'Média'),
(3, 'Realizar revisão de código', 'Revisar o código em busca de erros e melhorar qualidade', 2, 'Baixa'),
(3, 'Implementar funcionalidades de segurança', 'Adicionar segurança nas APIs e no front-end', 3, 'Alta'),
(3, 'Documentar endpoints da API', 'Criar a documentação para os endpoints da API', 4, 'Média');

-- Soma do id_tarefa com o responsável
SELECT id_tarefa + responsavel AS soma_id_responsavel
FROM Tarefas;

-- Subtração do responsável e do id_tarefa
SELECT id_tarefa - responsavel AS soma_id_responsavel
FROM Tarefas;

-- Multiplicação do responsável e do id_tarefa
SELECT id_tarefa * responsavel AS soma_id_responsavel
FROM Tarefas;

-- Metade de cada id_tarefa
SELECT id_tarefa, id_tarefa / 2.0 AS metade_id_tarefa
FROM Tarefas;

-- Resto da divisão do id_tarefa pelo responsável
SELECT id_tarefa, responsavel, MOD(id_tarefa, responsavel) AS resto_divisao
FROM Tarefas;

-- Tarefas com prioridade alta
SELECT id_tarefa, titulo, descricao, responsavel, prioridade
FROM Tarefas
WHERE prioridade = 'Alta';

-- Tarefa com ID maior que 10
SELECT id_tarefa, titulo, descricao, responsavel, prioridade
FROM Tarefas
WHERE id_tarefa > 10;

-- Tarefas que estão pendentes e tem alta prioridade
SELECT t.id_tarefa, t.titulo, t.descricao, t.responsavel, t.prioridade, c.nome AS nome_coluna
FROM Tarefas t
JOIN Colunas c ON t.id_coluna = c.id_coluna
WHERE c.nome = 'A Fazer' AND t.prioridade = 'Alta';

-- Tarefas que pertencem ao usuário com id menor do que 5 e estão pendentes
SELECT t.id_tarefa, t.titulo, t.descricao, t.responsavel, t.prioridade, t.status
FROM Tarefas t
WHERE t.responsavel < 5 AND t.status = 'Ativa';

-- Tarefas com id menor do que 5 com prioridade baixa e status 'pronto'
SELECT t.id_tarefa, t.titulo, t.descricao, t.responsavel, t.prioridade, t.status
FROM Tarefas t
WHERE t.responsavel < 5 AND (t.prioridade = 'Baixa' OR t.status = 'Ativa');

-- Tarefas pendentes e prioridade média ou alta
SELECT t.id_tarefa, t.titulo, t.descricao, t.responsavel, t.prioridade, c.nome AS nome_coluna
FROM Tarefas t
JOIN Colunas c ON t.id_coluna = c.id_coluna
WHERE c.nome = 'A Fazer' AND t.prioridade IN ('Média', 'Alta');

-- Tarefas com ID menor ou igual a 5 que não estão prontas e tem alta prioridade
SELECT t.id_tarefa, t.titulo, t.descricao, t.responsavel, t.prioridade, t.status
FROM Tarefas t
WHERE t.responsavel <= 5 AND t.status <> 'Ativa' AND t.prioridade = 'Alta';