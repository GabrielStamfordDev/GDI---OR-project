/*
CONSULTA 1: Para cada disciplina, vou checar a qual curso ela pertence e o coordenador desse curso
*/

SELECT d.codigo_disciplina, d.nome_disciplina, DEREF(d.curso_ref).nome_curso AS curso_nome, DEREF(DEREF(d.curso_ref).coordenador).nome AS coordenador_nome FROM Disciplina d;
-- Ou SELECT d.codigo_disciplina, d.nome_disciplina, DEREF(d.curso_ref).nome_curso, DEREF(d.curso_ref).coordenador.nome FROM Disciplina d;
-- Ou SELECT d.codigo_disciplina, d.nome_disciplina, DEREF(d.curso_ref).nome_curso, d.curso_ref.coordenador.nome FROM Disciplina d;

/*
CONSULTA 2: Printar os cursos que têm mais de 2 alunos
*/

SELECT a.curso.nome_curso AS curso_nome, COUNT(CPF) AS quantidade_alunos FROM Aluno a GROUP BY a.curso.nome_curso HAVING COUNT(*) > 2;
