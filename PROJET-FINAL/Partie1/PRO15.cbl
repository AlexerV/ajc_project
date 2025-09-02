       IDENTIFICATION DIVISION.
       PROGRAM-ID.    PRO15.
      ****************************************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
            DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT PRODUCT ASSIGN TO LPRODUCT
                   ORGANIZATION IS SEQUENTIAL
                   FILE STATUS  IS FS-PRODUCT.

       DATA DIVISION.
       FILE SECTION.

       FD  PRODUCT.
       01  PRODUCT-REC          PIC X(45).

       WORKING-STORAGE SECTION.

      *--------------------------------------------------------------
      *  FILE STATUS
      *--------------------------------------------------------------
       77  FS-PRODUCT           PIC XX.

      *--------------------------------------------------------------
      *  FLAGS FIN DE FICHIER
      *--------------------------------------------------------------
       77  WS-FLAG-PRODUCT      PIC 9  VALUE 0.
           88 FF-PRODUCT               VALUE 1.
           88 NFF-PRODUCT              VALUE 0.

      *--------------------------------------------------------------
      *  VARIABLES UTILITAIRES CSV
      *--------------------------------------------------------------
       01  W-INTEGER-PART       PIC X(10).
       01  W-DECIMAL-PART       PIC X(05).
       77  W-TEMP-INT           PIC 9(5) VALUE 0.
       77  W-TEMP-DEC           PIC 99   VALUE 0.
       77  PRO-PRICE-NUM        PIC 9(3)V99 VALUE 0.
       77  WS-PRICE-TXT         PIC X(15) VALUE SPACES.
       77  PRO-PRICE-FMT        PIC ZZZ9,99.
       77  W-CURRENCY-CODE      PIC XX    VALUE SPACES.
       77  WS-LINE              PIC X(80).
      *--------------------------------------------------------------
      *  VARIABLES DE POSITION / INDEX
      *--------------------------------------------------------------
       01  W-IDX                PIC 9(4) COMP VALUE 0.
       01  W-DELIM              PIC X VALUE ';'.

      *--------------------------------------------------------------
      *  VARIABLES SYSIN
      *--------------------------------------------------------------
       77  WS-SYSIN             PIC X(5) VALUE SPACES.

      *--------------------------------------------------------------
      *  TAUX DE CONVERSION
      *--------------------------------------------------------------
       01  WS-RATES.
           05 RATE-ENTRY OCCURS 50 TIMES.
               10 RATE-CURRENCY   PIC XX.
               10 RATE-FACTOR     PIC 9V99.
       77  WS-RATE-COUNT          PIC 9(2) VALUE 0.
       77  WS-RATE-TXT            PIC X(5) VALUE SPACES.
       77  W-TEMP-NUM             PIC 9(5) VALUE 0.
       77  WS-FOUND               PIC 9 VALUE 0.

      ****************************************************************
      * DB2 HOST VARIABLES (DCLGEN)
      ****************************************************************
            EXEC SQL
                 INCLUDE SQLCA
            END-EXEC.

            EXEC SQL
                 INCLUDE PRO
            END-EXEC.

      ****************************************************************
      *  PROCEDURE DIVISION
      ****************************************************************
       PROCEDURE DIVISION.

      *--------------------------------------------------------------
      *  LECTURE DES TAUX DE CONVERSION EN SYSIN
      *--------------------------------------------------------------
           ACCEPT WS-SYSIN FROM SYSIN
           PERFORM UNTIL WS-SYSIN = '00000'
               ADD 1 TO WS-RATE-COUNT
               MOVE WS-SYSIN TO RATE-ENTRY(WS-RATE-COUNT)


               ACCEPT WS-SYSIN FROM SYSIN
           END-PERFORM.

      *--------------------------------------------------------------
      *  OUVERTURE DU CSV
      *--------------------------------------------------------------
           OPEN INPUT PRODUCT
           IF FS-PRODUCT NOT = "00"
              DISPLAY 'ERR OPEN PRODUCT, FS=' FS-PRODUCT
              PERFORM ABEND-PROG
           END-IF

           DISPLAY '+---------------------------------------------+'
           DISPLAY '| P_NO  DESCRIPTION      PRICE      DEVISE    |'
           DISPLAY '+---------------------------------------------+'



      *--------------------------------------------------------------
      *  LECTURE ET TRAITEMENT DES LIGNES CSV
      *--------------------------------------------------------------
           PERFORM UNTIL FF-PRODUCT
              READ PRODUCT
                 AT END
                    SET FF-PRODUCT TO TRUE
                 NOT AT END
                    MOVE SPACES TO PRO-P-NO PRO-DESCRIPTION-TEXT
                    MOVE SPACES TO WS-PRICE-TXT W-CURRENCY-CODE
                    MOVE 0 TO WS-FOUND
                    UNSTRING PRODUCT-REC DELIMITED BY ';'
                        INTO PRO-P-NO
                             PRO-DESCRIPTION-TEXT
                             WS-PRICE-TXT
                             W-CURRENCY-CODE
                    END-UNSTRING

             MOVE FUNCTION LOWER-CASE(PRO-DESCRIPTION-TEXT)
                  TO PRO-DESCRIPTION-TEXT
             PERFORM VARYING W-IDX FROM 1 BY 1
                 UNTIL W-IDX > LENGTH OF PRO-DESCRIPTION-TEXT
                IF W-IDX = 1 OR PRO-DESCRIPTION-TEXT(W-IDX - 1:1) = ' '
                 MOVE FUNCTION UPPER-CASE(PRO-DESCRIPTION-TEXT(W-IDX:1)))
                       TO PRO-DESCRIPTION-TEXT(W-IDX:1)
                END-IF
             END-PERFORM
             INSPECT WS-PRICE-TXT REPLACING ALL '.' BY ','
             COMPUTE PRO-PRICE-NUM = FUNCTION NUMVAL-C(WS-PRICE-TXT)
      *--- APPLIQUER LE TAUX DE CONVERSION
           PERFORM VARYING W-IDX FROM 1 BY 1                            N
                        UNTIL W-IDX > WS-RATE-COUNT OR WS-FOUND = 1
            IF RATE-CURRENCY(W-IDX) = W-CURRENCY-CODE
              COMPUTE PRO-PRICE-NUM = PRO-PRICE-NUM * RATE-FACTOR(W-IDX)
              MOVE 1 TO WS-FOUND

            END-IF
           END-PERFORM
             MOVE 'DO' TO W-CURRENCY-CODE
             MOVE PRO-PRICE-NUM TO PRO-PRICE-FMT
             MOVE SPACES TO WS-LINE
             MOVE PRO-P-NO               TO WS-LINE(2:3)
             MOVE PRO-DESCRIPTION-TEXT(1:20) TO WS-LINE(6:20)
             MOVE PRO-PRICE-FMT          TO WS-LINE(27:6)
             MOVE W-CURRENCY-CODE           TO WS-LINE(35:2)
             DISPLAY '|' WS-LINE '|'







           DISPLAY '+---------------------------------------------+'

      *>--CALCUL DE LA LONGUEUR REELLE DESCRIPTION
             MOVE LENGTH OF PRO-DESCRIPTION-TEXT TO W-IDX
           PERFORM UNTIL W-IDX = 0 OR PRO-DESCRIPTION-TEXT(W-IDX:1)
                                   NOT = SPACE
                     SUBTRACT 1 FROM W-IDX
                 END-PERFORM
                    IF W-IDX = 0
                       MOVE 0 TO PRO-DESCRIPTION-LEN
                    ELSE
                       MOVE W-IDX TO PRO-DESCRIPTION-LEN
                    END-IF

                    MOVE PRO-PRICE-NUM TO PRO-PRICE

                    EXEC SQL
                       INSERT INTO PRODUCTS (P_NO, DESCRIPTION, PRICE)
                       VALUES (:PRO-P-NO,
                               :PRO-DESCRIPTION,
                               :PRO-PRICE)
                    END-EXEC
              END-READ
           END-PERFORM.

      *--------------------------------------------------------------
      *  FERMETURE
      *--------------------------------------------------------------
           CLOSE PRODUCT
           GOBACK.

      ****************************************************************
      *  ABEND-PROG
      ****************************************************************
       ABEND-PROG.
           DISPLAY '---- ABEND-PROG ----'
           GOBACK.
