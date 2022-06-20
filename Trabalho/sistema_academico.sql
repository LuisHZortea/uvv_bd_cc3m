--Esse é o primeiro passo, é a conexão ao SGBD MariaDB/MYSQL.
mysql -u root -p
computacao@raiz

--A seguir, a criação do banco de dados "sistema_academico"
create database sistema_academico;
use sistema_academico;

--Criação da tabela "cep"
CREATE TABLE cep (
                cep VARCHAR(8) NOT NULL,
                PRIMARY KEY (cep)
);

-- Comentários da tabela "cep"
ALTER TABLE cep COMMENT 'Tabela que armazena os CEPs.';

ALTER TABLE cep MODIFY COLUMN cep VARCHAR(8) COMMENT 'PK da tabela. É o próprio CEP.';

--Criação da tabela "uf"
CREATE TABLE uf (
                sigla VARCHAR(2) NOT NULL,
                nome VARCHAR(100) NOT NULL,
                PRIMARY KEY (sigla)
);

-- Comentários da tabela "uf"
ALTER TABLE uf COMMENT 'Tabela que armazena as unidades da federação.';

ALTER TABLE uf MODIFY COLUMN sigla VARCHAR(2) COMMENT 'PK da tabela. É a sigla padronizada de cada estado.';

ALTER TABLE uf MODIFY COLUMN nome VARCHAR(100) COMMENT 'Nome da unidade da federação.';

--Criação da tabela "cidade"
CREATE TABLE cidade (
                codigo INT NOT NULL,
                nome VARCHAR(100) NOT NULL,
                PRIMARY KEY (codigo)
);

-- Comentários da tabela "cidade"
ALTER TABLE cidade COMMENT 'Tabela que armazena os dados referentes às cidades.';

ALTER TABLE cidade MODIFY COLUMN codigo INTEGER COMMENT 'PK da tabela. Armazena um código único e exclusivo para cada cidade.';

ALTER TABLE cidade MODIFY COLUMN nome VARCHAR(100) COMMENT 'Nome padronizado da cidade.';

--Criação da tabela "bairro"
CREATE TABLE bairro (
                codigo INT NOT NULL,
                nome VARCHAR(100) NOT NULL,
                PRIMARY KEY (codigo)
);

-- Comentários da tabela "bairro"
ALTER TABLE bairro COMMENT 'Tabela que armazena';

ALTER TABLE bairro MODIFY COLUMN codigo INTEGER COMMENT 'PK da tabela. Código único para cada bairro.';

ALTER TABLE bairro MODIFY COLUMN nome VARCHAR(100) COMMENT 'Nome padronizado do bairro.';

--Criação da tabela "complemento"
CREATE TABLE complemento (
                complemento VARCHAR(100) NOT NULL,
                PRIMARY KEY (complemento)
);

-- Comentários da tabela "complemento"
ALTER TABLE complemento COMMENT 'Tabela que armazena';

ALTER TABLE complemento MODIFY COLUMN complemento VARCHAR(100) COMMENT 'Complemento do logradouro. É a PK dessa tabela.';

--Criação da tabela "numero"
CREATE TABLE numero (
                numero INT NOT NULL,
                PRIMARY KEY (numero)
);

-- Comentários da tabela "numero"
ALTER TABLE numero COMMENT 'Tabela que armazena';

--Criação da tabela "logradouro"
CREATE TABLE logradouro (
                logradouro VARCHAR(100) NOT NULL,
                PRIMARY KEY (logradouro)
);

-- Comentários da tabela "logradouro"
ALTER TABLE logradouro COMMENT 'Tabela que armazena o nome da rua, avenida, etc.';

ALTER TABLE logradouro MODIFY COLUMN logradouro VARCHAR(100) COMMENT 'Nome da rua, avenida, etc. É a PK dessa tabela.';

--Criação da tabela "pessoas"
CREATE TABLE pessoas (
                codigo_da_pessoa INT NOT NULL,
                nome VARCHAR(50) NOT NULL,
                data_cadastro DATE NOT NULL,
                email VARCHAR(50),
                complemento VARCHAR(100),
                uf VARCHAR(2) NOT NULL,
                codigo_cidade INT NOT NULL,
                codigo_bairro INT NOT NULL,
                numero INT NOT NULL,
                logradouro VARCHAR(100) NOT NULL,
                cep VARCHAR(8) NOT NULL,
                PRIMARY KEY (codigo_da_pessoa)
);

