-- Exercícios de SQL - parte 1
-- 1. Obter os códigos dos diferentes departamentos que tem turmas no ano-semestre 2002/1
SELECT DISTINCT coddepto
FROM   turma
WHERE  anosem = 20021;

-- 2. Obter os códigos dos professores que são do departamento de código 'INF01' e que ministraram ao menos uma turma em 2002/1.
SELECT DISTINCT professor.codprof
FROM   professor,
       profturma
WHERE  professor.codprof = profturma.codprof
       AND anosem = 20021
       AND professor.coddepto = 'INF01';

-- 3. Obter os horários de aula (dia da semana,hora inicial e número de horas ministradas) do professor "Antunes" em 20021.
SELECT DISTINCT horario.diasem,
                horario.horarioinicio,
                horario.numhoras
FROM   professor,
       profturma,
       horario
WHERE  professor.nomeprof = 'Antunes'
       AND horario.anosem = 20021
       AND professor.codprof = profturma.codprof
       AND profturma.anosem = horario.anosem
       AND profturma.coddepto = horario.coddepto
       AND profturma.numdisc = horario.numdisc
       AND profturma.siglatur = horario.siglatur;

-- 4. Obter os nomes dos departamentos que têm turmas que, em 2002/1, têm aulas na sala 101 do prédio denominado 
-- 'Informática - aulas'.
SELECT DISTINCT nomedepto
FROM   depto,
       horario,
       predio
WHERE  depto.coddepto = horario.coddepto
       AND horario.codpred = predio.codpred
       AND numsala = 101
       AND nomepred = 'Informática - aulas'
       AND anosem = 20021;

-- 5. Obter os códigos dos professores com título denominado 'Doutor' que não ministraram aulas em 2002/1.
SELECT codprof
FROM   professor
       natural JOIN titulacao
       natural JOIN profturma
WHERE  codtit = 1
       AND anosem <> 20021;

-- 6. Obter os identificadores das salas (código do prédio e número da sala) que, em 2002/1:
-- o nas segundas-feiras (dia da semana = 2), tiveram ao menos uma turma do departamento 'Informática', e o nas quartas-feiras
-- (dia da semana = 4), tiveram ao menos uma turma ministrada pelo professor denominado 'Antunes'.
SELECT codpred,
       numsala
FROM   horario,
       depto
WHERE  horario.coddepto = depto.coddepto
       AND nomedepto = 'Informática'
       AND diasem = 2
       AND anosem = 20021
INTERSECT
SELECT codpred,
       numsala
FROM   horario,
       profturma,
       professor
WHERE  professor.codprof = profturma.codprof
       AND profturma.anosem = horario.anosem
       AND profturma.coddepto = horario.coddepto
       AND profturma.numdisc = horario.numdisc
       AND profturma.siglatur = horario.siglatur
       AND nomeprof = 'Antunes'
       AND diasem = 4
       AND horario.anosem = 20021;

-- 7. Obter o dia da semana, a hora de início e o número de horas de cada horário de cada turma ministrada por um professor de 
-- nome `Antunes', em 2002/1, na sala número 101 do prédio de código 43423.
SELECT diasem,
       horarioinicio,
       numhoras
FROM   professor,
       profturma,
       horario
WHERE  professor.codprof = profturma.codprof
       AND profturma.anosem = horario.anosem
       AND profturma.coddepto = horario.coddepto
       AND profturma.numdisc = horario.numdisc
       AND profturma.siglatur = horario.siglatur
       AND numsala = 101
       AND profturma.anosem = 20021
       AND nomeprof = 'Antunes'
       AND codpred = 43423;

-- 8. Um professor pode ministrar turmas de disciplinas pertencentes a outros departamentos. Para cada professor que já 
-- ministrou aulas em disciplinas de outros departamentos, obter o código do professor, seu nome, o nome de seu departamento e o
-- nome do departamento no qual ministrou disciplina.
SELECT professor.codprof,
       nomeprof,
       deptoprof.nomedepto deptoprof,
       deptodisc.nomedepto deptodisc
FROM   professor,
       profturma,
       depto deptoprof,
       depto deptodisc
WHERE  professor.codprof = profturma.codprof
       AND professor.coddepto <> profturma.coddepto
       AND professor.coddepto = deptoprof.coddepto
       AND profturma.coddepto = deptodisc.coddepto;

-- 9. Obter o nome dos professores que possuem horários conflitantes (possuem turmas que tenham a mesma hora inicial, no mesmo 
-- dia da semana e no mesmo semestre). Além dos nomes, mostrar as chaves primárias das turmas em conflito.
SELECT DISTINCT nomeprof
FROM   horario
       natural JOIN horario horario2
       natural JOIN profturma prof2
       natural JOIN professor;

-- 10. Para cada disciplina que possui pré-requisito, obter o nome da disciplina seguido do nome da disciplina que é seu 
-- pré-requisito.
SELECT disciplina.nomedisc,
       discpre.nomedisc
FROM   disciplina,
       prereq,
       disciplina discpre
WHERE  disciplina.coddepto = prereq.coddepto
       AND disciplina.numdisc = prereq.numdisc
       AND prereq.coddeptoprereq = discpre.coddepto
       AND prereq.numdiscprereq = discpre.numdisc;

-- 11. Obter os nomes das disciplinas que não têm pré-requisito.
SELECT nomedisc
FROM   disciplina
EXCEPT
SELECT nomedisc
FROM   prereq,
       disciplina
WHERE  disciplina.coddepto = prereq.coddepto
       AND disciplina.numdisc = prereq.numdisc;

-- 12. Obter o nome de cada disciplina que possui ao menos dois pré-requisitos.
SELECT DISTINCT nomedisc
FROM   disciplina,
       prereq pre1,
       prereq pre2
WHERE  disciplina.coddepto = pre1.coddepto
       AND disciplina.numdisc = pre1.numdisc
       AND disciplina.coddepto = pre2.coddepto
       AND disciplina.numdisc = pre2.numdisc
       AND ( pre1.coddeptoprereq <> pre2.coddeptoprereq
              OR pre1.numdiscprereq <> pre2.numdiscprereq ); 