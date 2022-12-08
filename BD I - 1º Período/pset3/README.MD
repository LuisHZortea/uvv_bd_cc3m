<div align="center">
 
  # Problem Set 3
 
</div>

#### Aluno: Luis Henrique Gomes Zortea | Curso: Ciência da Computação | Turma: CC1M | Professor(a): Abrantes Araújo Silva Filho | Monitor(a): Suellen Miranda Amorim  

## Visão Geral

- **Esse *Problem Set* só é possível ser feito por meio da implementação e uso do Banco de Dados do primeiro PSet.**
- Esse terceiro e último PSet foi criado para que nós tivessemos um breve contato com uma _query_ hierárquica. O objetivo era descobrir como formular um comando que mostrasse claramente todas as classificações de produtos, indicando que classificação é filha e que classificação é pai.

Essa foi a forma que encontrei para resolver:

~~~SQL
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
~~~
