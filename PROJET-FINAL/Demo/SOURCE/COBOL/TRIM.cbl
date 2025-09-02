       IDENTIFICATION DIVISION.
       PROGRAM-ID     TRIM.
      **********************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      **********************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-I       PIC 9(3) VALUE 1.
       01 WS-J       PIC 9(3) VALUE 1.
       01 WS-STOP    PIC 9    VALUE 0.

       LINKAGE SECTION.
       01 INPUT-STR.
          05 INPUT-LEN   PIC 9(3).
          05 INPUT-TEXT  PIC X(100).
       01 OUTPUT-STR.
          05 OUTPUT-LEN  PIC 9(3).
          05 OUTPUT-TEXT PIC X(100).

       PROCEDURE DIVISION USING INPUT-STR OUTPUT-STR.
            MOVE ZERO TO OUTPUT-LEN
            MOVE SPACES TO OUTPUT-TEXT
      *     Recherche du première caractère non espace
            PERFORM UNTIL WS-I > 100 OR WS-STOP > 0
               IF INPUT-TEXT(WS-I:1) NOT = SPACE
                  MOVE 1 TO WS-STOP
               ELSE
                  ADD 1 TO WS-I
               END-IF
            END-PERFORM

      *     Recherche du dernier caractère non espace
            MOVE ZERO TO WS-STOP
            MOVE INPUT-LEN TO WS-J
            PERFORM UNTIL WS-J < WS-I OR WS-STOP > 0
               IF INPUT-TEXT(WS-J:1) NOT = SPACE
                  DISPLAY INPUT-TEXT(WS-J:1)
                  MOVE 1 TO WS-STOP
               ELSE
                  COMPUTE WS-J = WS-J - 1
               END-IF
            END-PERFORM

      *     On extrait la sous-chaine
            IF WS-J >= WS-I
               COMPUTE OUTPUT-LEN = (WS-J - WS-I) + 1
               MOVE INPUT-TEXT(WS-I:OUTPUT-LEN) TO OUTPUT-TEXT
            ELSE
               MOVE ZERO TO OUTPUT-LEN
               MOVE SPACES TO OUTPUT-TEXT
            END-IF.
            GOBACK.
