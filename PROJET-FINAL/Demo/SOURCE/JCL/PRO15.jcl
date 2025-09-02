//API1RES4  JOB (ACCT#),'COMPDB2',MSGCLASS=H,REGION=4M,
//    CLASS=A,MSGLEVEL=(1,1),NOTIFY=&SYSUID,
//    COND=(4,LT),TIME=(0,5)
//*
//*------------------------------------------------------*
//* ===> CHANGER XX PAR N¢ DU GROUPE   (XX 01 @ 15)      *
//*      CHANGER     API3DB$  PAR LE NOM DU PROGRAMME    *
//*------------------------------------------------------*
//*
//*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*
//*   CETTE PROCEDURE CONTIENT 5 STEPS :                             *
//*       ======> SI RE-EXECUTION FAIRE RESTART AU "STEPRUN"         *
//*                                                                  *
//*         1/  PRECOMPILE  DB2                                      *
//*         2/  COMPILE COBOL II                                     *
//*         3/  LINKEDIT  (DANS FORM.CICS.LOAD)                      *
//*         4/  BIND PLAN PARTIR DE API3.SOURCE.DBRMLIB              *
//*         5/  EXECUTE DU PROGRAMME                                 *
//*  LES   PROCEDURES  SE TROUVENT DANS SDJ.FORM.PROCLIB             *
//*=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-*
//PROCLIB  JCLLIB ORDER=SDJ.FORM.PROCLIB
//*
//         SET SYSUID=API1,
//             NOMPGM=PRO15
//*
//APPROC   EXEC COMPDB2
//STEPDB2.SYSLIB   DD DSN=&SYSUID..SOURCE.DCLGEN,DISP=SHR
//STEPDB2.SYSIN    DD DSN=&SYSUID..SOURCE.COBOL(&NOMPGM),DISP=SHR
//STEPDB2.DBRMLIB  DD DSN=&SYSUID..SOURCE.DBRMLIB(&NOMPGM),DISP=SHR
//STEPCOB.SYSLIB   DD DSN=&SYSUID..SOURCE.COPY,DISP=SHR
//STEPLNK.SYSLMOD  DD DSN=&SYSUID..SOURCE.PGMLIB(&NOMPGM),DISP=SHR
//*
//*--- ETAPE DE BIND --------------------------------------
//*
//BIND     EXEC PGM=IKJEFT01,COND=(4,LT)
//*DBRMLIB  DD  DSN=&SYSUID..SOURCE.DBRMLIB,DISP=SHR
//DBRMLIB  DD  DSN=&SYSUID..SOURCE.DBRMLIB,DISP=SHR
//SYSTSPRT DD  SYSOUT=*,OUTLIM=25000
//SYSTSIN  DD  *
  DSN SYSTEM (DSN1)
  BIND PLAN      (PRO15)   -
       QUALIFIER (API3)    -
       ACTION    (REPLACE) -
       MEMBER    (PRO15)   -
       VALIDATE  (BIND)    -
       ISOLATION (CS)      -
       ACQUIRE   (USE)     -
       RELEASE   (COMMIT)  -
       EXPLAIN   (NO)
/*
//STEPRUN  EXEC PGM=IKJEFT01,COND=(4,LT)
//STEPLIB  DD  DSN=&SYSUID..COB.LOAD.NEW,DISP=SHR
//LPRODUCT DD  DSN=API3.PROJET.NEWPRODS.DATA,DISP=SHR
//SYSOUT   DD  SYSOUT=*,OUTLIM=1000
//SYSTSPRT DD  SYSOUT=*,OUTLIM=2500
//SYSIN    DD  *
EU110
DO100
YU014
00000
/*
//SYSTSIN  DD  *
  DSN SYSTEM (DSN1)
  RUN PROGRAM(PRO15) PLAN (PRO15)
//
//