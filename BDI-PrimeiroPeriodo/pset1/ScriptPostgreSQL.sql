--[No Terminal Linux] - Esse é o primeiro passo, é a conexão ao SGBD Postgres, a criação do usuário, e a garantia de seus privilégios no banco de dados. 

/*Atenção: Os comandos a seguir devem ser colocados no Terminal Linux separadamente para evitar possíveis erros. */

psql -U postgres
computacao@raiz

createuser luis -dPs
123
123
computacao@raiz

psql
computacao@raiz

--[Ainda no Terminal Linux] - O segundo passo é a criação do banco de dados "uvv".
CREATE DATABASE uvv
    WITH 
    OWNER = luis
    TEMPLATE = template0
    ENCODING = 'UTF8'
    LC_COLLATE = 'pt_BR.UTF-8'
    LC_CTYPE = 'pt_BR.UTF-8'
    ALLOW_CONNECTIONS = TRUE;

\c uvv luis;
123

CREATE SCHEMA elmasri
    AUTHORIZATION luis;

SET SEARCH_PATH TO elmasri, "$user", public;

ALTER USER luis
SET SEARCH_PATH TO elmasri, "$user", public;

--[Ainda no Terminal Linux] - O terceiro passo é a implementação do projeto Elmasri feito no SQL Power Architect.
CREATE TABLE funcionario (
                cpf CHAR(11) NOT NULL,
                primeiro_nome VARCHAR(15) NOT NULL,
                nome_meio CHAR(1),
                ultimo_nome VARCHAR(15) NOT NULL,
                data_nascimento DATE,
                endereco VARCHAR(50),
                sexo CHAR(1),
                salario NUMERIC(10,2),
                cpf_supervisor CHAR(11),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT funcionario_pk PRIMARY KEY (cpf)
);
COMMENT ON TABLE funcionario IS 'Tabela que armazena as informações dos funcionários.';
COMMENT ON COLUMN funcionario.cpf IS 'CPF do funcionário. Será a PK da tabela.';
COMMENT ON COLUMN funcionario.primeiro_nome IS 'Primeiro nome do funcionário.';
COMMENT ON COLUMN funcionario.nome_meio IS 'Inicial do nome do meio.';
COMMENT ON COLUMN funcionario.ultimo_nome IS 'Sobrenome do funcionário.';
COMMENT ON COLUMN funcionario.endereco IS 'Endereço do funcionário.';
COMMENT ON COLUMN funcionario.sexo IS 'Sexo do funcionário.';
COMMENT ON COLUMN funcionario.salario IS 'Salário do funcionário.';
COMMENT ON COLUMN funcionario.cpf_supervisor IS 'CPF do supervisor. Será uma FK para a própria tabela (um auto-relacionamento).';
COMMENT ON COLUMN funcionario.numero_departamento IS 'Número do departamento do funcionário.';


CREATE TABLE departamento (
                numero_departamento INTEGER NOT NULL,
                nome_departamento VARCHAR(15) NOT NULL,
                cpf_gerente CHAR(11) NOT NULL,
                data_inicio_gerente DATE,
                CONSTRAINT departamento_pk PRIMARY KEY (numero_departamento)
);
COMMENT ON TABLE departamento IS 'Tabela que armazena as informações dos departamentos.';
COMMENT ON COLUMN departamento.numero_departamento IS 'Número do departamento. É a PK desta tabela.';
COMMENT ON COLUMN departamento.nome_departamento IS 'Nome do departamento. Deve ser único.';
COMMENT ON COLUMN departamento.cpf_gerente IS 'CPF do gerente do departamento. É uma FK para a tabela funcionários.';
COMMENT ON COLUMN departamento.data_inicio_gerente IS 'Data do início do gerente no departamento.';


CREATE UNIQUE INDEX departamento_idx
 ON departamento
 ( nome_departamento );

