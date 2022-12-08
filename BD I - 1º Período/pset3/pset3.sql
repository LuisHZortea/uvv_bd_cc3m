/* =========================================================================== */
/* PSET-3: script para a criação da tabela e carregamento dos dados que serão  */
/*         unilizados na solução do PSET-3.                                    */
/* =========================================================================== */
/* Prof. Abrantes Araújo Silva Filho                                           */
/*       abrantesasf@uvv.br                                                    */
/* =========================================================================== */



/* --------------------------------------------------------------------------- */
/* COMO EXECUTAR:                                                              */
/* --------------------------------------------------------------------------- */
/* Este script parte do pressuposto que você criou e já tem configurado no seu */
/* SGBD PostgreSQL (da máquina virtual ou outro qualquer) os seguintes objetos */
/* conforme detalhados no PSET-1:                                              */
/*    - Seu usuário (com uma senha específica)                                 */
/*    - O banco de dados "uvv"                                                 */
/*    - O esquema "elmasri"                                                    */
/*                                                                             */
/* Se você não tem o banco de dados do PSET-1 pronto, por favor, utilize o     */
/* script padrão de resposta do PSET-1 que o professor colocou no Portal do    */
/* Aluno para preparar tudo.                                                   */
/*                                                                             */
/* Depois que tudo está preparado, ALTERE A LINHA 43 deste script para dizer   */
/* qual é o seu usuário/senha de conexão ao banco de dados. Depois basta       */
/* executar o seguinte comando em um terminal Linux ou console Windows:        */
/*     psql -U postgres -d postgres < pset3.sql                                */
/* --------------------------------------------------------------------------- */



/* --------------------------------------------------------------------------- */
/* CONEXÃO AO BANCO UVV:                                                       */
/* --------------------------------------------------------------------------- */
/* Faz a conexão ao banco de dados com o usuário/senha que você configurar no  */
/* PSET-1:                                                                     */
/* --------------------------------------------------------------------------- */

-- Faz a conexão com o banco de dados (ALTERE O USUÁRIO/SENHA!):
\echo
\echo Conectando ao banco de dados:
\c "dbname=uvv user=luis password=123456"

-- Ajusta o SEARCH_PATH da conexão atual, por via das dúvidas:
SET SEARCH_PATH TO elmasri, "$user", public;



/* --------------------------------------------------------------------------- */
/* CLASSIFICAÇÃO:                                                              */
/* --------------------------------------------------------------------------- */
/* Cria a tabela "classificacao", que serve para armazenar a hierarquia de     */
/* classificações de produtos da empresa, e os demais objetos relacionados     */
/* (constraints, chaves, checks, etc.).                                        */
/* --------------------------------------------------------------------------- */

-- Cria a tabela "classificacao":
\echo
\echo Criando a tabela "classificacao" e objetos relacionados:
CREATE TABLE classificacao (
      	codigo     INT         CONSTRAINT nn_classif_codigo NOT NULL,
      	nome       VARCHAR(75) CONSTRAINT nn_classif_nome   NOT NULL,
      	codigo_pai INT
);

-- Primary key da tabela "classificacao":
ALTER TABLE classificacao ADD CONSTRAINT pk_classificacao
PRIMARY KEY (codigo);

-- Foreign keys da tabela "classificacao":
ALTER TABLE classificacao ADD CONSTRAINT fk_classif_codigo_pai_codigo
FOREIGN KEY (codigo_pai) REFERENCES classificacao (codigo);

-- Comentários da tabela "funcionario".
COMMENT ON TABLE  classificacao            IS 'Tabela que armazena a hierarquia de classificações de produtos.';
COMMENT ON COLUMN classificacao.codigo     IS 'Código da classificação. É a PK da tabela.';
COMMENT ON COLUMN classificacao.nome       IS 'Nome da classificação.';
COMMENT ON COLUMN classificacao.codigo_pai IS 'Código da classificação pai (será a FK do auto-relacionamento).';




/* --------------------------------------------------------------------------- */
/* INSERÇÃO DE DADOS:                                                          */
/* --------------------------------------------------------------------------- */
/* Faz a inserção de dados na tabela classificação, respeitando a ordem devida */
/* de classificações "pai" e "filhos".                                         */
/* --------------------------------------------------------------------------- */

