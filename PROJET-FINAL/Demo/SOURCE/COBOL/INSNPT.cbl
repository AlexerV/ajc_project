       IDENTIFICATION DIVISION.
       PROGRAM-ID     INSNPT.
      **********************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT NPT ASSIGN TO FNPT
            ORGANIZATION IS INDEXED
            ACCESS MODE IS DYNAMIC
            RECORD KEY IS PNO-NPT
            FILE STATUS IS FS-NPT.
      **********************************************
       DATA DIVISION.
       FILE SECTION.
       FD NPT.
       COPY NEWPARTS.
       WORKING-STORAGE SECTION.
             EXEC SQL
                  INCLUDE SQLCA
             END-EXEC

             EXEC SQL
                  INCLUDE PAR
             END-EXEC

       01 ED-SQLCODE PIC +Z(8)9.

       01 TRIM-OUTPUT.
          05 OUTPUT-LEN  PIC 9(3).
          05 OUTPUT-TEXT PIC X(100).
       01 TRIM-INPUT.
          05 INPUT-LEN   PIC 9(3).
          05 INPUT-TEXT  PIC X(100).

       77 FS-NPT      PIC 99     VALUE ZERO.
       77 WS-NB-NPT   PIC 99     VALUE ZERO.
       77 WS-ANO      PIC 9.
       77 WS-MSG      PIC X(20)  VALUE 'DEFAULT'.


      ***************************************
      * PROGRAMME PRINCIPAL                 *
      ***************************************
       PROCEDURE DIVISION.
            OPEN INPUT NPT.
            PERFORM BALAYAGE-FICHIER.
            CLOSE NPT.
            GOBACK.

       BALAYAGE-FICHIER.
            READ NPT NEXT
            PERFORM UNTIL FS-NPT NOT EQUAL ZERO
                DISPLAY 'PNO: ' PNO-NPT
                DISPLAY 'PNAME: ' PNAME-NPT
                DISPLAY 'COLOR: ' COLOR-NPT
                DISPLAY 'WEIGHT: ' WEIGHT-NPT
                DISPLAY 'CITY: ' CITY-NPT
                PERFORM INSERTION-SQL
                READ NPT NEXT
            END-PERFORM.

       INSERTION-SQL.
            MOVE PNO-NPT     TO PAR-PNO

            MOVE 30          TO INPUT-LEN
            MOVE PNAME-NPT   TO INPUT-TEXT
            CALL 'TRIM' USING TRIM-INPUT TRIM-OUTPUT
            MOVE OUTPUT-TEXT TO PAR-PNAME-TEXT
            MOVE OUTPUT-LEN  TO PAR-PNAME-LEN

            MOVE 20          TO INPUT-LEN
            MOVE COLOR-NPT   TO INPUT-TEXT
            CALL 'TRIM' USING TRIM-INPUT TRIM-OUTPUT
            MOVE OUTPUT-TEXT TO PAR-COLOR-TEXT
            MOVE OUTPUT-LEN  TO PAR-COLOR-LEN

            MOVE WEIGHT-NPT  TO PAR-WEIGHT

            MOVE 20          TO INPUT-LEN
            MOVE CITY-NPT    TO INPUT-TEXT
            CALL 'TRIM' USING TRIM-INPUT TRIM-OUTPUT
            MOVE OUTPUT-TEXT TO PAR-CITY-TEXT
            MOVE OUTPUT-LEN  TO PAR-CITY-LEN

            EXEC SQL
                 INSERT INTO
                 API1.PARTS(PNO, PNAME, COLOR, WEIGHT, CITY)
                 VALUES (:PAR-PNO, :PAR-PNAME, :PAR-COLOR, :PAR-WEIGHT
                   , :PAR-CITY)
            END-EXEC
            PERFORM TEST-SQLCODE.

       TEST-SQLCODE.
           EVALUATE TRUE
                WHEN SQLCODE = ZERO
                   CONTINUE
                WHEN SQLCODE = -803
                   DISPLAY
                     'ERREUR INSERT : DOUBLON SUR CODE '
                WHEN SQLCODE > ZERO
                   IF SQLCODE = +100
                     DISPLAY  'CODE XX INTROUVABLE POUR OPERATION '
                   END-IF
                   MOVE SQLCODE TO ED-SQLCODE
                   DISPLAY 'WARNING : ' ED-SQLCODE
                WHEN OTHER
                   DISPLAY 'MSG -> ' WS-MSG
                   MOVE SQLCODE TO ED-SQLCODE
                   DISPLAY 'ANOMALIE ' ED-SQLCODE
                   PERFORM ABEND-PROG
           END-EVALUATE.

        ABEND-PROG.
           EXEC SQL ROLLBACK END-EXEC
           DISPLAY 'ROLLING BACK TO PREV TABLE STATE'
           COMPUTE WS-ANO = 1 / WS-ANO.
