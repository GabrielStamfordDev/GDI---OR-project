/*
JÁ FOI FEITO ANTERIORMENTE, MAS VOU INSERIR UMA SALA USANDO O CONSTRUTOR QUE CRIEI
*/
INSERT INTO tb_sala VALUES (sala_tp(local_Sala_tp('Prédio F', 'D011')));
-- Para checar
SELECT s.capacidade, s.local.predio, s.local.num_sala FROM tb_sala s WHERE s.local.predio = 'Prédio F' AND s.local.num_sala = 'D011';
/*
CONSULTA 1: Para cada disciplina, vou checar a qual curso ela pertence e o coordenador desse curso
*/

SELECT d.codigo_disciplina, d.nome_disciplina, DEREF(d.curso_ref).nome_curso AS curso_nome, DEREF(DEREF(d.curso_ref).coordenador).nome AS coordenador_nome FROM Disciplina d;
-- Ou SELECT d.codigo_disciplina, d.nome_disciplina, DEREF(d.curso_ref).nome_curso, DEREF(d.curso_ref).coordenador.nome FROM Disciplina d;
-- Ou SELECT d.codigo_disciplina, d.nome_disciplina, DEREF(d.curso_ref).nome_curso, d.curso_ref.coordenador.nome FROM Disciplina d;

/*
CONSULTA 2: Printar os cursos que têm mais de 2 alunos
*/

SELECT DEREF(a.curso).nome_curso AS curso_nome, COUNT(CPF) AS quantidade_alunos FROM Aluno a GROUP BY DEREF(a.curso).nome_curso HAVING COUNT(*) > 2;

/*
USA O MAP FUNCTION DE PESSOA
CONSULTA 3: Consultar todos os professores, que têm supervisores, e seus supervisores e ordená-los pela suas datas de nascimento
*/

SELECT P.nome AS Nome_professor, P.CPF AS Cpf_professor, P.data_nascimento AS data_nascimento, DEREF(P.CPF_supervisor).nome AS Nome_Supervisor, DEREF(P.CPF_supervisor).CPF AS CPF_Supervisor
FROM Professor P WHERE P.CPF_supervisor IS NOT NULL ORDER BY P.data_nasc();

/*
CONSULTA 4: Consultar quantos professores supervisionados cada professor supervisor tem:
*/

SELECT s.CPF AS supervisor_cpf, s.nome AS supervisor_nome, COUNT(p.CPF) AS num_supervisados FROM Professor p JOIN Professor s ON p.CPF_supervisor = REF(s) GROUP BY s.CPF, s.nome;

/*


CONSULTA A UM VARRAY
CONSULTA 5: Consultar quantos telefones uma pessoa possui. Vou fazer uma consulta para um aluno e outra para um professor.
*/

-- Para aluno de CPF '12345678911'

DECLARE
  telefones_aluno Aluno.telefone%TYPE;
  nome Aluno.nome%TYPE;
BEGIN
  SELECT A.telefone, A.nome INTO telefones_aluno, nome FROM Aluno A WHERE A.CPF = '12345678911';

  IF telefones_aluno.count > 1 THEN
      DBMS_OUTPUT.PUT_LINE('Primeiro telefone do aluno ' || nome || ' = ' || telefones_aluno(1).telefone_pessoa || '. Mas ele possui ' || telefones_aluno.count || ' telefones.');
  ELSIF telefones_aluno.count = 1 THEN
      DBMS_OUTPUT.PUT_LINE('O aluno ' || nome || ' só tem um telefone = ' || telefones_aluno(1).telefone_pessoa);
  ELSE
    DBMS_OUTPUT.PUT_LINE('O aluno ' || nome || ' não possui telefones cadastrados.');
  END IF;
END;
/

-- Para professor de CPF '85619370518'

DECLARE
  telefones_professor Professor.telefone%TYPE;
  nome Professor.nome%TYPE;
