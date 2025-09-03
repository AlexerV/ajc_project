       IDENTIFICATION DIVISION.
       PROGRAM-ID     DATETEXT.
      **********************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
      **********************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-DATE.
          05 WS-DATE-YYYY   PIC 9(4).
          05 WS-DATE-MM     PIC 9(2).
          05 WS-DATE-DD     PIC 9(2).

       01 WS-JOUR-SEMAINE   PIC 9.

       01 WS-TEXTE-MOIS     PIC X(10).
       01 WS-TEXTE-JOUR     PIC X(9).

       01 WS-DEF-MOIS.
          05 FILLER PIC X(10) VALUE 'January  '.
          05 FILLER PIC X(10) VALUE 'February '.
          05 FILLER PIC X(10) VALUE 'March    '.
          05 FILLER PIC X(10) VALUE 'April    '.
          05 FILLER PIC X(10) VALUE 'May      '.
          05 FILLER PIC X(10) VALUE 'June     '.
          05 FILLER PIC X(10) VALUE 'July     '.
          05 FILLER PIC X(10) VALUE 'August   '.
          05 FILLER PIC X(10) VALUE 'September'.
          05 FILLER PIC X(10) VALUE 'October  '.
          05 FILLER PIC X(10) VALUE 'November '.
          05 FILLER PIC X(10) VALUE 'December '.
       01 WS-TAB-MOIS REDEFINES WS-DEF-MOIS.
          05 LIB-MOIS OCCURS 12 TIMES PIC X(10).

       01 WS-DEF-JOUR.
          05 FILLER PIC X(9) VALUE 'Monday   '.
          05 FILLER PIC X(9) VALUE 'Tuesday  '.
          05 FILLER PIC X(9) VALUE 'Wednesday'.
          05 FILLER PIC X(9) VALUE 'Thursday '.
          05 FILLER PIC X(9) VALUE 'Friday   '.
          05 FILLER PIC X(9) VALUE 'Saturday '.
          05 FILLER PIC X(9) VALUE 'Sunday   '.
       01 WS-TAB-JOUR REDEFINES WS-DEF-JOUR.
          05 LIB-JOUR OCCURS 7 TIMES PIC X(9).

       01 TEXTE-DATE.
          05 TEXTE-JOUR     PIC X(9).
          05 FILLER         PIC X(2) VALUE ', '.
          05 TEXTE-MOIS     PIC X(10).
          05 FILLER         PIC X VALUE ' '.
          05 TEXTE-JOUR-INT PIC 9(2).
          05 FILLER         PIC X(2) VALUE ', '.
          05 TEXTE-ANNEE    PIC 9(4).

       LINKAGE SECTION.
       01 RESULT PIC X(30).

       PROCEDURE DIVISION USING RESULT.

            ACCEPT WS-DATE         FROM DATE YYYYMMDD
            ACCEPT WS-JOUR-SEMAINE FROM DAY-OF-WEEK

            MOVE LIB-MOIS(WS-DATE-MM)      TO TEXTE-MOIS.
            MOVE LIB-JOUR(WS-JOUR-SEMAINE) TO TEXTE-JOUR.

            STRING
                TEXTE-JOUR    DELIMITED BY SPACES
                ', '          DELIMITED BY SIZE
                TEXTE-MOIS    DELIMITED BY SPACES
                ' '           DELIMITED BY SIZE
                WS-DATE-DD    DELIMITED BY SPACES
                ', '          DELIMITED BY SIZE
                WS-DATE-YYYY  DELIMITED BY SIZE
            INTO RESULT
            GOBACK.
