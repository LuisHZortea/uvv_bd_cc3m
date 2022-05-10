--1ª Questão

select avg(f.salario) as media_salarial, d.nome_departamento
from funcionario f
inner join departamento d
on d.numero_departamento = f.numero_departamento
group by d.nome_departamento;

--2ª Questão

select avg(f.salario) as media_salarial, f.sexo
from funcionario f
group by f.sexo;

--3ª Questão

select d.nome_departamento,
concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_funcionario,
f.data_nascimento,
timestampdiff (year, data_nascimento, curdate()) as idade,
f.salario
from departamento d
inner join funcionario f
on f.numero_departamento = d.numero_departamento;

--4ª Questão

select concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_funcionario,
f.data_nascimento,
timestampdiff (year, data_nascimento, curdate()) as idade,
f.salario as salario_atual,
(case
when (f.salario < 35) then 20
else 15
end) as taxa_reajuste,
(case
when (f.salario < 35) then f.salario + (f.salario * 0.2)
else f.salario + (f.salario * 0.15)
end) as salario_ajustado
from funcionario f;

--5ª Questão

with gerente as (
select concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome,
f.cpf
from funcionario f
)
select d.nome_departamento,
concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) as nome_funcionario,
f.data_nascimento,
timestampdiff (year, data_nascimento, curdate()) as idade,
f.salario,
g.nome as nome_gerente
from departamento d
inner join funcionario f
on f.numero_departamento = d.numero_departamento
inner join gerente g on g.cpf = d.cpf_gerente
order by d.nome_departamento asc, f.salario desc;

-- 6ª Questão

select concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) funcionário, dpt.nome_departamento Departamento, 
concat(d.nome_dependente, ' ', f.nome_meio, ' ', f.ultimo_nome) dependente, timestampdiff(year, d.data_nascimento, curdate()) "Idade do Dependente",
case
when d.sexo = 'M' then "Masculino"
when d.sexo = 'F' then "Feminino"
end "Sexo do Dependente"
from funcionario f
inner join departamento dpt
on f.numero_departamento = dpt.numero_departamento
inner join dependente d
on f.cpf = d.cpf_funcionario;

-- 7ª Questão

select concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) funcionário, dpt.nome_departamento departamento,
concat("R$", ' ', f.salario) Salário
from funcionario f
left outer join dependente d
on f.cpf = d.cpf_funcionario
inner join departamento dpt
on f.numero_departamento = dpt.numero_departamento
where d.cpf_funcionario is null;

-- 8ª Questão

select dpt.nome_departamento departamento, p.nome_projeto projeto,
concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) "Nome Completo", concat(t.horas, "h") Horas
from funcionario f 
inner join departamento dpt 
inner join projeto p 
inner join trabalha_em t
where f.numero_departamento = dpt.numero_departamento 
and p.numero_projeto = t.numero_projeto 
and f.cpf = t.cpf_funcionario 
order by p.numero_projeto;

-- 9ª  Questão

select dpt.nome_departamento Departamento, p.nome_projeto Projeto, sum(distinct(t.horas)) "Tempo Total"
from trabalha_em t
inner join funcionario f
on t.cpf_funcionario = f.cpf
inner join departamento dpt
on f.numero_departamento = dpt.numero_departamento
inner join projeto p
on dpt.numero_departamento = p.numero_departamento
group by p.nome_projeto;

-- 10ª Questão

select avg(f.salario) as media_salarial, d.nome_departamento
from funcionario f
inner join departamento d
on d.numero_departamento = f.numero_departamento
group by d.nome_departamento;

-- 11ª Questão

select concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) Funcionário, p.nome_projeto Projeto,
case
when t.horas > 0 then concat("R$", ' ', t.horas * 50)
else "R$ 0.0"
end "Total Recebido"
from funcionario f
inner join trabalha_em t
on f.cpf = t.cpf_funcionario
inner join projeto p
on t.numero_projeto = p.numero_projeto
order by t.horas desc;

-- 12ª Questão

select dpt.nome_departamento Departamento, p.nome_projeto Projeto,
f.primeiro_nome Funcionário, concat(t.horas, "h") "Horas de Trabalho"
from funcionario f 
inner join departamento dpt
on f.numero_departamento = dpt.numero_departamento
inner join projeto p
on dpt.numero_departamento = p.numero_departamento
inner join trabalha_em t
on p.numero_projeto = t.numero_projeto
where t.horas = 0;

-- 13ª Questão

select concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) "Nome Completo",
case
when f.sexo = "M" then "Masculino"
when f.sexo = "F" then "Feminino"
end Sexo,
timestampdiff(year, f.data_nascimento, curdate()) Idade
from funcionario f
union
select concat(d.nome_dependente, ' ', f.nome_meio, ' ', f.ultimo_nome) "Nome Completo",
case
when d.sexo = "M" then "Masculino"
when d.sexo = "F" then "Feminino"
end Sexo,
timestampdiff(year, d.data_nascimento, curdate()) Idade
from dependente d 
inner join funcionario f
on d.cpf_funcionario = f.cpf
order by idade desc;

-- 14ª Questão

select dpt.nome_departamento Departamento, count(f.numero_departamento) "Qtde. de Funcionários"
from funcionario f
inner join departamento dpt
on f.numero_departamento = dpt.numero_departamento
group by dpt.nome_departamento;

-- 15ª Questão

select distinct concat(f.primeiro_nome, ' ', f.nome_meio, ' ', f.ultimo_nome) "Nome Completo",
dpt.nome_departamento Departamento, p.nome_projeto Projeto
from departamento dpt 
inner join projeto p 
inner join trabalha_em t 
inner join funcionario f 
where dpt.numero_departamento = f.numero_departamento 
and p.numero_projeto = t.numero_projeto 
and t.cpf_funcionario = f.cpf
order by p.nome_projeto desc;
