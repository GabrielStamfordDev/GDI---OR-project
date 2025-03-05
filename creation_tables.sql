-- Criar o tipo objeto para Curso
CREATE OR REPLACE TYPE Curso_t AS OBJECT (
    nome_curso VARCHAR2(50),
    carga_horaria NUMBER,
    CPF_coordenador CHAR(11)
);
/

-- Criar uma tabela de objetos para armazenar os cursos
CREATE TABLE tb_curso OF Curso_t (
    carga_horaria NOT NULL,
    CPF_coordenador NOT NULL,
    CONSTRAINT curso_pk PRIMARY KEY (nome_curso)
);
/

-- Criar o tipo objeto para Disciplina, incluindo um REF para Curso
CREATE OR REPLACE TYPE Disciplina_t AS OBJECT (
    codigo_disciplina INTEGER,
    nome_disciplina VARCHAR2(50),
    carga_horaria NUMBER,
    curso_ref REF Curso_t -- Referência ao Curso
);
/

-- Criar uma tabela de objetos para armazenar as disciplinas
CREATE TABLE Disciplina OF Disciplina_t (
    nome_disciplina NOT NULL,
    carga_horaria NOT NULL,
    curso_ref WITH ROWID REFERENCES tb_curso, -- ✅ Correção aqui!
    CONSTRAINT disciplina_pk PRIMARY KEY (codigo_disciplina)
);
/

-- Inserir um curso
INSERT INTO tb_curso VALUES ('Banco de Dados', 120, '12345678901');

-- Inserir uma disciplina referenciando um curso usando REF
-- Eu tentei inserir em disciplina antes de inserir o curso. Não deu um erro, como daria usando FOREIGN KEY, mas pelo menos ele não adicionou nada em disciplina
INSERT INTO Disciplina
SELECT 101, 'SQL Avançado', 60, REF(c)
FROM tb_curso c
WHERE c.nome_curso = 'Banco de Dados';
/

SELECT d.codigo_disciplina, d.nome_disciplina, d.carga_horaria,
       DEREF(d.curso_ref).nome_curso AS curso
FROM Disciplina d;
