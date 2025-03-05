-- Criando sequência para código da disciplina
CREATE SEQUENCE codigo_disciplina 
    INCREMENT BY 1 
    START WITH 1;

-- Criando sequência para código do curso
CREATE SEQUENCE codigo_curso 
    INCREMENT BY 1 
    START WITH 1;

-- Criando o tipo de objeto curso
CREATE OR REPLACE TYPE Curso_t AS OBJECT (
    codigo_curso INTEGER,
    nome_curso VARCHAR2(50),
    carga_horaria NUMBER,
    CPF_coordenador CHAR(11)
);
/

-- Criando a tabela de objeto do tipo curso
CREATE TABLE tb_curso OF Curso_t (
    carga_horaria NOT NULL,
    CPF_coordenador NOT NULL,
    CONSTRAINT curso_pk PRIMARY KEY (codigo_curso)
);
/

-- Criando o tipo de objeto disciplina, contendo REF por causa do relacionamento N:1
CREATE OR REPLACE TYPE Disciplina_t AS OBJECT (
    codigo_disciplina INTEGER,
    nome_disciplina VARCHAR2(50),
    carga_horaria NUMBER,
    curso_ref REF Curso_t
);
/

-- Criando a tabela de objeto do tipo disciplina, com ROWID para garantir integridade referencial
CREATE TABLE Disciplina OF Disciplina_t (
    nome_disciplina NOT NULL,
    carga_horaria NOT NULL,
    curso_ref WITH ROWID REFERENCES tb_curso,
    CONSTRAINT disciplina_pk PRIMARY KEY (codigo_disciplina)
);
/

-- Apesar de não ser população, a fim de testes, inserirei um curso e uma disiciplina, para checar se está tudo ok.
INSERT INTO tb_curso VALUES (codigo_curso.NEXTVAL, 'Banco de Dados', 120, '12345678901');

-- Inserir uma disciplina referenciando um curso usando REF
-- Eu tentei inserir em disciplina antes de inserir o curso. Não deu um erro, como daria usando FOREIGN KEY, mas pelo menos ele não adicionou nada em disciplina
INSERT INTO Disciplina
SELECT codigo_disciplina.NEXTVAL, 'SQL Avançado', 60, REF(c)
FROM tb_curso c
WHERE c.nome_curso = 'Banco de Dados';
/
-- printanfo o que adicionei em curso
SELECT * FROM tb_curso;
-- printando o que adicionei em disicplina
SELECT d.codigo_disciplina, d.nome_disciplina, d.carga_horaria, DEREF(d.curso_ref).nome_curso AS nome_curso
FROM Disciplina d;


