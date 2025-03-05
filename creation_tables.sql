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
-- printando o que adicionei em curso
SELECT * FROM tb_curso;
-- printando o que adicionei em disicplina
SELECT d.codigo_disciplina, d.nome_disciplina, d.carga_horaria, DEREF(d.curso_ref).nome_curso AS nome_curso
FROM Disciplina d;

-- Criando o tipo de objeto sala. Para isso, preciso antes, criar o tipo de objeto local, que é composto.
CREATE OR REPLACE TYPE local_Sala_tp AS OBJECT(
    predio VARCHAR2(20),
    num_sala VARCHAR2(4)
);
/

-- Vou adicionar um ORDER para ordenar as salas de acordo com a capacidade
CREATE OR REPLACE TYPE sala_tp AS OBJECT(
    local local_Sala_tp,
    capacidade NUMBER,
    ORDER MEMBER FUNCTION comparaCapacidade(S sala_tp) RETURN INTEGER
);
/

--Criando corpo de sala pro order

CREATE OR REPLACE TYPE BODY sala_tp AS ORDER MEMBER FUNCTION comparaCapacidade(S sala_tp) RETURN INTEGER IS
BEGIN 
RETURN SELF.capacidade - S.capacidade;
END;
END;
/
    
-- Criando a tabela de objeto do tipo sala.
CREATE TABLE tb_sala OF sala_tp (
    CONSTRAINT sala_pk PRIMARY KEY (local.predio, local.num_sala)
);
/

-- Inserindo em sala para testar

INSERT INTO tb_sala VALUES (sala_tp(local_Sala_tp('Predio E', 'D009'), 50));

--Printando o que adicionei em sala. Por algum motivo, ele não consegue mostrar o objeto composto em si

SELECT * FROM tb_sala;

-- dividindo o objeto composto no print

SELECT S.local.predio, S.local.num_sala, S.capacidade FROM tb_sala S;

--Vou adicionar outra sala para poder testar o order function

INSERT INTO tb_sala VALUES (sala_tp(local_Sala_tp('Predio D', 'D010'), 25));

--Testando o ORDER

DECLARE
    x sala_tp;
    n INTEGER;
BEGIN
    -- Pegando a sala com maior capacidade
    SELECT VALUE(S) INTO x 
    FROM tb_sala S 
    WHERE S.local.predio = 'Predio E' AND S.local.num_sala = 'D009';

    -- Comparando com outra sala
    SELECT S.comparaCapacidade(x) INTO n 
    FROM tb_sala S 
    WHERE S.local.predio = 'Predio D' AND S.local.num_sala = 'D010';

    -- Verificando a comparação
    IF n > 0 THEN 
        DBMS_OUTPUT.PUT_LINE('Sala em Predio D e numero de sala D010' || 
                             ' tem capacidade maior que a sala em ' || x.local.predio || ' e ' || x.local.num_sala);
    ELSIF n = 0 THEN 
         DBMS_OUTPUT.PUT_LINE('Sala em Predio D e numero de sala D010' || 
                             ' tem capacidade igual que a sala em ' || x.local.predio || ' e ' || x.local.num_sala);
    ELSE 
         DBMS_OUTPUT.PUT_LINE('Sala em Predio D e numero de sala D010' || 
                             ' tem capacidade menor que a sala em ' || x.local.predio || ' e ' || x.local.num_sala);
    END IF;
END;
/
