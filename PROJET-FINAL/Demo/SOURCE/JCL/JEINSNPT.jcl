//A1EINPT   JOB NOTIFY=&SYSUID,CLASS=A,MSGCLASS=H,
//       TIME=(0,30),MSGLEVEL=(1,1)
//**************************************************************
//*                EXECUTION                                   *
//**************************************************************
//STEPRUN  EXEC PGM=IKJEFT01,COND=(8,LT)
//STEPLIB  DD DSN=&SYSUID..SOURCE.PGMLIB,DISP=SHR
//FNPT     DD DSN=API1.PROJET.NEWPARTS.KSDS,DISP=SHR
//SYSTSPRT DD  SYSOUT=*,OUTLIM=2500
//SYSOUT   DD  SYSOUT=*,OUTLIM=1000
//SYSTSIN  DD  *
  DSN SYSTEM (DSN1)
  RUN PROGRAM(INSNPT) PLAN(INSNPT)
/*
