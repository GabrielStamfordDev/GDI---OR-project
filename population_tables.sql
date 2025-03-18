Dreammer
dreammer6298
Disponível

victor — 28/11/2024, 20:07
essa é a versão final?
myah — 28/11/2024, 20:10
esse é do slide da monitoria
victor — 28/11/2024, 20:10
saquei
qual o link do diagrama de vocês?
Dreammer — 28/11/2024, 20:38
Nn
myah — 18/12/2024, 16:53
mapeamento
1,2
20%
3,4
20%
5,6
Você votou nesta resposta
20%
7,8
20%
9,10
20%
11,12
0%
Votação encerrada
A pesquisa mapeamento de myah foi encerrada. — 19/12/2024, 16:53
Os resultados foram empatados
20%
pca — 13/01/2025, 15:05
https://github.com/pedrocalheiross/Projeto-GDI
GitHub
GitHub - pedrocalheiross/Projeto-GDI: Projeto de Gerenciamento de D...
Projeto de Gerenciamento de Dados e Informação. Contribute to pedrocalheiross/Projeto-GDI development by creating an account on GitHub.
GitHub - pedrocalheiross/Projeto-GDI: Projeto de Gerenciamento de D...
pca — 13/01/2025, 15:43
CREATE SEQUENCE codigo_disciplina 
    INCREMENT BY 1 
    START WITH 1;

CREATE TABLE curso(
    nome_curso VARCHAR2(50),
    carga_horaria NUMBER NOT NULL,
    cpf_coordenador CHAR(11) NOT NULL,
    CONSTRAINT curso_pk PRIMARY KEY(nome_curso)
);

CREATE TABLE disciplina(
    codigo_disciplina INTEGER,
    nome_disciplina VARCHAR2(20) NOT NULL,
    carga_horaria NUMBER NOT NULL,
    nome_curso VARCHAR2(50) NOT NULL,
    CONSTRAINT disciplina_pk PRIMARY KEY(codigo_disciplina),
    CONSTRAINT disciplina_nome_curso_fk FOREIGN KEY(nome_curso) REFERENCES curso(nome_curso)
);

CREATE TABLE sala(
    predio VARCHAR2(20),
    num_sala VARCHAR2(4),
    capacidade NUMBER,
    CONSTRAINT sala_pk PRIMARY KEY(predio,num_sala)
);

CREATE TABLE turma(
    codigo_turma VARCHAR2(10),
    codigo_disciplina INTEGER,
    CONSTRAINT turma_pk PRIMARY KEY(codigo_turma,codigo_disciplina),
    CONSTRAINT turma_codigo_disciplina_fk FOREIGN KEY(codigo_disciplina) REFERENCES disciplina(codigo_disciplina)
);

CREATE TABLE data_aula(
    codigo_turma VARCHAR2(10),
    codigo_disciplina INTEGER,
    horario,
    dia_semana,
);
--ALTER TABLE curso ADD(CONSTRAINT curso_cpf_coordenador_fk FOREIGN KEY(cpf_coordenador) REFERENCES professor(cpf_professor));
 
pca — 13/01/2025, 16:37
CREATE SEQUENCE codigo_disciplina 
    INCREMENT BY 1 
    START WITH 1;

CREATE TABLE Curso(
    nome_curso VARCHAR2(50),
    carga_horaria NUMBER NOT NULL,
    cpf_coordenador CHAR(11) NOT NULL,
    CONSTRAINT curso_pk PRIMARY KEY(nome_curso)
);

CREATE TABLE Disciplina(
    codigo_disciplina INTEGER,
    nome_disciplina VARCHAR2(20) NOT NULL,
    carga_horaria NUMBER NOT NULL,
    nome_curso VARCHAR2(50) NOT NULL,
    CONSTRAINT disciplina_pk PRIMARY KEY(codigo_disciplina),
    CONSTRAINT disciplina_nome_curso_fk FOREIGN KEY(nome_curso) REFERENCES Curso(nome_curso)
);

CREATE TABLE Sala(
    predio VARCHAR2(20),
    num_sala VARCHAR2(4),
    capacidade NUMBER,
    CONSTRAINT sala_pk PRIMARY KEY(predio,num_sala)
);

CREATE TABLE Turma(
    codigo_turma VARCHAR2(10),
    codigo_disciplina INTEGER,
    CONSTRAINT turma_pk PRIMARY KEY(codigo_turma,codigo_disciplina),
    CONSTRAINT turma_codigo_disciplina_fk FOREIGN KEY(codigo_disciplina) REFERENCES Disciplina(codigo_disciplina)
);

CREATE TABLE Data_aula(
    codigo_turma VARCHAR2(10),
    codigo_disciplina INTEGER,
    horario TIME,
    dia_semana VARCHAR(13),
    CONSTRAINT data_aula_pk PRIMARY KEY (codigo_turma,codigo_disciplina,horario,dia_semana),
    CONSTRAINT data_aula_codigo_turma_fk FOREIGN KEY(codigo_turma) REFERENCES Turma(codigo_turma),
    CONSTRAINT data_aula_codigo_disciplina FOREIGN KEY(codigo_disciplina) REFERENCES Disciplina(codigo_disciplina),
    CONSTRAINT data_aula_horario_check CHECK (dia_semana = SEGUNDA OR dia_semana = TERCA OR dia_semana = QUARTA OR dia_semana = QUINTA OR dia_semana = SEXTA OR dia_semana = SABADO OR dia_semana = DOMINGO), 
    CONSTRAINT data_aula_dia_semana_check CHECK (TO_CHAR(hora, 'HH24:MI:SS') BETWEEN '00:00:00' AND '23:59:59')
);
--ALTER TABLE Curso ADD(CONSTRAINT curso_cpf_coordenador_fk FOREIGN KEY(cpf_coordenador) REFERENCES Professor(cpf_professor));
pca — 13/01/2025, 16:49
CREATE SEQUENCE codigo_disciplina 
    INCREMENT BY 1 
    START WITH 1;

CREATE TABLE Curso(
    nome_curso VARCHAR2(50),
    carga_horaria NUMBER NOT NULL,
    cpf_coordenador CHAR(11) NOT NULL,
    CONSTRAINT curso_pk PRIMARY KEY(nome_curso)
);

CREATE TABLE Disciplina(
    codigo_disciplina INTEGER,
    nome_disciplina VARCHAR2(20) NOT NULL,
    carga_horaria NUMBER NOT NULL,
    nome_curso VARCHAR2(50) NOT NULL,
    CONSTRAINT disciplina_pk PRIMARY KEY(codigo_disciplina),
    CONSTRAINT disciplina_nome_curso_fk FOREIGN KEY(nome_curso) REFERENCES Curso(nome_curso)
);

CREATE TABLE Sala(
    predio VARCHAR2(20),
    num_sala VARCHAR2(4),
    capacidade NUMBER,
    CONSTRAINT sala_pk PRIMARY KEY(predio,num_sala)
);

CREATE TABLE Turma(
    codigo_turma VARCHAR2(10),
    codigo_disciplina INTEGER,
    CONSTRAINT turma_pk PRIMARY KEY(codigo_turma,codigo_disciplina),
    CONSTRAINT turma_codigo_disciplina_fk FOREIGN KEY(codigo_disciplina) REFERENCES Disciplina(codigo_disciplina)
);

