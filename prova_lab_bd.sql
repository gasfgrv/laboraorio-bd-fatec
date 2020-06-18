
-- Prova impar
-- Nome: Gustavo Almeida da Silva
-- Status da atividade: Funcionou
 CREATE OR REPLACE PROCEDURE p2 IS CURSOR c1 IS
SELECT
	disciplina.nomedisc,
	discpre.nomedisc,
	professor.nomeprof,
	profturma.anosem
FROM
	profturma NATURAL
JOIN professor,
	titulacao,
	disciplina,
	prereq,
	disciplina discpre
WHERE
	disciplina.coddepto = prereq.coddepto
	AND disciplina.numdisc = prereq.numdisc
	AND prereq.coddeptoprereq = discpre.coddepto
	AND prereq.numdiscprereq = discpre.numdisc
	AND professor.codtit = titulacao.codtit
	AND titulacao.nometit = 'Doutor'
	AND profturma.anosem >= 20161;

disciplinas VARCHAR(100);

disciplinasprereq VARCHAR(100);

nomeprof VARCHAR(100);

anosem NUMBER(38);
BEGIN
	dbms_output.put_line('iniciando procedure');

OPEN c1;

FETCH c1
INTO
	disciplinas,
	disciplinasprereq,
	nomeprof,
	anosem;

WHILE c1%FOUND LOOP dbms_output.put_line('Nome Disciplina: ' || disciplinas || ' - Nome Pré req:' || disciplinasprereq || ' - Nome Prof: ' || nomeprof || ' ano-semestre: ' || anosem);

FETCH c1
INTO
	disciplinas,
	disciplinasprereq,
	nomeprof,
	anosem;
END LOOP;

CLOSE c1;
END;
BEGIN
	p2;
END;