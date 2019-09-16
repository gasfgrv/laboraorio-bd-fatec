#Laboratório de Banco de Dados
## Resumo PL/SQL
### Funções agregadas
- **MAX:** A função MAX analisa um conjunto de valores e retorna o maior entre eles.
- **MIN:** MIN analisa um grupo de valores e retorna o menor entre eles.
- **SUM:** A função SUM realiza a soma dos valores em uma única coluna e retorna esse resultado.
- **AVG:** Com a função AVG podemos calcular a média aritmética dos valores em uma única coluna.
- **COUNT:** A função COUNT retorna o total de linhas selecionadas. Ela pode receber por parâmetro o nome da coluna ou um asterisco. Por padrão, quando informado o nome de uma coluna, valores do tipo null são ignorados, mas quando informado * todas as linhas serão contabilizadas.
- **GROUP BY:** Ao utilizar a cláusula GROUP BY dividimos os registros que serão agregados em grupos de valores.
- **HAVING:** Podemos usar a cláusula HAVING em conjunto com GROUP BY para filtrar os resultado que serão submetidos a agregação.
- **ALIAS:** A fim de facilitar a compreensão do SQL, podemos utilizar a palavra-chave as para criar um apelido para uma coluna.
### Functions e Procedures
#### Functions
- Uma function é um bloco PL/SQL muito semelhante a uma procedure. O que podemos entender de início entre esses dois tipos de blocos é que os blocos functions retornam valores e as procedures podem ou não retornar um valor. As functions tem duas características que diferem das procedures, as quais não podemos deixar de tratar:
  - As functions sempre retornam valores
  - Functions são usadas como parte de uma expressão.
- Podemos executar a função de várias formas. No caso da função retornar um valor, podemos declará-lo como uma variável, como da seguinte forma:
    ```sql
        func_nome :=  primeiro_nome_func;
    ```
- Ou então como parte de uma instrução select:
    ```sql
        SELECT primeiro_nome_func FROM dual;
    ```
- Ou também como uma instrução PL/SQL:
    ```sql
        dbms_output.put_line(primeiro_nome_func);
    ```
- Uma stored procedure é um bloco de instruções PL/SQL que executa uma ou mais tarefas específicas. Elas são bem similares com as procedures de outras linguagens de programação.
- Podemos passar os parâmetros para uma procedure de três maneiras:
  - **Parâmetros IN** – passamos o valor na própria procedure.
  - **Parâmetros OUT** – recebemos o valor a partir da chamada de blocos externos.
  - **Parâmetros IN OUT** – passamos um valor inicial para a procedure e recebemos de volta uma atualização.
- Como executamos uma strored procedure? Para este ponto, a resposta é bem simples, pois temos duas maneiras de chamar uma stored procedure:
  - Usando a palavra-chave EXECUTE;
    ```sql
        EXECUTE detalhes_dos_funcionarios;
    ```
  - Chamando o nome da procedure de um bloco PL/SQL.
    ```sql
        BEGIN
        detalhes_dos_funcionarios
        END;
    ```
- Para deletarmos uma procedute, utilizamos a instrução DROP PROCEDURE. Vejamos a seguir a sintaxe para a exclusão:
    ```sql
    DROP PROCEDURE nome_da_procedure;
    ```
