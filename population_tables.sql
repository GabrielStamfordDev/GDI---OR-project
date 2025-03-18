--Como na criação inserimos algumas tuplas para realziar testes, vamos, antes de começar a população, limpar as tabelas

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
