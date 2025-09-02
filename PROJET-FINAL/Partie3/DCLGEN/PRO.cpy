      ******************************************************************
      * DCLGEN TABLE(API1.PRODUCTS)                                    *
      *        LIBRARY(API1.SOURCE.COPY(PRO))                          *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(PRO-)                                             *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE API1.PRODUCTS TABLE
           ( P_NO                           CHAR(3) NOT NULL,
             DESCRIPTION                    VARCHAR(30) NOT NULL,
             PRICE                          DECIMAL(5, 2) NOT NULL
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE API1.PRODUCTS                      *
      ******************************************************************
       01  DCLPRODUCTS.
      *    *************************************************************
      *                       P_NO
           10 PRO-P-NO             PIC X(3).
      *    *************************************************************
           10 PRO-DESCRIPTION.
      *                       DESCRIPTION LENGTH
              49 PRO-DESCRIPTION-LEN  PIC S9(4) USAGE COMP.
      *                       DESCRIPTION
              49 PRO-DESCRIPTION-TEXT  PIC X(30).
      *    *************************************************************
      *                       PRICE
           10 PRO-PRICE            PIC S9(3)V9(2) USAGE COMP-3.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 3       *
      ******************************************************************