-- Comentários da tabela "pessoas"
ALTER TABLE pessoas COMMENT 'Tabela que armazena';

ALTER TABLE pessoas MODIFY COLUMN codigo_da_pessoa INTEGER COMMENT 'PK da tabela. Código único para cada pessoa.';

ALTER TABLE pessoas MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome completo da pessoa.';

ALTER TABLE pessoas MODIFY COLUMN data_cadastro DATE COMMENT 'Data na qual a pessoa fez o seu cadastro.';

ALTER TABLE pessoas MODIFY COLUMN email VARCHAR(50) COMMENT 'Email da pessoa.';

ALTER TABLE pessoas MODIFY COLUMN complemento VARCHAR(100) COMMENT 'Complemento do logradouro.';

ALTER TABLE pessoas MODIFY COLUMN uf VARCHAR(2) COMMENT 'FK para a tabela de unidades da federação.';

ALTER TABLE pessoas MODIFY COLUMN codigo_cidade INTEGER COMMENT 'FK para a tabela cidade.';

ALTER TABLE pessoas MODIFY COLUMN codigo_bairro INTEGER COMMENT 'FK para a tabela bairro.';

ALTER TABLE pessoas MODIFY COLUMN numero INTEGER COMMENT 'FK para a tabela telefones.';

ALTER TABLE pessoas MODIFY COLUMN logradouro VARCHAR(100) COMMENT 'Nome da rua, avenida, etc.';

ALTER TABLE pessoas MODIFY COLUMN cep VARCHAR(8) COMMENT 'PK da tabela. É o próprio CEP.';

--Criação da tabela "alunos"
CREATE TABLE alunos (
                codigo_da_pessoa INT NOT NULL,
                matricula INT NOT NULL,
                PRIMARY KEY (codigo_da_pessoa)
);

-- Comentários da tabela "alunos"
ALTER TABLE alunos COMMENT 'Tabela que armazena informações sobre os alunos.';

ALTER TABLE alunos MODIFY COLUMN codigo_da_pessoa INTEGER COMMENT 'Código da pessoa, neste caso aluno, é PK nesta tabela e FK para a tabela pessoas.';

ALTER TABLE alunos MODIFY COLUMN matricula INTEGER COMMENT 'Matrícula do aluno.';

--Criação da tabela "professores"
CREATE TABLE professores (
                codigo_da_pessoa INT NOT NULL,
                PRIMARY KEY (codigo_da_pessoa)
);

-- Comentários da tabela "professores"
ALTER TABLE professores COMMENT 'Tabela que armazena informações sobre os professores.';

ALTER TABLE professores MODIFY COLUMN codigo_da_pessoa INTEGER COMMENT 'Código da pessoa, neste caso professor, É PK nesta tabela.';

--Criação da tabela "ofertas"
CREATE TABLE ofertas (
                codigo_da_oferta INT NOT NULL,
                codigo_do_professor INT NOT NULL,
                semestre INT NOT NULL,
                quantidade_minima_alunos INT NOT NULL,
                quantidade_maxima_alunos INT NOT NULL,
                PRIMARY KEY (codigo_da_oferta)
);

-- Comentários da tabela "ofertas"
ALTER TABLE ofertas COMMENT 'Tabela que armazena os dados referente as ofertas.';

ALTER TABLE ofertas MODIFY COLUMN codigo_da_oferta INTEGER COMMENT 'Código da oferta. É a PK dessa tabela.';

ALTER TABLE ofertas MODIFY COLUMN codigo_do_professor INTEGER COMMENT 'Código do professor. É FK para a tabela professores.';

ALTER TABLE ofertas MODIFY COLUMN semestre INTEGER COMMENT 'Semestre da oferta.';

ALTER TABLE ofertas MODIFY COLUMN quantidade_minima_alunos INTEGER COMMENT 'Quantidade mínima de alunos.';

ALTER TABLE ofertas MODIFY COLUMN quantidade_maxima_alunos INTEGER COMMENT 'Quantidade máxima de alunos.';

--Criação da tabela "matricula_em"
CREATE TABLE matricula_em (
                codigo_da_pessoa INT NOT NULL,
                codigo_da_oferta INT NOT NULL,
                PRIMARY KEY (codigo_da_pessoa, codigo_da_oferta)
);

-- Comentários da tabela "matricula_em"
ALTER TABLE matricula_em COMMENT 'Tabela que armazena informações sobre quais alunos se matriculam nas devidas ofertas.';

