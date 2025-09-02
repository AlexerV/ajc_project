//APIEKSD  JOB (ACCT#),'AYMERICF',CLASS=A,MSGCLASS=H,MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID,REGION=4M,TIME=(,30),COND=(8,LT)
//* SUPPRIMER LE FICHIER API1.AJC.EMPLOYE.KSDS                 *
//****************************************************************
//SUPPKSDS EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE API1.AJC.EMPLOYE.KSDS
/*
//* CREATION DU FICHIER API1.AJC.EMPLOYE.KSDS                 *
//****************************************************************
//CREKSDS  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DEFINE CLUSTER (NAME(API1.AJC.EMPLOYE.KSDS)  -
                    VOLUME(APIWK2)            -
                    TRACKS(3 2)               -
                    FREESPACE(20 20)          -
                    KEYS(5 0)                 -
                    RECORDSIZE(70 70)         -
                    INDEXED)                  -
           DATA (NAME(API1.AJC.EMPLOYE.KSDS.D)) -
          INDEX (NAME(API1.AJC.EMPLOYE.KSDS.I))
/*
//* ALIMENTATION  DU FICHIER API1.AJC.EMPLOYE.KSDS              *
//*     A PARTIR  DU FICHIER API1.AJC.EMPLOYE.DATA              *
//****************************************************************
//ALIMKSDS EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//DDIN     DD DSN=API1.AJC.EMPLOYE.DATA,DISP=SHR
//DDOUT    DD DSN=API1.AJC.EMPLOYE.KSDS,DISP=SHR
//SYSIN    DD *
 REPRO INFILE(DDIN)  -
       OUTFILE(DDOUT)
/*
//* AFFICHAGE   DU FICHIER API1.AJC.EMPLOYE.DATA              *
//*          ET DU FICHIER API1.AJC.EMPLOYE.KSDS              *
//AFFICHE  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 PRINT INDATASET(API1.AJC.EMPLOYE.DATA) CHAR
 PRINT INDATASET(API1.AJC.EMPLOYE.KSDS) CHAR
/*