#### Cursores
- Cursores são áreas compostas de linhas e colunas armazenadas em memória que servem para armazenar o resultado de uma seleção que retorna nenhuma, uma ou diversas linhas. 
- Com o uso de cursores é possível selecionar um conjunto de linhas e manipular o resultado desta consulta linha a linha, dentro de um código PL/SQL (Program Language SQL), como stored procedures, triggers e código escritos dentro de ferramentas Oracle como o Developer, Designer ou Discoverer.
- Os cursores em PL/SQL podem ser explícitos e implícitos. O PL/SQL declara um cursor implicitamente para toda instrução DML (UPDATE, INSERT, DELETE, SELECT...INTO), incluindo consultas que retornam apenas uma linha. As consultas que retornam mais de uma linha deverão ser declaradas explicitamente.
- Cursores explícitos são indicados quando é necessário um controle no processamento do mesmo.
- Quando declaramos um cursor é associado a ele um nome e a consulta SQL que será processada por este cursor. Assim como as variáveis, os cursores devem ser declarados na seção DECLARE.
- O comando OPEN abre o cursor, executa a consulta associada a ele e gera o conjunto ativo, que consiste de todas as linhas que atendem os critérios de pesquisa da consulta associada ao cursor. Para gerenciar o conjunto ativo existe um ponteiro que registra qual linha está passível do comando FETCH. Após o OPEN o FETCH atuará sobre a primeira linha do conjunto ativo.
- Extair os dados do cursor é o evento onde os dados da linha atual do conjunto ativo são copiados para variáveis ou registros e a cada FETCH realizado, o ponteiro passará a apontar para a linha seguinte do conjunto ativo.
- O comando CLOSE desativa o cursor e libera o conjunto ativo. Esta etapa permite que o cursor seja reaberto, se necessário, para gerar um outro conjunto ativo.
- Neste primeiro estilo de loop de busca, a sintaxe de loop simples é utilizada para processamento do cursor.  Atributos explícitos de cursor são utilizados para controlar o número de vezes que o loop é executado.
- Existem os cursor implícitos que são criados para processar as instruções INSERT, UPDATE, DELETE, SELECT...INTO e são manipulados a revelia do programador.
- Atributos do Cursor 

| **Atributo** | **Tipo** | **Descrição**                                                          |
| ------------ | -------- | ---------------------------------------------------------------------- |
| %ISOPEN      | Booleano | Será avaliado para TRUE se o cursor estiver aberto                     |
| %NOTFOUND    | Booleano | Será avaliado para TRUE se a extração mais recente não retornar linha. |
| %FOUND       | Booleano | Será avaliado para TRUE se a extração mais recente retornar linha.     |
| %ROWCOUNT    | Numérico | Será avaliado para o número total de linhas retornadas até o momento.  |