CREATE TABLE Data_aula(
    codigo_turma VARCHAR2(10),
    codigo_disciplina INTEGER,
    horario DATE,
    dia_semana VARCHAR(13),
    CONSTRAINT data_aula_pk PRIMARY KEY (codigo_turma,codigo_disciplina,horario,dia_semana),
    CONSTRAINT data_aula_codigo_turma_fk FOREIGN KEY(codigo_turma,codigo_disciplina) REFERENCES Turma(codigo_turma,codigo_disciplina),
    CONSTRAINT data_aula_codigo_disciplina_fk FOREIGN KEY(codigo_disciplina) REFERENCES Disciplina(codigo_disciplina),
    CONSTRAINT data_aula_horario_check CHECK (dia_semana = 'SEGUNDA' OR dia_semana = 'TERCA' OR dia_semana = 'QUARTA' OR dia_semana = 'QUINTA' OR dia_semana = 'SEXTA' OR dia_semana = 'SABADO' OR dia_semana = 'DOMINGO'), 
    CONSTRAINT data_aula_dia_semana_check CHECK (TO_CHAR(horario, 'HH24:MI:SS') BETWEEN '00:00:00' AND '23:59:59')
);
--ALTER TABLE Curso ADD(CONSTRAINT curso_cpf_coordenador_fk FOREIGN KEY(cpf_coordenador) REFERENCES Professor(cpf_professor));
pca — 13/01/2025, 17:44
```SQL
CREATE SEQUENCE codigo_disciplina 
    INCREMENT BY 1 
    START WITH 1;

CREATE TABLE Curso(
Expandir
message.txt
4 KB
pca — 13/01/2025, 17:54
CREATE SEQUENCE codigo_disciplina 
    INCREMENT BY 1 
    START WITH 1;

CREATE TABLE Curso(
    nome_curso VARCHAR2(50),
Expandir
message.txt
6 KB
https://github.com/pedrocalheiross/Projeto-GDI
GitHub
GitHub - pedrocalheiross/Projeto-GDI: Projeto de Gerenciamento de D...
Projeto de Gerenciamento de Dados e Informação. Contribute to pedrocalheiross/Projeto-GDI development by creating an account on GitHub.
GitHub - pedrocalheiross/Projeto-GDI: Projeto de Gerenciamento de D...
pca — 16/01/2025, 10:34
INSERT INTO Pessoa (CPF, rua, cidade, numero, CEP, data_nascimento, email, nome) VALUES('85619370518', 'Rua das Flores', 'São Paulo', 123, '01311000', TO_DATE('01-01-1980', 'DD-MM-YYYY'), 'carlos.silva@gmail.com', 'Carlos Silva');
INSERT INTO Pessoa (CPF, rua, cidade, numero, CEP, data_nascimento, email, nome) VALUES('32450176829', 'Av. Central', 'Rio de Janeiro', 456, '20040002', TO_DATE('15-06-1985','DD-MM-YYYY'), 'ana.souza@gmail.com', 'Ana Souza');
INSERT INTO Pessoa (CPF, rua, cidade, numero, CEP, data_nascimento, email, nome) VALUES('48273956108', 'Rua A', 'Belo Horizonte', 789, '30140071', TO_DATE('10-12-2000','DD-MM-YYYY'), 'joao.santos@gmail.com', 'João Santos');
INSERT INTO Pessoa (CPF, rua, cidade, numero, CEP, data_nascimento, email, nome) VALUES('56189023471', 'Rua B', 'Curitiba', 101, '80230120', TO_DATE('20-03-1995', 'DD-MM-YYYY'), 'maria.oliveira@gmail.com', 'Maria Oliveira');
INSERT INTO Pessoa (CPF, rua, cidade, numero, CEP, data_nascimento, email, nome) VALUES('71028394615', 'Rua C', 'Porto Alegre', 202, '90040100', TO_DATE('11-07-1978', 'DD-MM-YYYY'), 'roberto.lima@gmail.com', 'Roberto Lima');
Expandir
message.txt
7 KB
pca — 07/02/2025, 14:36
https://docs.google.com/document/d/1oNhWW6SxbM_k3CyaaiXd86_8D9AuPGJyHZBMFD1ziGQ/edit?usp=sharing
Google Docs
Cópia de Checklist AV4
SQL ALTER TABLE CREATE INDEX INSERT INTO UPDATE DELETE SELECT-FROM-WHERE BETWEEN IN LIKE IS NULL ou IS NOT NULL INNER JOIN MAX MIN AVG COUNT LEFT ou RIGHT ou FULL OUTER JOIN SUBCONSULTA COM OPERADOR RELACIONAL SUBCONSULTA COM IN SUBCONSULTA COM ANY SUBC...
Imagem
Dreammer — 08/02/2025, 11:07
INSERT INTO Pessoa VALUES('45678912564', 'Avenida Magica', 'Recife', 444499, '50030098', TO_DATE('30-11-1990', 'DD-MM-YYYY'), 'sininho@gmail.com', 'Sininho');
INSERT INTO Pessoa VALUES('45678912009', 'Terra do Nunca', 'Recife', 2019029, '50030099', TO_DATE('11-08-1989', 'DD-MM-YYYY'), 'peter.pan@gmail.com', 'Peter Pan');

INSERT INTO Professor VALUES('45678912564', 'Titular', TO_DATE('15-06-1968', 'DD-MM-YYYY'), '85619370518'); 
INSERT INTO Professor VALUES('45678912009', 'Titular', TO_DATE('14-03-1972', 'DD-MM-YYYY'), '85619370518'); 

SELECT P.CPF_professor, P.data_contratacao, PC.cargo, PC.salario FROM Professor P INNER JOIN Professor_cargo PC ON P.cargo = PC.cargo WHERE PC.salario = (SELECT MAX(salario) FROM Professor_cargo);

SELECT * FROM Curso WHERE carga_horaria = (SELECT MIN(carga_horaria) FROM Curso);

SELECT P.CPF_professor, P.data_contratacao, PC.cargo, PC.salario FROM Professor P INNER JOIN Professor_cargo PC ON P.cargo = PC.cargo     WHERE PC.salario > (SELECT AVG(salario) FROM Professor_cargo);

SELECT nome_curso, COUNT(CPF_aluno) FROM Aluno GROUP BY nome_curso HAVING COUNT() > 2;

SELECT codigo_prova, D.nome_disciplina, P.CPF_aluno, P.pontuacao FROM Prova P INNER JOIN Disciplina D ON P.codigo_disciplina = D.codigo_disciplina WHERE P.pontuacao BETWEEN 8 AND 9;

SELECT nome_curso, carga_horaria FROM Curso WHERE nome_curso LIKE 'Engenharia%' ORDER BY carga_horaria;

/ ESTES DEVEM SER OS ÚLTIMOS COMANDOS */

SELECT A.CPF_aluno FROM Aluno A LEFT JOIN Matricula M ON A.CPF_aluno = M.CPF_aluno;

DELETE FROM Aluno WHERE CPF_aluno IN (SELECT A.CPF_aluno FROM Aluno A LEFT JOIN Matricula M ON A.CPF_aluno = M.CPF_aluno);
Dreammer — 08/02/2025, 21:02
ALTERAR PROVA FOREIGN KEY
ADICIONAR ALUNO FOREIGN KEY

INSERT INTO Pessoa VALUES('45678912564', 'Avenida Magica', 'Recife', 444499, '50030098', TO_DATE('30-11-1990', 'DD-MM-YYYY'), 'sininho@gmail.com', 'Sininho');
INSERT INTO Pessoa VALUES('45678912009', 'Terra do Nunca', 'Recife', 2019029, '50030099', TO_DATE('11-08-1989', 'DD-MM-YYYY'), 'peter.pan@gmail.com', 'Peter Pan');

INSERT INTO Professor VALUES('45678912564', 'Titular', TO_DATE('15-06-1968', 'DD-MM-YYYY'), '85619370518'); 
INSERT INTO Professor VALUES('45678912009', 'Titular', TO_DATE('14-03-1972', 'DD-MM-YYYY'), '85619370518'); 

SELECT P.CPF_professor, P.data_contratacao, PC.cargo, PC.salario FROM Professor P INNER JOIN Professor_cargo PC ON P.cargo = PC.cargo WHERE PC.salario = (SELECT MAX(salario) FROM Professor_cargo);

SELECT * FROM Curso WHERE carga_horaria = (SELECT MIN(carga_horaria) FROM Curso);

SELECT * FROM Sala WHERE capacidade IN (30, 50);

SELECT P.CPF_professor, P.data_contratacao, PC.cargo, PC.salario FROM Professor P INNER JOIN Professor_cargo PC ON P.cargo = PC.cargo WHERE PC.salario > (SELECT AVG(salario) FROM Professor_cargo);

SELECT nome_curso, COUNT(CPF_aluno) FROM Aluno GROUP BY nome_curso HAVING COUNT() > 2;

SELECT codigo_prova, D.nome_disciplina, P.CPF_aluno, P.pontuacao FROM Prova P INNER JOIN Disciplina D ON P.codigo_disciplina = D.codigo_disciplina WHERE P.pontuacao BETWEEN 8 AND 9;

SELECT nome_curso, carga_horaria FROM Curso WHERE nome_curso LIKE 'Engenharia%' ORDER BY carga_horaria;

( SELECT nome_disciplina FROM Disciplina WHERE nome_curso = 'Engenharia da Computação' ) UNION (SELECT nome_curso FROM Disciplina WHERE nome_curso = 'Ciência da Computação');

/ ESTES DEVEM SER OS ÚLTIMOS COMANDOS */

SELECT A.CPF_aluno FROM Aluno A LEFT JOIN Matricula M ON A.CPF_aluno = M.CPF_aluno WHERE M.CPF_aluno IS NULL;

DELETE FROM Aluno WHERE CPF_aluno IN (SELECT A.CPF_aluno FROM Aluno A LEFT JOIN Matricula M ON A.CPF_aluno = M.CPF_aluno WHERE M.CPF_aluno IS NULL);
Dreammer — 09/02/2025, 15:20
ALTER TABLE Disciplina ALTER COLUMN codigo_disciplina DEFAULT codigo_disciplina.NEXTVAL;
Dreammer — 11/02/2025, 14:33
https://codeshare.io/gdiprojetoalnooo
Dreammer — 11/02/2025, 15:43
https://docs.google.com/document/d/1Y4xg80d_PMlFVRljqa7mlCYaghULLJK9gLS0_3s2S2Y/edit?tab=t.0
pca — 11/02/2025, 16:22
CREATE OR REPLACE FUNCTION calcular_media_aluno(
    p_cpf_aluno IN CHAR,
    p_codigo_disciplina IN INTEGER
) RETURN NUMBER IS
    v_total_pontuacao NUMBER := 0;
    v_num_provas INTEGER := 0;
    v_media NUMBER := 0;
BEGIN
    -- Calculate the total score and number of tests for the student in the given discipline
    SELECT SUM(pontuacao), COUNT(*)
    INTO v_total_pontuacao, v_num_provas
    FROM Prova
    WHERE CPF_aluno = p_cpf_aluno
      AND codigo_disciplina = p_codigo_disciplina;

    -- If no tests are found, raise an exception
    IF v_num_provas = 0 THEN
        RAISE_APPLICATION_ERROR(-20001, 'No tests found for the specified student and discipline.');
    END IF;

    -- Calculate the average score
    v_media := v_total_pontuacao / v_num_provas;

    RETURN v_media;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE_APPLICATION_ERROR(-20002, 'No data found for the specified student and discipline.');
    WHEN OTHERS THEN
        RAISE_APPLICATION_ERROR(-20003, 'An unexpected error occurred.');
END;
/
DECLARE
    v_media NUMBER;
BEGIN
    v_media := calcular_media_aluno('56189023471', 1);
    DBMS_OUTPUT.PUT_LINE('Average score: ' || v_media);
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('Error: ' || SQLERRM);
END;
/
 
SELECT P.pontuacao, D.nome_disciplina, P.CPF_aluno
FROM Prova P INNER JOIN Disciplina D ON P.codigo_disciplina = D.codigo_disciplina
WHERE D.nome_disciplina = 'Algoritmos Avançados'
AND P.pontuacao > ALL (
    SELECT P.pontuacao
    FROM Prova P
    INNER JOIN Disciplina D ON P.codigo_disciplina = D.codigo_disciplina
    WHERE D.nome_disciplina = 'Introdução à Programação'
);
pca — 11/02/2025, 16:40
DECLARE
    -- 1. Declaração do tipo TABLE (associative array)
    TYPE tabela_nomes IS TABLE OF VARCHAR2(50) INDEX BY PLS_INTEGER;
    
    -- 2. Variável do tipo TABLE
    v_nomes_alunos tabela_nomes;
BEGIN
    -- 3. Preenche a coleção com nomes de alunos do curso de Engenharia da Computação
    SELECT p.nome
    BULK COLLECT INTO v_nomes_alunos
    FROM Pessoa p
    JOIN Aluno a ON p.CPF = a.CPF_aluno
    WHERE a.nome_curso = 'Engenharia da Computação';

    -- 4. Verifica se há dados e exibe os nomes
    IF v_nomes_alunos.COUNT > 0 THEN
        DBMS_OUTPUT.PUT_LINE('Alunos de Engenharia da Computação:');
        FOR i IN 1..v_nomes_alunos.COUNT LOOP
            DBMS_OUTPUT.PUT_LINE(i || ': ' || v_nomes_alunos(i));
        END LOOP;
    ELSE
        DBMS_OUTPUT.PUT_LINE('Nenhum aluno encontrado neste curso.');
    END IF;
END;
/
Dreammer — 11/02/2025, 18:11
@pca manda aq a subconsulta com o ALL pf eo Alter Table
pca — 11/02/2025, 18:12
a do all ta aq
Dreammer — 11/02/2025, 18:34
e a do ALTER?
@pca altera essa pontuacao pra 8.6, ao inves de 9.2 pf
Imagem
pca — 11/02/2025, 19:03
ok farei
a do alter ainda n saiu n
mudei
pca — 11/02/2025, 20:53
po alter table era pra ser da entrega passada
ALTER TABLE Curso 
ADD CONSTRAINT carga_horaria_positiva 
CHECK (carga_horaria > 0);
 
sla
algo assim
Dreammer — 11/02/2025, 21:41
https://codeshare.io/gdiprojeto
https://codeshare.io/gdiprojeto
pca — 11/02/2025, 21:51
`

