
-- Trigger para adicionar um sufixo ao inserir um departamento
CREATE OR REPLACE
TRIGGER TG_SUFIXO BEFORE
INSERT
	ON
	Depto FOR EACH ROW
BEGIN
	:NEW.NOMEDEPTO := :NEW.NOMEDEPTO || 'sons';
END;

-- Trigger para impedir que o insert ou update de um professor que seja doutor
CREATE OR REPLACE
TRIGGER TG_DOUTOR BEFORE
INSERT
	OR
UPDATE
	OF codtit ON
	professor FOR EACH ROW
BEGIN
	IF :NEW.codtit = 1 THEN RAISE_APPLICATION_ERROR(-20000,
	'Titulação Inválida');
END IF;
END;

-- Trigger de auditoria, pega o horario e o usuário logado após cada alteração.
CREATE OR REPLACE
TRIGGER tg_historico AFTER
UPDATE
	ON
	professor FOR EACH ROW
DECLARE DATA_ATUALIZACAO TIMESTAMP;

LOGIN_ATUAL VARCHAR2(20);
BEGIN
DATA_ATUALIZACAO := CURRENT_TIMESTAMP;

LOGIN_ATUAL := SYS_CONTEXT ('USERENV',
'SESSION_USER');

INSERT
	INTO
	PROFESSOR_HIST
VALUES (:new.CODPROF,
:new.CODDEPTO,
:new.CODTIT,
:new.NOMEPROF,
DATA_ATUALIZACAO,
LOGIN_ATUAL);
END;

-- trigger para garantir integridade referencial
CREATE OR REPLACE TRIGGER tg_fkprereq BEFORE
    DELETE ON disciplina
    FOR EACH ROW
BEGIN
    DELETE FROM prereq
    WHERE
        ( numdisc = :old.numdisc )
        OR ( prereq.numdiscprereq = :old.numdisc );

END;

CREATE OR REPLACE TRIGGER tg_fkdisciplina BEFORE
    INSERT OR UPDATE ON prereq
    FOR EACH ROW
DECLARE
    linhas NUMBER;
BEGIN
    SELECT
        numdisc
    INTO linhas
    FROM
        disciplina
    WHERE
        numdisc = :new.numdisc
        OR numdisc = :new.numdiscprereq;

    IF linhas < 1 THEN
        raise_application_error(-20000, 'INSERT ou UPDATE na tabela (prereq) viola a FK');
    END IF;
END;