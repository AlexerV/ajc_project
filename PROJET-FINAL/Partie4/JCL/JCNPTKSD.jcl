//A1PTKSD  JOB (ACCT#),'AYMERICF',CLASS=A,MSGCLASS=H,MSGLEVEL=(1,1),
//             NOTIFY=&SYSUID,REGION=4M,TIME=(,30),COND=(8,LT)
//* SUPPRIMER LE FICHIER API1.PROJET.NEWPARTS.KSDS             *
//****************************************************************
//SUPPKSDS EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
 DELETE API1.PROJET.NEWPARTS.KSDS
/*
//* CREATION DU FICHIER API1.PROJET.NEWPARTS.KSDS             *
//****************************************************************
//CREKSDS  EXEC PGM=IDCAMS
//SYSPRINT DD SYSOUT=*
//SYSIN    DD *
  DEFINE CLUSTER (NAME(API1.PROJET.NEWPARTS.KSDS)   -
                    VOLUME(APIWK2)                  -
                    TRACKS(3 2)                     -
                    FREESPACE(20 20)                -
                    KEYS(2 0)                       -
                    RECORDSIZE(80 80)               -
                    INDEXED)                        -
           DATA (NAME(API1.PROJET.NEWPARTS.KSDS.D)) -
          INDEX (NAME(API1.PROJET.NEWPARTS.KSDS.I))
/*
