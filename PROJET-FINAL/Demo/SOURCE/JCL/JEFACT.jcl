//API1EFAC JOB (ACCT#),'STEEVEA',CLASS=A,MSGCLASS=H,MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID,REGION=4M,TIME=(,30),COND=(8,LT)
//****************************************************************
//* SUPPRIMER LE FICHIER API1.PROJET.FACTURE.DATA                *
//****************************************************************
//SUPPKSDS EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE API1.PROJET.FACTURE.DATA
/*
//****************************************************************
//* EXECUTION DU PROGRAMME API9.SOURCE.COBOL(DEMO01)
//****************************************************************
//STEP01   EXEC PGM=CREAFACT
//STEPLIB  DD DSN=API1.COBOL.LOAD,DISP=SHR
//EXTRACT  DD DSN=API1.PROJET.EXTRACT.DATA,DISP=SHR
//FFACT    DD DSN=API1.PROJET.FACTURE.DATA,DISP=(NEW,CATLG,DELETE),
//         DCB=(LRECL=79,RECFM=FB,BLKSIZE=790),
//         SPACE=(TRK,(5,5),RLSE)
//SYSOUT   DD SYSOUT=*
//SYSIN    DD *
0115
/*
