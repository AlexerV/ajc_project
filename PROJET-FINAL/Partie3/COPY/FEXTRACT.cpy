      ***************************************************************
      *  DESCRIPTION DU FICHIER PROJET.EXTRACT.DATA                 *
      ***************************************************************
000721 01 ENR.
000722    05 ENR-GENERIC.
000724       10 TYPE-ENR           PIC X(3).
000725       10 FILLER             PIC X(247).
000726
000730    05 ENR-ORDER REDEFINES ENR-GENERIC.
000732       10 TYPE-ORD           PIC X(3).
000733       10 EORD-O-NO          PIC S9(3)V     USAGE COMP-3.
000734       10 EORD-O-DATE        PIC X(10).
000735       10 EEMP-E-NO          PIC S9(2)V     USAGE COMP-3.
000737       10 EEMP-LNAME         PIC X(20).
000738       10 EEMP-FNAME         PIC X(20).
000739       10 ECUS-C-NO          PIC X(3).
000740       10 ECUS-COMPANY       PIC X(30).
000741       10 ECUS-ADDRESS       PIC X(100).
000742       10 ECUS-CITY          PIC X(20).
000743       10 ECUS-ZIP           PIC X(5).
000744       10 ECUS-STATE         PIC X(2).
000745       10 EDEP-DEPT          PIC S9(4)V     USAGE COMP-3.
000746       10 EDEP-DNAME         PIC X(20).
000746       10 FILLER             PIC X(10).
000748
000749    05 ENR-PRODUCT REDEFINES ENR-GENERIC.
000750       10 TYPE-PRO           PIC X(3).
000751       10 EPRO-P-NO          PIC X(3).
000760       10 EPRO-PRICE         PIC S9(3)V9(2) USAGE COMP-3.
000770       10 EPRO-DESCRIPTION   PIC X(30).
000780       10 EITE-QUANTITY      PIC S9(2)V     USAGE COMP-3.
000790       10 EITE-PRICE         PIC S9(3)V9(2) USAGE COMP-3.
000791       10 FILLER             PIC X(206).