ALTER TABLE matricula_em MODIFY COLUMN codigo_da_pessoa INTEGER COMMENT 'Código da pessoa, neste caso aluno, é PK nesta tabela e FK para a tabela alunos.';

ALTER TABLE matricula_em MODIFY COLUMN codigo_da_oferta INTEGER COMMENT 'Código da oferta que o aluno está se matriculando, é PK nesta tabela e FK para a tabela ofertas.';

--Criação da tabela "professores_pos_graduacao"
CREATE TABLE professores_pos_graduacao (
                codigo_da_pessoa INT NOT NULL,
                diploma VARCHAR(80) NOT NULL,
                PRIMARY KEY (codigo_da_pessoa, diploma)
);

-- Comentários da tabela "professores_pos_graduacao"
ALTER TABLE professores_pos_graduacao COMMENT 'Tabela que armazena as pós-graduações dos professores.';

ALTER TABLE professores_pos_graduacao MODIFY COLUMN codigo_da_pessoa INTEGER COMMENT 'Código da pessoa, neste caso professor, é PK nesta tabela e FK para a tabela professores.';

ALTER TABLE professores_pos_graduacao MODIFY COLUMN diploma VARCHAR(80) COMMENT 'Diplomas de pós graduação que o professor possui.';

--Criação da tabela "professor_graduacao"
CREATE TABLE professor_graduacao (
                codigo_da_pessoa INT NOT NULL,
                diploma VARCHAR(80) NOT NULL,
                PRIMARY KEY (codigo_da_pessoa, diploma)
);

-- Comentários da tabela "professor_graduacao"
ALTER TABLE professor_graduacao COMMENT 'Tabela que armazena as graduações dos professores.';

ALTER TABLE professor_graduacao MODIFY COLUMN codigo_da_pessoa INTEGER COMMENT 'Código da pessoa, neste caso professor, é PK nesta tabela e FK para a tabela professores.';

ALTER TABLE professor_graduacao MODIFY COLUMN diploma VARCHAR(80) COMMENT 'Diplomas de graduação que o professor possui.';

--Criação da tabela "telefones"
CREATE TABLE telefones (
                codigo_da_pessoa INT NOT NULL,
                numero VARCHAR(11) NOT NULL,
                PRIMARY KEY (codigo_da_pessoa, numero)
);

-- Comentários da tabela "telefones"
ALTER TABLE telefones COMMENT 'Tabela que armazena os telefones dos clientes.';

ALTER TABLE telefones MODIFY COLUMN codigo_da_pessoa INTEGER COMMENT 'Código que identifica a pessoa. É a PK dessa tabela e FK para a tabela pessoas.';

ALTER TABLE telefones MODIFY COLUMN numero VARCHAR(11) COMMENT 'Número do telefone do clientes (comporta DDD e número). É a PK dessa tabela.';

--Criação da tabela "cursos"
CREATE TABLE cursos (
                codigo_do_curso INT NOT NULL,
                nome VARCHAR(50) NOT NULL,
                data_de_inicio DATE NOT NULL,
                PRIMARY KEY (codigo_do_curso)
);

-- Comentários da tabela "cursos"
ALTER TABLE cursos COMMENT 'Tabela que armazena informações sobre os cursos.';

ALTER TABLE cursos MODIFY COLUMN codigo_do_curso INTEGER COMMENT 'Código que vai identificar o curso, é PK nesta tabela.';

ALTER TABLE cursos MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome do curso.';

ALTER TABLE cursos MODIFY COLUMN data_de_inicio DATE COMMENT 'Data de inicio do curso.';

--Criação da tabela "fazem_em"
CREATE TABLE fazem_em (
                codigo_da_pessoa INT NOT NULL,
                codigo_do_curso INT NOT NULL,
                PRIMARY KEY (codigo_da_pessoa, codigo_do_curso)
);

-- Comentários da tabela "fazem_em"
ALTER TABLE fazem_em COMMENT 'Tabela que armazena informações de quais cursos os alunos fazem.';

ALTER TABLE fazem_em MODIFY COLUMN codigo_da_pessoa INTEGER COMMENT 'Código da pessoa, neste caso aluno que está fazendo o curso, é PK nesta tabela e FK para a tabela alunos.';

ALTER TABLE fazem_em MODIFY COLUMN codigo_do_curso INTEGER COMMENT 'Código do curso que o aluno está fazendo, é PK nesta tabela e FK para a tabela cursos.';

