create table PREDIO ( 
    codpred int, 
    nomepred varchar(40),
    primary key (codpred)
);

create table SALA (  
    numsala int, 
    codpred int, 
    descricaosala varchar(40), 
    capacsala int,
    primary key (numsala, codpred),
    constraint fk_sala_relation_predio
        foreign key (codpred) references PREDIO(codpred)
);

create table TITULACAO (
    codtit int,
    nometit varchar(40),
    primary key (codtit)
);

create table DEPTO (
    coddepto char(5),
    nomedepto varchar(40),
    primary key (coddepto)
);

create table PROFESSOR (
    codprof int,
    coddepto char(5),
    codtit int,
    nomeprof varchar(40),
    primary key (codprof),
    constraint fk_professor_relation_titulacao
        foreign key (codtit) references TITULACAO(codtit),
    constraint fk_professor_relation_depto
        foreign key (coddepto) references DEPTO(coddepto)
);

create table DISCIPLINA (
    coddepto char(5),
    numdisc int,
    nomedisc varchar(10),
    creditodisc int,
    primary key (numdisc, coddepto),
    constraint fk_discipli_relation_depto
        foreign key (coddepto) references DEPTO(coddepto)
);

create table PREREQ (
    coddeptoprereq char(5),
    numdiscprereq int,
    coddepto char(5),
    numdisc int,
    primary key (coddeptoprereq, numdiscprereq, coddepto, numdisc),
    constraint fk_prereq_tem_pre_discipli
        foreign key (coddepto, numdisc) references DISCIPLINA(coddepto, numdisc),
    constraint fk_prereq_eh_pre_discipli
        foreign key (coddeptoprereq, numdiscprereq) references DISCIPLINA(coddepto, numdisc)
);

create table TURMA (
    anosem int,
    coddepto char(5),
    numdisc int,
    siglatur char(2),
    capactur int,
    primary key (anosem, siglatur, coddepto, numdisc),
    constraint fk_turma_relation_discipli
        foreign key (numdisc, coddepto) references DISCIPLINA(numdisc, coddepto)
);

create table PROFTURMA (
    anosem int,
    coddepto char(5),
    numdisc int,
    siglatur char(2),
    codprof int,
    primary key (anosem, coddepto, numdisc, siglatur, codprof),
    constraint fk_profturm_relation_professor
        foreign key (codprof) references PROFESSOR(codprof),
    constraint fk_profturm_relation_turma
        foreign key (siglatur, numdisc, coddepto, anosem) references TURMA(siglatur, numdisc, coddepto, anosem)
);

create table HORARIO (
    anosem int,
    coddepto char(5),
    numdisc int,
    siglatur char(2),
    diasem int,
    horarioinicio int,
    numsala int,
    codpred int,
    numhoras int,
    primary key (horarioinicio, diasem),
    constraint fk_horario_relation_turma
        foreign key (siglatur, numdisc, coddepto, anosem) references TURMA(siglatur, numdisc, coddepto, anosem),
    constraint fk_horario_relation_sala
        foreign key (numsala, codpred) references SALA(numsala, codpred)
);

delete from predio;
insert into predio values (43423, 'Informática - aulas');
insert into predio values (43566, 'Gestão - aulas');
insert into predio values (34567, 'Matemática - aulas');

delete from sala;
insert into sala values (101, 34567, 'sala média', 40);
insert into sala values (102, 43423, 'sala grande', 60);
insert into sala values (103, 43566, 'sala pequena', 27);

delete from titulacao;
insert into titulacao values (1, 'Doutor');
insert into titulacao values (2, 'Mestre');
insert into titulacao values (3, 'Bacharel');
insert into titulacao values (4, 'Licenciatura');

delete from depto;
insert into depto values ('INFO1', 'Informática');
insert into depto values ('MATE2', 'Matemática 2');
insert into depto values ('GEST1', 'Gestão');
insert into depto values ('PROG1', 'Programação');

delete from professor;
insert into professor values (1, 'MATE2', 4, 'Antunes');
insert into professor values (2, 'INFO1', 1, 'Joilson');
insert into professor values (3, 'INFO1', 1, 'Colevati');
insert into professor values (4, 'PROG1', 2, 'Wellington');
insert into professor values (5, 'GEST1', 3, 'Cleiton');

delete from disciplina;
insert into disciplina values ('PROG1', 1, 'Progrm1', 4);
insert into disciplina values ('GEST1', 2, 'Gest~DEmp', 2);
insert into disciplina values ('PROG1', 3, 'Progrm2', 4);
insert into disciplina values ('INFO1', 4, 'BancDado1', 4);
insert into disciplina values ('INFO1', 5, 'BancDado2', 4);

delete from prereq;
insert into prereq values ('INFO1', 5, 'INFO1', 4);
insert into prereq values ('PROG1', 1, 'PROG1', 3);

delete from turma;
insert into turma values (20021, 'PROG1', 1, 'P1', 40);
insert into turma values (20022, 'PROG1', 3, 'P2', 40);
insert into turma values (20021, 'GEST1', 2, 'G1', 60);
insert into turma values (20021, 'INFO1', 4, 'B1', 40);
insert into turma values (20022, 'INFO1', 4, 'B1', 40);
insert into turma values (20021, 'INFO1', 5, 'B2', 27);
insert into turma values (20031, 'PROG1', 1, 'P1', 40);
insert into turma values (20032, 'PROG1', 3, 'P2', 40);
insert into turma values (20031, 'GEST1', 2, 'G1', 60);

delete from profturma;
insert into profturma values (20021, 'PROG1', 1, 'P1', 4);
insert into profturma values (20022, 'PROG1', 3, 'P2', 3);
insert into profturma values (20021, 'GEST1', 2, 'G1', 1);
insert into profturma values (20021, 'INFO1', 4, 'B1', 5);
insert into profturma values (20022, 'INFO1', 4, 'B1', 5);
insert into profturma values (20021, 'INFO1', 5, 'B2', 3);
insert into profturma values (20031, 'PROG1', 1, 'P1', 4);
insert into profturma values (20032, 'PROG1', 3, 'P2', 3);
insert into profturma values (20031, 'GEST1', 2, 'G1', 1);

delete from horario;
insert into horario values (20021, 'PROG1', 1, 'P1', 4, 12, 103, 43566, 4);
insert into horario values (20022, 'PROG1', 3, 'P2', 1, 17, 102, 43423, 4);
insert into horario values (20021, 'GEST1', 2, 'G1', 2, 07, 101, 34567, 2);
insert into horario values (20021, 'INFO1', 4, 'B1', 2, 08, 102, 43423, 4);
insert into horario values (20022, 'INFO1', 4, 'B1', 3, 04, 103, 43566, 4);
insert into horario values (20021, 'INFO1', 5, 'B2', 2, 05, 102, 43423, 5);
insert into horario values (20031, 'PROG1', 1, 'P1', 4, 13, 103, 43566, 4);
insert into horario values (20032, 'PROG1', 3, 'P2', 5, 13, 103, 43566, 4);
insert into horario values (20031, 'GEST1', 2, 'G1', 6, 13, 102, 43423, 2);
