      ***************************************************************
      *  DESCRIPTION DU FICHIER PROJET.EXTRACT.DATA                 *
      ***************************************************************
       01 ENR.
          05 ENR-GENERIC.
             10 TYPE-ENR           PIC X(3).
             10 FILLER             PIC X(267).

          05 ENR-ORDER REDEFINES ENR-GENERIC.
             10 TYPE-ORD           PIC X(3).
             10 EORD-O-NO          PIC S9(3)V USAGE COMP-3.
             10 EORD-O-DATE        PIC X(10).
             10 EEMP-E-NO          PIC S9(2)V USAGE COMP-3.
             10 EEMP-LNAME         PIC X(20).
             10 EEMP-LNAME-LEN     PIC S9(4)  USAGE COMP-3.
             10 EEMP-FNAME         PIC X(20).
             10 EEMP-FNAME-LEN     PIC S9(4)  USAGE COMP-3.
             10 EEMP-COM           PIC SV9(2) USAGE COMP-3.
             10 ECUS-C-NO          PIC X(4).
             10 ECUS-COMPANY       PIC X(30).
             10 ECUS-COMPANY-LEN   PIC S9(4)  USAGE COMP-3.
             10 ECUS-ADDRESS       PIC X(100).
             10 ECUS-ADDRESS-LEN   PIC S9(4)  USAGE COMP-3.
             10 ECUS-CITY          PIC X(20).
             10 ECUS-CITY-LEN      PIC S9(4)  USAGE COMP-3.
             10 ECUS-ZIP           PIC X(5).
             10 ECUS-STATE         PIC X(2).
             10 EDEP-DEPT          PIC S9(4)V USAGE COMP-3.
             10 EDEP-DNAME         PIC X(20).
             10 EDEP-DNAME-LEN     PIC S9(4)  USAGE COMP-3.
             10 FILLER             PIC X(9).

          05 ENR-PRODUCT REDEFINES ENR-GENERIC.
             10 TYPE-PRO             PIC X(3).
             10 EPRO-P-NO            PIC X(3).
             10 EPRO-PRICE           PIC S9(3)V9(2) USAGE COMP-3.
             10 EPRO-DESCRIPTION     PIC X(30).
             10 EPRO-DESCRIPTION-LEN PIC S9(4)    USAGE COMP-3.
             10 EITE-QUANTITY        PIC S9(2)V     USAGE COMP-3.
             10 EITE-PRICE           PIC S9(3)V9(2) USAGE COMP-3.
             10 FILLER               PIC X(223).
