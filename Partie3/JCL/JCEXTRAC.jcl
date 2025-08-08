//JA1EXP    JOB NOTIFY=&SYSUID,CLASS=A,MSGCLASS=H,
//       TIME=(0,30),MSGLEVEL=(1,1)
//***********************************************************
//*  ====> JCL D'APPEL DE LA PROCEDURE COMPDB2  BATCH       *
//*                                                         *
//*  ====> COMPIL COBOL/DB2 + BIND   (BATCH)                *
//*        =======================   *******                *
//*        REMPLACER API? PAR VOTRE USER TSO                *
//*           ? : Nì DU GROUPE,  $ : N¢ DU PROGRAMME        *
//*                  API?DB$ PAR LE NOM DU PROGRAMME        *
//*                                                         *
//***********************************************************
//PROCLIB  JCLLIB ORDER=SDJ.FORM.PROCLIB
//*
//         SET SYSUID=API1,
//             NOMPGM=EXTRACTP
//*
//APPROC   EXEC COMPDB2
//STEPDB2.SYSLIB   DD DSN=&SYSUID..SOURCE.DCLGEN,DISP=SHR
//STEPDB2.SYSIN    DD DSN=&SYSUID..SOURCE.COBOL(&NOMPGM),DISP=SHR
//STEPDB2.DBRMLIB  DD DSN=&SYSUID..SOURCE.DBRMLIB(&NOMPGM),DISP=SHR
//STEPCOB.SYSLIB   DD DSN=&SYSUID..SOURCE.COPY(&NOMPGM),DISP=SHR
//STEPLNK.SYSLMOD  DD DSN=&SYSUID..SOURCE.PGMLIB(&NOMPGM),DISP=SHR
//*
//*--- ETAPE DE BIND --------------------------------------
//*
//BIND     EXEC PGM=IKJEFT01,COND=(4,LT)
//DBRMLIB  DD  DSN=&SYSUID..SOURCE.DBRMLIB,DISP=SHR
//SYSTSPRT DD  SYSOUT=*,OUTLIM=25000
//SYSTSIN  DD  *
  DSN SYSTEM (DSN1)
  BIND PLAN      (EXTRACTP) -
       QUALIFIER (API6)     -
       ACTION    (REPLACE)  -
       MEMBER    (EXTRACTP) -
       VALIDATE  (BIND)     -
       ISOLATION (CS)       -
       ACQUIRE   (USE)      -
       RELEASE   (COMMIT)   -
       EXPLAIN   (NO)
/*
//****************************************************************
//* SUPPRIMER LE FICHIER API1.PROJET.EXTRACT.DATA                *
//****************************************************************
//SUPPKSDS EXEC PGM=IDCAMS,COND=(4,LT)
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE API1.PROJET.EXTRACT.DATA
/*
//**************************************************************
//*                EXECUTION                                   *
//**************************************************************
//STEPRUN  EXEC PGM=IKJEFT01,COND=(8,LT)
//STEPLIB  DD DSN=&SYSUID..SOURCE.PGMLIB,DISP=SHR
//EXTRACT  DD DSN=API1.PROJET.EXTRACT.DATA,DISP=(NEW,CATLG,DELETE),
//         DCB=(LRECL=250,RECFM=FB,BLKSIZE=2500),
//         SPACE=(TRK,(2,3),RLSE)
//SYSTSPRT DD  SYSOUT=*,OUTLIM=2500
//SYSOUT   DD  SYSOUT=*,OUTLIM=1000
//SYSTSIN  DD  *
  DSN SYSTEM (DSN1)
  RUN PROGRAM(EXTRACTP) PLAN(EXTRACTP)
/*
