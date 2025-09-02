      ******************************************************************
      * DCLGEN TABLE(API1.ORDERS)                                      *
      *        LIBRARY(API1.SOURCE.COPY(ORD))                          *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(ORD-)                                             *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE API1.ORDERS TABLE
           ( O_NO                           DECIMAL(3, 0) NOT NULL,
             S_NO                           DECIMAL(2, 0) NOT NULL,
             C_NO                           DECIMAL(4, 0) NOT NULL,
             O_DATE                         DATE NOT NULL
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE API1.ORDERS                        *
      ******************************************************************
       01  DCLORDERS.
      *    *************************************************************
      *                       O_NO
           10 ORD-O-NO             PIC S9(3)V USAGE COMP-3.
      *    *************************************************************
      *                       S_NO
           10 ORD-S-NO             PIC S9(2)V USAGE COMP-3.
      *    *************************************************************
      *                       C_NO
           10 ORD-C-NO             PIC S9(4)V USAGE COMP-3.
      *    *************************************************************
      *                       O_DATE
           10 ORD-O-DATE           PIC X(10).
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 4       *
      ******************************************************************