CREATE TABLE projeto (
                numero_projeto INTEGER NOT NULL,
                nome_projeto VARCHAR(15) NOT NULL,
                local_projeto VARCHAR(15),
                numero_departamento INTEGER NOT NULL,
                CONSTRAINT projeto_pk PRIMARY KEY (numero_projeto)
);
COMMENT ON TABLE projeto IS 'Tabela que armazena as informações sobre os projetos dos departamentos.';
COMMENT ON COLUMN projeto.numero_projeto IS 'Número do projeto. É a PK desta tabela.';
COMMENT ON COLUMN projeto.nome_projeto IS 'Nome do projeto. Deve ser único.';
COMMENT ON COLUMN projeto.local_projeto IS 'Localização do projeto.';
COMMENT ON COLUMN projeto.numero_departamento IS 'Número do departamento. É uma FK para a tabela departamento.';


CREATE UNIQUE INDEX projeto_idx
 ON projeto
 ( nome_projeto );

CREATE TABLE localizacoes_departamento (
                numero_departamento INTEGER NOT NULL,
                local VARCHAR(15) NOT NULL,
                CONSTRAINT localizacoes_departamento_pk PRIMARY KEY (numero_departamento, local)
);
COMMENT ON TABLE localizacoes_departamento IS 'Tabela que armazena as possíveis localizações dos departamentos.';
COMMENT ON COLUMN localizacoes_departamento.numero_departamento IS 'Número do departamento. Faz parta da PK desta tabela e também é uma FK para a tabela departamento.';
COMMENT ON COLUMN localizacoes_departamento.local IS 'Localização do departamento. Faz parte da PK desta tabela.';


CREATE TABLE trabalha_em (
                cpf_funcionario CHAR(11) NOT NULL,
                numero_projeto INTEGER NOT NULL,
                horas NUMERIC(3,1) NOT NULL,
                CONSTRAINT trabalha_em_pk PRIMARY KEY (cpf_funcionario, numero_projeto)
);
COMMENT ON TABLE trabalha_em IS 'Tabela para armazenar quais funcionários trabalham em quais projetos.';
COMMENT ON COLUMN trabalha_em.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN trabalha_em.numero_projeto IS 'Número do projeto. Faz parte da PK desta tabela e é uma FK para a tabela projeto.';
COMMENT ON COLUMN trabalha_em.horas IS 'Horas trabalhadas pelo funcionário neste projeto.';


CREATE TABLE dependente (
                cpf_funcionario CHAR(11) NOT NULL,
                nome_dependente VARCHAR(15) NOT NULL,
                sexo CHAR(1),
                data_nascimento DATE,
                parentesco VARCHAR(15),
                CONSTRAINT dependente_pk PRIMARY KEY (cpf_funcionario, nome_dependente)
);
COMMENT ON TABLE dependente IS 'Tabela que armazena as informações dos dependentes dos funcionários.';
COMMENT ON COLUMN dependente.cpf_funcionario IS 'CPF do funcionário. Faz parte da PK desta tabela e é uma FK para a tabela funcionário.';
COMMENT ON COLUMN dependente.nome_dependente IS 'Nome do dependente. Faz parte da PK desta tabela.';
COMMENT ON COLUMN dependente.sexo IS 'Sexo do dependente.';
COMMENT ON COLUMN dependente.data_nascimento IS 'Data de nascimento do dependente.';
COMMENT ON COLUMN dependente.parentesco IS 'Descrição do parentesco do dependente com o funcionário.';


ALTER TABLE dependente ADD CONSTRAINT funcionario_dependente_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalha_em ADD CONSTRAINT funcionario_trabalha_em_fk
FOREIGN KEY (cpf_funcionario)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE departamento ADD CONSTRAINT funcionario_departamento_fk
FOREIGN KEY (cpf_gerente)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE funcionario ADD CONSTRAINT funcionario_funcionario_fk
FOREIGN KEY (cpf_supervisor)
REFERENCES funcionario (cpf)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE localizacoes_departamento ADD CONSTRAINT departamento_localizacoes_departamento_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE projeto ADD CONSTRAINT departamento_projeto_fk
FOREIGN KEY (numero_departamento)
REFERENCES departamento (numero_departamento)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

ALTER TABLE trabalha_em ADD CONSTRAINT projeto_trabalha_em_fk
FOREIGN KEY (numero_projeto)
REFERENCES projeto (numero_projeto)
ON DELETE NO ACTION
ON UPDATE NO ACTION
NOT DEFERRABLE;

--[Ainda no Terminal Linux] - O quarto e último passo é inserção dos dados no banco de dados.
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
