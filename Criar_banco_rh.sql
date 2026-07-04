
-- BANCO DE DADOS DE RH - PROJETO PRÁTICO SQL
-- =============================================
-- Script para criar e popular as tabelas
-- =============================================

-- Tabela: departamentos
CREATE TABLE departamentos (
    id INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    localizacao VARCHAR(100),
    orcamento_anual DECIMAL(12,2)
);

INSERT INTO departamentos VALUES
(1, 'Tecnologia', 'São Paulo - SP', 2500000.00),
(2, 'Recursos Humanos', 'São Paulo - SP', 800000.00),
(3, 'Financeiro', 'São Paulo - SP', 1200000.00),
(4, 'Marketing', 'Rio de Janeiro - RJ', 1500000.00),
(5, 'Vendas', 'Belo Horizonte - MG', 1800000.00),
(6, 'Operações', 'Curitiba - PR', 2000000.00),
(7, 'Jurídico', 'São Paulo - SP', 900000.00),
(8, 'Logística', 'Campinas - SP', 1100000.00);

-- Tabela: cargos
CREATE TABLE cargos (
    id INTEGER PRIMARY KEY,
    titulo VARCHAR(100) NOT NULL,
    nivel VARCHAR(20) NOT NULL, -- junior, pleno, senior, gerente, diretor
    salario_base DECIMAL(10,2),
    departamento_id INTEGER REFERENCES departamentos(id)
);

INSERT INTO cargos VALUES
(1, 'Desenvolvedor Júnior', 'junior', 4500.00, 1),
(2, 'Desenvolvedor Pleno', 'pleno', 7500.00, 1),
(3, 'Desenvolvedor Sênior', 'senior', 12000.00, 1),
(4, 'Tech Lead', 'gerente', 16000.00, 1),
(5, 'Diretor de Tecnologia', 'diretor', 25000.00, 1),
(6, 'Analista de RH Júnior', 'junior', 3500.00, 2),
(7, 'Analista de RH Pleno', 'pleno', 5500.00, 2),
(8, 'Gerente de RH', 'gerente', 12000.00, 2),
(9, 'Analista Financeiro Júnior', 'junior', 4000.00, 3),
(10, 'Analista Financeiro Pleno', 'pleno', 6500.00, 3),
(11, 'Controller', 'senior', 14000.00, 3),
(12, 'Diretor Financeiro', 'diretor', 22000.00, 3),
(13, 'Analista de Marketing Júnior', 'junior', 3800.00, 4),
(14, 'Analista de Marketing Pleno', 'pleno', 6000.00, 4),
(15, 'Gerente de Marketing', 'gerente', 13000.00, 4),
(16, 'Vendedor', 'junior', 3000.00, 5),
(17, 'Executivo de Vendas', 'pleno', 5500.00, 5),
(18, 'Gerente de Vendas', 'gerente', 11000.00, 5),
(19, 'Diretor Comercial', 'diretor', 20000.00, 5),
(20, 'Analista de Operações', 'pleno', 5000.00, 6),
(21, 'Coordenador de Operações', 'senior', 9000.00, 6),
(22, 'Gerente de Operações', 'gerente', 14000.00, 6),
(23, 'Advogado Júnior', 'junior', 5000.00, 7),
(24, 'Advogado Pleno', 'pleno', 8000.00, 7),
(25, 'Gerente Jurídico', 'gerente', 15000.00, 7),
(26, 'Auxiliar de Logística', 'junior', 2800.00, 8),
(27, 'Analista de Logística', 'pleno', 4500.00, 8),
(28, 'Coordenador de Logística', 'senior', 7500.00, 8);

-- Tabela: funcionarios
CREATE TABLE funcionarios (
    id INTEGER PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    email VARCHAR(150) NOT NULL,
    data_nascimento DATE,
    data_admissao DATE NOT NULL,
    data_demissao DATE,
    cargo_id INTEGER REFERENCES cargos(id),
    departamento_id INTEGER REFERENCES departamentos(id),
    salario_atual DECIMAL(10,2) NOT NULL,
    genero VARCHAR(20),
    cidade VARCHAR(100),
    estado VARCHAR(2),
    status VARCHAR(20) DEFAULT 'ativo' -- ativo, desligado, licença
);

