       01 PAGE-HEADER.
          05 PH-LINE1.
             10 FILLER      PIC X     VALUE '+'.
             10 FILLER      PIC X(76) VALUE ALL '-'.
             10 FILLER      PIC X     VALUE '+'.
          05 PH-LINE2.
             10 FILLER      PIC X     VALUE '|'.
             10 FILLER      PIC X(45) VALUE ALL SPACES.
             10 FILLER      PIC X     VALUE '+'.
             10 FILLER      PIC X(28) VALUE ALL '-'.
             10 FILLER      PIC X     VALUE '+'.
             10 FILLER      PIC X(2)  VALUE ' |'.
          05 PH-LINE3.
             10 FILLER      PIC X     VALUE '|'.
             10 FILLER      PIC X(45) VALUE ALL SPACES.
             10 FILLER      PIC X(2)  VALUE '| '.
             10 P-COMPANY   PIC X(26).
             10 FILLER      PIC X(4)  VALUE ' | |'.
          05 PH-LINE4.
             10 FILLER      PIC X     VALUE '|'.
             10 FILLER      PIC X(45) VALUE ALL SPACES.
             10 FILLER      PIC X(2)  VALUE '| '.
             10 P-ADDRESS   PIC X(26).
             10 FILLER      PIC X(4)  VALUE ' | |'.
          05 PH-LINE5.
             10 FILLER      PIC X     VALUE '|'.
             10 FILLER      PIC X(45) VALUE ALL SPACES.
             10 FILLER      PIC X(2)  VALUE '| '.
             10 P-CITY-ZIP PIC X(26).
             10 FILLER      PIC X(4)  VALUE ' | |'.
          05 PH-LINE6.
             10 FILLER      PIC X     VALUE '|'.
             10 FILLER      PIC X(45) VALUE ALL SPACES.
             10 FILLER      PIC X(2)  VALUE '| '.
             10 P-STATE     PIC X(26).
             10 FILLER      PIC X(4)  VALUE ' | |'.
          05 PH-LINE7.
             10 FILLER      PIC X     VALUE '|'.
             10 FILLER      PIC X(45) VALUE ALL SPACES.
             10 FILLER      PIC X     VALUE '+'.
             10 FILLER      PIC X(28) VALUE ALL '-'.
             10 FILLER      PIC X     VALUE '+'.
             10 FILLER      PIC X(2)  VALUE ' |'.
       01 PAGE-HEADER-ARRY REDEFINES PAGE-HEADER.
          05 PH-LINES      OCCURS 7 TIMES PIC X(78).
       01 PAGE-ORDER.
          05 PO-LINE1.
             10 FILLER      PIC XX    VALUE '| '.
             10 P-DATE      PIC X(74).
             10 FILLER      PIC XX    VALUE ' |'.
          05 PO-LINE2.
             COPY TEMPLLNE.
          05 PO-LINE3.
             COPY TEMPLLNE.
          05 PO-LINE4.
             10 FILLER     PIC XX     VALUE '| '.
             10 P-O-NO     PIC X(74).
             10 FILLER     PIC XX     VALUE ' |'.
          05 PO-LINE5.
             10 FILLER     PIC XX     VALUE '| '.
             10 P-O-DATE   PIC X(74).
             10 FILLER     PIC XX     VALUE ' |'.
          05 PO-LINE6.
             COPY TEMPLLNE.
          05 PO-LINE7.
             COPY TEMPLLNE.
          05 PO-LINE8.
             10 FILLER     PIC XX     VALUE '| '.
             10 P-CONTACT  PIC X(74).
             10 FILLER     PIC XX     VALUE ' |'.
          05 PO-LINE9.
             COPY TEMPLLNE.
       01 PAGE-ORDER-ARRAY REDEFINES PAGE-ORDER.
          05 PO-LINES      OCCURS 9 TIMES PIC X(78).
       01 PAGE-PRODUCT.
          05 PP-LINE-HEADER.
             10 FILLER     PIC X(3)   VALUE '| +'.
             10 FILLER     PIC X(72)  VALUE ALL '-'.
             10 FILLER     PIC X(3)   VALUE '+ |'.
          05 PP-LINE-LIB.
             10 FILLER     PIC X(3)   VALUE '| |'.
             10 FILLER     PIC X(2)   VALUE 'NO'.
             10 FILLER     PIC X(4)   VALUE ALL SPACES.
             10 FILLER     PIC X(11)  VALUE 'DESCRIPTION'.
             10 FILLER     PIC X(25)  VALUE ALL SPACES.
             10 FILLER     PIC X(8)   VALUE 'QUANTITY'.
             10 FILLER     PIC X(4)   VALUE ALL SPACES.
             10 FILLER     PIC X(5)   VALUE 'PRICE'.
             10 FILLER     PIC X(2)   VALUE ALL SPACES.
             10 FILLER     PIC X(10)  VALUE 'LINE TOTAL'.
             10 FILLER     PIC X(4)   VALUE ' | |'.
          05 PP-PRODUCT.
             10 FILLER         PIC X(3)   VALUE '| |'.
             10 P-P-NO         PIC X(4).
             10 FILLER         PIC X(2)   VALUE ALL SPACES.
             10 P-DESCRIPTION  PIC X(35).
             10 FILLER         PIC X(7)   VALUE ALL SPACES.
             10 P-QUANTITY     PIC ZZ.
             10 FILLER         PIC X(2)   VALUE ALL SPACES.
             10 P-PRICE        PIC ZZZ,99.
             10 FILLER         PIC X      VALUE '$'.
             10 FILLER         PIC X(2)   VALUE ALL SPACES.
             10 P-LINE-TOTAL   PIC ZZZZZZ,99.
             10 FILLER         PIC X(2)   VALUE '$ '.
             10 FILLER         PIC X(3)   VALUE '| |'.
          05 PP-LINE-FOOTER.
             10 FILLER     PIC X(3)   VALUE '| +'.
             10 FILLER     PIC X(72)  VALUE ALL '-'.
             10 FILLER     PIC X(3)   VALUE '+ |'.
       01 PAGE-TOTAL.
          05 PT-LINE1.
             COPY TEMPLLNE.
          05 PT-LINE2.
             10 FILLER       PIC X       VALUE '|'.
             10 FILLER       PIC X(40)   VALUE ALL SPACES.
             10 FILLER       PIC X(11)   VALUE 'SUB TOTAL: '.
             10 FILLER       PIC X(10)   VALUE ALL SPACES.
             10 P-SUB-TOTAL  PIC Z(7)9,99.
             10 FILLER       PIC X       VALUE '$'.
             10 FILLER       PIC X(3)    VALUE ALL SPACES.
             10 FILLER       PIC X       VALUE '|'.
          05 PT-LINE3.
             COPY TEMPLLNE.
          05 PT-LINE4.
             10 FILLER       PIC X       VALUE '|'.
             10 FILLER       PIC X(40)   VALUE ALL SPACES.
             10 FILLER       PIC X(10)   VALUE 'SALES TAX '.
             10 P-ST-RATE    PIC X(8).
             10 FILLER       PIC X(3)    VALUE ' : '.
             10 P-ST-VALUE   PIC Z(7)9,99.
             10 FILLER       PIC X       VALUE '$'.
             10 FILLER       PIC X(3)    VALUE ALL SPACES.
             10 FILLER       PIC X       VALUE '|'.
          05 PT-LINE5.
             COPY TEMPLLNE.
          05 PT-LINE6.
             10 FILLER       PIC X       VALUE '|'.
             10 FILLER       PIC X(40)   VALUE ALL SPACES.
             10 FILLER       PIC X(11)   VALUE 'COMMISSION '.
             10 P-COM-RATE   PIC X(7).
             10 FILLER       PIC X(3)    VALUE ' : '.
             10 P-COM-VALUE  PIC Z(7)9,99.
             10 FILLER       PIC X       VALUE '$'.
             10 FILLER       PIC X(3)    VALUE ALL SPACES.
             10 FILLER       PIC X       VALUE '|'.
          05 PT-LINE7.
             COPY TEMPLLNE.
          05 PT-LINE8.
             10 FILLER       PIC X       VALUE '|'.
             10 FILLER       PIC X(40)   VALUE ALL SPACES.
             10 FILLER       PIC X(8)    VALUE 'TOTAL : '.
             10 FILLER       PIC X(12)   VALUE ALL SPACES.
             10 P-TOTAL      PIC Z(9),99.
             10 FILLER       PIC X       VALUE '$'.
             10 FILLER       PIC X(3)    VALUE ALL SPACES.
             10 FILLER       PIC X       VALUE '|'.
          05 PT-LINE9.
             COPY TEMPLLNE.
          05 PT-LINE10.
             10 FILLER       PIC X       VALUE '+'.
             10 FILLER       PIC X(76)   VALUE ALL '-'.
             10 FILLER       PIC X       VALUE '+'.
       01 PAGE-TOTAL-ARRAY  REDEFINES PAGE-TOTAL.
           05 PT-LINES       OCCURS 10 TIMES PIC X(78).
