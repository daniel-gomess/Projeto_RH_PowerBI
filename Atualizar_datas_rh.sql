-- ATUALIZACAO DE DATAS - PROJETO RH
-- =============================================
-- Objetivo:
-- Atualizar as datas da base ja criada no SQL Server,
-- trazendo os anos 3 anos para frente e preservando dia/mes.
--
-- Exemplo:
-- 2015-07-01 -> 2018-07-01
-- 2023-05-01 -> 2026-05-01
--
-- Observacao:
-- A condicao abaixo evita aplicar a atualizacao novamente
-- caso a base ja tenha sido ajustada.
-- =============================================

BEGIN TRANSACTION;

IF EXISTS (
    SELECT 1
    FROM dbo.funcionarios
    WHERE data_admissao < '2018-01-01'
)
BEGIN
    UPDATE dbo.funcionarios
    SET
        data_nascimento = DATEADD(YEAR, 3, data_nascimento),
        data_admissao = DATEADD(YEAR, 3, data_admissao),
        data_demissao = DATEADD(YEAR, 3, data_demissao);

    UPDATE dbo.historico_promocoes
    SET
        data_promocao = DATEADD(YEAR, 3, data_promocao);

    PRINT 'Datas atualizadas com sucesso: anos acrescidos em 3.';
END
ELSE
BEGIN
    PRINT 'Atualizacao nao aplicada: as datas de admissao ja parecem estar ajustadas.';
END;

COMMIT TRANSACTION;

-- Validacao dos novos intervalos
SELECT
    MIN(data_admissao) AS MenorDataAdmissao,
    MAX(data_admissao) AS MaiorDataAdmissao,
    MIN(data_demissao) AS MenorDataDemissao,
    MAX(data_demissao) AS MaiorDataDemissao
FROM dbo.funcionarios;

SELECT
    MIN(data_promocao) AS MenorDataPromocao,
    MAX(data_promocao) AS MaiorDataPromocao
FROM dbo.historico_promocoes;