--Criação da tabela "obras"
CREATE TABLE obras (
                codigo_da_obra INT NOT NULL,
                nome VARCHAR(50) NOT NULL,
                editora VARCHAR(50) NOT NULL,
                tipo VARCHAR(10) NOT NULL CHECK (tipo IN ('livro', 'cd', 'dvd', 'revista')),
                PRIMARY KEY (codigo_da_obra)
);

-- Comentários da tabela "obras"
ALTER TABLE obras COMMENT 'Tabela que armazena as informações referentes às obras.';

ALTER TABLE obras MODIFY COLUMN codigo_da_obra INTEGER COMMENT 'Código da obra. É a PK dessa tabela.';

ALTER TABLE obras MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome da obra.';

ALTER TABLE obras MODIFY COLUMN editora VARCHAR(50) COMMENT 'Nome da editora.';

ALTER TABLE obras MODIFY COLUMN tipo VARCHAR(10) COMMENT 'Tipo da obra. Pode variar entre livro, cd, dvd, e revista.';

--Criação da tabela "volumes"
CREATE TABLE volumes (
                codigo_do_volume INT NOT NULL,
                ano_publicacao DATE NOT NULL,
                edicao INT NOT NULL,
                codigo_da_obra INT NOT NULL,
                PRIMARY KEY (codigo_do_volume)
);

-- Comentários da tabela "volumes"
ALTER TABLE volumes COMMENT 'Tabela que armazena';

ALTER TABLE volumes MODIFY COLUMN codigo_do_volume INTEGER COMMENT 'Código do volume da obra. É a PK dessa tabela.';

ALTER TABLE volumes MODIFY COLUMN ano_publicacao DATE COMMENT 'Ano de publicação do volume.';

ALTER TABLE volumes MODIFY COLUMN edicao INTEGER COMMENT 'Número da edição do volume.';

ALTER TABLE volumes MODIFY COLUMN codigo_da_obra INTEGER COMMENT 'Código da obra. É FK para a tabela obras.';

--Criação da tabela "emprestimos"
CREATE TABLE emprestimos (
                data_inicio_emprestimo DATE NOT NULL,
                codigo_do_volume INT NOT NULL,
                codigo_da_pessoa INT NOT NULL,
                data_fim_emprestimo DATE NOT NULL,
                data_devolucao DATE NOT NULL,
                PRIMARY KEY (data_inicio_emprestimo, codigo_do_volume, codigo_da_pessoa)
);

-- Comentários da tabela "emprestimos"
ALTER TABLE emprestimos COMMENT 'Tabela que armazena';

ALTER TABLE emprestimos MODIFY COLUMN data_inicio_emprestimo DATE COMMENT 'Data inicial do empréstimo. É a PK desta tabela.';

ALTER TABLE emprestimos MODIFY COLUMN codigo_do_volume INTEGER COMMENT 'Código do volume da obra. É PK nesta tabla e FK para a tabela volumes.';

ALTER TABLE emprestimos MODIFY COLUMN codigo_da_pessoa INTEGER COMMENT 'Código que identifica a pessoa. É PK nesta tabela e FK para a tabela pessoas.';

ALTER TABLE emprestimos MODIFY COLUMN data_fim_emprestimo DATE COMMENT 'Data de término do empréstimo.';

ALTER TABLE emprestimos MODIFY COLUMN data_devolucao DATE COMMENT 'Data de devolução.';

--Criação da tabela "reservas"
CREATE TABLE reservas (
                data_inicio_reserva DATE NOT NULL,
                codigo_da_pessoa INT NOT NULL,
                codigo_do_volume INT NOT NULL,
                data_fim_reserva DATE NOT NULL,
                PRIMARY KEY (data_inicio_reserva, codigo_da_pessoa, codigo_do_volume)
);

-- Comentários da tabela "reservas"
ALTER TABLE reservas COMMENT 'Tabela que armazena';

ALTER TABLE reservas MODIFY COLUMN data_inicio_reserva DATE COMMENT 'Data de inicio da reserva. É a PK da tabela.';

ALTER TABLE reservas MODIFY COLUMN codigo_da_pessoa INTEGER COMMENT 'Código que identifica a pessoa que fez a reserva. É PK nesta tabela e FK para a tabela pessoas.';

