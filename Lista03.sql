-- Exercícios de SQL - parte 3
-- 1. Obter o os nomes dos professores que são do departamento denominado
-- 'Informática', sejam doutores, e que, em 20022, ministraram alguma turma de
-- disciplina do departamento 'Informática' que tenha mais que três créditos.
-- Resolver a questão da seguinte forma:
-- a. sem consultas aninhadas e sem sintaxe explícita para junções,
 SELECT
	PROFESSOR.NOMEPROF
FROM
	disciplina NATURAL
JOIN PROFESSOR NATURAL
JOIN DEPTO NATURAL
JOIN PROFTURMA NATURAL
JOIN TITULACAO
WHERE
	NOMEDEPTO = 'Informática'
	AND CREDITODISC > 3
	AND CODTIT = 1
	AND ANOSEM = 20022;
-- b. usando SQL, em estilo de cálculo relacional, com consultas aninhadas
-- (quando possível usar IN, caso contrário usar EXISTS).
 SELECT
	DISTINCT NOMEPROF
FROM
	DEPTO,
	PROFESSOR,
	DISCIPLINA,
	PROFTURMA
WHERE
	NOMEDEPTO = 'Informática'
	AND CREDITODISC > 3
	AND CODTIT = 1
	AND ANOSEM = 20022;
-- 2. Obter os nomes das disciplinas do departamento denominado 'Informática' que
-- não foram oferecidas no semestre 20021.
-- Resolver a questão da seguinte forma:
-- a. no estilo de álgebra relacional, isto é, sem consultas aninhadas
-- (subselects),
 SELECT
	NOMEDISC
FROM
	DEPTO D NATURAL
JOIN DISCIPLINA NATURAL
JOIN TURMA
WHERE
	d.nomedepto = 'Informática'
	AND ANOSEM = 20021;
-- b. no estilo cálculo relacional, isto é, com consultas aninhadas (subselects).
 SELECT
	NOMEDISC
FROM
	DEPTO D NATURAL
JOIN DISCIPLINA
WHERE
	d.nomedepto = 'Informática'
	AND CODDEPTO IN (
	SELECT
		CODDEPTO
	FROM
		TURMA
	WHERE
		anosem = 20021);
-- 3. Obter uma tabela com as seguintes colunas: código de departamento, nome do
-- departamento, número de disciplina, créditos da disciplina, sigla da turma e
-- capacidade da turma. A tabela deve conter cada departamento associado com
-- cada uma de suas disciplinas e, para cada disciplina as respectivas turmas no ano
-- semestre 20022. Caso um departamento não tenha disciplinas, as demais colunas
-- devem aparecer vazias. Caso uma disciplina não tenha turmas, as demais
-- colunas deve aparecer vazias.
 SELECT
	CODDEPTO,
	NOMEDEPTO,
	NUMDISC,
	CREDITODISC,
	SIGLATUR,
	SIGLATUR
FROM
	DEPTO NATURAL
LEFT JOIN TURMA NATURAL
LEFT JOIN DISCIPLINA;
-- 4. Obter uma tabela com duas colunas, contendo o nome de cada disciplina
-- seguido do nome de cada um de seus pré-requisitos. Disciplinas sem pré-
-- requisito têm a segunda coluna vazia.
 SELECT
	DISCIPLINA.NOMEDISC,
	discReq.NOMEDISC
FROM
	DISCIPLINA
LEFT JOIN PREREQ ON
	DISCIPLINA.CODDEPTO = PREREQ.CODDEPTO
	AND DISCIPLINA.NUMDISC = PREREQ.NUMDISC
LEFT JOIN DISCIPLINA discReq ON
	discReq.CODDEPTO = PREREQ.CODDEPTOPREREQ
	AND discReq.NUMDISC = PREREQ.NUMDISCPREREQ
-- 5. Obter os identificadores de todas turmas de disciplinas do departamento
-- denominado `Informática' que não têm aula na sala de número 102 do prédio de
-- código 43421.
 SELECT
	SIGLATUR
FROM
	HORARIO NATURAL
JOIN DEPTO
WHERE
	NOMEDEPTO = 'Informática'
	AND NOT NUMSALA = 102
	AND CODPRED = 43421;
-- 6. Obter o número de disciplinas do departamento denominado `Informática'.
 SELECT
	COUNT(NOMEDISC)
FROM
	DISCIPLINA NATURAL
JOIN DEPTO
WHERE
	NOMEDEPTO = 'Informática';
-- 7. Obter o número de salas que foram usadas no ano-semestre 20021 por turmas do
-- departamento denominado `Informática'.
 SELECT
	COUNT(SIGLATUR)
FROM
	HORARIO NATURAL
JOIN DEPTO
WHERE
	NOMEDEPTO = 'Informática'
	AND ANOSEM = 20021;
-- 8. Obter os nomes das disciplinas do departamento denominado `Informática' que
-- têm o maior número de créditos dentre as disciplinas deste departamento.
 SELECT
	NOMEDISC
