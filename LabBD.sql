CREATE TABLE predio (
    codpred    INT,
    nomepred   VARCHAR(40)
);

ALTER TABLE predio ADD CONSTRAINT pk_predio PRIMARY KEY ( codpred );

CREATE TABLE sala (
    numsala         INT,
    codpred         INT,
    descricaosala   VARCHAR(40),
    capacsala       INT
);

ALTER TABLE sala ADD CONSTRAINT pk_sala PRIMARY KEY ( numsala,
                                                      codpred );

ALTER TABLE sala
    ADD CONSTRAINT fk_sala_relation_predio FOREIGN KEY ( codpred )
        REFERENCES predio ( codpred );

CREATE TABLE titulacao (
    codtit    INT,
    nometit   VARCHAR(40)
);

ALTER TABLE titulacao ADD CONSTRAINT pk_titulacao PRIMARY KEY ( codtit );

CREATE TABLE depto (
    coddepto    CHAR(5),
    nomedepto   VARCHAR(40)
);

ALTER TABLE depto ADD CONSTRAINT pk_depto PRIMARY KEY ( coddepto );

CREATE TABLE professor (
    codprof    INT,
    coddepto   CHAR(5),
    codtit     INT,
    nomeprof   VARCHAR(40)
);

ALTER TABLE professor ADD CONSTRAINT pk_professor PRIMARY KEY ( codprof );

ALTER TABLE professor
    ADD CONSTRAINT fk_professor_relation_titulacao FOREIGN KEY ( codtit )
        REFERENCES titulacao ( codtit );

ALTER TABLE professor
    ADD CONSTRAINT fk_professor_relation_depto FOREIGN KEY ( coddepto )
        REFERENCES depto ( coddepto );

CREATE TABLE disciplina (
    coddepto      CHAR(5),
    numdisc       INT,
    nomedisc      VARCHAR(10),
    creditodisc   INT
);

ALTER TABLE disciplina ADD CONSTRAINT pk_disciplina PRIMARY KEY ( numdisc,
                                                                  coddepto );

ALTER TABLE disciplina
    ADD CONSTRAINT fk_discipli_relation_depto FOREIGN KEY ( coddepto )
        REFERENCES depto ( coddepto );

CREATE TABLE prereq (
    coddeptoprereq   CHAR(5),
    numdiscprereq    INT,
    coddepto         CHAR(5),
    numdisc          INT
);

ALTER TABLE prereq
    ADD CONSTRAINT pk_prereq PRIMARY KEY ( coddeptoprereq,
                                           numdiscprereq,
                                           coddepto,
                                           numdisc );

ALTER TABLE prereq
    ADD CONSTRAINT fk_prereq_tem_pre_discipli FOREIGN KEY ( coddepto,
                                                            numdisc )
        REFERENCES disciplina ( coddepto,
                                numdisc );

ALTER TABLE prereq
    ADD CONSTRAINT fk_prereq_eh_pre_discipli FOREIGN KEY ( coddeptoprereq,
                                                           numdiscprereq )
        REFERENCES disciplina ( coddepto,
                                numdisc );

CREATE TABLE turma (
    anosem     INT,
    coddepto   CHAR(5),
    numdisc    INT,
    siglatur   CHAR(2),
    capactur   INT
);

ALTER TABLE turma
    ADD CONSTRAINT pk_turma PRIMARY KEY ( anosem,
                                          siglatur,
                                          coddepto,
                                          numdisc );

ALTER TABLE turma
    ADD CONSTRAINT fk_turma_relation_discipli FOREIGN KEY ( numdisc,
                                                            coddepto )
        REFERENCES disciplina ( numdisc,
                                coddepto );

CREATE TABLE profturma (
    anosem     INT,
    coddepto   CHAR(5),
    numdisc    INT,
    siglatur   CHAR(2),
    codprof    INT
);

ALTER TABLE profturma
    ADD CONSTRAINT pk_profturma PRIMARY KEY ( anosem,
                                              coddepto,
                                              numdisc,
                                              siglatur,
                                              codprof );

ALTER TABLE profturma
    ADD CONSTRAINT fk_profturm_relation_professor FOREIGN KEY ( codprof )
        REFERENCES professor ( codprof );

ALTER TABLE profturma
    ADD CONSTRAINT fk_profturm_relation_turma FOREIGN KEY ( siglatur,
                                                            numdisc,
                                                            coddepto,
                                                            anosem )
        REFERENCES turma ( siglatur,
                           numdisc,
                           coddepto,
                           anosem );

CREATE TABLE horario (
    anosem          INT,
    coddepto        CHAR(5),
    numdisc         INT,
    siglatur        CHAR(2),
    diasem          INT,
    horarioinicio   INT,
    numsala         INT,
    codpred         INT,
    numhoras        INT
);

ALTER TABLE horario ADD CONSTRAINT pk_horario PRIMARY KEY ( horarioinicio,
                                                            diasem );

ALTER TABLE horario
    ADD CONSTRAINT fk_horario_relation_turma FOREIGN KEY ( siglatur,
                                                           numdisc,
                                                           coddepto,
                                                           anosem )
        REFERENCES turma ( siglatur,
                           numdisc,
                           coddepto,
                           anosem );

ALTER TABLE horario
    ADD CONSTRAINT fk_horario_relation_sala FOREIGN KEY ( numsala,
                                                          codpred )
        REFERENCES sala ( numsala,
                          codpred );

DELETE FROM predio;

INSERT INTO predio VALUES (
    43423,
    'Informática - aulas'
);

INSERT INTO predio VALUES (
    43566,
    'Gestão - aulas'
);

INSERT INTO predio VALUES (
    34567,
    'Matemática - aulas'
);

DELETE FROM sala;