ALTER TABLE reservas MODIFY COLUMN codigo_do_volume INTEGER COMMENT 'Código do volume da obra. É PK nesta tabela e FK para a tabela volumes.';

ALTER TABLE reservas MODIFY COLUMN data_fim_reserva DATE COMMENT 'Data de término da reserva.';

--Criação da tabela "disciplinas"
CREATE TABLE disciplinas (
                codigo_da_disciplina INT NOT NULL,
                nome VARCHAR(50) NOT NULL,
                carga_horaria DECIMAL NOT NULL,
                ementa VARCHAR(200) NOT NULL,
                conteudo VARCHAR(200) NOT NULL,
                codigo_da_obra INT NOT NULL,
                PRIMARY KEY (codigo_da_disciplina)
);

-- Comentários da tabela "disciplinas"
ALTER TABLE disciplinas COMMENT 'Tabela que armazena os dados referentes às disciplinas.';

ALTER TABLE disciplinas MODIFY COLUMN codigo_da_disciplina INTEGER COMMENT 'Código da disciplina. É a PK dessa tabela.';

ALTER TABLE disciplinas MODIFY COLUMN nome VARCHAR(50) COMMENT 'Nome da disciplina.';

ALTER TABLE disciplinas MODIFY COLUMN carga_horaria DECIMAL COMMENT 'Carga horária da disciplina.';

ALTER TABLE disciplinas MODIFY COLUMN ementa VARCHAR(200) COMMENT 'Ementa da disciplina.';

ALTER TABLE disciplinas MODIFY COLUMN conteudo VARCHAR(200) COMMENT 'Conteúdo da disciplina.';

ALTER TABLE disciplinas MODIFY COLUMN codigo_da_obra INTEGER COMMENT 'Código da obra. É FK para a tabela volumes.';

--Criação da tabela "envolvem_a"
CREATE TABLE envolvem_a (
                codigo_da_oferta INT NOT NULL,
                codigo_da_disciplina INT NOT NULL,
                PRIMARY KEY (codigo_da_oferta, codigo_da_disciplina)
);

-- Comentários da tabela "envolvem_a"
ALTER TABLE envolvem_a COMMENT 'Tabela que armazena quais ofertas estão relacionadas com as respectivas disciplinas.';

ALTER TABLE envolvem_a MODIFY COLUMN codigo_da_oferta INTEGER COMMENT 'Código da oferta, é PK nesta tabela e FK para a tabela ofertas.';

ALTER TABLE envolvem_a MODIFY COLUMN codigo_da_disciplina INTEGER COMMENT 'Código da disciplina, é PK nesta tabela e FK para a tabela disciplinas.';

--Criação da tabela "compostas_por"
CREATE TABLE compostas_por (
                codigo_do_curso INT NOT NULL,
                codigo_da_disciplina INT NOT NULL,
                PRIMARY KEY (codigo_do_curso, codigo_da_disciplina)
);

-- Comentários da tabela "compostas_por"
ALTER TABLE compostas_por COMMENT 'Tabela que armazena quais disciplinas estão compondo os devidos cursos.';

ALTER TABLE compostas_por MODIFY COLUMN codigo_do_curso INTEGER COMMENT 'Código do curso, é PK nesta tabela e FK para a tabela cursos.';

ALTER TABLE compostas_por MODIFY COLUMN codigo_da_disciplina INTEGER COMMENT 'Código da disciplina, é PK nesta tabela e FK para a tabela disciplinas.';

--Criação da tabela "obras_autor"
CREATE TABLE obras_autor (
                codigo_da_obra INT NOT NULL,
                nome_do_autor VARCHAR(50) NOT NULL,
                PRIMARY KEY (codigo_da_obra)
);

-- Comentários da tabela "obras_autor"
ALTER TABLE obras_autor COMMENT 'Tabela que armazena informações sobre os autores das obras.';

ALTER TABLE obras_autor MODIFY COLUMN codigo_da_obra INTEGER COMMENT 'Código da obra em questão, é a PK desta tabela e FK para a tabela obras.';

ALTER TABLE obras_autor MODIFY COLUMN nome_do_autor VARCHAR(50) COMMENT 'Nome do autor da obra em questão.';