BEGIN
  SELECT P.telefone, P.nome INTO telefones_professor, nome FROM Professor P WHERE P.CPF = '85619370518';

  IF telefones_professor.count > 1 THEN
      DBMS_OUTPUT.PUT_LINE('Primeiro telefone do professor ' || nome || ' = ' || telefones_professor(1).telefone_pessoa || '. Mas ele possui ' || telefones_professor.count || ' telefones.');
  ELSIF telefones_professor.count = 1 THEN
      DBMS_OUTPUT.PUT_LINE('O professor ' || nome || ' só tem um telefone = ' || telefones_professor(1).telefone_pessoa);
  ELSE
    DBMS_OUTPUT.PUT_LINE('O professor ' || nome || ' não possui telefones cadastrados.');
  END IF;
END;
/

/* Uma forma mais elegante de fazer é usando um for para quando uma pesoa tiver mais de um telefone, eu conseguir printar todos, ao invés de somente o primeiro */

DECLARE
  telefones_aluno Aluno.telefone%TYPE;
  nome Aluno.nome%TYPE;
BEGIN
  SELECT A.telefone, A.nome INTO telefones_aluno, nome FROM Aluno A WHERE A.CPF = '12345678911';

  IF telefones_aluno.count > 1 THEN
      DBMS_OUTPUT.PUT_LINE('O aluno ' || nome || ' possui ' || telefones_aluno.count || ' telefones:');
      
      FOR i IN 1..telefones_aluno.count LOOP
          DBMS_OUTPUT.PUT_LINE('- Telefone ' || i || ': ' || telefones_aluno(i).telefone_pessoa);
      END LOOP;
  
  ELSIF telefones_aluno.count = 1 THEN
      DBMS_OUTPUT.PUT_LINE('O aluno ' || nome || ' só tem um telefone: ' || telefones_aluno(1).telefone_pessoa);
  ELSE
      DBMS_OUTPUT.PUT_LINE('O aluno ' || nome || ' não possui telefones cadastrados.');
  END IF;
EXCEPTION
  WHEN NO_DATA_FOUND THEN
    DBMS_OUTPUT.PUT_LINE('Aluno não encontrado.');
END;
/

/*
  CONSULTA A UMA NESTED TABLE
  CONSULTA 6: Consultando todas as turmas e suas respectivas datas_aulas
*/

SELECT T.codigo_turma, T.codigo_disciplina, TO_CHAR(TB.horario, 'HH24:MI:SS') AS horario, TB.dia_semana FROM Turma T, TABLE(T.lista_datas) TB;

/*
  CONSULTA A UMA NESTED TABLE MAIS ELEGANTE
  CONSULTA 7: Consultando todas as turmas que têm mais de 2 datas_aulas e suas respectivas datas_aulas e disciplina
*/

SELECT T.codigo_turma, T.codigo_disciplina, TO_CHAR(TB.horario, 'HH24:MI:SS') AS horario, TB.dia_semana FROM Turma T, TABLE(T.lista_datas) TB WHERE (T.codigo_turma, T.codigo_disciplina) IN
(SELECT T.codigo_turma, T.codigo_disciplina FROM Turma T, TABLE(T.lista_datas) TB
GROUP BY T.codigo_turma, T.codigo_disciplina HAVING COUNT(*) > 2) ORDER BY T.codigo_turma, T.codigo_disciplina, TB.horario, TB.dia_semana;

/*SELECT T.codigo_turma, T.codigo_disciplina, TO_CHAR(TB.horario, 'HH24:MI:SS') AS horario, TB.dia_semana FROM Turma T, TABLE(T.lista_datas) TB WHERE T.codigo_turma IN
(SELECT T.codigo_turma FROM Turma T, TABLE(T.lista_datas) TB
GROUP BY T.codigo_turma HAVING COUNT(*) > 2);*/

/*
  CONSULTA 8: Comparando a capacidade de duas salas
*/


DECLARE
    x sala_tp;
    n INTEGER;
