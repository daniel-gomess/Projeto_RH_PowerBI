
SELECT *
FROM dbo.cargos WITH (NOLOCK)

SELECT *
FROM departamentos WITH (NOLOCK)

SELECT *
FROM funcionarios WITH (NOLOCK)

SELECT *
FROM historico_promocoes WITH (NOLOCK)


--Calcular total de funcionários por departamento, média salarial geral e listar os 10 maiores salários.
-- Total de funcionários por departamento
SELECT 
	d.nome AS Departamento,
	COUNT(f.id) AS Total_Funcionarios
FROM 
	dbo.funcionarios f WITH (NOLOCK)
INNER JOIN
	dbo.departamentos d WITH (NOLOCK)
ON
	f.departamento_id = d.id
GROUP BY
	d.nome
ORDER BY
	Total_Funcionarios DESC,
	d.nome

-- Média salarial geral
SELECT
    AVG(salario_atual) AS media_salarial_geral
FROM funcionarios;

-- Os 10 maiores salários
SELECT TOP 10
	nome			AS Funcionarios,
	salario_atual	AS Salario_atual
FROM 
	dbo.funcionarios WITH (NOLOCK)
ORDER BY
	Salario_atual DESC




--Além dos requisitos do nível fácil: usar JOINs entre tabelas, subconsultas, calcular percentuais de distribuição, comparar salários entre departamentos e identificar funcionários com mais tempo de empresa.

--usar JOINs entre tabelas
--Listar funcionário, departamento e cargo.
SELECT
    f.nome AS funcionario,
    d.nome AS departamento,
    c.titulo AS cargo,
    f.salario_atual
FROM funcionarios f WITH (NOLOCK)
INNER JOIN departamentos d WITH (NOLOCK)
    ON f.departamento_id = d.id
INNER JOIN cargos c WITH (NOLOCK)
    ON f.cargo_id = c.id
ORDER BY d.nome, f.nome;


--subconsultas
-- Listar os funcionários que recebem acima da média salarial da empresa
SELECT
    nome,
    salario_atual
FROM funcionarios
WHERE salario_atual >
(
    SELECT AVG(salario_atual)
    FROM funcionarios
)
ORDER BY salario_atual DESC;


--calcular percentuais de distribuição
--funcionários por departamento
SELECT
    d.nome AS departamento,
    COUNT(f.id) AS total_funcionarios,
    ROUND(
        COUNT(f.id) * 100.0 /
        (SELECT COUNT(*) FROM funcionarios),
        2
    ) AS percentual_distribuicao
FROM departamentos d
INNER JOIN funcionarios f
    ON f.departamento_id = d.id
GROUP BY d.nome
ORDER BY total_funcionarios DESC;

--comparar salários entre departamentos
SELECT
    d.nome AS departamento,
    ROUND(AVG(f.salario_atual), 2) AS media_salarial
FROM funcionarios f
INNER JOIN departamentos d
    ON f.departamento_id = d.id
GROUP BY d.nome
ORDER BY media_salarial DESC;


--identificar funcionários com mais tempo de empresa.
SELECT TOP 10
    nome,
    data_admissao,
    DATEDIFF(YEAR, data_admissao, GETDATE()) AS anos_empresa
FROM funcionarios
ORDER BY data_admissao;


--Além dos requisitos anteriores: usar CTEs e Window Functions, calcular turnover por departamento, análise de evolução salarial com LAG/LEAD, criar views reutilizáveis e ranking de performance por múltiplos critérios.
-- 9. Turnover por departamento usando CTE
WITH funcionarios_departamento AS (
    SELECT
        d.id AS departamento_id,
        d.nome AS departamento,
        COUNT(f.id) AS total_funcionarios,
        SUM(CASE WHEN f.status = 'desligado' THEN 1 ELSE 0 END) AS total_desligados
    FROM dbo.departamentos d
    LEFT JOIN dbo.funcionarios f
        ON f.departamento_id = d.id
    GROUP BY d.id, d.nome
)
SELECT
    departamento,
    total_funcionarios,
    total_desligados,
    CAST(
        total_desligados * 100.0 / NULLIF(total_funcionarios, 0)
        AS DECIMAL(10,2)
    ) AS turnover_percentual
FROM funcionarios_departamento
ORDER BY turnover_percentual DESC;