ALTER TABLE pessoas ADD CONSTRAINT cep_pessoas_fk
FOREIGN KEY (cep)
REFERENCES cep (cep)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pessoas ADD CONSTRAINT uf_pessoas_fk
FOREIGN KEY (uf)
REFERENCES uf (sigla)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pessoas ADD CONSTRAINT cidade_pessoas_fk
FOREIGN KEY (codigo_cidade)
REFERENCES cidade (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pessoas ADD CONSTRAINT bairro_pessoas_fk
FOREIGN KEY (codigo_bairro)
REFERENCES bairro (codigo)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pessoas ADD CONSTRAINT complemento_pessoas_fk
FOREIGN KEY (complemento)
REFERENCES complemento (complemento)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pessoas ADD CONSTRAINT numero_pessoas_fk
FOREIGN KEY (numero)
REFERENCES numero (numero)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pessoas ADD CONSTRAINT logradouro_pessoas_fk
FOREIGN KEY (logradouro)
REFERENCES logradouro (logradouro)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE telefones ADD CONSTRAINT pessoas_telefones_fk
FOREIGN KEY (codigo_da_pessoa)
REFERENCES pessoas (codigo_da_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE emprestimos ADD CONSTRAINT pessoas_emprestimos_fk
FOREIGN KEY (codigo_da_pessoa)
REFERENCES pessoas (codigo_da_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE professores ADD CONSTRAINT pessoas_professores_fk
FOREIGN KEY (codigo_da_pessoa)
REFERENCES pessoas (codigo_da_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE alunos ADD CONSTRAINT pessoas_alunos_fk
FOREIGN KEY (codigo_da_pessoa)
REFERENCES pessoas (codigo_da_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE reservas ADD CONSTRAINT pessoas_reservas_fk
FOREIGN KEY (codigo_da_pessoa)
REFERENCES pessoas (codigo_da_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fazem_em ADD CONSTRAINT alunos_fazem_em_fk
FOREIGN KEY (codigo_da_pessoa)
REFERENCES alunos (codigo_da_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE matricula_em ADD CONSTRAINT alunos_matricula_em_fk
FOREIGN KEY (codigo_da_pessoa)
REFERENCES alunos (codigo_da_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE professor_graduacao ADD CONSTRAINT professores_graduacao_fk
FOREIGN KEY (codigo_da_pessoa)
REFERENCES professores (codigo_da_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE professores_pos_graduacao ADD CONSTRAINT professores_pos_graduacao_fk
FOREIGN KEY (codigo_da_pessoa)
REFERENCES professores (codigo_da_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE ofertas ADD CONSTRAINT professores_ofertas_fk
FOREIGN KEY (codigo_do_professor)
REFERENCES professores (codigo_da_pessoa)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE matricula_em ADD CONSTRAINT ofertas_matricula_em_fk
FOREIGN KEY (codigo_da_oferta)
REFERENCES ofertas (codigo_da_oferta)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envolvem_a ADD CONSTRAINT ofertas_envolvem_a_fk
FOREIGN KEY (codigo_da_oferta)
REFERENCES ofertas (codigo_da_oferta)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE fazem_em ADD CONSTRAINT cursos_fazem_em_fk
FOREIGN KEY (codigo_do_curso)
REFERENCES cursos (codigo_do_curso)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE compostas_por ADD CONSTRAINT cursos_compostas_por_fk
FOREIGN KEY (codigo_do_curso)
REFERENCES cursos (codigo_do_curso)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE obras_autor ADD CONSTRAINT obras_autor_fk
FOREIGN KEY (codigo_da_obra)
REFERENCES obras (codigo_da_obra)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE disciplinas ADD CONSTRAINT obras_disciplinas_fk
FOREIGN KEY (codigo_da_obra)
REFERENCES obras (codigo_da_obra)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE volumes ADD CONSTRAINT obras_volumes_fk
FOREIGN KEY (codigo_da_obra)
REFERENCES obras (codigo_da_obra)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE reservas ADD CONSTRAINT volumes_reservas_fk
FOREIGN KEY (codigo_do_volume)
REFERENCES volumes (codigo_do_volume)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE emprestimos ADD CONSTRAINT volumes_emprestimos_fk
FOREIGN KEY (codigo_do_volume)
REFERENCES volumes (codigo_do_volume)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE compostas_por ADD CONSTRAINT disciplinas_compostas_por_fk
FOREIGN KEY (codigo_da_disciplina)
REFERENCES disciplinas (codigo_da_disciplina)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE envolvem_a ADD CONSTRAINT disciplinas_envolvem_a_fk
FOREIGN KEY (codigo_da_disciplina)
REFERENCES disciplinas (codigo_da_disciplina)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