INSERT INTO funcionarios VALUES
(1, 'Ana Beatriz Costa', 'ana.costa@empresa.com', '1990-03-15', '2019-02-01', NULL, 3, 1, 12500.00, 'Feminino', 'São Paulo', 'SP', 'ativo'),
(2, 'Bruno Mendes', 'bruno.mendes@empresa.com', '1988-07-22', '2018-06-15', NULL, 4, 1, 16500.00, 'Masculino', 'São Paulo', 'SP', 'ativo'),
(3, 'Carla Rodrigues', 'carla.rodrigues@empresa.com', '1995-11-30', '2021-03-01', NULL, 1, 1, 5000.00, 'Feminino', 'São Paulo', 'SP', 'ativo'),
(4, 'Daniel Ferreira', 'daniel.ferreira@empresa.com', '1992-05-18', '2020-01-10', NULL, 2, 1, 8000.00, 'Masculino', 'São Paulo', 'SP', 'ativo'),
(5, 'Elena Souza', 'elena.souza@empresa.com', '1987-09-25', '2017-04-20', NULL, 5, 1, 26000.00, 'Feminino', 'São Paulo', 'SP', 'ativo'),
(6, 'Fábio Lima', 'fabio.lima@empresa.com', '1993-01-12', '2022-07-01', NULL, 1, 1, 4800.00, 'Masculino', 'São Paulo', 'SP', 'ativo'),
(7, 'Gabriela Santos', 'gabriela.santos@empresa.com', '1991-04-08', '2019-09-15', NULL, 2, 1, 7800.00, 'Feminino', 'São Paulo', 'SP', 'ativo'),
(8, 'Hugo Almeida', 'hugo.almeida@empresa.com', '1996-12-03', '2023-01-10', NULL, 1, 1, 4600.00, 'Masculino', 'São Paulo', 'SP', 'ativo'),
(9, 'Isabela Martins', 'isabela.martins@empresa.com', '1989-08-17', '2020-05-01', '2023-08-30', 2, 1, 7200.00, 'Feminino', 'São Paulo', 'SP', 'desligado'),
(10, 'João Oliveira', 'joao.oliveira@empresa.com', '1994-02-28', '2021-11-01', NULL, 1, 1, 5200.00, 'Masculino', 'São Paulo', 'SP', 'ativo'),
(11, 'Karen Silva', 'karen.silva@empresa.com', '1990-06-14', '2019-01-15', NULL, 7, 2, 6000.00, 'Feminino', 'São Paulo', 'SP', 'ativo'),
(12, 'Leonardo Pereira', 'leonardo.pereira@empresa.com', '1985-10-20', '2016-03-01', NULL, 8, 2, 13000.00, 'Masculino', 'São Paulo', 'SP', 'ativo'),
(13, 'Mariana Vieira', 'mariana.vieira@empresa.com', '1997-03-25', '2022-09-01', NULL, 6, 2, 3800.00, 'Feminino', 'São Paulo', 'SP', 'ativo'),
(14, 'Natália Ribeiro', 'natalia.ribeiro@empresa.com', '1993-07-09', '2020-02-15', '2022-11-20', 6, 2, 3600.00, 'Feminino', 'São Paulo', 'SP', 'desligado'),
(15, 'Oscar Dias', 'oscar.dias@empresa.com', '1991-11-11', '2021-06-01', NULL, 7, 2, 5800.00, 'Masculino', 'São Paulo', 'SP', 'ativo'),
(16, 'Paulo Gomes', 'paulo.gomes@empresa.com', '1988-04-30', '2018-01-10', NULL, 10, 3, 7000.00, 'Masculino', 'São Paulo', 'SP', 'ativo'),
(17, 'Quésia Nunes', 'quesia.nunes@empresa.com', '1986-08-15', '2015-07-01', NULL, 12, 3, 23000.00, 'Feminino', 'São Paulo', 'SP', 'ativo'),
(18, 'Rafael Barbosa', 'rafael.barbosa@empresa.com', '1994-12-22', '2022-03-01', NULL, 9, 3, 4200.00, 'Masculino', 'São Paulo', 'SP', 'ativo'),
(19, 'Sabrina Campos', 'sabrina.campos@empresa.com', '1992-09-05', '2020-08-15', NULL, 11, 3, 14500.00, 'Feminino', 'São Paulo', 'SP', 'ativo'),
(20, 'Tiago Cardoso', 'tiago.cardoso@empresa.com', '1990-01-18', '2019-05-20', '2023-03-15', 10, 3, 6800.00, 'Masculino', 'São Paulo', 'SP', 'desligado'),
(21, 'Úrsula Monteiro', 'ursula.monteiro@empresa.com', '1995-05-27', '2023-02-01', NULL, 9, 3, 4000.00, 'Feminino', 'São Paulo', 'SP', 'ativo'),
(22, 'Vitor Rocha', 'vitor.rocha@empresa.com', '1989-03-14', '2018-11-01', NULL, 15, 4, 13500.00, 'Masculino', 'Rio de Janeiro', 'RJ', 'ativo'),
(23, 'Wanda Teixeira', 'wanda.teixeira@empresa.com', '1996-07-08', '2022-01-15', NULL, 13, 4, 4000.00, 'Feminino', 'Rio de Janeiro', 'RJ', 'ativo'),
(24, 'Xavier Moreira', 'xavier.moreira@empresa.com', '1993-10-31', '2021-04-01', NULL, 14, 4, 6200.00, 'Masculino', 'Rio de Janeiro', 'RJ', 'ativo'),
(25, 'Yasmin Araujo', 'yasmin.araujo@empresa.com', '1991-12-19', '2020-09-01', '2023-06-30', 14, 4, 5800.00, 'Feminino', 'Rio de Janeiro', 'RJ', 'desligado'),
(26, 'Zeca Pinheiro', 'zeca.pinheiro@empresa.com', '1994-06-03', '2022-08-01', NULL, 13, 4, 3900.00, 'Masculino', 'Rio de Janeiro', 'RJ', 'ativo'),
(27, 'Amanda Duarte', 'amanda.duarte@empresa.com', '1990-02-14', '2019-03-10', NULL, 18, 5, 11500.00, 'Feminino', 'Belo Horizonte', 'MG', 'ativo'),
(28, 'Bernardo Moura', 'bernardo.moura@empresa.com', '1987-11-08', '2017-01-15', NULL, 19, 5, 21000.00, 'Masculino', 'Belo Horizonte', 'MG', 'ativo'),
(29, 'Cecília Farias', 'cecilia.farias@empresa.com', '1995-04-22', '2021-07-01', NULL, 16, 5, 3200.00, 'Feminino', 'Belo Horizonte', 'MG', 'ativo'),
(30, 'Diego Sampaio', 'diego.sampaio@empresa.com', '1992-08-16', '2020-02-01', NULL, 17, 5, 5800.00, 'Masculino', 'Belo Horizonte', 'MG', 'ativo'),
(31, 'Elisa Cunha', 'elisa.cunha@empresa.com', '1993-06-29', '2021-11-15', NULL, 16, 5, 3100.00, 'Feminino', 'Belo Horizonte', 'MG', 'ativo'),
(32, 'Fernando Lopes', 'fernando.lopes@empresa.com', '1988-09-10', '2018-04-01', '2022-12-20', 17, 5, 5500.00, 'Masculino', 'Belo Horizonte', 'MG', 'desligado'),
(33, 'Gisele Ramos', 'gisele.ramos@empresa.com', '1997-01-05', '2023-03-01', NULL, 16, 5, 3000.00, 'Feminino', 'Belo Horizonte', 'MG', 'ativo'),
(34, 'Henrique Alves', 'henrique.alves@empresa.com', '1991-10-13', '2020-06-15', NULL, 17, 5, 6000.00, 'Masculino', 'Belo Horizonte', 'MG', 'ativo'),
(35, 'Iris Nascimento', 'iris.nascimento@empresa.com', '1989-04-07', '2019-08-01', NULL, 22, 6, 14500.00, 'Feminino', 'Curitiba', 'PR', 'ativo'),
(36, 'Julio Freitas', 'julio.freitas@empresa.com', '1994-07-21', '2021-01-10', NULL, 20, 6, 5200.00, 'Masculino', 'Curitiba', 'PR', 'ativo'),
(37, 'Karina Machado', 'karina.machado@empresa.com', '1992-12-15', '2020-04-01', NULL, 21, 6, 9500.00, 'Feminino', 'Curitiba', 'PR', 'ativo'),
(38, 'Leandro Castro', 'leandro.castro@empresa.com', '1996-03-28', '2022-06-01', NULL, 20, 6, 5000.00, 'Masculino', 'Curitiba', 'PR', 'ativo'),
(39, 'Marta Silveira', 'marta.silveira@empresa.com', '1990-08-09', '2019-10-15', '2023-04-30', 20, 6, 5300.00, 'Feminino', 'Curitiba', 'PR', 'desligado'),
(40, 'Nelson Correia', 'nelson.correia@empresa.com', '1993-05-17', '2021-09-01', NULL, 20, 6, 5100.00, 'Masculino', 'Curitiba', 'PR', 'ativo'),
(41, 'Olga Braga', 'olga.braga@empresa.com', '1988-11-24', '2017-06-15', NULL, 25, 7, 15500.00, 'Feminino', 'São Paulo', 'SP', 'ativo'),
(42, 'Pedro Azevedo', 'pedro.azevedo@empresa.com', '1995-02-10', '2022-02-01', NULL, 23, 7, 5200.00, 'Masculino', 'São Paulo', 'SP', 'ativo'),
(43, 'Renata Fonseca', 'renata.fonseca@empresa.com', '1991-07-06', '2020-07-15', NULL, 24, 7, 8500.00, 'Feminino', 'São Paulo', 'SP', 'ativo'),
(44, 'Sérgio Tavares', 'sergio.tavares@empresa.com', '1994-09-19', '2021-12-01', NULL, 23, 7, 5500.00, 'Masculino', 'São Paulo', 'SP', 'ativo'),
(45, 'Tatiana Pinto', 'tatiana.pinto@empresa.com', '1992-04-01', '2020-03-10', '2023-09-15', 24, 7, 8200.00, 'Feminino', 'São Paulo', 'SP', 'desligado'),
(46, 'Ulisses Melo', 'ulisses.melo@empresa.com', '1990-06-23', '2019-11-01', NULL, 28, 8, 8000.00, 'Masculino', 'Campinas', 'SP', 'ativo'),
(47, 'Valéria Cruz', 'valeria.cruz@empresa.com', '1996-10-14', '2022-04-15', NULL, 26, 8, 3000.00, 'Feminino', 'Campinas', 'SP', 'ativo'),
(48, 'Wagner Prado', 'wagner.prado@empresa.com', '1993-01-28', '2021-02-01', NULL, 27, 8, 4800.00, 'Masculino', 'Campinas', 'SP', 'ativo'),
(49, 'Ximena Torres', 'ximena.torres@empresa.com', '1989-08-05', '2018-09-01', '2022-06-30', 27, 8, 4600.00, 'Feminino', 'Campinas', 'SP', 'desligado'),
(50, 'Yuri Campos', 'yuri.campos@empresa.com', '1995-12-30', '2023-05-01', NULL, 26, 8, 2900.00, 'Masculino', 'Campinas', 'SP', 'ativo');

