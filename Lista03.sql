
-- Exercícios de SQL - parte 3
-- 1. Obter o os nomes dos professores que são do departamento denominado
-- 'Informática', sejam doutores, e que, em 20022, ministraram alguma turma de
-- disciplina do departamento 'Informática' que tenha mais que três créditos.
-- Resolver a questão da seguinte forma:

-- a. sem consultas aninhadas e sem sintaxe explícita para junções,
 SELECT
	professor.nomeprof
FROM
	disciplina NATURAL
JOIN professor NATURAL
JOIN depto NATURAL
JOIN profturma NATURAL
JOIN titulacao
WHERE
	nomedepto = 'Informática'
	AND creditodisc > 3
	AND codtit = 1
	AND anosem = 20022;
-- b. usando SQL, em estilo de cálculo relacional, com consultas aninhadas

-- (quando possível usar IN, caso contrário usar EXISTS).
 SELECT
	DISTINCT nomeprof
FROM
	depto,
	professor,
	disciplina,
	profturma
WHERE
	nomedepto = 'Informática'
	AND creditodisc > 3
	AND codtit = 1
	AND anosem = 20022;
-- 2. Obter os nomes das disciplinas do departamento denominado 'Informática' que
-- não foram oferecidas no semestre 20021.
-- Resolver a questão da seguinte forma:
-- a. no estilo de álgebra relacional, isto é, sem consultas aninhadas

-- (subselects),
 SELECT
	nomedisc
FROM
	depto d NATURAL
JOIN disciplina NATURAL
JOIN turma
WHERE
	d.nomedepto = 'Informática'
	AND anosem = 20021;
-- b. no estilo cálculo relacional, isto é, com consultas aninhadas (subselects).
 SELECT
	nomedisc
FROM
	depto d NATURAL
JOIN disciplina
WHERE
	d.nomedepto = 'Informática'
	AND coddepto IN (
	SELECT
		coddepto
	FROM
		turma
	WHERE
		anosem = 20021 );
-- 3. Obter uma tabela com as seguintes colunas: código de departamento, nome do
-- departamento, número de disciplina, créditos da disciplina, sigla da turma e
-- capacidade da turma. A tabela deve conter cada departamento associado com
-- cada uma de suas disciplinas e, para cada disciplina as respectivas turmas no ano
-- semestre 20022. Caso um departamento não tenha disciplinas, as demais colunas
-- devem aparecer vazias. Caso uma disciplina não tenha turmas, as demais

-- colunas deve aparecer vazias.
 SELECT
	coddepto,
	nomedepto,
	numdisc,
	creditodisc,
	siglatur,
	siglatur
FROM
	depto NATURAL
LEFT JOIN turma NATURAL
LEFT JOIN disciplina;
-- 4. Obter uma tabela com duas colunas, contendo o nome de cada disciplina
-- seguido do nome de cada um de seus pré-requisitos. Disciplinas sem pré-

-- requisito têm a segunda coluna vazia.
 SELECT
	disciplina.nomedisc,
	discreq.nomedisc
FROM
	disciplina
LEFT JOIN prereq ON
	disciplina.coddepto = prereq.coddepto
	AND disciplina.numdisc = prereq.numdisc
LEFT JOIN disciplina discreq ON
	discreq.coddepto = prereq.coddeptoprereq
	AND discreq.numdisc = prereq.numdiscprereq;
-- 5. Obter os identificadores de todas turmas de disciplinas do departamento
-- denominado `Informática' que não têm aula na sala de número 102 do prédio de

-- código 43421.
 SELECT
	siglatur
FROM
	horario NATURAL
JOIN depto
WHERE
	nomedepto = 'Informática'
	AND NOT numsala = 102
	AND codpred = 43421;
-- 6. Obter o número de disciplinas do departamento denominado `Informática'.
 SELECT
	COUNT(nomedisc)
FROM
	disciplina NATURAL
JOIN depto
WHERE
	nomedepto = 'Informática';
-- 7. Obter o número de salas que foram usadas no ano-semestre 20021 por turmas do

-- departamento denominado `Informática'.
 SELECT
	COUNT(siglatur)
FROM
	horario NATURAL
JOIN depto
WHERE
	nomedepto = 'Informática'
	AND anosem = 20021;
-- 8. Obter os nomes das disciplinas do departamento denominado `Informática' que