FROM
	DISCIPLINA NATURAL
JOIN DEPTO
WHERE
	NOMEDEPTO = 'Informática'
	AND CREDITODISC =(
	SELECT
		MAX(CREDITODISC)
	FROM
		DISCIPLINA) ;
-- 9. Para cada departamento, obter seu nome e o número de disciplinas do
-- departamento. Obter o resultado em ordem descendente de número de
-- disciplinas.
 SELECT
	DISTINCT NOMEDEPTO,
	(
	SELECT
		COUNT(NOMEDISC)
	FROM
		DISCIPLINA
	WHERE
		DISCIPLINA.CODDEPTO = DEPTO.CODDEPTO) QtdeDisc
FROM
	DEPTO
ORDER BY
	QtdeDisc DESC;
-- 10. Para cada departamento, obter seu nome e os créditos totais oferecidos no ano-
-- semestre 20022. O número de créditos oferecidos é calculado através do produto
-- de número de créditos da disciplina pelo número de turmas oferecidas no
-- semestre.
 SELECT
	DISTINCT NOMEDEPTO,
	((
	SELECT
		DISTINCT CREDITODISC
	FROM
		DISCIPLINA
	WHERE
		DISCIPLINA.CODDEPTO = DEPTO.CODDEPTO) * (
	SELECT
		COUNT(SIGLATUR)
	FROM
		HORARIO
	WHERE
		HORARIO.CODDEPTO = DEPTO.CODDEPTO)) AS QTDEDISC
FROM
	DEPTO
ORDER BY
	QtdeDisc DESC;
-- 11. Resolver a consulta da questão anterior, mas incluindo somente os
-- departamentos que têm mais que 5 disciplinas.
 SELECT
	DISTINCT NOMEDEPTO,
	((
	SELECT
		DISTINCT CREDITODISC
	FROM
		DISCIPLINA
	WHERE
		DISCIPLINA.CODDEPTO = DEPTO.CODDEPTO) * (
	SELECT
		COUNT(SIGLATUR)
	FROM
		HORARIO
	WHERE
		HORARIO.CODDEPTO = DEPTO.CODDEPTO)) AS QTDEDISC
FROM
	DEPTO
WHERE
	(
	SELECT
		COUNT(NOMEDISC)
	FROM
		DISCIPLINA
	WHERE
		DISCIPLINA.CODDEPTO = DEPTO.CODDEPTO) > 5
ORDER BY
	QtdeDisc DESC;
-- 12. Obter os nomes dos departamentos que possuem a maior soma de créditos.
 SELECT
	*
FROM
	(
	SELECT
		NOMEDEPTO,
		(
		SELECT
			SUM(CREDITODISC)
		FROM
			DISCIPLINA
		WHERE
			DISCIPLINA.CODDEPTO = DEPTO.CODDEPTO) somaCreditos
	FROM
		DEPTO) tbl
WHERE
	tbl.somaCreditos >= (
	SELECT
		MAX(SUM(CREDITODISC))
	FROM
		DISCIPLINA NATURAL
	JOIN DEPTO
	GROUP BY
		CODDEPTO);
-- 13. Obter os nomes das disciplinas que em 20022, têm pelo menos uma turma cuja
-- total de horas seja diferente do número de créditos da disciplina.
-- Resolver a questão da seguinte forma:
-- 1. sem usar GROUP BY, com consultas aninhadas (subselects),
 SELECT
	NOMEDISC
FROM
	DISCIPLINA
WHERE
	NOMEDISC = (
	SELECT
		NOMEDISC
	FROM
		HORARIO,
		DISCIPLINA
	WHERE
		HORARIO.NUMDISC = DISCIPLINA.NUMDISC
		AND DISCIPLINA.CREDITODISC <> HORARIO.NUMHORAS);
-- 2. usando GROUP BY, sem consultas aninhadas.
 SELECT
	NOMEDISC
FROM
	HORARIO NATURAL
JOIN DISCIPLINA
WHERE
	DISCIPLINA.CREDITODISC <> HORARIO.NUMHORAS;
-- 14. Obter os nomes dos professores que, em 20022, deram aula em mais de uma
-- turma.
-- Resolver a questão da seguinte forma:
-- 1. sem funções de agregação (tipo COUNT, MIN,MAX,AVG,SUM),
 SELECT
	DISTINCT NOMEPROF
FROM
	PROFTURMA,
	PROFESSOR
WHERE
	ANOSEM = 20022
ORDER BY
	NOMEPROF ASC
-- 2. ou ainda, com funções de agregação.
 SELECT
	DISTINCT NOMEPROF,
	COUNT(SIGLATUR)
FROM
	PROFTURMA,
	PROFESSOR
WHERE
	ANOSEM = 20022
GROUP BY
	NOMEPROF;