#### Estruturas de Controle
- Os controles de declarações são realizados em três categorias, as quais são a de declarações condicionais de seleção, declarações em loop (repetitivas) e as declarações de controle em sequência.
- Quando trabalhamos com as instruções IF no Oracle, estas são utilizadas para a execução de código para quando uma condição for satisfeita, ou seja, quando esta for verdadeira, em caso de apresentar um resultado diferente, ela executará uma outra estrutura de código. Os IF’s são executados em uma dada sequência de instruções, onde temos três formas de apresentação desta instrução: IF-THEN, IF-THEN-ELSE e IF-THEN-ELSEIF.
- A instrução CASE é uma forma mais compacta para realizar a avaliação de uma única condição e escolher entre algumas ações alternativas. No caso de termos mais de dois IF’s, de certa forma, passa a ser mais aplicável a utilização de CASES. Para que possamos entender melhor com relação a estrutura do CASE.
- No PL/SQL temos também o recurso CASE Searched, o qual é bastante semelhante às instruções simples do CASE, com a diferença de que nesta forma o CASE não possui parâmetros de entrada e em suas cláusulas WHEN temos condições de pesquisa que retornam valores booleanos ao invés de expressões que podem ter valores de qualquer tipo.
- A partir desse momento estaremos trabalhando com os Loops no Oracle, que nada mais são que estruturas de repetição. No Oracle podemos utilizar os Loops para rodar as mesmas estruturas de formas diferentes com diferentes valores. Os loops realizam a execução de sequências de instruções até alcançar o objetivo. As estruturas de Loop no Oracle são o Loop Básico, For Loop, Cursos Loop e o While Loop. 
- Quando utilizamos a declaração EXIT WHEN, ela sai da iteração atual do ciclo quando a condição da cláusula WHEN é verdadeira, no caso TRUE. Ocorrendo essa validação, o controle é transferido para o fim do loop. 
- Quando utilizamos a declaração CONTINUE WHEN, ela sai da iteração atual do ciclo quando a condição em sua cláusula WHEN é apresentada como TRUE, e em seguida, transfere o controle para a próxima iteração do loop.
#### Propriedades de transação (ACID)
> O que é uma transação? 
>   Uma transação é uma sequência de operações executadas como uma única unidade lógica de trabalho.
- ACID é um conceito que se refere às quatro propriedades de transação de um sistema de banco de dados: Atomicidade, Consistência, Isolamento e Durabilidade.
- **Atomicidade**: As transações são, geralmente, compostas de várias declarações (comandos / operações). A atomicidade é uma propriedade que garante que cada transação seja tratada como uma entidade única, a qual deve ser executada por completo ou falhar completamente. Desta forma, todas as operações da transação devem ser executadas com sucesso para que a transação tenha sucesso.
- Se uma única operação que seja do bloco da transação falhar, toda a transação deverá ser cancelada – as transações são aplicadas de uma forma “tudo ou nada”. Caso haja falha em qualquer operação da transação, o banco de dados será retornado ao estado anterior ao início da transação. Chamamos a esse retorno de estado de Rollback (“transação desfeita”).
- Caso a transação tenha sucesso, o BD é alterado de forma permanente, em um processo denominado Commit (“efetivação”)
- **Consistência**: A propriedade da consistência permite assegurar que uma transação somente leve o banco de dados de um estado válido a outro, mantendo a estabilidade do banco. Os dados que são gravados devem sempre ser válidos, de acordo com regras definidas, e isso inclui qualquer operação considerada, como triggers, constraints (restrições), procedimentos armazenados, ou outras que determinem a validade dos dados inseridos. Desta forma, é evitada a corrupção do banco de dados que pode ser causada por uma transação ilegal.
- Por exemplo, se for feita uma tentativa de inserir um registro em uma tabela de vendas da venda de um produto que não esteja presente em uma tabela de produtos, a transação falhará.
- **Isolamento**: É muito comum que transações sejam executadas de forma concorrente, ou seja, de forma que várias tabelas sejam lidas ou alteradas por vários usuários simultaneamente. Com a propriedade do isolamento a execução concorrente permite deixar o banco de dados no mesmo estado em que ele estaria caso as transações fossem executadas em sequência.
- Por exemplo, imagine dois clientes tentando comprar o último exemplar de um produto em estoque, simultaneamente. O primeiro a finalizar a compra fará com que a transação do outro seja interrompida, sofrendo rollback.
- **Durabilidade**: A propriedade da durabilidade garante que uma transação, uma vez executada (efetivada), permanecerá neste estado mesmo que haja um problema grave no sistema, como travamento de sistema ou falta de energia elétrica no servidor. Para isso, as transações finalizadas são gravadas em dispositivos de memória permanente (não-volátil), como discos rígidos, de modo que os dados estejam sempre disponíveis, mesmo que a instância do BD seja reiniciada.
#### Joins
- **Inner join**: 
- Uma Junção Interna é caracterizada por uma seleção que retorna apenas os dados que atendem às condições de junção, isto é, quais linhas de uma tabela se relacionam com as linhas de outras tabelas. Para isto utilizamos a cláusula ON, que é semelhante à cláusula WHERE.
- Podemos especificar duas formas diferentes de expressar esta junção: a explícita utiliza a palavra JOIN, enquanto a implícita utiliza ',' para separar as tabelas a combinar na cláusula FROM do SELECT. Então sempre é gerado o produto cruzado do qual são selecionadas as combinações que cumpram a cláusula WHERE.
- **Outer join** 
  - Left Outer Join: O resultado desta seleção sempre contém todos os registros da tabela esquerda (isto é, a primeira tabela mencionada na consulta), mesmo quando não exista registros correspondentes na tabela direita. Desta forma, esta seleção retorna todos os valores da tabela esquerda com os valores da tabela direita correspondente, ou quando não há correspondência retorna um valor NULL.
  - Right Outer Join: Esta operação apresenta todos os dados das tabelas à esquerda e à direita, mesmo que não possuam correspondência em outra tabela. A tabela combinada possuirá assim todos os registros de ambas as tabelas e apresentará valores nulos para os registros sem correspondência.
