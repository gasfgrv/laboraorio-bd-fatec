
-- Trigger para adicionar um sufixo ao inserir um novo departamento.
 CREATE OR REPLACE
TRIGGER TG_SUFIXO BEFORE
INSERT
	ON
	Depto FOR EACH ROW
BEGIN
	:NEW.NOMEDEPTO := :NEW.NOMEDEPTO || 'sons';
END;
-- Triger para não permitir que haja um professor com a titulação de doutor.
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