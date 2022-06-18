WITH RECURSIVE tabela_geral
AS ( SELECT codigo, nome, codigo_pai, CAST(nome AS TEXT) AS ordem
FROM classificacao
WHERE codigo_pai IS NULL
UNION ALL
SELECT c.codigo, tg.nome, c.codigo_pai, CAST(tg.ordem || ' > ' || c.nome AS TEXT) AS ordem
FROM classificacao c
INNER JOIN tabela_geral tg ON c.codigo_pai = tg.codigo)
SELECT ordem AS "Ordem", codigo_pai AS "Código do Pai"
FROM tabela_geral tg
ORDER BY ordem;