INSERT INTO sala VALUES (
    101,
    34567,
    'sala média',
    40
);

INSERT INTO sala VALUES (
    102,
    43423,
    'sala grande',
    60
);

INSERT INTO sala VALUES (
    103,
    43566,
    'sala pequena',
    27
);

DELETE FROM titulacao;

INSERT INTO titulacao VALUES (
    1,
    'Doutor'
);

INSERT INTO titulacao VALUES (
    2,
    'Mestre'
);

INSERT INTO titulacao VALUES (
    3,
    'Bacharel'
);

INSERT INTO titulacao VALUES (
    4,
    'Licenciatura'
);

DELETE FROM depto;

INSERT INTO depto VALUES (
    'INFO1',
    'Informática'
);

INSERT INTO depto VALUES (
    'MATE2',
    'Matemática 2'
);

INSERT INTO depto VALUES (
    'GEST1',
    'Gestão'
);

INSERT INTO depto VALUES (
    'PROG1',
    'Programação'
);

DELETE FROM professor;

INSERT INTO professor VALUES (
    1,
    'MATE2',
    4,
    'Antunes'
);

INSERT INTO professor VALUES (
    2,
    'INFO1',
    1,
    'Joilson'
);

INSERT INTO professor VALUES (
    3,
    'INFO1',
    1,
    'Colevati'
);

INSERT INTO professor VALUES (
    4,
    'PROG1',
    2,
    'Wellington'
);

INSERT INTO professor VALUES (
    5,
    'GEST1',
    3,
    'Cleiton'
);

DELETE FROM disciplina;

INSERT INTO disciplina VALUES (
    'PROG1',
    1,
    'Progrm1',
    4
);

INSERT INTO disciplina VALUES (
    'GEST1',
    2,
    'Gest~DEmp',
    2
);

INSERT INTO disciplina VALUES (
    'PROG1',
    3,
    'Progrm2',
    4
);

INSERT INTO disciplina VALUES (
    'INFO1',
    4,
    'BancDado1',
    4
);

INSERT INTO disciplina VALUES (
    'INFO1',
    5,
    'BancDado2',
    4
);

DELETE FROM prereq;

INSERT INTO prereq VALUES (
    'INFO1',
    5,
    'INFO1',
    4
);

INSERT INTO prereq VALUES (
    'PROG1',
    1,
    'PROG1',
    3
);

DELETE FROM turma;

INSERT INTO turma VALUES (
    20021,
    'PROG1',
    1,
    'P1',
    40
);

INSERT INTO turma VALUES (
    20022,
    'PROG1',
    3,
    'P2',
    40
);

INSERT INTO turma VALUES (
    20021,
    'GEST1',
    2,
    'G1',
    60
);

INSERT INTO turma VALUES (
    20021,
    'INFO1',
    4,
    'B1',
    40
);

INSERT INTO turma VALUES (
    20022,
    'INFO1',
    4,
    'B1',
    40
);

INSERT INTO turma VALUES (
    20021,
    'INFO1',
    5,
    'B2',
    27
);

INSERT INTO turma VALUES (
    20031,
    'PROG1',
    1,
    'P1',
    40
);

INSERT INTO turma VALUES (
    20032,
    'PROG1',
    3,
    'P2',
    40
);

INSERT INTO turma VALUES (
    20031,
    'GEST1',
    2,
    'G1',
    60
);

DELETE FROM profturma;

INSERT INTO profturma VALUES (
    20021,
    'PROG1',
    1,
    'P1',
    4
);

INSERT INTO profturma VALUES (
    20022,
    'PROG1',
    3,
    'P2',
    3
);

INSERT INTO profturma VALUES (
    20021,
    'GEST1',
    2,
    'G1',
    1
);

INSERT INTO profturma VALUES (
    20021,
    'INFO1',
    4,
    'B1',
    5
);

INSERT INTO profturma VALUES (
    20022,
    'INFO1',
    4,
    'B1',
    5
);

INSERT INTO profturma VALUES (
    20021,
    'INFO1',
    5,
    'B2',
    3
);

INSERT INTO profturma VALUES (
    20031,
    'PROG1',
    1,
    'P1',
    4
);

INSERT INTO profturma VALUES (
    20032,
    'PROG1',
    3,
    'P2',
    3
);

INSERT INTO profturma VALUES (
    20031,
    'GEST1',
    2,
    'G1',
    1
);

DELETE FROM horario;

INSERT INTO horario VALUES (
    20021,
    'PROG1',
    1,
    'P1',
    4,
    12,
    103,
    43566,
    4
);

INSERT INTO horario VALUES (
    20022,
    'PROG1',
    3,
    'P2',
    1,
    17,
    102,
    43423,
    4
);

INSERT INTO horario VALUES (
    20021,
    'GEST1',
    2,
    'G1',
    2,
    07,
    101,
    34567,
    2
);

INSERT INTO horario VALUES (
    20021,
    'INFO1',
    4,
    'B1',
    2,
    08,
    102,
    43423,
    4
);

INSERT INTO horario VALUES (
    20022,
    'INFO1',
    4,
    'B1',
    3,
    04,
    103,
    43566,
    4
);

INSERT INTO horario VALUES (
    20021,
    'INFO1',
    5,
    'B2',
    2,
    05,
    102,
    43423,
    5
);

INSERT INTO horario VALUES (
    20031,
    'PROG1',
    1,
    'P1',
    4,
    13,
    103,
    43566,
    4
);

INSERT INTO horario VALUES (
    20032,
    'PROG1',
    3,
    'P2',
    5,
    13,
    103,
    43566,
    4
);

INSERT INTO horario VALUES (
    20031,
    'GEST1',
    2,
    'G1',
    6,
    13,
    102,
    43423,
    2
);