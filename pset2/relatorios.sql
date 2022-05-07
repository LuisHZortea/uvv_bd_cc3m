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