- **Self join**
- Bem, um SELF JOIN nada mais é que um JOIN na mesma tabela, relacionando colunas diferentes claro. Então é necessário que a tabela tenha pelo menos duas colunas, onda faremos uma coluna se relacionar com a outra. Isto acontece poucas vezes na prática, mas é muito bom com dados hierárquicos, onde podemos fazer uma árvore genealógica, ou como no exemplo mais abaixo podemos relacionar um empregado com o seu gerente que também é um empregado e existe na mesma tabela.
- **Cross Join**
- Quando queremos juntar duas ou mais tabelas por cruzamento.
- **Natural join**
- Cria um INNER ou OUTTER join entre as duas tabelas, sem definição EXPLICITA do critério de junção, pois, automaticamente, se utiliza dos campos que as duas tabelas tem em comum para criar a junçao (Utiliza as chaves estrangeiras que interligam as duas tabelas).
- **Theta e equi join**
- Muitos consideram ambos EQUI JOIN e Theta JOIN semelhantes a INNER, OUTER etc JOINs. Mas eu acredito fortemente que é um erro e faz o ideias vagas. Porque INNER JOIN, OUTER JOIN etc estão todos conectados com as tabelas e seus dados, enquanto EQUI JOIN e THETA JOIN são apenas conectado com os operadores que usamos no primeiro.

## Exemplos