--Evolução salarial com LAG
-- 10. Evolução de promoções com LAG e LEAD
WITH evolucao_promocoes AS (
    SELECT
        f.nome AS funcionario,
        hp.data_promocao,
        ca.titulo AS cargo_anterior,
        cn.titulo AS cargo_novo,
        hp.aumento_percentual,
        LAG(cn.titulo) OVER (
            PARTITION BY hp.funcionario_id
            ORDER BY hp.data_promocao
        ) AS cargo_promocao_anterior,
        LEAD(cn.titulo) OVER (
            PARTITION BY hp.funcionario_id
            ORDER BY hp.data_promocao
        ) AS proximo_cargo
    FROM dbo.historico_promocoes hp
    INNER JOIN dbo.funcionarios f
        ON f.id = hp.funcionario_id
    INNER JOIN dbo.cargos ca
        ON ca.id = hp.cargo_anterior_id
    INNER JOIN dbo.cargos cn
        ON cn.id = hp.cargo_novo_id
)
SELECT
    funcionario,
    data_promocao,
    cargo_anterior,
    cargo_novo,
    aumento_percentual,
    cargo_promocao_anterior,
    proximo_cargo
FROM evolucao_promocoes
ORDER BY funcionario, data_promocao;

-- 11. View reutilizável de funcionários
CREATE VIEW dbo.vw_funcionarios_completa AS
SELECT
    f.id AS funcionario_id,
    f.nome AS funcionario,
    f.email,
    d.nome AS departamento,
    c.titulo AS cargo,
    c.nivel,
    c.salario_base,
    f.salario_atual,
    f.data_admissao,
    f.data_demissao,
    f.status,
    f.cidade,
    f.estado
FROM dbo.funcionarios f
INNER JOIN dbo.departamentos d
    ON d.id = f.departamento_id
INNER JOIN dbo.cargos c
    ON c.id = f.cargo_id;

--Consulta View de Funcionarios
SELECT * FROM vw_funcionarios_completa (NOLOCK)


-- 12. View reutilizável de promoções
CREATE VIEW dbo.vw_historico_promocoes_completo AS
SELECT
    hp.id AS promocao_id,
    f.nome AS funcionario,
    d.nome AS departamento,
    ca.titulo AS cargo_anterior,
    cn.titulo AS cargo_novo,
    hp.data_promocao,
    hp.aumento_percentual,
    hp.motivo
FROM dbo.historico_promocoes hp
INNER JOIN dbo.funcionarios f
    ON f.id = hp.funcionario_id
INNER JOIN dbo.departamentos d
    ON d.id = f.departamento_id
INNER JOIN dbo.cargos ca
    ON ca.id = hp.cargo_anterior_id
INNER JOIN dbo.cargos cn
    ON cn.id = hp.cargo_novo_id;


--Consulta View de Historico de Promoções
SELECT * FROM vw_historico_promocoes_completo (NOLOCK)


-- Ranking de performance por múltiplos critérios
WITH base_ranking AS (
    SELECT
        f.id AS funcionario_id,
        f.nome AS funcionario,
        d.nome AS departamento,
        c.titulo AS cargo,
        f.salario_atual,
        c.salario_base,
        DATEDIFF(YEAR, f.data_admissao, GETDATE()) AS anos_empresa,
        COUNT(hp.id) AS total_promocoes,
        AVG(hp.aumento_percentual) AS media_aumento_percentual
    FROM dbo.funcionarios f
    INNER JOIN dbo.departamentos d
        ON d.id = f.departamento_id
    INNER JOIN dbo.cargos c
        ON c.id = f.cargo_id
    LEFT JOIN dbo.historico_promocoes hp
        ON hp.funcionario_id = f.id
    WHERE f.status = 'ativo'
    GROUP BY
        f.id,
        f.nome,
        d.nome,
        c.titulo,
        f.salario_atual,
        c.salario_base,
        f.data_admissao
)
SELECT
    funcionario,
    departamento,
    cargo,
    salario_atual,
    salario_base,
    anos_empresa,
    total_promocoes,
    media_aumento_percentual,
    RANK() OVER (
        PARTITION BY departamento
        ORDER BY
            total_promocoes DESC,
            media_aumento_percentual DESC,
            anos_empresa DESC,
            salario_atual DESC
    ) AS ranking_departamento
FROM base_ranking
ORDER BY departamento, ranking_departamento;


