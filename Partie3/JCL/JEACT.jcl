//API1EFAC JOB (ACCT#),'STEEVEA',CLASS=A,MSGCLASS=H,MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID,REGION=4M,TIME=(,30)
//****************************************************************
//* EXECUTION DU PROGRAMME API9.SOURCE.COBOL(DEMO01)
//****************************************************************
//STEP01   EXEC PGM=CREAFACT
//STEPLIB  DD DSN=API1.COBOL.LOAD,DISP=SHR
//EXTRACT  DD DSN=API1.PROJET.EXTRACT.DATA,DISP=SHR
//SYSOUT   DD SYSOUT=*