/*GRANT SERVE PARA DAR PRIVILÉGIOS A UM DADO USUÁRIO PARA UMA DADA TABELA OU VIEW. ESSES PRIVILÉGIOS PODEM SER VÁRIOS, COMO INSERT, DELETE, ETC.
SEGUE COMANDO GERAL: GRANT <PRIVILEGIOS> ON <TABELA/VIEW> TO <USUARIO>; O USUARIO PODE SER UM USUARIO CADASTRADO OU PODE SER SETADO EM PUBLIC

O REVOKE É JUSTAMENTE O OPOSTO DO GRATN, OU SEJA, REMOVE PROVILEGIOS DE UM DADO USUARIO DE UMA DETERMINADA TABELA OU VIEW. SEGUE COMANDO GERAL:
REVOKE <PRIVILEGIOS> ON <TABELA/VIEW> FORM <USUARIO>;*/
Expandir
message.txt
13 KB
pca — Ontem às 17:09
TRUNCATE TABLE Prova;
TRUNCATE TABLE Matricula;
TRUNCATE TABLE Ensina;
TRUNCATE TABLE Turma;
TRUNCATE TABLE Disciplina;
TRUNCATE TABLE tb_curso;
TRUNCATE TABLE Professor;
TRUNCATE TABLE Aluno;
TRUNCATE TABLE tb_sala;
TRUNCATE TABLE professor_cargo;

INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Coordenador', 8000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Professor', 5000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Adjunto', 4000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Titular', 10000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Visitante', 6000));

INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio A','D005'), 30));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio A','D002'), 40));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E101'), 30));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E102'), 60));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E103'), 30));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E106'), 60));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio C','F101'), 35));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio C','F102'), 45));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio D','G201'), 25));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio D','G202'), 50));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio E','H301'), 55));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio E','H302'), 45));
pca — Ontem às 17:20
TRUNCATE TABLE Prova;
TRUNCATE TABLE Matricula;
TRUNCATE TABLE Ensina;
TRUNCATE TABLE Turma;
TRUNCATE TABLE Disciplina;
TRUNCATE TABLE tb_curso;
TRUNCATE TABLE Professor;
TRUNCATE TABLE Aluno;
TRUNCATE TABLE tb_sala;
TRUNCATE TABLE professor_cargo;

INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Coordenador', 8000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Professor', 5000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Adjunto', 4000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Titular', 10000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Visitante', 6000));

INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio A','D005'), 30));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio A','D002'), 40));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E101'), 30));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E102'), 60));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E103'), 30));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E106'), 60));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio C','F101'), 35));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio C','F102'), 45));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio D','G201'), 25));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio D','G202'), 50));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio E','H301'), 55));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio E','H302'), 45));

INSERT INTO Professor 
  VALUES (
    tp_professor(
      '85619370518', 
      'Rua Conselheiro Portela', 
      'Recife', 
      139, 
      '52020212', 
      TO_DATE('01-01-1980','DD-MM-YYYY'), 
      'carlos.silva@gmail.com', 
      'Carlos Silva', 
      tp_telefone(), 
      TO_DATE('01-01-2010','DD-MM-YYYY'),
      NULL, 
      (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Coordenador')
    )
  );

-- Professor: 32450176829, Professor, data_contratacao = 03-05-2015, supervisor = 85619370518
INSERT INTO Professor 
  VALUES (
    tp_professor(
      '32450176829', 
      'Rua Real da Torre', 
      'Recife', 
      705, 
      '50610000', 
      TO_DATE('15-06-1985','DD-MM-YYYY'), 
      'ana.souza@gmail.com', 
      'Ana Souza', 
      tp_telefone(telefone_pessoa_tp('81982366399'), telefone_pessoa_tp('81922577399')), 
      TO_DATE('03-05-2015','DD-MM-YYYY'),
      (SELECT REF(P) FROM Professor P WHERE P.CPF = '85619370518'),
      (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Professor')
    )
  );

-- Professor: 26678900981, Coordenador, data_contratacao = 21-10-1978, supervisor = 85619370518
INSERT INTO Professor 
  VALUES (
    tp_professor(
      '26678900981', 
      'Rua do Bom Jesus ', 
      'Recife', 
      432, 
      '50030170', 
      TO_DATE('11-09-1990','DD-MM-YYYY'), 
      'marcelo.lima@gmail.com', 
      'Marcelo Cristian', 
      tp_telefone(), 
      TO_DATE('21-10-1978','DD-MM-YYYY'),
      (SELECT REF(P) FROM Professor P WHERE P.CPF = '85619370518'),
      (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Coordenador')
... (116 linhas)
Recolher
message.txt
7 KB
TRUNCATE TABLE Prova;
TRUNCATE TABLE Matricula;
TRUNCATE TABLE Ensina;
TRUNCATE TABLE Turma;
TRUNCATE TABLE Disciplina;
TRUNCATE TABLE tb_curso;
Expandir
message.txt
8 KB
pca — Ontem às 17:28
TRUNCATE TABLE Prova;
TRUNCATE TABLE Matricula;
TRUNCATE TABLE Ensina;
TRUNCATE TABLE Turma;
TRUNCATE TABLE Disciplina;
TRUNCATE TABLE tb_curso;
Expandir
message.txt
10 KB
TRUNCATE TABLE Prova;
TRUNCATE TABLE Matricula;
TRUNCATE TABLE Ensina;
TRUNCATE TABLE Turma;
TRUNCATE TABLE Disciplina;
TRUNCATE TABLE tb_curso;
Expandir
message.txt
17 KB
pca — Ontem às 18:21
-- CODIGO_DISCIPLINA PROBLEMS, TELEFONE MISSING
TRUNCATE TABLE Prova;
TRUNCATE TABLE Matricula;
TRUNCATE TABLE Ensina;
TRUNCATE TABLE Turma;
TRUNCATE TABLE Disciplina;
TRUNCATE TABLE tb_curso;
Expandir
message.txt
23 KB
pca — Ontem às 18:33
TRUNCATE TABLE Prova;
TRUNCATE TABLE Matricula;
TRUNCATE TABLE Ensina;
TRUNCATE TABLE Turma;
TRUNCATE TABLE Disciplina;
TRUNCATE TABLE tb_curso;
Expandir
message.txt
29 KB
FALTA AJEITAR AS SEQUENCIAS E O TELEFONE DAS PESSOAS
pca — Ontem às 20:11
TRUNCATE TABLE Prova;
TRUNCATE TABLE Matricula;
TRUNCATE TABLE Ensina;
TRUNCATE TABLE Turma;
TRUNCATE TABLE Disciplina;
TRUNCATE TABLE tb_curso;
Expandir
message.txt
29 KB
pca — Ontem às 20:37
PRONTO:
TRUNCATE TABLE Prova;
TRUNCATE TABLE Matricula;
TRUNCATE TABLE Ensina;
TRUNCATE TABLE Turma;
TRUNCATE TABLE Disciplina;
TRUNCATE TABLE tb_curso;
TRUNCATE TABLE Professor;
TRUNCATE TABLE Aluno;
TRUNCATE TABLE tb_sala;
TRUNCATE TABLE professor_cargo;

INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Coordenador', 8000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Professor', 5000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Adjunto', 4000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Titular', 10000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Visitante', 6000));

INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio A','D005'), 30));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio A','D002'), 40));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E101'), 30));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E102'), 60));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E103'), 30));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E106'), 60));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio C','F101'), 35));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio C','F102'), 45));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio D','G201'), 25));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio D','G202'), 50));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio E','H301'), 55));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio E','H302'), 45));

INSERT INTO Professor 
  VALUES (
    tp_professor(
      '85619370518', 
      'Rua Conselheiro Portela', 
      'Recife', 
      139, 
      '52020212', 
      TO_DATE('01-01-1980','DD-MM-YYYY'), 
      'carlos.silva@gmail.com', 
      'Carlos Silva', 
      tp_telefone(telefone_pessoa_tp('81982374309')), 
      TO_DATE('01-01-2010','DD-MM-YYYY'),
      NULL, 
      (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Coordenador')
    )
  );

-- Professor: 32450176829, Professor, data_contratacao = 03-05-2015, supervisor = 85619370518
INSERT INTO Professor 
  VALUES (
    tp_professor(
      '32450176829', 
      'Rua Real da Torre', 
      'Recife', 
      705, 
      '50610000', 
      TO_DATE('15-06-1985','DD-MM-YYYY'), 
      'ana.souza@gmail.com', 
      'Ana Souza', 
      tp_telefone(telefone_pessoa_tp('81982366399'), telefone_pessoa_tp('81922577399')), 
      TO_DATE('03-05-2015','DD-MM-YYYY'),
      (SELECT REF(P) FROM Professor P WHERE P.CPF = '85619370518'),
      (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Professor')
    )
  );

-- Professor: 26678900981, Coordenador, data_contratacao = 21-10-1978, supervisor = 85619370518
INSERT INTO Professor 
  VALUES (
    tp_professor(
      '26678900981', 
      'Rua do Bom Jesus ', 
      'Recife', 
      432, 
      '50030170', 
      TO_DATE('11-09-1990','DD-MM-YYYY'), 
      'marcelo.lima@gmail.com', 
      'Marcelo Cristian', 
      tp_telefone(
         telefone_pessoa_tp('81980001001'),
         telefone_pessoa_tp('81980001002')
      ), 
... (801 linhas)
Recolher
message.txt
30 KB
BASTA TROCAR NA CRIACAO, TODAS AS OCORRENCIAS DE NEXTVAL POR 1
que funciona
@Dreammer
﻿
TRUNCATE TABLE Prova;
TRUNCATE TABLE Matricula;
TRUNCATE TABLE Ensina;
TRUNCATE TABLE Turma;
TRUNCATE TABLE Disciplina;
TRUNCATE TABLE tb_curso;
TRUNCATE TABLE Professor;
TRUNCATE TABLE Aluno;
TRUNCATE TABLE tb_sala;
TRUNCATE TABLE professor_cargo;

INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Coordenador', 8000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Professor', 5000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Adjunto', 4000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Titular', 10000));
INSERT INTO professor_cargo 
  VALUES (cargo_salario_professor('Visitante', 6000));

INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio A','D005'), 30));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio A','D002'), 40));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E101'), 30));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E102'), 60));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E103'), 30));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio B','E106'), 60));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio C','F101'), 35));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio C','F102'), 45));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio D','G201'), 25));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio D','G202'), 50));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio E','H301'), 55));
INSERT INTO tb_sala 
  VALUES (sala_tp(local_Sala_tp('Prédio E','H302'), 45));

