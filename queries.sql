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
CONSULTA 3: Consultar todos os professores, que têm supervisores, e seus supervisores
*/

SELECT P.nome AS Nome_professor, P.CPF AS Cpf_professor, DEREF(P.CPF_supervisor).nome AS Nome_Supervisor, DEREF(P.CPF_supervisor).CPF AS CPF_Supervisor
FROM Professor P WHERE P.CPF_supervisor IS NOT NULL;

/*
CONSULTA 4: Consultar quantos professores supervisionados cada professor supervisor tem:
*/

SELECT s.CPF AS supervisor_cpf, s.nome AS supervisor_nome, COUNT(p.CPF) AS num_supervisadosFROM Professor p JOIN Professor s ON p.CPF_supervisor = REF(s) GROUP BY s.CPF, s.nome;

/*
CONSULTA A UM VARRAU
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
  ELSIF telefones_aluno.count <= 1 THEN
      DBMS_OUTPUT.PUT_LINE('O aluno ' || nome || ' só tem um telefone = ' || telefones_aluno(1).telefone_pessoa);
  END IF;
END;
/

-- Para professor de CPF '85619370518'

DECLARE
  telefones_professor Professor.telefone%TYPE;
  nome Professor.nome%TYPE;
BEGIN
  SELECT P.telefone, P.nome INTO telefones_aluno, nome FROM Professor P WHERE P.CPF = '85619370518';

  IF telefones_professor.count > 1 THEN
      DBMS_OUTPUT.PUT_LINE('Primeiro telefone do professor ' || nome || ' = ' || telefones_professor(1).telefone_pessoa || '. Mas ele possui ' || telefones_professor.count || ' telefones.');
  ELSIF telefones_professor.count <= 1 THEN
      DBMS_OUTPUT.PUT_LINE('O professor ' || nome || ' só tem um telefone = ' || telefones_professor(1).telefone_pessoa);
  END IF;
END;
/
