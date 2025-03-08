-- Criando sequência para código da disciplina
CREATE SEQUENCE codigo_disciplina 
    INCREMENT BY 1 
    START WITH 1;

-- Criando sequência para código do curso
CREATE SEQUENCE codigo_curso 
    INCREMENT BY 1 
    START WITH 1;

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

-- Para criar objeto pessoa, preciso, antes, criar o objeto telefone e usar varray para representar o atributo multivalorado

CREATE OR REPLACE TYPE telefone_pessoa_tp AS OBJECT(
    telefone_pessoa VARCHAR(11)   
);
/

CREATE OR REPLACE TYPE tp_telefone AS VARRAY(5) OF telefone_pessoa_tp; 
/

-- Criando objeto tipo pessoa

CREATE OR REPLACE TYPE tp_pessoa AS OBJECT(
    CPF CHAR(11),
    rua VARCHAR2(50),
    cidade VARCHAR2(20),
    numero NUMBER,
    CEP CHAR(8),
    data_nascimento DATE,
    email VARCHAR2(30),
    nome VARCHAR2(50),
    telefone tp_telefone,
    MEMBER PROCEDURE dizer_idade
)NOT FINAL NOT INSTANTIABLE;
/

CREATE OR REPLACE TYPE BODY tp_pessoa AS

MEMBER PROCEDURE dizer_idade IS
    idade INTEGER;
    BEGIN
        idade := TRUNC(MONTHS_BETWEEN(SYSDATE, data_nascimento) / 12);
        DBMS_OUTPUT.PUT_LINE('A pessoa de CPF: ' || CPF || ' tem ' || idade || ' anos');
    END;
END;
/

--VOU TESTAR O PROCEDURE LÁ EMBAIXO COM ALUNO

-- Para manter a ideia de transitividade de cargo e salário do professo, irei criar um tipo de objeto contendo ambos.

CREATE OR REPLACE TYPE cargo_salario_professor AS OBJECT(
    cargo VARCHAR(20),
    salario NUMBER
);
/

CREATE TABLE professor_cargo of cargo_salario_professor(
    CONSTRAINT professor_cargo_pk PRIMARY KEY(cargo)
);
/


-- Criando tipo professor

CREATE OR REPLACE TYPE tp_professor UNDER tp_pessoa(
    data_contratacao DATE,
    CPF_supervisor REF tp_professor,
    cargo REF cargo_salario_professor
);
/
    
CREATE TABLE Professor OF tp_professor(
    CONSTRAINT professor_pk PRIMARY KEY(CPF),
    CPF_supervisor SCOPE IS Professor,
    cargo SCOPE IS professor_cargo
);

--Para checar se está tudo ok com professor, vou inserir um cargo e salario e um professor

INSERT INTO professor_cargo VALUES (cargo_salario_professor('Coordenador', 8000));