INSERT INTO Professor 
  VALUES (
    tp_professor(
      '85619370518', 
      'Rua Conselheiro Portela', 
      'Recife', 
      139, 
      '52020212', 
      TO_DATE('01-01-1980','DD-MM-YYYY'), 
      'carlos.silva@gmail.com', 
      'Carlos Silva', 
      tp_telefone(telefone_pessoa_tp('81982374309')), 
      TO_DATE('01-01-2010','DD-MM-YYYY'),
      NULL, 
      (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Coordenador')
    )
  );

-- Professor: 32450176829, Professor, data_contratacao = 03-05-2015, supervisor = 85619370518
INSERT INTO Professor 
  VALUES (
    tp_professor(
      '32450176829', 
      'Rua Real da Torre', 
      'Recife', 
      705, 
      '50610000', 
      TO_DATE('15-06-1985','DD-MM-YYYY'), 
      'ana.souza@gmail.com', 
      'Ana Souza', 
      tp_telefone(telefone_pessoa_tp('81982366399'), telefone_pessoa_tp('81922577399')), 
      TO_DATE('03-05-2015','DD-MM-YYYY'),
      (SELECT REF(P) FROM Professor P WHERE P.CPF = '85619370518'),
      (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Professor')
    )
  );

-- Professor: 26678900981, Coordenador, data_contratacao = 21-10-1978, supervisor = 85619370518
INSERT INTO Professor 
  VALUES (
    tp_professor(
      '26678900981', 
      'Rua do Bom Jesus ', 
      'Recife', 
      432, 
      '50030170', 
      TO_DATE('11-09-1990','DD-MM-YYYY'), 
      'marcelo.lima@gmail.com', 
      'Marcelo Cristian', 
      tp_telefone(
         telefone_pessoa_tp('81980001001'),
         telefone_pessoa_tp('81980001002')
      ), 
      TO_DATE('21-10-1978','DD-MM-YYYY'),
      (SELECT REF(P) FROM Professor P WHERE P.CPF = '85619370518'),
      (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Coordenador')
    )
  );

-- Professor: 48273956108, Adjunto, data_contratacao = 23-09-2018, supervisor = 85619370518
INSERT INTO Professor 
  VALUES (
    tp_professor(
      '48273956108', 
      'Avenida 17 de Agosto', 
      'Recife', 
      2413, 
      '52061540', 
      TO_DATE('10-12-2000','DD-MM-YYYY'), 
      'joao.santos@gmail.com', 
      'João Santos', 
      tp_telefone(telefone_pessoa_tp('83983493847')),
      TO_DATE('23-09-2018','DD-MM-YYYY'),
      (SELECT REF(P) FROM Professor P WHERE P.CPF = '85619370518'),
      (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Adjunto')
    )
  );

-- Professor: 68913476523, Professor, data_contratacao = 01-08-2017, supervisor = 85619370518
INSERT INTO Professor 
  VALUES (
    tp_professor(
      '68913476523', 
      'Rua da Aurora', 
      'Recife', 
      99, 
      '50050000', 
      TO_DATE('05-05-1992','DD-MM-YYYY'), 
      'beatriz.ferreira@gmail.com', 
      'Beatriz Ferreira', 
      tp_telefone(telefone_pessoa_tp('81985474321')), 
      TO_DATE('01-08-2017','DD-MM-YYYY'),
      (SELECT REF(P) FROM Professor P WHERE P.CPF = '85619370518'),
      (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Professor')
    )
  );

-- Professor: 09786423901, Adjunto, data_contratacao = 12-04-2018, supervisor = 32450176829
INSERT INTO Professor 
  VALUES (
    tp_professor(
      '09786423901', 
      'Rua das Flores', 
      'Olinda', 
      121, 
      '53000090', 
      TO_DATE('20-10-1988','DD-MM-YYYY'), 
      'antonio.martins@gmail.com', 
      'Antonio Martins', 
      tp_telefone(telefone_pessoa_tp('81986743210')), 
      TO_DATE('12-04-2018','DD-MM-YYYY'),
      (SELECT REF(P) FROM Professor P WHERE P.CPF = '32450176829'),
      (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Adjunto')
    )
  );

-- Professor: 12345678910, Visitante, data_contratacao = 10-09-2020, supervisor = 26678900981
INSERT INTO Professor 
  VALUES (
    tp_professor(
      '12345678910', 
      'Rua Padre Roma', 
      'Recife', 
      57, 
      '52020210', 
      TO_DATE('15-09-1999','DD-MM-YYYY'), 
      'lucas.amaral@gmail.com', 
      'Lucas Amaral', 
      tp_telefone(telefone_pessoa_tp('83987432198')), 
      TO_DATE('10-09-2020','DD-MM-YYYY'),
      (SELECT REF(P) FROM Professor P WHERE P.CPF = '26678900981'),
      (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Visitante')
    )
  );

-- Professor: 23198765432, Titular, data_contratacao = 15-03-2015, supervisor = 85619370518
INSERT INTO Professor 
  VALUES (
    tp_professor(
      '23198765432', 
      'Avenida Norte', 
      'Recife', 
      601, 
      '52011020', 
      TO_DATE('30-06-1990','DD-MM-YYYY'), 
      'mariana.santos@gmail.com', 
      'Mariana Santos', 
      tp_telefone(telefone_pessoa_tp('83988765432')), 
      TO_DATE('15-03-2015','DD-MM-YYYY'),
      (SELECT REF(P) FROM Professor P WHERE P.CPF = '85619370518'),
      (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Titular')
    )
  );

-- Professor: 09876543219, Adjunto, data_contratacao = 28-11-2019, supervisor = 32450176829
INSERT INTO Professor 
  VALUES (
    tp_professor(
      '09876543219', 
      'Rua Central', 
      'Olinda', 
      303, 
      '53010010', 
      TO_DATE('10-02-1975','DD-MM-YYYY'), 
      'ricardo.lopes@gmail.com', 
      'Ricardo Lopes', 
      tp_telefone(telefone_pessoa_tp('81989876543')), 
      TO_DATE('28-11-2019','DD-MM-YYYY'),
      (SELECT REF(P) FROM Professor P WHERE P.CPF = '32450176829'),
      (SELECT REF(PC) FROM professor_cargo PC WHERE PC.cargo = 'Adjunto')
    )
  );

INSERT INTO tb_curso 
  VALUES (codigo_curso.NEXTVAL, 'Engenharia da Computação', 3000,
          (SELECT REF(P) FROM Professor P WHERE P.CPF = '85619370518'));
INSERT INTO tb_curso 
  VALUES (codigo_curso.NEXTVAL, 'Ciência da Computação', 3200,
          (SELECT REF(P) FROM Professor P WHERE P.CPF = '26678900981'));
INSERT INTO tb_curso 
  VALUES (codigo_curso.NEXTVAL, 'Engenharia Eletrônica', 3500,
          (SELECT REF(P) FROM Professor P WHERE P.CPF = '68913476523'));
INSERT INTO tb_curso 
  VALUES (codigo_curso.NEXTVAL, 'Sistemas de Informação', 3100,
          (SELECT REF(P) FROM Professor P WHERE P.CPF = '09786423901'));
INSERT INTO tb_curso 
  VALUES (codigo_curso.NEXTVAL, 'Engenharia de Software', 4000,
          (SELECT REF(P) FROM Professor P WHERE P.CPF = '12345678910'));
INSERT INTO tb_curso 
  VALUES (codigo_curso.NEXTVAL, 'Análise e Desenvolvimento de Sistemas', 2800,
          (SELECT REF(P) FROM Professor P WHERE P.CPF = '23198765432'));
INSERT INTO tb_curso 
  VALUES (codigo_curso.NEXTVAL, 'Ciência de Dados', 3600,
          (SELECT REF(P) FROM Professor P WHERE P.CPF = '09876543219'));

INSERT INTO Disciplina
SELECT codigo_disciplina.NEXTVAL, 'Introdução à Programação', 120, REF(c)
FROM tb_curso c
WHERE c.nome_curso = 'Engenharia da Computação';

INSERT INTO Disciplina
SELECT codigo_disciplina.NEXTVAL, 'Matemática Discreta', 90, REF(c)
FROM tb_curso c
WHERE c.nome_curso = 'Engenharia da Computação';

INSERT INTO Disciplina
SELECT codigo_disciplina.NEXTVAL, 'Sistemas Digitais', 100, REF(c)
FROM tb_curso c
WHERE c.nome_curso = 'Ciência da Computação';

INSERT INTO Disciplina
SELECT codigo_disciplina.NEXTVAL, 'Redes de Computadores', 80, REF(c)
FROM tb_curso c
WHERE c.nome_curso = 'Ciência da Computação';

INSERT INTO Disciplina
SELECT codigo_disciplina.NEXTVAL, 'Algoritmos Avançados', 150, REF(c)
FROM tb_curso c
WHERE c.nome_curso = 'Engenharia Eletrônica';

INSERT INTO Disciplina
SELECT codigo_disciplina.NEXTVAL, 'Banco de Dados', 100, REF(c)
FROM tb_curso c
WHERE c.nome_curso = 'Sistemas de Informação';

INSERT INTO Disciplina
SELECT codigo_disciplina.NEXTVAL, 'Engenharia de Requisitos', 90, REF(c)
FROM tb_curso c
WHERE c.nome_curso = 'Engenharia de Software';

INSERT INTO Disciplina
SELECT codigo_disciplina.NEXTVAL, 'Desenvolvimento Web', 120, REF(c)
FROM tb_curso c
WHERE c.nome_curso = 'Análise e Desenvolvimento de Sistemas';

INSERT INTO Disciplina
SELECT codigo_disciplina.NEXTVAL, 'Inteligência Artificial', 140, REF(c)
FROM tb_curso c
WHERE c.nome_curso = 'Ciência de Dados';


INSERT INTO Aluno 
  VALUES (
    tp_aluno(
      '56189023471', 
      'Rua São Bento', 
      'Olinda', 
      358, 
      '53020080', 
      TO_DATE('20-03-1995','DD-MM-YYYY'), 
      'maria.oliveira@gmail.com', 
      'Maria Oliveira', 
      tp_telefone(telefone_pessoa_tp('83984918304')),
      '20250001', 
      'Ativo', 
      TO_DATE('12-01-2022','DD-MM-YYYY'),
      (SELECT REF(C) FROM tb_curso C WHERE C.nome_curso = 'Engenharia da Computação')
    )
  );
INSERT INTO Aluno 
  VALUES (
    tp_aluno(
      '71028394615', 
      'Rua do Futuro', 
      'Recife', 
      180, 
      '52050005', 
      TO_DATE('11-07-1978','DD-MM-YYYY'), 
      'roberto.lima@gmail.com', 
      'Roberto Lima', 
      tp_telefone(telefone_pessoa_tp('81999999083')),  
      '20230008', 
      'Ativo', 
      TO_DATE('13-01-2020','DD-MM-YYYY'),
      (SELECT REF(C) FROM tb_curso C WHERE C.nome_curso = 'Ciência da Computação')
    )
  );
INSERT INTO Aluno 
  VALUES (
    tp_aluno(
      '68913476523', 
      'Rua da Aurora', 
      'Recife', 
      99, 
      '50050000', 
      TO_DATE('05-05-1992','DD-MM-YYYY'), 
      'beatriz.ferreira@gmail.com', 
      'Beatriz Ferreira', 
      tp_telefone(telefone_pessoa_tp('81985474321')), 
      '20260002', 
      'Ativo', 
      TO_DATE('10-02-2023','DD-MM-YYYY'),
      (SELECT REF(C) FROM tb_curso C WHERE C.nome_curso = 'Engenharia Eletrônica')
    )
  );
INSERT INTO Aluno 
  VALUES (
    tp_aluno(
      '09786423901', 
      'Rua das Flores', 
      'Olinda', 
      121, 
      '53000090', 
      TO_DATE('20-10-1988','DD-MM-YYYY'), 
      'antonio.martins@gmail.com', 
      'Antonio Martins', 
      tp_telefone(telefone_pessoa_tp('81986743210')), 
      '20260003', 
      'Ativo', 
      TO_DATE('14-01-2023','DD-MM-YYYY'),
      (SELECT REF(C) FROM tb_curso C WHERE C.nome_curso = 'Sistemas de Informação')
    )
  );
INSERT INTO Aluno 
  VALUES (
    tp_aluno(
      '12345678910', 
      'Rua Padre Roma', 
      'Recife', 
      57, 
      '52020210', 
      TO_DATE('15-09-1999','DD-MM-YYYY'), 
      'lucas.amaral@gmail.com', 
      'Lucas Amaral', 
      tp_telefone(telefone_pessoa_tp('83987432198')),
      '20260004', 
      'Ativo', 
      TO_DATE('18-01-2023','DD-MM-YYYY'),
      (SELECT REF(C) FROM tb_curso C WHERE C.nome_curso = 'Engenharia de Software')
    )
  );
INSERT INTO Aluno 
  VALUES (
    tp_aluno(
      '23198765432', 
      'Avenida Norte', 
      'Recife', 
      601, 
      '52011020', 
      TO_DATE('30-06-1990','DD-MM-YYYY'), 
      'mariana.santos@gmail.com', 
      'Mariana Santos', 
      tp_telefone(telefone_pessoa_tp('83988765432')), 
      '20260005', 
      'Ativo', 
      TO_DATE('21-01-2023','DD-MM-YYYY'),
      (SELECT REF(C) FROM tb_curso C WHERE C.nome_curso = 'Análise e Desenvolvimento de Sistemas')
    )
  );
INSERT INTO Aluno 
  VALUES (
    tp_aluno(
      '09876543219', 
      'Rua Central', 
      'Olinda', 
      303, 
      '53010010', 
      TO_DATE('10-02-1975','DD-MM-YYYY'), 
      'ricardo.lopes@gmail.com', 
      'Ricardo Lopes', 
      tp_telefone(telefone_pessoa_tp('81989876543')),
      '20260006', 
      'Ativo', 
      TO_DATE('25-01-2023','DD-MM-YYYY'),
      (SELECT REF(C) FROM tb_curso C WHERE C.nome_curso = 'Ciência de Dados')
    )
  );
INSERT INTO Aluno 
  VALUES (
    tp_aluno(
      '12345678911', 
      'Rua Nova', 
      'Recife', 
      12, 
      '50000001', 
      TO_DATE('01-01-2000','DD-MM-YYYY'), 
      'lucia.santos@gmail.com', 
      'Lucia Santos', 
      tp_telefone(
         telefone_pessoa_tp('81980000011'),
         telefone_pessoa_tp('81980000012')
      ), 
      '20260007', 
      'Ativo', 
      TO_DATE('01-02-2025','DD-MM-YYYY'),
      (SELECT REF(C) FROM tb_curso C WHERE C.nome_curso = 'Ciência de Dados')
    )
  );
INSERT INTO Aluno 
  VALUES (
    tp_aluno(
      '98765432112', 
      'Rua Velha', 
      'Olinda', 
      45, 
      '53000002', 
      TO_DATE('02-02-2001','DD-MM-YYYY'), 
      'maria.oliveira@gmail.com', 
      'Maria Oliveira', 
      tp_telefone(
         telefone_pessoa_tp('81980000013'),
         telefone_pessoa_tp('81980000014')
      ),
      '20260008', 
      'Ativo', 
      TO_DATE('02-02-2025','DD-MM-YYYY'),
      (SELECT REF(C) FROM tb_curso C WHERE C.nome_curso = 'Engenharia Eletrônica')
    )
  );
INSERT INTO Aluno 
  VALUES (
    tp_aluno(
      '19283746510', 
      'Rua das Mangueiras', 
      'Recife', 
      120, 
      '52000100', 
      TO_DATE('03-03-2002','DD-MM-YYYY'), 
      'joao.costa@gmail.com', 
      'João Costa', 
      tp_telefone(
         telefone_pessoa_tp('81980000015'),
         telefone_pessoa_tp('81980000016')
      ),
      '20260009', 
      'Ativo', 
      TO_DATE('03-02-2025','DD-MM-YYYY'),
      (SELECT REF(C) FROM tb_curso C WHERE C.nome_curso = 'Sistemas de Informação')
    )
  );
INSERT INTO Aluno 
  VALUES (
    tp_aluno(
      '10293847560', 
      'Avenida das Flores', 
      'Recife', 
      303, 
      '52100011', 
      TO_DATE('04-04-2003','DD-MM-YYYY'), 
      'ana.brito@gmail.com', 
      'Ana Brito', 
      tp_telefone(), 
      '20260010', 
      'Ativo', 
      TO_DATE('04-02-2025','DD-MM-YYYY'),
      (SELECT REF(C) FROM tb_curso C WHERE C.nome_curso = 'Engenharia de Software')
    )
  );
INSERT INTO Aluno 
  VALUES (
    tp_aluno(
      '56473829100', 
      'Rua Central', 
      'Olinda', 
      600, 
      '53010090', 
      TO_DATE('05-05-2004','DD-MM-YYYY'), 
      'pedro.lima@gmail.com', 
      'Pedro Lima', 
      tp_telefone(
         telefone_pessoa_tp('81980000019'),
         telefone_pessoa_tp('81980000020')
      ), 
      '20260011', 
      'Ativo', 
      TO_DATE('05-02-2025','DD-MM-YYYY'),
      (SELECT REF(C) FROM tb_curso C WHERE C.nome_curso = 'Engenharia da Computação')
    )
  );
INSERT INTO Aluno 
  VALUES (
    tp_aluno(
      '12398745609', 
      'Rua do Sol', 
      'Recife', 
      700, 
      '54000010', 
      TO_DATE('06-06-1999','DD-MM-YYYY'), 
      'carlos.martins@gmail.com', 
      'Carlos Martins', 
      tp_telefone(), 
      '20260012', 
      'Ativo', 
      TO_DATE('06-02-2025','DD-MM-YYYY'),
      (SELECT REF(C) FROM tb_curso C WHERE C.nome_curso = 'Engenharia da Computação')
    )
  );
INSERT INTO Aluno 
  VALUES (
    tp_aluno(
      '97856412311', 
      'Avenida Brasil', 
      'Recife', 
      809, 
      '50230080', 
      TO_DATE('07-07-1998','DD-MM-YYYY'), 
      'fernanda.menezes@gmail.com', 
      'Fernanda Menezes', 
      tp_telefone(
         telefone_pessoa_tp('81980000023'),
         telefone_pessoa_tp('81980000024')
      ), 
      '20260013', 
      'Ativo', 
      TO_DATE('07-02-2025','DD-MM-YYYY'),
      (SELECT REF(C) FROM tb_curso C WHERE C.nome_curso = 'Ciência da Computação')
    )
  );
INSERT INTO Aluno 
  VALUES (
    tp_aluno(
      '98723145678', 
      'Rua Verde', 
      'Recife', 
      110, 
      '51111000', 
      TO_DATE('08-08-1997','DD-MM-YYYY'), 
      'mariana.souza@gmail.com', 
      'Mariana Souza', 
      tp_telefone(
         telefone_pessoa_tp('81980000025'),
         telefone_pessoa_tp('81980000026')
      ), 
      '20260014', 
      'Ativo', 
      TO_DATE('08-02-2025','DD-MM-YYYY'),
      (SELECT REF(C) FROM tb_curso C WHERE C.nome_curso = 'Ciência da Computação')
    )
  );

INSERT INTO Turma 
  VALUES (
    tp_turma('T01', 1, nt_data_aula(
      tp_data_aula_turma(TO_DATE('10:00:00','HH24:MI:SS'), 'SEGUNDA'),
      tp_data_aula_turma(TO_DATE('10:30:00','HH24:MI:SS'), 'QUARTA'),
      tp_data_aula_turma(TO_DATE('11:00:00','HH24:MI:SS'), 'SEXTA')
    ))
  );
INSERT INTO Turma 
  VALUES (
    tp_turma('T10', 1, nt_data_aula(
      tp_data_aula_turma(TO_DATE('09:00:00','HH24:MI:SS'), 'TERÇA'),
      tp_data_aula_turma(TO_DATE('09:30:00','HH24:MI:SS'), 'QUINTA')
    ))
  );
INSERT INTO Turma 
  VALUES (
    tp_turma('T02', 2, nt_data_aula(
      tp_data_aula_turma(TO_DATE('14:00:00','HH24:MI:SS'), 'SEGUNDA'),
      tp_data_aula_turma(TO_DATE('14:00:00','HH24:MI:SS'), 'QUARTA')
    ))
  );
INSERT INTO Turma 
  VALUES (
    tp_turma('T11', 2, nt_data_aula(
      tp_data_aula_turma(TO_DATE('16:00:00','HH24:MI:SS'), 'TERÇA'),
      tp_data_aula_turma(TO_DATE('16:30:00','HH24:MI:SS'), 'QUINTA')
    ))
  );
INSERT INTO Turma 
  VALUES (
    tp_turma('T03', 3, nt_data_aula(
      tp_data_aula_turma(TO_DATE('08:00:00','HH24:MI:SS'), 'SEGUNDA'),
      tp_data_aula_turma(TO_DATE('08:30:00','HH24:MI:SS'), 'QUARTA'),
      tp_data_aula_turma(TO_DATE('08:00:00','HH24:MI:SS'), 'SEXTA')
    ))
  );
INSERT INTO Turma 
  VALUES (
    tp_turma('T04', 4, nt_data_aula(
      tp_data_aula_turma(TO_DATE('10:00:00','HH24:MI:SS'), 'TERÇA'),
      tp_data_aula_turma(TO_DATE('10:15:00','HH24:MI:SS'), 'QUINTA')
    ))
  );
INSERT INTO Turma 
  VALUES (
    tp_turma('T05', 5, nt_data_aula(
      tp_data_aula_turma(TO_DATE('15:00:00','HH24:MI:SS'), 'SEGUNDA'),
      tp_data_aula_turma(TO_DATE('15:00:00','HH24:MI:SS'), 'QUARTA')
    ))
  );
INSERT INTO Turma 
  VALUES (
    tp_turma('T06', 6, nt_data_aula(
      tp_data_aula_turma(TO_DATE('13:00:00','HH24:MI:SS'), 'TERÇA'),
      tp_data_aula_turma(TO_DATE('13:00:00','HH24:MI:SS'), 'QUINTA'),
      tp_data_aula_turma(TO_DATE('13:30:00','HH24:MI:SS'), 'SEXTA')
    ))
  );
INSERT INTO Turma 
  VALUES (
    tp_turma('T07', 7, nt_data_aula(
      tp_data_aula_turma(TO_DATE('11:00:00','HH24:MI:SS'), 'QUARTA'),
      tp_data_aula_turma(TO_DATE('11:15:00','HH24:MI:SS'), 'SEXTA')
    ))
  );

-- Turma T08 – disciplina 8 – 2 meeting times
INSERT INTO Turma 
  VALUES (
    tp_turma('T08', 8, nt_data_aula(
      tp_data_aula_turma(TO_DATE('17:00:00','HH24:MI:SS'), 'SEGUNDA'),
      tp_data_aula_turma(TO_DATE('17:30:00','HH24:MI:SS'), 'QUARTA')
    ))
  );
INSERT INTO Turma 
  VALUES (
    tp_turma('T09', 9, nt_data_aula(
      tp_data_aula_turma(TO_DATE('12:00:00','HH24:MI:SS'), 'TERÇA'),
      tp_data_aula_turma(TO_DATE('12:30:00','HH24:MI:SS'), 'QUINTA'),
      tp_data_aula_turma(TO_DATE('12:00:00','HH24:MI:SS'), 'SEXTA')
    ))
  );


INSERT INTO Ensina 
  VALUES (tp_ensina(
           (SELECT REF(P) FROM Professor P WHERE P.CPF = '85619370518'),
           (SELECT REF(S) FROM tb_sala S WHERE S.local.predio = 'Prédio A' AND S.local.num_sala = 'D005'),
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T01' AND T.codigo_disciplina = 1)
         ));
INSERT INTO Ensina 
  VALUES (tp_ensina(
           (SELECT REF(P) FROM Professor P WHERE P.CPF = '32450176829'),
           (SELECT REF(S) FROM tb_sala S WHERE S.local.predio = 'Prédio A' AND S.local.num_sala = 'D002'),
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T02' AND T.codigo_disciplina = 2)
         ));
INSERT INTO Ensina 
  VALUES (tp_ensina(
           (SELECT REF(P) FROM Professor P WHERE P.CPF = '32450176829'),
           (SELECT REF(S) FROM tb_sala S WHERE S.local.predio = 'Prédio B' AND S.local.num_sala = 'E101'),
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T03' AND T.codigo_disciplina = 3)
         ));
INSERT INTO Ensina 
  VALUES (tp_ensina(
           (SELECT REF(P) FROM Professor P WHERE P.CPF = '85619370518'),
           (SELECT REF(S) FROM tb_sala S WHERE S.local.predio = 'Prédio B' AND S.local.num_sala = 'E102'),
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T04' AND T.codigo_disciplina = 4)
         ));
INSERT INTO Ensina 
  VALUES (tp_ensina(
           (SELECT REF(P) FROM Professor P WHERE P.CPF = '68913476523'),
           (SELECT REF(S) FROM tb_sala S WHERE S.local.predio = 'Prédio C' AND S.local.num_sala = 'F101'),
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T05' AND T.codigo_disciplina = 5)
         ));
INSERT INTO Ensina 
  VALUES (tp_ensina(
           (SELECT REF(P) FROM Professor P WHERE P.CPF = '09786423901'),
           (SELECT REF(S) FROM tb_sala S WHERE S.local.predio = 'Prédio C' AND S.local.num_sala = 'F102'),
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T06' AND T.codigo_disciplina = 6)
         ));
INSERT INTO Ensina 
  VALUES (tp_ensina(
           (SELECT REF(P) FROM Professor P WHERE P.CPF = '12345678910'),
           (SELECT REF(S) FROM tb_sala S WHERE S.local.predio = 'Prédio D' AND S.local.num_sala = 'G201'),
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T07' AND T.codigo_disciplina = 7)
         ));
INSERT INTO Ensina 
  VALUES (tp_ensina(
           (SELECT REF(P) FROM Professor P WHERE P.CPF = '23198765432'),
           (SELECT REF(S) FROM tb_sala S WHERE S.local.predio = 'Prédio D' AND S.local.num_sala = 'G202'),
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T08' AND T.codigo_disciplina = 8)
         ));
INSERT INTO Ensina 
  VALUES (tp_ensina(
           (SELECT REF(P) FROM Professor P WHERE P.CPF = '09876543219'),
           (SELECT REF(S) FROM tb_sala S WHERE S.local.predio = 'Prédio E' AND S.local.num_sala = 'H301'),
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T09' AND T.codigo_disciplina = 9)
         ));


INSERT INTO Matricula 
  VALUES (tp_matricula(
           codigo_matricula.NEXTVAL,
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T01' AND T.codigo_disciplina = 1),
           (SELECT REF(A) FROM Aluno A WHERE A.CPF = '56189023471')
         ));
INSERT INTO Matricula 
  VALUES (tp_matricula(
           codigo_matricula.NEXTVAL,
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T01' AND T.codigo_disciplina = 1),
           (SELECT REF(A) FROM Aluno A WHERE A.CPF = '98723145678')
         ));
INSERT INTO Matricula 
  VALUES (tp_matricula(
           codigo_matricula.NEXTVAL,
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T03' AND T.codigo_disciplina = 3),
           (SELECT REF(A) FROM Aluno A WHERE A.CPF = '19283746510')
         ));
INSERT INTO Matricula 
  VALUES (tp_matricula(
           codigo_matricula.NEXTVAL,
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T03' AND T.codigo_disciplina = 3),
           (SELECT REF(A) FROM Aluno A WHERE A.CPF = '71028394615')
         ));
INSERT INTO Matricula 
  VALUES (tp_matricula(
           codigo_matricula.NEXTVAL,
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T05' AND T.codigo_disciplina = 5),
           (SELECT REF(A) FROM Aluno A WHERE A.CPF = '68913476523')
         ));
INSERT INTO Matricula 
  VALUES (tp_matricula(
           codigo_matricula.NEXTVAL,
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T06' AND T.codigo_disciplina = 6),
           (SELECT REF(A) FROM Aluno A WHERE A.CPF = '09786423901')
         ));
INSERT INTO Matricula 
  VALUES (tp_matricula(
           codigo_matricula.NEXTVAL,
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T07' AND T.codigo_disciplina = 7),
           (SELECT REF(A) FROM Aluno A WHERE A.CPF = '12345678910')
         ));
INSERT INTO Matricula 
  VALUES (tp_matricula(
           codigo_matricula.NEXTVAL,
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T08' AND T.codigo_disciplina = 8),
           (SELECT REF(A) FROM Aluno A WHERE A.CPF = '23198765432')
         ));
INSERT INTO Matricula 
  VALUES (tp_matricula(
           codigo_matricula.NEXTVAL,
           (SELECT REF(T) FROM Turma T WHERE T.codigo_turma = 'T09' AND T.codigo_disciplina = 9),
           (SELECT REF(A) FROM Aluno A WHERE A.CPF = '09876543219')
         ));


INSERT INTO Prova 
  VALUES (tp_prova(
           86869,
           'Prova 1 de Introdução à Programaçaõ',
           8.5,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 1)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           09090,
           'Prova de Sistemas Digitais',
           9.0,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 2)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           45678,
           'Prova de Algoritmos Avançados',
           8.6,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 3)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           12345,
           'Prova de Banco de Dados',
           8.7,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 4)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           78901,
           'Prova de Engenharia de Requisitos',
           9.5,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 5)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           67890,
           'Prova de Desenvolvimento Web',
           9.8,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 6)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           54321,
           'Prova de Inteligência Artificial',
           9.0,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 7)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           28741,
           'Prova 1 - Introdução à Programação',
           7.5,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 8)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           59203,
           'Prova 2 - Introdução à Programação',
           8.5,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 9)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           41035,
           'Prova 1 - Sistemas Digitais',
           8.0,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 10)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           67294,
           'Prova 2 - Sistemas Digitais',
           9.0,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 11)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           83015,
           'Prova 2 - Introdução à Programação',
           9.0,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 12)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           19472,
           'Prova Final - Sistemas Digitais',
           8.5,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 13)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           35681,
           'Prova 2 - Algoritmos Avançados',
           9.5,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 14)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           72940,
           'Prova 2 - Banco de Dados',
           8.9,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 15)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           46305,
           'Prova 2 - Engenharia de Requisitos',
           9.7,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 16)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           50184,
           'Prova Final - Desenvolvimento Web',
           9.9,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 17)
         ));
INSERT INTO Prova 
  VALUES (tp_prova(
           63729,
           'Prova Final - Inteligência Artificial',
           9.5,
           (SELECT REF(M) FROM Matricula M WHERE M.codigo_matricula = 18)
         ));
message.txt
30 KB