-- Tabela: historico_promocoes
CREATE TABLE historico_promocoes (
    id INTEGER PRIMARY KEY,
    funcionario_id INTEGER REFERENCES funcionarios(id),
    cargo_anterior_id INTEGER REFERENCES cargos(id),
    cargo_novo_id INTEGER REFERENCES cargos(id),
    data_promocao DATE NOT NULL,
    aumento_percentual DECIMAL(5,2),
    motivo VARCHAR(200)
);

INSERT INTO historico_promocoes VALUES
(1, 1, 1, 2, '2020-06-01', 15.00, 'Desempenho excepcional no primeiro ano'),
(2, 1, 2, 3, '2022-03-01', 20.00, 'Liderança técnica em projeto estratégico'),
(3, 2, 2, 3, '2019-12-01', 18.00, 'Certificação e entrega de projetos complexos'),
(4, 2, 3, 4, '2021-08-01', 25.00, 'Promoção a Tech Lead do time mobile'),
(5, 4, 1, 2, '2021-09-01', 15.00, 'Crescimento técnico consistente'),
(6, 7, 1, 2, '2021-03-01', 12.00, 'Domínio de novas tecnologias'),
(7, 11, 6, 7, '2021-06-01', 20.00, 'Implementação de programa de treinamento'),
(8, 16, 9, 10, '2020-07-01', 18.00, 'Otimização de processos financeiros'),
(9, 19, 10, 11, '2022-01-01', 25.00, 'Liderança em auditoria interna'),
(10, 22, 14, 15, '2020-06-01', 30.00, 'Resultado de campanhas digitais'),
(11, 24, 13, 14, '2023-01-01', 15.00, 'Crescimento de performance'),
(12, 27, 17, 18, '2021-09-01', 22.00, 'Superação de metas consecutivas'),
(13, 30, 16, 17, '2022-05-01', 18.00, 'Melhor vendedor do trimestre'),
(14, 34, 16, 17, '2022-08-01', 20.00, 'Conquista de clientes estratégicos'),
(15, 37, 20, 21, '2022-02-01', 22.00, 'Otimização de cadeia de suprimentos'),
(16, 43, 23, 24, '2022-06-01', 18.00, 'Resolução de casos complexos'),
(17, 46, 27, 28, '2021-10-01', 20.00, 'Redução de custos logísticos em 15%'),
(18, 48, 26, 27, '2022-09-01', 15.00, 'Implementação de sistema de rastreamento');

-- =============================================
-- INSTRUÇÕES:
-- 1. Execute este script no Playground SQL da plataforma
--    ou em qualquer SGBD compatível com SQL padrão
-- 2. Após criar as tabelas, explore os dados com SELECT
-- 3. Use JOINs para cruzar informações entre tabelas
-- =============================================
