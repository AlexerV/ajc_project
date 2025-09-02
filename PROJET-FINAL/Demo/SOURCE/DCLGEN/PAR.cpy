      ******************************************************************
      * DCLGEN TABLE(API1.PARTS)                                       *
      *        LIBRARY(API1.SOURCE.DCLGEN(PAR))                        *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(PAR-)                                             *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE API1.PARTS TABLE
           ( PNO                            CHAR(2) NOT NULL,
             PNAME                          VARCHAR(30) NOT NULL,
             COLOR                          VARCHAR(20),
             WEIGHT                         DECIMAL(2, 0),
             CITY                           VARCHAR(20)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE API1.PARTS                         *
      ******************************************************************
       01  DCLPARTS.
      *    *************************************************************
      *                       PNO
           10 PAR-PNO              PIC X(2).
      *    *************************************************************
           10 PAR-PNAME.
      *                       PNAME LENGTH
              49 PAR-PNAME-LEN     PIC S9(4) USAGE COMP.
      *                       PNAME
              49 PAR-PNAME-TEXT    PIC X(30).
      *    *************************************************************
           10 PAR-COLOR.
      *                       COLOR LENGTH
              49 PAR-COLOR-LEN     PIC S9(4) USAGE COMP.
      *                       COLOR
              49 PAR-COLOR-TEXT    PIC X(20).
      *    *************************************************************
      *                       WEIGHT
           10 PAR-WEIGHT           PIC S9(2)V USAGE COMP-3.
      *    *************************************************************
           10 PAR-CITY.
      *                       CITY LENGTH
              49 PAR-CITY-LEN      PIC S9(4) USAGE COMP.
      *                       CITY
              49 PAR-CITY-TEXT     PIC X(20).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 5       *
      ******************************************************************