#### IF-THEN
```sql
    DECLARE
      precoVenda  NUMBER(10,2) := 300;
      cota  NUMBER(8,2) := 500;
      bonificacao  NUMBER(5,2);
      codFunc NUMBER(6) := 15;
  BEGIN
      IF precoVenda > (cota + 100) THEN
        bonificacao := (precoVenda - cota)/4;
        UPDATE funcionario SET salarioFunc = salarioFunc + bonificacao
        WHERE funcionario_id = codFunc;
   END IF;
  END;
```
#### IF-THEN-ELSE
```sql
    DECLARE
       precoVenda  NUMBER(8,2) := 400;
       cota  NUMBER(8,2) := 10;
       bonificacao  NUMBER(6,2);
       codFunc NUMBER(6) := 20;
     BEGIN
       IF precoVenda > (cota + 30) THEN
         bonificacao := (precoVenda - cota)/4;
       ELSE
         bonificacao := 100;
      END IF;
         UPDATE funcionario
       SET salarioFunc = salarioFunc + bonificacao
       WHERE funcionario_id = codFunc;
   END;
```
#### IF-THEN-ELSIF
```sql
    DECLARE
      precoVenda  NUMBER(8,2) := 200;
      bonificacao  NUMBER(6,2);
      codFunc NUMBER(6)   := 120;
    BEGIN
      IF precoVenda > 6000 THEN
        bonificacao := 1200;
      ELSIF precoVenda > 3500 THEN
        bonificacao := 250;
      ELSE
        bonificacao := 100;
      END IF;
       UPDATE funcionario SET salarioFunc = salarioFunc + bonificacao
       WHERE funcionario_id = codFunc;
    END;
```
#### IF Aninhados
```sql
    DECLARE
     precoVenda  NUMBER(8,2) := 21000;
     cota  NUMBER(8,2) := 1000;
     bonificacao  NUMBER(6,2);
     codFunc NUMBER(6)   := 150;
   BEGIN
     IF precoVenda > (cota + 50) THEN
        bonificacao := (precoVenda - cota)/4;
      ELSE
        IF precoVenda > cota THEN
          bonificacao := 70;
        ELSE
          bonificacao := 0;
        END IF;
      END IF;
        UPDATE funcionario
         SET salarioFunc = salarioFunc + bonificacao
         WHERE funcionario_id = codFunc;
    END;

```
#### CASE
```sql
    DECLARE
      nota integer;
    BEGIN
      nota := 9;
     
     CASE nota
        WHEN 10 THEN DBMS_OUTPUT.PUT_LINE('Nota Excelente');
        WHEN 9 THEN DBMS_OUTPUT.PUT_LINE('Nota muito boa');
        WHEN 8 THEN DBMS_OUTPUT.PUT_LINE('Boa nota');
        WHEN 7 THEN DBMS_OUTPUT.PUT_LINE('Nota na média');
        WHEN 6 THEN DBMS_OUTPUT.PUT_LINE('Nota abaixo da média');
        ELSE DBMS_OUTPUT.PUT_LINE('Sem classificação de notas');
      END CASE;
   END;
```
#### CASE searched
```sql
    case searched
DECLARE
      nota INTEGER;
    BEGIN
      nota := 7;
      CASE
        WHEN nota = 10 THEN DBMS_OUTPUT.PUT_LINE('Nota Excelente');
        WHEN nota = 9 THEN DBMS_OUTPUT.PUT_LINE('NOta muito boa');
        WHEN nota = 8 THEN DBMS_OUTPUT.PUT_LINE('Boa nota');
        WHEN nota = 7 THEN DBMS_OUTPUT.PUT_LINE('Nota média');
        WHEN nota = 5 THEN DBMS_OUTPUT.PUT_LINE('Nota abaixo da média');
        ELSE DBMS_OUTPUT.PUT_LINE('Sem classificação de notas');
      END CASE;
    END;
```
#### CASE com exceptions
```sql
    DECLARE
      nota INTEGER;
    BEGIN
      nota := 3;
      CASE
        WHEN nota = 10 THEN DBMS_OUTPUT.PUT_LINE('Nota Excelente');
        WHEN nota = 9 THEN DBMS_OUTPUT.PUT_LINE('Nota muito boa');
        WHEN nota = 8 THEN DBMS_OUTPUT.PUT_LINE('Boa nota');
        WHEN nota = 7 THEN DBMS_OUTPUT.PUT_LINE('Nota média');
        WHEN nota = 5 THEN DBMS_OUTPUT.PUT_LINE('Nota abaixo da média');
    END CASE;
      EXCEPTION
        WHEN CASE_NOT_FOUND THEN
          DBMS_OUTPUT.PUT_LINE('Sem classificação de notas');
    END;
```
#### LOOP
```sql
    DECLARE
    valor NUMBER := 0;
  BEGIN
    LOOP
      DBMS_OUTPUT.PUT_LINE (' No interior do loop, temos o valor = ' || TO_CHAR(valor));
      valor := valor + 1;
      IF valor > 40 THEN
        EXIT;
      END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE(' Após o Loop com valor = ' || TO_CHAR(valor));
  END;
```
#### LOOP com EXIT WHEN
```sql
    DECLARE
    valor NUMBER := 0;
  BEGIN
    LOOP
      DBMS_OUTPUT.PUT_LINE('Dentro do loop, temos o valor = ' || TO_CHAR(valor));
      valor := valor + 1;
      EXIT WHEN valor > 10;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Após o último registro do loop verificado, temos o valor = ' || TO_CHAR(valor));
  END;
```
#### LOOPs aninhados
```sql
    DECLARE
    s INTEGER := 0;
    i INTEGER := 0;
    j INTEGER;
  BEGIN
    <<outer_loop>>
    LOOP
      i := i + 1;
      j := 0;
      << inner_loop >>
      LOOP
        j := j + 1;
        s := s + i * j;
        EXIT inner_loop WHEN (j > 8);
        EXIT outer_loop WHEN ((i * j) > 26);
      END LOOP inner_loop;
    END LOOP outer_loop;
    DBMS_OUTPUT.PUT_LINE
      ('A soma do valor dos produtos é igual a: ' || TO_CHAR(s));
  END;
```
#### Loops aninhados com cláusulas EXIT WHEN
```sql
    DECLARE
    i INTEGER := 0;
    j INTEGER := 0;
  BEGIN
    LOOP
      i := i + 1;
      DBMS_OUTPUT.PUT_LINE ('o valor de i é: ' || i);
     LOOP
        j := j + 1;
        DBMS_OUTPUT.PUT_LINE ('O valor de j é:' || j);
        EXIT WHEN (j > 8);
      END LOOP;
      DBMS_OUTPUT.PUT_LINE ('Saindo do loop interno');
      EXIT WHEN (i > 6);
    END LOOP;
    DBMS_OUTPUT.PUT_LINE ('Saindo do Loop externo');
  END;
```
#### Loop básico com cláusula CONTINUE
```sql
    DECLARE
   valor NUMBER := 0;
  BEGIN
    LOOP – Após a declaração CONTINUE
      DBMS_OUTPUT.PUT_LINE ('Valor apresentado no interior do loop é igual a: ' || TO_CHAR(valor));
      valor := valor + 1;
      IF valor < 15 THEN
        CONTINUE;
      END IF;
      DBMS_OUTPUT.PUT_LINE
        ('No interior do loop, após a cláusula CONTINUE, o valor é igual a: ' || TO_CHAR(valor));
      EXIT WHEN valor = 5;
    END LOOP;
     DBMS_OUTPUT.PUT_LINE ('Após o loop, o valor é igual a: ' || TO_CHAR(valor));
  END;
```
#### Cláusula CONTINUE com a utilização da cláusula CONTINUE WHEN
```sql
    DECLARE
        valor NUMBER := 0;
    BEGIN
    LOOP
        DBMS_OUTPUT.PUT_LINE ('Dentro do Loop o valor é igual a:  ' || TO_CHAR(valor));
        valor := valor + 1;
        CONTINUE WHEN valor < 8;
        DBMS_OUTPUT.PUT_LINE ('Após a cláusula CONTINUE, o valor é igual a: ' || TO_CHAR(valor));
        EXIT WHEN valor = 7;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE ('Após o loop, o valor é igual a:' || TO_CHAR(valor));
  END;
```
#### criação de uma função
```sql
CREATE OR REPLACE FUNCTION primeiro_nome_func
  RETURN VARCHAR(20);
 IS 
  emp_name VARCHAR(20); 
BEGIN 
SELECT primeiro_nome INTO emp_name
 FROM funcionarios_tbl WHERE ID = 90;
 RETURN emp_name;
END;
```
#### valor máximo entre dois números inteiros
```sql
SET serveroutput ON;
  
DECLARE
  a NUMBER;
  b NUMBER;
  c NUMBER;
  
  FUNCTION max_entre_numeros(
      x IN NUMBER,
      y IN NUMBER)
    RETURN NUMBER
  IS
    z NUMBER;
  BEGIN
    IF x > y THEN
      z := x;
    ELSE
      Z:= y;
    END IF;
    RETURN z;
  END;
  BEGIN
    a := 23;
    b := 45;
    c := max_entre_numeros (a, b);
    dbms_output.put_line('Valor máximo obtido entre os valores ' || a ||
     ' e ' || b || ' foi ' || c);  
END;
```
#### função recursiva para calcular o fatorial de um número
```sql
DECLARE
  num NUMBER;
  valor NUMBER;
  fatorial NUMBER;
  FUNCTION fact(
      x NUMBER)
    RETURN NUMBER
  IS
    f NUMBER;
  BEGIN
    IF x =0 THEN
      f := 1;
    ELSE
      f := x * fact(x-1);
    END IF;
    RETURN f;
  END;
  BEGIN
    num       := &valor;
    factorial := fact(num);
    dbms_output.put_line(' O valor fatorial de '|| num 
     || ' é ' || fatorial);
  END;
```
#### Criação de uma procedure
```sql
CREATE OR REPLACE
PROCEDURE detalhes_dos_funcionarios
IS
  CURSOR emp_cur
  IS
    SELECT first_name, last_name, salary FROM emp_tbl;
  emp_rec emp_cur%rowtype;
BEGIN
  FOR emp_rec IN sales_cur
  LOOP
    dbms_output.put_line('Nome do funcionário: ' || emp_cur.first_name || 
     '. Sobrenome do funcionário: ' ||emp_cur.last_name || 
     '. Salário do funcionário: 
     ' ||emp_cur.salary);
  END LOOP;
END;
```
#### procedure para retornar o número mínimo utilizando o IN OUT
```sql
DECLARE
   a number;
   b number;
   c number;
  
PROCEDURE valorMinimo(x IN number, y IN number, z OUT number) IS
BEGIN
   IF x < y THEN
      z:= x;
   ELSE
      z:= y;
   END IF;
END; 
  
BEGIN
   a:= 23;
   b:= 45;
   valorMinimo(a, b, c);
 dbms_output.put_line('O valor mínimo obtido entre os valores ' || a
 || ' e ' || b || ' foi ' || c);  
END;
```
#### Exemplo de cursor
```sql
  DECLARE
    V_empno NUMBER;
    V_ename VARCHAR2(100);
    CURSOR cEmplyee IS
     SELECT employee_id,first_name
       FROM EMPLOYEES;
    rEmployee cEmplyee%ROWTYPE;
    CURSOR cEmplyeeJob
      (p_job varchar)
    IS
     SELECT first_name
       FROM EMPLOYEES
      WHERE Job_id = p_job;
  BEGIN
    OPEN cEmplyee;
    FETCH cEmplyee INTO V_empno, V_ename;
    DBMS_OUTPUT.PUT_LINE(V_ename);
    FETCH cEmplyee INTO V_empno, V_ename;
    DBMS_OUTPUT.PUT_LINE(V_ename);
    FETCH cEmplyee INTO V_empno, V_ename;
    DBMS_OUTPUT.PUT_LINE(V_ename);
    FETCH cEmplyee INTO rEmployee ;
    DBMS_OUTPUT.PUT_LINE(rEmployee.first_name);
    CLOSE cEmplyee;

    OPEN cEmplyeeJob('SALESMAN');
    FETCH cEmplyeeJob INTO V_ename;
    DBMS_OUTPUT.PUT_LINE(V_ename);
    FETCH cEmplyeeJob INTO V_ename;
    DBMS_OUTPUT.PUT_LINE(V_ename);
    CLOSE cEmplyeeJob;

    OPEN cEmplyeeJob('MANAGER');
    FETCH cEmplyeeJob INTO V_ename;
    DBMS_OUTPUT.PUT_LINE(V_ename);
    FETCH cEmplyeeJob INTO V_ename;
    DBMS_OUTPUT.PUT_LINE(V_ename);
    CLOSE cEmplyeeJob;
  END;
```
Cursor com loop simples
```sql  
  DECLARE
    CURSOR cEmpregados IS
      SELECT first_name FROM employees;
    aName employees.first_name%TYPE;
  BEGIN
    OPEN cEmpregados;
    LOOP
      FETCH cEmpregados INTO aName;
      EXIT WHEN cEmpregados%NOTFOUND;
      DBMS_OUTPUT.PUT_LINE(aName);
    END LOOP;
    CLOSE cEmpregados;
  END;
```
Cursores com while loop
```sql
  DECLARE
    CURSOR cCidades IS
      SELECT * FROM locations;
    rCity locations%ROWTYPE;
  BEGIN
    OPEN cCidades;
    FETCH cCidades INTO rCity;
    WHILE cCidades%FOUND LOOP
      DBMS_OUTPUT.PUT_LINE(rCity.city||' - '||rCity.state_province);
      FETCH cCidades INTO rCity;
    END LOOP;
    CLOSE cCidades;
  END;
```
cursor com loop for
```sql
  DECLARE
    CURSOR cCargos IS
      SELECT job_title, job_id
        FROM jobs;
  BEGIN
    FOR rCargo IN cCargos LOOP
      DBMS_OUTPUT.PUT_LINE(rCargo.job_id||' - '||rCargo.job_title);
    END LOOP;
  END;
```
Cursor com for implicito
```sql
 BEGIN
   FOR rDepartamento IN (SELECT d.department_id, d.department_name
                           FROM departments d) LOOP
     DBMS_OUTPUT.PUT_LINE(rDepartamento.department_name);
   END LOOP;
 END;
```
cursor implicito
```sql
  BEGIN
    UPDATE jobs
       SET MAX_SALARY = MAX_SALARY+100
     WHERE MAX_SALARY < 9000;
 
    DBMS_OUTPUT.PUT_LINE(SQL%ROWCOUNT||' linhas salarios foram atualizadas');
  END;
```