-- Insere dados na tabela "classificacao":
\echo
\echo Inserindo dados na tabela "classificacao":
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (1, 'Enteral', null);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (94, 'A Classificar Enteral', 1);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (95, 'A Classificar Enteral', 94);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (56, 'Complementos Líquidos', 1);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (58, 'Complemento Líquido Padrão', 56);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (57, 'Complementos em Pó', 1);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (59, 'Complemento em Pó Padrão', 57);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (2, 'Descartáveis/Material Auxiliar', 1);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (3, 'Equipo', 2);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (4, 'Material Auxiliar', 2);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (5, 'Sonda', 2);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (6, 'Dietas em Pó', 1);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (7, 'Dieta Enteral/Oral Especializa', 6);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (8, 'Dieta Enteral/Oral Padrão', 6);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (9, 'Dieta Enteral/Oral Pediátrica', 6);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (10, 'Dietas Líquidas', 1);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (11, 'Especializada', 10);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (12, 'Padrão', 10);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (13, 'Pediátrica', 10);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (14, 'Módulos', 1);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (15, 'Módulos De Fibra', 14);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (16, 'Módulos Espessantes', 14);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (17, 'Módulos Protéicos', 14);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (18, 'Módulos Sacarídeos', 14);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (60, 'Módulos Vitamínicos', 14);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (99, 'Suplementos', 1);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (19, 'Suplementos Cremosos', 99);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (20, 'Suplemento Cremoso Padrão', 19);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (21, 'Suplementos Líquidos', 99);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (23, 'Suplemento Liquido Padrão', 21);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (24, 'Suplemento Líquido Pediátrico', 21);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (22, 'Suplementos Liquido Especializado', 21);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (25, 'Suplementos Pó', 99);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (26, 'Suplemento Pó Padrão', 25);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (50, 'Frete', null);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (51, 'Servicos de Frete', 50);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (52, 'Frete em Geral', 51);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (27, 'Parenteral', null);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (96, 'A Classificar Parenteral', 27);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (97, 'A Classificar Parenteral', 96);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (28, 'Descartáveis/Material da Produção', 27);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (29, 'Bolsas', 28);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (30, 'Equipos da Produção', 28);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (31, 'Material Produção', 28);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (62, 'Ribbon e Etiquetas', 28);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (32, 'Insumos', 27);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (61, 'Água para Injeção', 32);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (33, 'Aminoácidos', 32);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (34, 'Eletrólitos', 32);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (35, 'Glicoses', 32);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (36, 'Lipídios', 32);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (37, 'Oligoelementos', 32);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (38, 'Soluções Fisiológicas', 32);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (39, 'Vitaminas', 32);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (71, 'Limpeza e Higienização', 27);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (73, 'Coletores', 71);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (72, 'Saneantes/Desinfetantes Diversos', 71);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (77, 'Material de Transporte', 27);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (78, 'Caixas/Sacos/etc. para Transporte', 77);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (86, 'Manutenção de Temperatura', 77);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (84, 'Outros', 27);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (85, 'Outros Materiais', 84);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (63, 'Patrimônio', null);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (87, 'Bens Imóveis', 63);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (89, 'Outros Bens Imóveis', 87);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (64, 'Bens Móveis', 63);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (88, 'Automóveis em Geral', 64);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (91, 'Eletrodomésticos', 64);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (65, 'Máquinas e Equipamentos', 64);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (90, 'Material de Informática em Geral', 64);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (92, 'Produtos Hospitalres', null);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (93, 'Materiais Especiais de Cosumo', 92);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (47, 'Uso e Consumo', null);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (48, 'Em Geral' , 47);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (83, 'Impressos em Geral', 48);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (55, 'Infraestrutura e Manutenção', 48);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (76, 'Livros/Guias/Referências', 48);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (70, 'Material de Copa e Cozinha', 48);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (49, 'Material de Informática', 48);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (74, 'Material de Limpeza e Higiene', 48);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (53, 'Material de Expediente/Escritório', 48);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (75, 'Uniformes/Roupas/Outros', 48);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (79, 'Utilidades', 47);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (80, 'Energia Elétrica', 79);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (82, 'Internet', 79);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (81, 'Telefonia', 79);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (43, 'Vendas Parenterais', null);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (44, 'Adultos', 43);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (66, 'Bolsas/Kit', 43);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (67, 'Adulto', 66);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (68, 'Infantil', 66);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (69, 'Veterinária', 66);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (45, 'Infantil', 43);
INSERT INTO classificacao (codigo, nome, codigo_pai) VALUES (46, 'Veterinária', 43);



/* FIM DO SCRIPT */
