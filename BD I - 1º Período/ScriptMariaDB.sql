--[No Terminal Linux] - Esse é o primeiro passo, é a conexão ao SGBD MariaDB/MYSQL, a criação do usuário, a garantia de seus privilégios no banco de dados, e a criação do banco de dados.

/*Atenção: Os comandos a seguir devem ser colocados no Terminal Linux separadamente para evitar possíveis erros. */
mysql -u root -p
computacao@raiz

CREATE USER 'luis'@'localhost' IDENTIFIED BY '123456';
GRANT ALL ON uvv.* TO 'luis'@'localhost';

system mysql -u luis -p
123456

CREATE DATABASE uvv;
USE uvv;

--[Ainda no Terminal Linux] - O segundo passo é a implementação do projeto Elmasri feito no SQL Power Architect.
CREATE TABLE funcionario (
                cpf char(11) not null,
                primeiro_nome varchar(15) not null,
                nome_meio char(1),
                ultimo_nome varchar(15) not null,
                data_nascimento date,
                endereco varchar(50),
                sexo char(1),
                salario decimal(10,2),
                cpf_supervisor char(11),
                numero_departamento int not null,
                primary key (cpf)
);

ALTER TABLE funcionario COMMENT 'Tabela que armazena as informações dos funcionários.';


CREATE TABLE departamento (
                numero_departamento int not null,
                nome_departamento varchar(15) not null,
                cpf_gerente char(11) not null,
                data_inicio_gerente date,
                primary key (numero_departamento)
);

ALTER TABLE departamento COMMENT 'Tabela que armazena as informações dos departamentos.';


CREATE UNIQUE INDEX departamento_idx
 ON departamento
 ( nome_departamento );

CREATE TABLE localizacoes_departamento (
                numero_departamento int not null,
                local varchar(15) not null,
                primary key (numero_departamento, local)
);

ALTER TABLE localizacoes_departamento COMMENT 'Tabela que armazena as possíveis localizações dos departamentos.';


CREATE TABLE projeto (
                numero_projeto int not null,
                nome_projeto varchar(15) not null,
                local_projeto varchar(15),
                numero_departamento int not null,
                primary key (numero_projeto)
);

ALTER TABLE projeto COMMENT 'Tabela que armazena as informações sobre os projetos dos departamentos.';


CREATE UNIQUE INDEX projeto_idx
 ON projeto
 ( nome_projeto );

CREATE TABLE trabalha_em (
                cpf_funcionario char(11) not null,
                numero_projeto int not null,
                horas decimal(3,1) not null,
                primary key (cpf_funcionario, numero_projeto)
);

ALTER TABLE trabalha_em COMMENT 'Tabela para armazenar quais funcionários trabalham em quais projetos.';


CREATE TABLE dependente (
                cpf_funcionario char(11) not null,
                nome_dependente varchar(15) not null,
                sexo char(1),
                data_nascimento date,
                parentesco varchar(15),
                primary key (cpf_funcionario, nome_dependente)
);

ALTER TABLE dependente COMMENT 'Tabela que armazena as informações dos dependentes dos funcionários.';


ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

--[Ainda no Terminal Linux] - O terceiro e último passo é inserção dos dados no banco de dados.

INSERT INTO funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, numero_departamento)
VALUES ('Jorge', 'E', 'Brito', 88866555576, '1937-11-10', 'Rua do Horto, 35, São Paulo, SP', 'M', 55000, 1);

INSERT INTO funcionario (primeiro_nome, nome_meio, ultimo_nome, cpf, data_nascimento, endereco, sexo, salario, cpf_supervisor, numero_departamento)
VALUES('Jennifer', 'S', 'Souza', 98765432168, '1941-06-20', 'Av.Arthur de Lima, 54, Santo André, SP', 'F', 43000, 88866555576, 4),
('Fernando', 'T', 'Wong', 33344555587, '1955-12-08', 'Rua da Lapa, 34, São Paulo, SP', 'M', 40000, 88866555576, 5),
('André', 'V', 'Pereira', 98798798733, '1969-03-29', 'Rua Timbira, 35, São Paulo, SP', 'M', 25000, 98765432168, 4),
('Alice', 'J', 'Zelaya', 99988777767, '1968-01-19', 'Rua Souza Lima, 35, Curitiba, PR', 'F', 25000, 98765432168, 4),
('Ronaldo', 'K', 'Lima', 66688444476, '1962-09-15', 'Rua Rebouças, 65, Piracicaba, SP', 'M', 38000, 33344555587, 5),
('Joice', 'A', 'Leite', 45345345376, '1972-07-31', 'Av. Lucas Obes, 74, São Paulo, SP', 'F', 25000, 33344555587, 5),
('João', 'B', 'Silva', 12345678966, '1965-01-09', 'Rua das Flores, 751, São Paulo, SP', 'M', 30000, 33344555587, 5);

INSERT INTO departamento (nome_departamento, numero_departamento, cpf_gerente, data_inicio_gerente)
VALUES ('Pesquisa', 5, 33344555587, '1988-05-22'),
('Administração', 4, 98765432168, '1995-01-01'),
('Matriz', 1, 88866555576, '1981-06-19');

INSERT INTO localizacoes_departamento (numero_departamento, local)
VALUES (1, 'São Paulo'),
(4, 'Mauá'),
(5, 'Santo André'),
(5, 'Itu'),
(5, 'São Paulo');

INSERT INTO projeto (nome_projeto, numero_projeto, local_projeto, numero_departamento)
VALUES ('ProdutoX', 1, 'Santo André', 5),
('ProdutoY', 2, 'Itu', 5),
('ProdutoZ', 3, 'São Paulo', 5),
('Informatização', 10, 'Mauá', 4),
('Reorganização', 20, 'São Paulo', 1),
('Novosbeneficios', 30, 'Mauá', 4);

INSERT INTO dependente (cpf_funcionario, nome_dependente, sexo, data_nascimento, parentesco)
VALUES (33344555587, 'Alicia', 'F', '1986-04-05', 'Filha'),
(33344555587, 'Tiago', 'M', '1983-10-25', 'Filho'),
(33344555587, 'Janaína', 'F', '1958-05-03', 'Esposa'),
(98765432168, 'Antonio', 'M', '1942-02-28', 'Marido'),
(12345678966, 'Michael', 'M', '1988-01-04', 'Filho'),
(12345678966, 'Alicia', 'F', '1988-12-30', 'Filha'),
(12345678966, 'Elizabeth', 'F', '1967-05-05', 'Esposa');

INSERT INTO trabalha_em (cpf_funcionario, numero_projeto, horas)
VALUES (12345678966, 1, 32.5),
(12345678966, 2, 7.5),
(66688444476, 3, 40.0),
(45345345376, 1, 20.0),
(45345345376, 2, 20.0),
(33344555587, 2, 10.0),
(33344555587, 3, 10.0),
(33344555587, 10, 10.0),
(33344555587, 20, 10.0),
(99988777767, 30, 30.0),
(99988777767, 10, 10.0),
(98798798733, 10, 35.0),
(98798798733, 30, 5.0),
(98765432168, 30, 20.0),
(98765432168, 20, 15.0),
(88866555576, 20, 0);
