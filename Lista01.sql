-- Exercícios de SQL - parte 1

-- 1. Obter os códigos dos diferentes departamentos que tem turmas no ano-semestre 2002/1
SELECT DISTINCT coddepto 
FROM turma 
WHERE anosem=20021;

-- 2. Obter os códigos dos professores que são do departamento de código 'INF01' e que ministraram ao menos uma turma em 2002/1.
SELECT DISTINCT Professor.CodProf 
FROM Professor, ProfTurma 
WHERE Professor.CodProf=ProfTurma.CodProf 
AND AnoSem=20021 
AND Professor.CodDepto='INF01';

-- 3. Obter os horários de aula (dia da semana,hora inicial e número de horas ministradas) do professor "Antunes" em 20021.
SELECT DISTINCT 
Horario.DiaSem, 
Horario.HoraInicio, 
Horario.NumHoras 
FROM Professor, 
ProfTurma, 
Horario 
WHERE Professor.NomeProf='Antunes' 
AND Horario.AnoSem=20021 
AND Professor.CodProf = ProfTurma.CodProf 
AND ProfTurma.AnoSem = Horario.AnoSem 
AND ProfTurma.CodDepto = Horario.CodDepto 
AND ProfTurma.NumDisc = Horario.NumDisc 
AND ProfTurma.SiglaTur = Horario.SiglaTur;

-- 4. Obter os nomes dos departamentos que têm turmas que, em 2002/1, têm aulas na sala 101 do prédio denominado 
-- 'Informática - aulas'.
SELECT DISTINCT NomeDepto 
FROM Depto, 
Horario, 
Predio 
WHERE Depto.CodDepto=Horario.CodDepto 
AND Horario.CodPred=Predio.CodPred 
AND NumSala=101 
AND NomePred='Informática - aulas' 
AND AnoSem=20021;

-- 5. Obter os códigos dos professores com título denominado 'Doutor' que não ministraram aulas em 2002/1.

-- 6. Obter os identificadores das salas (código do prédio e número da sala) que, em 2002/1:
-- o nas segundas-feiras (dia da semana = 2), tiveram ao menos uma turma do departamento 'Informática', e o nas quartas-feiras
-- (dia da semana = 4), tiveram ao menos uma turma ministrada pelo professor denominado 'Antunes'.
SELECT CodPred, NumSala
FROM Horario,Depto
WHERE Horario.CodDepto=Depto.CodDepto
AND NomeDepto='Informática'
AND DiaSem=2
AND AnoSem=20021
INTERSECT
SELECT CodPred, NumSala
FROM Horario,
ProfTurma,
Professor
WHERE Professor.CodProf=ProfTurma.CodProf
AND ProfTurma.AnoSem=Horario.AnoSem
AND ProfTurma.CodDepto=Horario.CodDepto
AND ProfTurma.NumDisc=Horario.NumDisc
AND ProfTurma.SiglaTur=Horario.SiglaTur
AND NomeProf='Antunes'
AND DiaSem=4
AND Horario.AnoSem=20021;

-- 7. Obter o dia da semana, a hora de início e o número de horas de cada horário de cada turma ministrada por um professor de 
-- nome `Antunes', em 2002/1, na sala número 101 do prédio de código 43423.
SELECT DiaSem, HoraInicio, NumHoras FROM Professor, 
ProfTurma, 
Horario 
WHERE Professor.CodProf=ProfTurma.CodProf 
AND ProfTurma.AnoSem=Horario.AnoSem 
AND ProfTurma.CodDepto=Horario.CodDepto 
AND ProfTurma.NumDisc=Horario.NumDisc 
AND ProfTurma.SiglaTur=Horario.SiglaTur 
AND NumSala=101 
AND ProfTurma.AnoSem=20021 
AND NomeProf='Antunes' 
AND CodPred=43423;

-- 8. Um professor pode ministrar turmas de disciplinas pertencentes a outros departamentos. Para cada professor que já 
-- ministrou aulas em disciplinas de outros departamentos, obter o código do professor, seu nome, o nome de seu departamento e o
-- nome do departamento no qual ministrou disciplina.

SELECT Professor.CodProf, 
Professor.NomeProf, 
Depto.NomeDepto AS NomeDeptoProf, 
Depto.NomeDepto AS NomeDeptoDisc 
FROM Professor, 
ProfTurma, 
Depto
WHERE Professor.CodProf=ProfTurma.CodProf 
AND Professor.CodDepto<>ProfTurma.CodDepto 
AND Professor.CodDepto=Depto.CodDepto 
AND ProfTurma.CodDepto=Depto.CodDepto;

-- 9. Obter o nome dos professores que possuem horários conflitantes (possuem turmas que tenham a mesma hora inicial, no mesmo 
-- dia da semana e no mesmo semestre). Além dos nomes, mostrar as chaves primárias das turmas em conflito.

-- 10. Para cada disciplina que possui pré-requisito, obter o nome da disciplina seguido do nome da disciplina que é seu 
-- pré-requisito.
SELECT DISTINCT Professor.NomeProf 
FROM Horario, 
Horario AS Horario2, 
ProfTurma AS ProfTurma2, 
Professor 
WHERE Horario.AnoSem = Horario2.AnoSem 
AND Horario.DiaSem = Horario2.DiaSem 
AND Horario.HoraInicIO = Horario2.HoraInicIO 

AND Horario.CodDepto = ProfTurma.CodDepto 
AND Horario.NumDisc = ProfTurma.NumDisc 
AND Horario.AnoSem = ProfTurma.AnoSem 
AND Horario.SiglaTur = ProfTurma.SiglaTur 

AND Horario2.CodDepto = ProfTurma2.CodDepto 
AND Horario2.NumDisc = ProfTurma2.NumDisc 
AND Horario2.AnoSem = ProfTurma2.AnoSem 
AND Horario2.SiglaTur = ProfTurma2.SiglaTur 

AND ProfTurma.CodDepto = ProfTurma2.CodDepto 
AND Professor.CodProf = ProfTurma2.CodDepto;

-- 11. Obter os nomes das disciplinas que não têm pré-requisito.
SELECT Nomedisc 
FROM Disciplina 
EXCEPT 
SELECT Nomedisc 
FROM PreReq, 
Disciplina 
WHERE Disciplina.CodDepto=PreReq.CodDepto 
AND Disciplina.NumDisc=PreReq.NumDisc;

-- 12. Obter o nome de cada disciplina que possui ao menos dois pré-requisitos.
SELECT DISTINCT NomeDisc 
FROM Disciplina, 
PreReq AS Pre1, 
PreReq AS Pre2 
WHERE Disciplina.CodDepto=Pre1.CodDepto 
AND Disciplina.NumDisc=Pre1.NumDisc 
AND Disciplina.CodDepto=Pre2.CodDepto 
AND Disciplina.NumDisc=Pre2.NumDisc 
AND (Pre1.CodDeptoPreReq<>Pre2.CodDeptoPreReq 
OR Pre1.NumDiscPreReq<>Pre2.NumDiscPreReq);