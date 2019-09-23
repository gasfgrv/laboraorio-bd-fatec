-- Exercícios de SQL - parte 1
-- 1. Obter os códigos dos diferentes departamentos que tem turmas no ano-semestre 2002/1
 SELECT
	DISTINCT coddepto
FROM
	turma
WHERE
	anosem = 20021;
-- 2. Obter os códigos dos professores que são do departamento de código 'INF01' e que ministraram ao menos uma turma em 2002/1.
 SELECT
	DISTINCT CodProf
FROM
	Professor,
	ProfTurma
WHERE
	Professor.CodProf = ProfTurma.CodProf
	AND AnoSem = 20021
	AND Professor.CodDepto = 'INF01';
-- 3. Obter os horários de aula (dia da semana,hora inicial e número de horas ministradas) do professor "Antunes" em 20021.
 SELECT
	DISTINCT Horario.DiaSem,
	Horario.HORARIOINICIO,
	Horario.NumHoras
FROM
	Professor,
	ProfTurma,
	Horario
WHERE
	Professor.NomeProf = 'Antunes'
	AND Horario.AnoSem = 20021
	AND Professor.CodProf = ProfTurma.CodProf
	AND ProfTurma.AnoSem = Horario.AnoSem
	AND ProfTurma.CodDepto = Horario.CodDepto
	AND ProfTurma.NumDisc = Horario.NumDisc
	AND ProfTurma.SiglaTur = Horario.SiglaTur;
-- 4. Obter os nomes dos departamentos que têm turmas que, em 2002/1, têm aulas na sala 101 do prédio denominado 
-- 'Informática - aulas'.
 SELECT
	DISTINCT NomeDepto
FROM
	Depto,
	Horario,
	Predio
WHERE
	Depto.CodDepto = Horario.CodDepto
	AND Horario.CodPred = Predio.CodPred
	AND NumSala = 101
	AND NomePred = 'Informática - aulas'
	AND AnoSem = 20021;
-- 5. Obter os códigos dos professores com título denominado 'Doutor' que não ministraram aulas em 2002/1.
 SELECT
	CODPROF
FROM
	PROFESSOR NATURAL
JOIN TITULACAO NATURAL
JOIN PROFTURMA
WHERE
	CODTIT = 1
	AND ANOSEM <> 20021;
-- 6. Obter os identificadores das salas (código do prédio e número da sala) que, em 2002/1:
-- o nas segundas-feiras (dia da semana = 2), tiveram ao menos uma turma do departamento 'Informática', e o nas quartas-feiras
-- (dia da semana = 4), tiveram ao menos uma turma ministrada pelo professor denominado 'Antunes'.
 SELECT
	CodPred,
	NumSala
FROM
	Horario,
	Depto
WHERE
	Horario.CodDepto = Depto.CodDepto
	AND NomeDepto = 'Informática'
	AND DiaSem = 2
	AND AnoSem = 20021
INTERSECT
SELECT
	CodPred,
	NumSala
FROM
	Horario,
	ProfTurma,
	Professor
WHERE
	Professor.CodProf = ProfTurma.CodProf
	AND ProfTurma.AnoSem = Horario.AnoSem
	AND ProfTurma.CodDepto = Horario.CodDepto
	AND ProfTurma.NumDisc = Horario.NumDisc
	AND ProfTurma.SiglaTur = Horario.SiglaTur
	AND NomeProf = 'Antunes'
	AND DiaSem = 4
	AND Horario.AnoSem = 20021;
-- 7. Obter o dia da semana, a hora de início e o número de horas de cada horário de cada turma ministrada por um professor de 
-- nome `Antunes', em 2002/1, na sala número 101 do prédio de código 43423.
 SELECT
	DiaSem,
	HorarioInicio,
	NumHoras
FROM
	Professor,
	ProfTurma,
	Horario
WHERE
	Professor.CodProf = ProfTurma.CodProf
	AND ProfTurma.AnoSem = Horario.AnoSem
	AND ProfTurma.CodDepto = Horario.CodDepto
	AND ProfTurma.NumDisc = Horario.NumDisc
	AND ProfTurma.SiglaTur = Horario.SiglaTur
	AND NumSala = 101
	AND ProfTurma.AnoSem = 20021
	AND NomeProf = 'Antunes'
	AND CodPred = 43423;
-- 8. Um professor pode ministrar turmas de disciplinas pertencentes a outros departamentos. Para cada professor que já 
-- ministrou aulas em disciplinas de outros departamentos, obter o código do professor, seu nome, o nome de seu departamento e o
-- nome do departamento no qual ministrou disciplina.
 SELECT
	Professor.CodProf,
	NomeProf,
	DeptoProf.NomeDepto DeptoProf,
	DeptoDisc.NomeDepto DeptoDisc
FROM
	Professor,
	ProfTurma,
	Depto DeptoProf,
	Depto DeptoDisc
WHERE
	Professor.CodProf = ProfTurma.CodProf
	AND Professor.CodDepto <> ProfTurma.CodDepto
	AND Professor.CodDepto = DeptoProf.CodDepto
	AND ProfTurma.CodDepto = DeptoDisc.CodDepto;
-- 9. Obter o nome dos professores que possuem horários conflitantes (possuem turmas que tenham a mesma hora inicial, no mesmo 
-- dia da semana e no mesmo semestre). Além dos nomes, mostrar as chaves primárias das turmas em conflito.
 SELECT
	DISTINCT NOMEPROF
FROM
	HORARIO NATURAL
JOIN HORARIO horario2 NATURAL
JOIN PROFTURMA prof2 NATURAL
JOIN PROFESSOR;
-- 10. Para cada disciplina que possui pré-requisito, obter o nome da disciplina seguido do nome da disciplina que é seu 
-- pré-requisito.
 SELECT
	Disciplina.NomeDisc,
	DiscPre.NomeDisc
FROM
	Disciplina,
	PreReq,
	Disciplina DiscPre
WHERE
	Disciplina.CodDepto = PreReq.CodDepto
	AND Disciplina.NumDisc = PreReq.NumDisc
	AND PreReq.CodDeptoPreReq = DiscPre.CodDepto
	AND PreReq.NumDiscPreReq = DiscPre.NumDisc;
-- 11. Obter os nomes das disciplinas que não têm pré-requisito.
 SELECT
	Nomedisc
FROM
	Disciplina
EXCEPT
SELECT
	Nomedisc
FROM
	PreReq,
	Disciplina
WHERE
	Disciplina.CodDepto = PreReq.CodDepto
	AND Disciplina.NumDisc = PreReq.NumDisc;
-- 12. Obter o nome de cada disciplina que possui ao menos dois pré-requisitos.
 SELECT
	DISTINCT NomeDisc
FROM
	Disciplina,
	PreReq Pre1,
	PreReq Pre2
WHERE
	Disciplina.CodDepto = Pre1.CodDepto
	AND Disciplina.NumDisc = Pre1.NumDisc
	AND Disciplina.CodDepto = Pre2.CodDepto
	AND Disciplina.NumDisc = Pre2.NumDisc
	AND (Pre1.CodDeptoPreReq <> Pre2.CodDeptoPreReq
	OR Pre1.NumDiscPreReq <> Pre2.NumDiscPreReq);