INSERT INTO Professor VALUES (tp_professor('32450176829', 'Rua Real da Torre', 'Recife', 705, '50610000', TO_DATE('15-06-1985','DD-MM-YYYY'), 'ana.souza@gmail.com', 'Ana Souza', tp_telefone(telefone_pessoa_tp('81982366399'), telefone_pessoa_tp('81922577399')), TO_DATE('03-05-2015', 'DD-MM-YYYY'), null, (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Coordenador')));

SELECT T.*, P.cargo.cargo, P.cargo.salario, P.CPF FROM Professor P, TABLE(P.telefone) T;

-- Agora que criei um professor e testei, vou criar um outro professor que será supervisionado pelo primeiro, para testar o auto-relacionamento
--Vou antes, adicionar mais um cargo

INSERT INTO professor_cargo VALUES (cargo_salario_professor('Professor', 5000));

INSERT INTO Professor VALUES (tp_professor('48273956108', 'Avenida 17 de Agosto', 'Recife', 2413, '52061540', TO_DATE('10-12-2000','DD-MM-YYYY'), 'joao.santos@gmail.com', 'João Santos', tp_telefone(telefone_pessoa_tp('81982399389'), telefone_pessoa_tp('81881177399')), TO_DATE('23-09-2018', 'DD-MM-YYYY'), (SELECT REF(P) FROM Professor P WHERE P.CPF = '32450176829'), (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Professor')));

--Printando para testar

SELECT T.*, P.cargo.cargo, P.cargo.salario, P.CPF, P.CPF_supervisor.nome, P.CPF_supervisor.CPF  FROM Professor P, TABLE(P.telefone) T;

-- Vou criar um map em pesssoa para ordenar pela data de nascimento. Não quero que nenhum subtipo possa mudar esse map
ALTER TYPE tp_pessoa ADD FINAL MAP MEMBER FUNCTION data_nasc RETURN DATE CASCADE;
/

CREATE OR REPLACE TYPE BODY tp_pessoa AS

MEMBER PROCEDURE dizer_idade IS
    idade INTEGER;
    BEGIN
        idade := TRUNC(MONTHS_BETWEEN(SYSDATE, data_nascimento) / 12);
        DBMS_OUTPUT.PUT_LINE('A pessoa de CPF: ' || CPF || ' tem ' || idade || ' anos');
    END;  

FINAL MAP MEMBER FUNCTION data_nasc RETURN DATE IS
BEGIN
RETURN data_nascimento;
END data_nasc;
END;
/

/*
--reescrevendo dizer idade de pessoa

CREATE OR REPLACE TYPE BODY tp_professor AS
    
OVERRIDING MEMBER PROCEDURE dizer_idade IS
    idade INTEGER;
    anos_servico INTEGER;
    BEGIN
        idade := TRUNC(MONTHS_BETWEEN(SYSDATE, data_nascimento) / 12);
        anos_servico:= TRUNC(MONTHS_BETWEEN(SYSDATE, data_contratacao) / 12);
        DBMS_OUTPUT.PUT_LINE('A pessoa de CPF: ' || CPF || ' tem ' || idade || ' anos e tem ' || anos_servico || ' de tempo como professor ');
    END;  
END;
/
--Testando

DECLARE
    p tp_professor;
BEGIN
    SELECT VALUE(P) INTO p 
    FROM Professor P
    WHERE CPF = '48273956108';

    p.dizer_idade();
END;
/

*/
--Testando o MAP com os 2 professores inseridos
--O select deu certo, pois printou primeiro ana, que é mais velha e depois joao

SELECT T.*, P.cargo.cargo, P.cargo.salario, P.CPF, P.CPF_supervisor.nome, P.CPF_supervisor.CPF  FROM Professor P, TABLE(P.telefone) T ORDER BY P.data_nasc();

-- Agora que criei professor, posso criar curso, já que ele referencia professor

-- Criando o tipo de objeto curso
CREATE OR REPLACE TYPE Curso_t AS OBJECT (
    codigo_curso INTEGER,
    nome_curso VARCHAR2(50),
    carga_horaria NUMBER,
    coordenador REF tp_professor
);
/

-- Criando a tabela de objeto do tipo curso
CREATE TABLE tb_curso OF Curso_t (
    carga_horaria NOT NULL,
    CONSTRAINT curso_pk PRIMARY KEY (codigo_curso),
    coordenador WITH ROWID REFERENCES Professor
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
INSERT INTO tb_curso VALUES (codigo_curso.NEXTVAL, 'Banco de Dados', 120, (SELECT REF(P) FROM Professor P WHERE P.CPF = '32450176829'));

-- Inserir uma disciplina referenciando um curso usando REF
-- Eu tentei inserir em disciplina antes de inserir o curso. Não deu um erro, como daria usando FOREIGN KEY, mas pelo menos ele não adicionou nada em disciplina
INSERT INTO Disciplina
SELECT codigo_disciplina.NEXTVAL, 'SQL Avançado', 60, REF(c)
FROM tb_curso c
WHERE c.nome_curso = 'Banco de Dados';
/
-- printando o que adicionei em curso
SELECT  C.codigo_curso, C.carga_horaria, C.coordenador.CPF, C.coordenador.nome FROM tb_curso C;
-- printando o que adicionei em disicplina
SELECT d.codigo_disciplina, d.nome_disciplina, d.carga_horaria, DEREF(d.curso_ref).nome_curso AS nome_curso
FROM Disciplina d;

-- Criando subtipo aluno de pessoa

CREATE OR REPLACE TYPE tp_aluno UNDER tp_pessoa(
    numero_matricula VARCHAR2(11),
    status VARCHAR2(20),
    data_matricula DATE,
    curso REF Curso_t
);
/
    
CREATE TABLE Aluno OF tp_aluno(
    CONSTRAINT pessoa_pk PRIMARY KEY(CPF),
    curso SCOPE IS tb_curso
);

-- Inserindo aluno para testar

INSERT INTO Aluno VALUES (tp_aluno('85619370518', 'Rua Conselheiro Portela', 'Recife', 139, '52020212', TO_DATE('01-01-2000', 'DD-MM-YYYY'), 'carlos.silva@gmail.com', 'Carlos Silva', tp_telefone(telefone_pessoa_tp('81982374309'), telefone_pessoa_tp('81981577399')),  '20250001', 'Ativo', TO_DATE('12-01-2022', 'DD-MM-YYYY'), (SELECT REF(C) FROM tb_curso C WHERE C.codigo_curso = 1)));

-- Printando aluno inserido

-- Esse select funcionava antes de adicionar ref para curso SELECT * FROM Aluno;

-- Printando o atributo multivalorado telefone
SELECT * FROM TABLE(SELECT A.telefone FROM Aluno A);

-- Testando o PROCEDURE dizer_idade de pessoa com aluno

DECLARE
    a tp_aluno;
BEGIN
    SELECT VALUE(A) INTO a 
    FROM Aluno A
    WHERE CPF = '85619370518';

    a.dizer_idade();
END;
/

-- NÃO É POSSÍVEL APLICAR O CÓDIGO COMENTADO ABAIXO
-- NO ORACLE SQL ÃO TEM COMO COLOCA RPARTE OU O REF COMO CHAVE PRIMÁRIA OU PARTE DELA
-- DESSA MANEIRA, TEREI QUE USAR A RESTRIÇÃO DE FOREIGN KEY RELACIONAL MESMO

--Antes de criar tipo turma, preciso criar o tipo data_aula do atributo multivalorado de turma

/*CREATE OR REPLACE TYPE tp_data_aula_turma AS OBJECT(
    horario DATE,
    dia_semana VARCHAR(13)
);
/

--Criando a nested table que vai conter esses atributos multivalorados

CREATE TYPE nt_data_aula AS TABLE OF tp_data_aula_turma;
/
    
--Criando tipo turma

CREATE OR REPLACE TYPE tp_turma AS OBJECT(
    codigo_turma VARCHAR2(10),
    codigo_disciplina REF Disciplina_t,
    lista_datas_aulas nt_data_aula
);
/

CREATE TABLE Turma OF tp_turma (
    disciplina WITH ROWID REFERENCES Disciplina,
    CONSTRAINT turma_pk PRIMARY KEY (codigo_turma, disciplina)
)NESTED TABLE lista_datas_aulas STORE AS tb_lista_datas_aulas;
/
*/

CREATE OR REPLACE TYPE tp_data_aula_turma AS OBJECT(
    horario DATE,
    dia_semana VARCHAR(13)
);
/

--Criando a nested table que vai conter esses atributos multivalorados

CREATE TYPE nt_data_aula AS TABLE OF tp_data_aula_turma;
/

--Criando tipo turma

CREATE OR REPLACE TYPE tp_turma AS OBJECT(
    codigo_turma VARCHAR2(10),
    codigo_disciplina INTEGER,
    lista_datas nt_data_aula
);
/
    
--Criando tabela Turma

CREATE TABLE Turma OF tp_turma(
    CONSTRAINT turma_pk PRIMARY KEY(codigo_turma,codigo_disciplina),
    CONSTRAINT turma_codigo_disciplina_fk FOREIGN KEY(codigo_disciplina) REFERENCES Disciplina(codigo_disciplina)
)NESTED TABLE lista_datas STORE AS tb_lista_datas_aulas;
/

-- Criando uma turma

INSERT INTO Turma VALUES(tp_turma('T01', 1, nt_data_aula(tp_data_aula_turma(TO_DATE('10:00:00', 'HH24:MI:SS'), 'SEGUNDA'), tp_data_aula_turma(TO_DATE('10:00:00', 'HH24:MI:SS'), 'QUARTA'))));

--Checando 

SELECT T.codigo_turma, T.codigo_disciplina, TB.* FROM Turma T, TABLE(T.lista_datas) TB;

--Se eu tentar inserir uma turma com codigo de disicplina que nao existe, da erro de integridade. eu testei e deu certo

--Para criar o relacionamento ensina, basta criar o tipo e a tabela do tipo ensina, contendo as REF para as entidades que participam do relacionamento

CREATE OR REPLACE TYPE tp_ensina AS OBJECT(
    professor REF tp_professor,
    sala REF sala_tp,
    turma REF tp_turma
);
/

CREATE TABLE Ensina OF tp_ensina(
    professor WITH ROWID REFERENCES Professor,
    sala WITH ROWID REFERENCES tb_sala,
    turma WITH ROWID REFERENCES Turma
);
/

--Vamos adicionar referente às linhas já adiconadas das entidades em questão

INSERT INTO Ensina VALUES (tp_ensina((SELECT REF(P) FROM Professor P WHERE P.CPF = '32450176829'), (SELECT REF(S) FROM tb_sala S WHERE S.local.predio = 'Predio E' AND S.local.num_sala = 'D009'), (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T01' AND T.codigo_disciplina = 1)));

--Checando

SELECT E.professor.CPF, E.sala.capacidade, E.turma.codigo_turma FROM Ensina E;

--Criando o tipo Matrícula

CREATE SEQUENCE codigo_matricula
    INCREMENT BY 1 
    START WITH 1;

CREATE OR REPLACE TYPE tp_matricula AS OBJECT(
    codigo_matricula INTEGER,
    turma REF tp_turma,
    aluno REF tp_aluno
);
/

CREATE TABLE Matricula OF tp_matricula(
    turma WITH ROWID REFERENCES Turma,
    aluno WITH ROWID REFERENCES Aluno,
    CONSTRAINT matricula_pk PRIMARY KEY(codigo_matricula)
);
/

--Inserindo Matricula para testar e depois consultando

INSERT INTO Matricula VALUES (tp_matricula(codigo_matricula.NEXTVAL, (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T01' AND T.codigo_disciplina = 1), (SELECT REF(A) FROM Aluno A WHERE A.CPF = '85619370518')));

SELECT M.codigo_matricula, M.turma.codigo_turma, M.aluno.CPF FROM Matricula M;

--Criando o tipo Prova

CREATE OR REPLACE TYPE tp_prova AS OBJECT(
    codigo_prova INTEGER,
    descricao VARCHAR(100),
    pontuacao NUMBER(4,2),
    matricula REF tp_matricula
);
/

CREATE TABLE Prova OF tp_prova(
    CONSTRAINT prova_pk PRIMARY KEY(codigo_prova),
    matricula WITH ROWID REFERENCES Matricula
);
/

--Inserindo prova e consultando

INSERT INTO Prova VALUES (tp_prova(86869, 'Prova 1 de Introdução à Programaçaõ',8.5, (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 1)));

SELECT P.codigo_prova, P.matricula.aluno.CPF FROM Prova P;
