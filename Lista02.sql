-- 1. Obter os nomes docentes cuja titulação tem código diferente de 3.
select distinct nomeprof
from professor 
where codtit <> 3;
-- 2. Obter os nomes dos departamentos que têm turmas que, em 2002/1, têm aulas na
-- sala 101 do prédio denominado 'Informática - aulas'. Resolver usando theta-join
-- e junção natural.
select depto.nomedepto 
from depto 
     natural join horario 
     natural join sala
     natural join predio
where anosem=20021
and numsala=101
and nomepred='Informatica - aulas';
-- 3. Obter o nome de cada departamento seguido do nome de cada uma de suas
-- disciplinas que possui mais que três créditos (caso o departamento não tenha
-- disciplinas ou caso o departamento não tenha disciplinas com mais que três
-- créditos, seu nome deve aparecer seguido de vazio). A seguinte solução não está
-- correta (porquê?):

-- WHAT????????????

-- 4. Obter o nome dos professores que possuem horários conflitantes (possuem
-- turmas que tenham a mesma hora inicial, no mesmo dia da semana e no mesmo
-- semestre).

-- 5. Para cada disciplina que possui pré-requisito, obter o nome da disciplina seguido
-- do nome da disciplina que é seu pré-requisito (usar junções explícitas - quando
-- possível usar junção natural).

-- 6. Para cada disciplina, mesmo para aquelas que não possuem pré-requisito, obter o
-- nome da disciplina seguido do nome da disciplina que é seu pré-requisito (usar
-- junções explícitas - quando possível usar junção natural).

-- 7. Para cada disciplina que tem um pré-requisito que a sua vez também tem um
-- pré-requisito, obter o nome da disciplina seguido do nome do pré-requisito de
-- seu pré-requisito.

-- 8. Obter uma tabela que contém três colunas. Na primeira coluna aparece o nome
-- de cada disciplina que possui pré-requisito, na segunda coluna aparece o nome
-- de cada um de seus pré-requisitos e a terceira contém o nível de pré-requisito.
-- Nível 1 significa que trata-se de um pré-requisito imediato da disciplina, nível 2
-- significa que trata-se de um pré-requisito de um pré-requisito da disciplina, e
-- assim por diante. Limitar a consulta para três níveis. (DICA USAR UNION
-- ALL)

-- 9. Obter os códigos dos professores com código de título vazio que não
-- ministraram aulas em 2001/2 (resolver com junção natural).