BEGIN
    -- Pegando a sala com maior capacidade
    SELECT VALUE(S) INTO x 
    FROM tb_sala S 
    WHERE S.local.predio = 'Predio A' AND S.local.num_sala = 'D005';

    -- Comparando com outra sala
    SELECT S.comparaCapacidade(x) INTO n 
    FROM tb_sala S 
    WHERE S.local.predio = 'Prédio B' AND S.local.num_sala = 'E102';

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

/*
  CONSULTA 8.2: Ao invés de só comparar a capacidade de duas salas, vou fixar uma sala e compará-la com todas as demais no banco de dados
*/
  
DECLARE
    x sala_tp;
    n INTEGER;
    CURSOR c_salas IS SELECT VALUE(S) AS sala FROM tb_sala S; -- Cursor retorna um alias para evitar conflitos. Sem o alias dá errado.
    sala_atual sala_tp;
BEGIN
    -- Pegando a sala fixa para comparação
    SELECT VALUE(S) INTO x 
    FROM tb_sala S 
    WHERE S.local.predio = 'Prédio A' AND S.local.num_sala = 'D005';

    FOR rec IN c_salas LOOP
        sala_atual := rec.sala;  -- Agora 'rec' tem um alias 'sala' compatível

        n := x.comparaCapacidade(sala_atual);

        IF n > 0 THEN 
            DBMS_OUTPUT.PUT_LINE('A sala ' || x.local.num_sala || ' - ' || x.local.predio ||
                                ' tem capacidade maior que a sala ' || sala_atual.local.num_sala || ' - ' || sala_atual.local.predio);
        ELSIF n = 0 THEN 
            DBMS_OUTPUT.PUT_LINE('A sala ' || x.local.num_sala || ' - ' || x.local.predio ||
                                ' tem capacidade igual à sala ' || sala_atual.local.num_sala || ' - ' || sala_atual.local.predio);
        ELSE
            DBMS_OUTPUT.PUT_LINE('A sala ' || x.local.num_sala || ' - ' || x.local.predio ||
                                ' tem capacidade menor que a sala ' || sala_atual.local.num_sala || ' - ' || sala_atual.local.predio);
        END IF;
    END LOOP;
END;
/

/*
  CONSULTA 9: Checa se um professor já pode se aposentar ou não. O tempo para se aposentar foi baseado na internet, mas claro que na vida rea tem vários fatores.
*/
  
DECLARE
    v_professor tp_professor; 
    v_idade INTEGER;
    v_anos_servico INTEGER;
BEGIN
    SELECT VALUE (P) INTO v_professor FROM Professor P WHERE P.CPF='68913476523';

    v_professor.dizer_idade;

    v_idade := TRUNC(MONTHS_BETWEEN(SYSDATE, v_professor.data_nascimento) / 12);
    v_anos_servico := TRUNC(MONTHS_BETWEEN(SYSDATE, v_professor.data_contratacao) / 12);

    -- Avalia as condições de aposentadoria
    IF v_idade < 62 THEN
        DBMS_OUTPUT.PUT_LINE('Com certeza NÃO pode se aposentar.');
    ELSIF v_idade >= 65 AND v_anos_servico >= 20 THEN
        DBMS_OUTPUT.PUT_LINE('Com certeza PODE se aposentar.');
    ELSIF v_idade >= 62 AND v_anos_servico < 20 THEN
        DBMS_OUTPUT.PUT_LINE('Possivelmente, Depende do sexo e/ou do tempo de contribuição externo.');
    END IF;
END;
/


/*
CONSULTA 10: Usando o PROCEDURE dizer_idade de pessoa com aluno
*/

DECLARE
    a tp_aluno;
BEGIN
    SELECT VALUE(A) INTO a 
    FROM Aluno A
    WHERE CPF = '56189023471';

    a.dizer_idade();
END;
/

/*
CONSULTA 11: Usando a função dizer_tempo_estuda de aluno para os alunos que estudam a mais de 2 anos
*/

SELECT A.dizer_tempo_estuda(), A.nome, A.CPF FROM Aluno A WHERE A.dizer_tempo_estuda() > 2;
