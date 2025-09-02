      ******************************************************************
      * DCLGEN TABLE(API1.CUSTOMERS)                                   *
      *        LIBRARY(API1.SOURCE.COPY(CUS))                          *
      *        ACTION(REPLACE)                                         *
      *        LANGUAGE(COBOL)                                         *
      *        NAMES(CUS-)                                             *
      *        QUOTE                                                   *
      *        LABEL(YES)                                              *
      *        COLSUFFIX(YES)                                          *
      * ... IS THE DCLGEN COMMAND THAT MADE THE FOLLOWING STATEMENTS   *
      ******************************************************************
           EXEC SQL DECLARE API1.CUSTOMERS TABLE
           ( C_NO                           DECIMAL(4, 0) NOT NULL,
             COMPANY                        VARCHAR(30) NOT NULL,
             ADDRESS                        VARCHAR(100),
             CITY                           VARCHAR(20) NOT NULL,
             STATE                          CHAR(2) NOT NULL,
             ZIP                            CHAR(5) NOT NULL,
             PHONE                          CHAR(10),
             BALANCE                        DECIMAL(10, 2)
           ) END-EXEC.
      ******************************************************************
      * COBOL DECLARATION FOR TABLE API1.CUSTOMERS                     *
      ******************************************************************
       01  DCLCUSTOMERS.
      *    *************************************************************
      *                       C_NO
           10 CUS-C-NO             PIC S9(4)V USAGE COMP-3.
      *    *************************************************************
           10 CUS-COMPANY.
      *                       COMPANY LENGTH
              49 CUS-COMPANY-LEN   PIC S9(4) USAGE COMP.
      *                       COMPANY
              49 CUS-COMPANY-TEXT  PIC X(30).
      *    *************************************************************
           10 CUS-ADDRESS.
      *                       ADDRESS LENGTH
              49 CUS-ADDRESS-LEN   PIC S9(4) USAGE COMP.
      *                       ADDRESS
              49 CUS-ADDRESS-TEXT  PIC X(100).
      *    *************************************************************
           10 CUS-CITY.
      *                       CITY LENGTH
              49 CUS-CITY-LEN      PIC S9(4) USAGE COMP.
      *                       CITY
              49 CUS-CITY-TEXT     PIC X(20).
      *    *************************************************************
      *                       STATE
           10 CUS-STATE            PIC X(2).
      *    *************************************************************
      *                       ZIP
           10 CUS-ZIP              PIC X(5).
      *    *************************************************************
      *                       PHONE
           10 CUS-PHONE            PIC X(10).
      *    *************************************************************
      *                       BALANCE
           10 CUS-BALANCE          PIC S9(8)V9(2) USAGE COMP-3.
      ******************************************************************
      * THE NUMBER OF COLUMNS DESCRIBED BY THIS DECLARATION IS 8       *
      ******************************************************************
