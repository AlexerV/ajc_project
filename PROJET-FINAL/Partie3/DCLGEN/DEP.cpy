      ******************************************************************
      * DCLGEN TABLE(API1.DEPTS)                                       *
      *        LIBRARY(API1.SOURCE.COPY(DEP))                          *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(DEP-)                                             *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE API1.DEPTS TABLE
           ( DEPT                           DECIMAL(4, 0) NOT NULL,
             DNAME                          VARCHAR(20) NOT NULL
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE API1.DEPTS                         *
      ******************************************************************
       01  DCLDEPTS.
      *    *************************************************************
      *                       DEPT
           10 DEP-DEPT             PIC S9(4)V USAGE COMP-3.
      *    *************************************************************
           10 DEP-DNAME.
      *                       DNAME LENGTH
              49 DEP-DNAME-LEN     PIC S9(4) USAGE COMP.
      *                       DNAME
              49 DEP-DNAME-TEXT    PIC X(20).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 2       *
      ******************************************************************