-- têm o maior número de créditos dentre as disciplinas deste departamento.
 SELECT
	nomedisc
FROM
	disciplina NATURAL
JOIN depto
WHERE
	nomedepto = 'Informática'
	AND creditodisc = (
	SELECT
		MAX(creditodisc)
	FROM
		disciplina );
-- 9. Para cada departamento, obter seu nome e o número de disciplinas do
-- departamento. Obter o resultado em ordem descendente de número de

-- disciplinas.
 SELECT
	DISTINCT nomedepto,
	(
	SELECT
		COUNT(nomedisc)
	FROM
		disciplina
	WHERE
		disciplina.coddepto = depto.coddepto ) qtdedisc
FROM
	depto
ORDER BY
	qtdedisc DESC;
-- 10. Para cada departamento, obter seu nome e os créditos totais oferecidos no ano-
-- semestre 20022. O número de créditos oferecidos é calculado através do produto
-- de número de créditos da disciplina pelo número de turmas oferecidas no

-- semestre.
 SELECT
	DISTINCT nomedepto,
	( (
	SELECT
		DISTINCT creditodisc
	FROM
		disciplina
	WHERE
		disciplina.coddepto = depto.coddepto ) * (
	SELECT
		COUNT(siglatur)
	FROM
		horario
	WHERE
		horario.coddepto = depto.coddepto ) ) AS qtdedisc
FROM
	depto
GROUP BY
	nomedepto
ORDER BY
	qtdedisc DESC;
-- 11. Resolver a consulta da questão anterior, mas incluindo somente os

-- departamentos que têm mais que 5 disciplinas.
 SELECT
	DISTINCT nomedepto,
	( (
	SELECT
		DISTINCT creditodisc
	FROM
		disciplina
	WHERE
		disciplina.coddepto = depto.coddepto ) * (
	SELECT
		COUNT(siglatur)
	FROM
		horario
	WHERE
		horario.coddepto = depto.coddepto ) ) AS qtdedisc
FROM
	depto
WHERE
	(
	SELECT
		COUNT(nomedisc)
	FROM
		disciplina
	WHERE
		disciplina.coddepto = depto.coddepto ) > 5
GROUP BY
	nomedepto
ORDER BY
	qtdedisc DESC;
-- 12. Obter os nomes dos departamentos que possuem a maior soma de créditos.
 SELECT
	nomedepto nomedepto,
	somacreditos somacreditos
FROM
	(
	SELECT
		nomedepto, (
		SELECT
			SUM(creditodisc)
		FROM
			disciplina
		WHERE
			disciplina.coddepto = depto.coddepto ) somacreditos
	FROM
		depto ) tbl
WHERE
	tbl.somacreditos >= (
	SELECT
		MAX(SUM(creditodisc))
	FROM
		disciplina NATURAL
	JOIN depto
	GROUP BY
		coddepto );
-- 13. Obter os nomes das disciplinas que em 20022, têm pelo menos uma turma cuja
-- total de horas seja diferente do número de créditos da disciplina.
-- Resolver a questão da seguinte forma:

-- 1. sem usar GROUP BY, com consultas aninhadas (subselects),
 SELECT
	nomedisc
FROM
	disciplina
WHERE
	nomedisc = (
	SELECT
		nomedisc
	FROM
		horario, disciplina
	WHERE
		horario.numdisc = disciplina.numdisc
		AND disciplina.creditodisc <> horario.numhoras );
-- 2. usando GROUP BY, sem consultas aninhadas.
 SELECT
	nomedisc
FROM
	horario NATURAL
JOIN disciplina
WHERE
	disciplina.creditodisc <> horario.numhoras;
-- 14. Obter os nomes dos professores que, em 20022, deram aula em mais de uma
-- turma.
-- Resolver a questão da seguinte forma:

-- 1. sem funções de agregação (tipo COUNT, MIN,MAX,AVG,SUM),
 SELECT
	DISTINCT nomeprof
FROM
	profturma,
	professor
WHERE
	anosem = 20022
ORDER BY
	nomeprof ASC;
-- 2. ou ainda, com funções de agregação.
 SELECT
	DISTINCT nomeprof,
	COUNT(siglatur)
FROM
	profturma,
	professor
WHERE
	anosem = 20022
GROUP BY
	nomeprof;