-- Exercícios de SQL - parte 2
-- 1. Obter os nomes docentes cuja titulação tem código diferente de 3.
SELECT
    nomeprof
FROM
    professor
WHERE
    codtit <> 3;
-- 2. Obter os nomes dos departamentos que têm turmas que, em 2002/1, têm aulas na
-- sala 101 do prédio denominado 'Informática - aulas'. Resolver usando theta-join
-- e junção natural.

SELECT DISTINCT
    nomedepto
FROM
    depto
    NATURAL JOIN horario
    NATURAL JOIN predio
WHERE
    horario.anosem = 20021
    AND predio.nomepred = 'Informática - aulas';
-- 3. Obter o nome de cada departamento seguido do nome de cada uma de suas
-- disciplinas que possui mais que três créditos (caso o departamento não tenha
-- disciplinas ou caso o departamento não tenha disciplinas com mais que três
-- créditos, seu nome deve aparecer seguido de vazio). A seguinte solução não está
-- correta (porquê?):

SELECT DISTINCT
    nomedepto
FROM
    depto
    NATURAL LEFT JOIN disciplina
WHERE
    creditosdisc > 3; 
--R: pois a condição WHERE implica que possua mais de 3 créditos para que possa aparcer
-- 4. Obter o nome dos professores que possuem horários conflitantes (possuem
-- turmas que tenham a mesma hora inicial, no mesmo dia da semana e no mesmo
-- semestre).

SELECT DISTINCT
    nomeprof
FROM
    horario
    NATURAL JOIN horario     horario2
    NATURAL JOIN profturma   prof2
    NATURAL JOIN professor;
-- 5. Para cada disciplina que possui pré-requisito, obter o nome da disciplina seguido
-- do nome da disciplina que é seu pré-requisito (usar junções explícitas - quando
-- possível usar junção natural).

SELECT
    disciplina.nomedisc,
    discreq.nomedisc
FROM
    disciplina
    NATURAL JOIN prereq
    INNER JOIN disciplina discreq ON prereq.coddeptoprereq = discreq.coddepto
                                     AND prereq.numdiscprereq = discreq.numdisc;
-- 6. Para cada disciplina, mesmo para aquelas que não possuem pré-requisito, obter o
-- nome da disciplina seguido do nome da disciplina que é seu pré-requisito (usar
-- junções explícitas - quando possível usar junção natural).

SELECT
    disciplina.nomedisc,
    discreq.nomedisc
FROM
    disciplina   left
    JOIN prereq ON disciplina.coddepto = prereq.coddepto
                   AND disciplina.numdisc = prereq.numdisc
    LEFT JOIN disciplina   discreq ON discreq.coddepto = prereq.coddeptoprereq
                                    AND discreq.numdisc = prereq.numdiscprereq;
-- 7. Para cada disciplina que tem um pré-requisito que a sua vez também tem um
-- pré-requisito, obter o nome da disciplina seguido do nome do pré-requisito de
-- seu pré-requisito.

SELECT
    disciplina.nomedisc,
    dispre.nomedisc
FROM
    ( ( disciplina
    NATURAL JOIN prereq )
    JOIN prereq       preprereq ON ( prereq.coddeptoprereq = preprereq.coddepto
                               AND prereq.numdiscprereq = preprereq.numdisc ) )
    JOIN disciplina   dispre ON ( preprereq.coddeptoprereq = dispre.coddepto
                                AND preprereq.numdiscprereq = dispre.numdisc );
-- 8. Obter uma tabela que contém três colunas. Na primeira coluna aparece o nome
-- de cada disciplina que possui pré-requisito, na segunda coluna aparece o nome
-- de cada um de seus pré-requisitos e a terceira contém o nível de pré-requisito.
-- Nível 1 significa que trata-se de um pré-requisito imediato da disciplina, nível 2
-- significa que trata-se de um pré-requisito de um pré-requisito da disciplina, e
-- assim por diante. Limitar a consulta para três níveis. (DICA USAR UNION
-- ALL)

SELECT
    disciplina.nomedisc,
    discpre.nomedisc,
    1 AS nivel
FROM
    ( disciplina
    NATURAL JOIN prereq )
    JOIN disciplina discpre ON ( prereq.coddeptoprereq = discpre.coddepto
                                 AND prereq.numdiscprereq = discpre.numdisc )
UNION ALL
SELECT
    disciplina.nomedisc,
    discpre.nomedisc,
    2
FROM
    ( ( disciplina
    NATURAL JOIN prereq )
    JOIN prereq       preprereq ON ( prereq.coddeptoprereq = preprereq.coddepto
                               AND prereq.numdiscprereq = preprereq.numdisc ) )
    JOIN disciplina   discpre ON ( preprereq.coddeptoprereq = discpre.coddepto
                                 AND preprereq.numdiscprereq = discpre.numdisc )
UNION ALL
SELECT
    disciplina.nomedisc,
    discpre.nomedisc,
    3
FROM
    ( ( ( disciplina
    NATURAL JOIN prereq )
    JOIN prereq       preprereq ON ( prereq.coddeptoprereq = preprereq.coddepto
                               AND prereq.numdiscprereq = preprereq.numdisc ) )
    JOIN prereq       prepreprereq ON ( preprereq.coddeptoprereq = prepreprereq.coddepto
                                  AND preprereq.numdiscprereq = prepreprereq.numdisc ) )
    JOIN disciplina   discpre ON ( prepreprereq.coddeptoprereq = discpre.coddepto
                                 AND prepreprereq.numdiscprereq = discpre.numdisc );
-- 9. Obter os códigos dos professores com código de título vazio que não
-- ministraram aulas em 2001/2 (resolver com junção natural).

SELECT
    professor.codprof
FROM
    professor
    NATURAL JOIN profturma
WHERE
    NOT anosem = 20012
        AND codtit = NULL;

SELECT
    anosem,
    coddepto,
    numdisc,
    siglatur,
    codprof
FROM
    profturma;