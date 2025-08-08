       IDENTIFICATION DIVISION.
       PROGRAM-ID     EXTRACTP.
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

           EXEC SQL
               INCLUDE SQLCA
           END-EXEC

           EXEC SQL
               INCLUDE CUS
           END-EXEC

           EXEC SQL
               INCLUDE DEP
           END-EXEC

           EXEC SQL
               INCLUDE EMP
           END-EXEC

           EXEC SQL
               INCLUDE ITE
           END-EXEC

           EXEC SQL
               INCLUDE ORD
           END-EXEC

           EXEC SQL
               INCLUDE PRO
           END-EXEC

      *** DECLARATION DU CURSEUR ORDER ***
           EXEC SQL
                DECLARE CORDER CURSOR
                FOR
                SELECT O.O_NO, O.O_DATE, E.E_NO, E.DEPT, E.LNAME,
                    E.FNAME, C.C_NO, C.COMPANY, C.ADDRESS,
                    C.CITY, C.ZIP, C.STATE, D.DNAME
                FROM ORDERS O
                INNER JOIN EMPLOYEES E
                ON E.E_NO = O.S_NO
                INNER JOIN CUSTOMERS C
                ON C.C_NO = O.C_NO
                INNER JOIN DEPTS D
                ON D.DEPT = E.DEPT
                ORDER BY O.O_NO
           END-EXEC

      *** DECLARATION DU CURSEUR PRODUCTS ***
           EXEC SQL
                DECLARE CPROD CURSOR
                FOR
                SELECT O_NO, P.P_NO, QUANTITY, DESCRIPTION, I.PRICE
                 , P.PRICE
                FROM ITEMS I
                INNER JOIN PRODUCTS P
                ON I.P_NO = P.P_NO
                WHERE O_NO = :ORD-O-NO
                ORDER BY O_NO
           END-EXEC

       77 WS-ANO     PIC 99 VALUE ZERO.

       PROCEDURE DIVISION.

            PERFORM OPEN-ORDER
            PERFORM OPEN-FILE-EXT
            PERFORM FETCH-ORDER
            PERFORM UNTIL SQLCODE = +100
                PERFORM DISPLAY-ORDER
                PERFORM WRITE-ORDER
                PERFORM OPEN-PRODUCT
                PERFORM FETCH-PRODUCT
                PERFORM UNTIL SQLCODE = +100
                    PERFORM DISPLAY-PRODUCT
                    PERFORM WRITE-PRODUCT
                    PERFORM FETCH-PRODUCT
                END-PERFORM
                PERFORM CLOSE-PRODUCT
                PERFORM FETCH-ORDER
            END-PERFORM

            PERFORM CLOSE-ORDER
            PERFORM CLOSE-FILE-EXT
            GOBACK.

       OPEN-ORDER.
           EXEC SQL
             OPEN CORDER
           END-EXEC
           PERFORM TEST-SQLCODE.

       OPEN-PRODUCT.
           EXEC SQL
             OPEN CPROD
           END-EXEC
           PERFORM TEST-SQLCODE.

       OPEN-FILE-EXT.
           OPEN OUTPUT EXT.

       CLOSE-FILE-EXT.
           CLOSE EXT.

       CLOSE-ORDER.
           EXEC SQL
             CLOSE CORDER
           END-EXEC
           PERFORM TEST-SQLCODE.

       CLOSE-PRODUCT.
           EXEC SQL
             CLOSE CPROD
           END-EXEC
           PERFORM TEST-SQLCODE.

       DISPLAY-ORDER.
           DISPLAY 'ORD-O-NO, ' ORD-O-NO
           DISPLAY 'ORD-O-DATE, ' ORD-O-DATE
           DISPLAY 'EMP-E-NO, ' EMP-E-NO
           DISPLAY 'EMP-FNAME, ' EMP-FNAME
           DISPLAY 'EMP-LNAME, ' EMP-LNAME
           DISPLAY 'CUS-C-NO, ' CUS-C-NO
           DISPLAY 'CUS-COMPANY, ' CUS-COMPANY
           DISPLAY 'CUS-ADDRESS, ' CUS-ADDRESS
           DISPLAY 'CUS-CITY, ' CUS-CITY
           DISPLAY 'CUS-ZIP, ' CUS-ZIP
           DISPLAY 'CUS-STATE, ' CUS-STATE
           DISPLAY 'DEP-DNAME, ' DEP-DNAME
           DISPLAY 'DEP-DEPT, ' DEP-DEPT
           DISPLAY '****************************'.

       WRITE-ORDER.
           MOVE SPACES TO ENR
           MOVE 'ORD'       TO TYPE-ORD
           MOVE ORD-O-NO    TO EORD-O-NO
           MOVE ORD-O-DATE  TO EORD-O-DATE
           MOVE EMP-E-NO    TO EEMP-E-NO
           MOVE EMP-FNAME   TO EEMP-FNAME
           MOVE EMP-LNAME   TO EEMP-LNAME
           MOVE CUS-C-NO    TO ECUS-C-NO
           MOVE CUS-COMPANY TO ECUS-COMPANY
           MOVE CUS-ADDRESS TO ECUS-ADDRESS
           MOVE CUS-CITY    TO ECUS-CITY
           MOVE CUS-ZIP     TO ECUS-ZIP
           MOVE CUS-STATE   TO ECUS-STATE
           MOVE DEP-DEPT    TO EDEP-DEPT
           MOVE DEP-DNAME   TO EDEP-DNAME
           WRITE ENR.

       FETCH-ORDER.
           EXEC SQL
             FETCH CORDER
             INTO :ORD-O-NO, :ORD-O-DATE, :EMP-E-NO, :DEP-DEPT
               , :EMP-LNAME, :EMP-FNAME, :CUS-C-NO, :CUS-COMPANY
               , :CUS-ADDRESS, :CUS-CITY, :CUS-ZIP, :CUS-STATE
               , :DEP-DNAME
           END-EXEC
           PERFORM TEST-SQLCODE.

       DISPLAY-PRODUCT.
           DISPLAY 'ITE-O-NO, ' ITE-O-NO
           DISPLAY 'ITE-P-NO, ' ITE-P-NO
           DISPLAY 'ITE-QUANTITY, ' ITE-QUANTITY
           DISPLAY 'PRO-DESCRIPTION' PRO-DESCRIPTION
           DISPLAY 'ITE-PRICE, ' ITE-PRICE
           DISPLAY '********************************'.

       WRITE-PRODUCT.
           MOVE SPACES TO ENR
           MOVE 'PRO'           TO TYPE-PRO
           MOVE PRO-P-NO        TO EPRO-P-NO
           MOVE PRO-DESCRIPTION TO EPRO-DESCRIPTION
           MOVE PRO-PRICE       TO EPRO-PRICE
           MOVE ITE-QUANTITY    TO EITE-QUANTITY
           MOVE ITE-PRICE       TO EITE-PRICE
           WRITE ENR.

       FETCH-PRODUCT.
           EXEC SQL
             FETCH CPROD
             INTO :ITE-O-NO, :PRO-P-NO, :ITE-QUANTITY
               , :PRO-DESCRIPTION, :ITE-PRICE, :PRO-PRICE
           END-EXEC
           PERFORM TEST-SQLCODE.

       TEST-SQLCODE.
           EVALUATE TRUE
              WHEN SQLCODE = ZERO
                    CONTINUE
              WHEN SQLCODE > 0
                   IF SQLCODE = +100
                       DISPLAY "JEU DE DONNEES VIDE OU FINI"
                   ELSE
                       DISPLAY "WARNING : ", SQLCODE
                   END-IF
              WHEN SQLCODE < ZERO
                   PERFORM ABEND-PROG
           END-EVALUATE.

       ABEND-PROG.
           DISPLAY "ANOMALIE GRAVE : ", SQLCODE
           COMPUTE WS-ANO = 1 / WS-ANO.
