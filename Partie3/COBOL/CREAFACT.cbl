       IDENTIFICATION DIVISION.
       PROGRAM-ID     CREAFACT.
      **********************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT EXT ASSIGN TO EXTRACT
            ORGANIZATION IS SEQUENTIAL.
      **********************************************
       DATA DIVISION.
       FILE SECTION.
       FD EXT.
       COPY FEXTRACT.

       WORKING-STORAGE SECTION.
       77 WS-ANO     PIC 99 VALUE ZERO.
       77 FF-EXT     PIC 9  VALUE ZERO.

       PROCEDURE DIVISION.

            PERFORM OPEN-FILE-EXT
            PERFORM READ-FILE-EXT
            PERFORM UNTIL FF-EXT = 1
                IF TYPE-ENR = 'ORD' THEN
                   PERFORM DISPLAY-ORDER
                ELSE
                   PERFORM DISPLAY-PRODUCT
                END-IF
                PERFORM READ-FILE-EXT
            END-PERFORM
            PERFORM CLOSE-FILE-EXT
            GOBACK.

       OPEN-FILE-EXT.
           OPEN INPUT EXT.

       CLOSE-FILE-EXT.
           CLOSE EXT.

       READ-FILE-EXT.
           READ EXT AT END
               DISPLAY 'FIN DU FICHIER EXTRACT '
               MOVE 1 TO FF-EXT
           END-READ.

       DISPLAY-ORDER.
           DISPLAY 'ORD-O-NO, ' EORD-O-NO
           DISPLAY 'ORD-O-DATE, ' EORD-O-DATE
           DISPLAY 'EMP-E-NO, ' EEMP-E-NO
           DISPLAY 'EMP-FNAME, ' EEMP-FNAME
           DISPLAY 'EMP-LNAME, ' EEMP-LNAME
           DISPLAY 'CUS-C-NO, ' ECUS-C-NO
           DISPLAY 'CUS-COMPANY, ' ECUS-COMPANY
           DISPLAY 'CUS-ADDRESS, ' ECUS-ADDRESS
           DISPLAY 'CUS-CITY, ' ECUS-CITY
           DISPLAY 'CUS-ZIP, ' ECUS-ZIP
           DISPLAY 'CUS-STATE, ' ECUS-STATE
           DISPLAY 'DEP-DNAME, ' EDEP-DNAME
           DISPLAY 'DEP-DEPT, ' EDEP-DEPT
           DISPLAY '****************************'.

       DISPLAY-PRODUCT.
           DISPLAY 'ITE-P-NO, ' EPRO-P-NO
           DISPLAY 'ITE-QUANTITY, ' EITE-QUANTITY
           DISPLAY 'PRO-DESCRIPTION' EPRO-DESCRIPTION
           DISPLAY 'ITE-PRICE, ' EITE-PRICE
           DISPLAY 'PRO-PRICE, ' EPRO-PRICE
           DISPLAY '********************************'.
