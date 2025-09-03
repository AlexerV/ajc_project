       IDENTIFICATION DIVISION.
       PROGRAM-ID     CREAFACT.
      **********************************************
       ENVIRONMENT DIVISION.
       CONFIGURATION SECTION.
       SPECIAL-NAMES.
           DECIMAL-POINT IS COMMA.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.
            SELECT EXT ASSIGN TO EXTRACT
            ORGANIZATION IS SEQUENTIAL.
            SELECT FACT ASSIGN TO FFACT
            ORGANIZATION IS SEQUENTIAL
            FILE STATUS IS WS-FS.
      **********************************************
       DATA DIVISION.
       FILE SECTION.
       FD FACT.
       01 FACT-ENR     PIC X(78).
       FD EXT.
       COPY FEXTRACT.
       WORKING-STORAGE SECTION.
      ***************************************
      * PARAMETRES SYSIN                    *
      ***************************************
       01 WS-SYSIN.
          05 WS-ST-RATE    PIC 9V999.
      ***************************************
      * VARIABLE TRAITEMENT FICHIER         *
      ***************************************
       01 WS-FS            PIC XX.
       01 FF-EXT           PIC 9        VALUE ZERO.
      ***************************************
      * GESTION ERREUR                      *
      ***************************************
       01 WS-ANO           PIC 99.
      ***************************************
      * INDEX PARCOURS TABLEAU              *
      ***************************************
       01 WS-IDX           PIC 99       VALUE ZERO.
      ***************************************
      * VARIABLES CALCUL                    *
      ***************************************
       01 WS-EMP-COM       PIC V99      VALUE ZERO.
       01 WS-LINE-PRICE    PIC S9(9)V99 VALUE ZERO.
       01 WS-SUB-TOTAL     PIC S9(9)V99 VALUE ZERO.
       01 WS-ST-VALUE      PIC S9(9)V99 VALUE ZERO.
       01 WS-COM-VALUE     PIC S9(9)V99 VALUE ZERO.
       01 WS-TOTAL         PIC S9(9)V99 VALUE ZERO.

      ***************************************
      * VARIABLES AFFICHAGE                 *
      ***************************************
       01 WS-DATE          PIC X(30).
       01 E-ST-RATE        PIC 99,9.
       01 E-COM-RATE       PIC 9,9.
      ***************************************
      * LIBELLE DE NUMERO DE COMMANDE       *
      ***************************************
       01 L-ORDER-TEXT.
          05 FILLER        PIC X(8)    VALUE 'Order N°'.
          05 O-NO          PIC 9(3).
      ***************************************
      * LIBELLE DE DATE DE COMMANDE         *
      ***************************************
       01 L-DATE-TEXT.
          05 FILLER        PIC X(7)    VALUE 'Date : '.
          05 DATE-TEXT     PIC X(10).
      ***************************************
      * AFFICHAGE POURCENTAGE               *
      ***************************************
       01 L-ST-RATE.
          05 FILLER        PIC X        VALUE '('.
          05 ST-RATE-VAL   PIC 99,9.
          05 FILLER        PIC XX       VALUE '%)'.
       01 L-COM-RATE.
          05 FILLER        PIC X        VALUE '('.
          05 COM-RATE-VAL  PIC 9,9.
          05 FILLER        PIC XX       VALUE '%)'.

       COPY TEMPLFAC.

      ***************************************
      * PROGRAMME PRINCIPAL                 *
      ***************************************
       PROCEDURE DIVISION.
            PERFORM GET-RATES
            PERFORM OPEN-FILE-EXT
            PERFORM OPEN-FILE-FACT
            PERFORM READ-FILE-EXT
            PERFORM UNTIL FF-EXT = 1
               PERFORM WRITE-PAGE-FACTURE
            END-PERFORM
            PERFORM CLOSE-FILE-EXT
            PERFORM CLOSE-FILE-FACT
            GOBACK.

      ***************************************
      * ON RECUPERE LA TVA EN SYSIN         *
      ***************************************
       GET-RATES.
            ACCEPT WS-SYSIN FROM SYSIN
            COMPUTE E-ST-RATE = WS-ST-RATE * 100,0
            DISPLAY WS-ST-RATE.

      ***************************************
      * OUVERTURE DU FICHIER EXTRACTION     *
      ***************************************
       OPEN-FILE-EXT.
           OPEN INPUT EXT.

      ***************************************
      * FERMETURE DU FICHIER EXTRACTION     *
      ***************************************
       CLOSE-FILE-EXT.
           CLOSE EXT.

      ***************************************
      * OUVERTURE DU FICHIER FACTURE        *
      ***************************************
       OPEN-FILE-FACT.
           OPEN OUTPUT FACT.

      ***************************************
      * FERMETURE DU FICHIER FACTURE        *
      ***************************************
       CLOSE-FILE-FACT.
           CLOSE FACT.

      ***************************************
      * LECTURE DU FICHIER EXTRACTION       *
      ***************************************
       READ-FILE-EXT.
           READ EXT AT END
               DISPLAY 'FIN DU FICHIER EXTRACT '
               MOVE 1 TO FF-EXT
           END-READ.

      ***************************************
      * ECRITURE SUR LE FICHIER FACTURE     *
      * SI ERREUR = ABEND                   *
      ***************************************
       WRITE-FILE-FACT.
           WRITE FACT-ENR
           IF WS-FS NOT = ZERO THEN
              DISPLAY 'ERR WRITE :' WS-FS
              PERFORM ABEND-PROG
           END-IF.

      ***************************************
      * SAUT DE PAGE SUR LE FICHIER FACTURE *
      ***************************************
       WRITE-JUMP-PAGE-FACT.
           MOVE SPACE TO FACT-ENR
           WRITE FACT-ENR AFTER ADVANCING PAGE
           IF WS-FS NOT = ZERO THEN
              DISPLAY 'ERR WRITE :' WS-FS
              PERFORM ABEND-PROG
           END-IF.

      ***************************************
      * ECRITURE D'UNE PAGE DE LA FACTURE   *
      * EN UTILISANT LE FICHIER EXTRACT     *
      ***************************************
       WRITE-PAGE-FACTURE.
      *SI LA LIGNE ACTUELLE DECRIT UNE COMMANDE ON ECRIT LE HEADER
            IF TYPE-ENR = 'ORD' THEN
                MOVE ZERO TO WS-SUB-TOTAL
      *SI ON NE FAIT PAS LA SAUVEGARDE ON LE PERDRA QUAND ON PASSERA
      *AU PRODUIT
                MOVE EEMP-COM  TO WS-EMP-COM
                PERFORM WRITE-PAGE-HEADER
                PERFORM WRITE-PAGE-ORDER
                PERFORM READ-FILE-EXT
            ELSE
      *SI LA LIGNE ACTUELLE DECRIT UN PRODUIT ON ECRIT LES INFOS
      *DU PRODUIT
                PERFORM WRITE-PAGE-PRODUCT-HEADER
                PERFORM UNTIL FF-EXT = 1 OR TYPE-ENR = 'ORD'
      *CALCUL DU PRIX TOTAL DU PRODUIT EN FONCTION DE LA QUANTITE
                    COMPUTE WS-LINE-PRICE = EPRO-PRICE
                       * EITE-QUANTITY
      *ET ON L'AJOUTE AU TOTAL
                    ADD WS-LINE-PRICE TO WS-SUB-TOTAL
                    PERFORM WRITE-PAGE-PRODUCT-CONTENT
                    PERFORM READ-FILE-EXT
                END-PERFORM
                PERFORM WRITE-PAGE-PRODUCT-FOOTER
      *CALCUL DE LA VALEUR FINALE DE LA COMMANDE
                COMPUTE WS-ST-VALUE = WS-SUB-TOTAL * WS-ST-RATE
                COMPUTE WS-COM-VALUE = WS-SUB-TOTAL * WS-EMP-COM
                DISPLAY WS-COM-VALUE
                COMPUTE WS-TOTAL = WS-SUB-TOTAL + WS-ST-VALUE
                DISPLAY WS-TOTAL
                PERFORM WRITE-PAGE-TOTAL
                IF FF-EXT NOT EQUAL 1 THEN
                   PERFORM WRITE-JUMP-PAGE-FACT
                END-IF
            END-IF.

      ***************************************
      * ECRITURE DU HEADER                  *
      ***************************************
       WRITE-PAGE-HEADER.
           MOVE ECUS-COMPANY TO P-COMPANY
           MOVE ECUS-ADDRESS TO P-ADDRESS
           MOVE ECUS-STATE   TO P-STATE
           MOVE SPACE        TO P-CITY-ZIP
           STRING
                ECUS-CITY (1:ECUS-CITY-LEN)
                ', '      DELIMITED BY SIZE
                ECUS-ZIP  DELIMITED BY SPACES
           INTO P-CITY-ZIP

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 7
              MOVE PH-LINES(WS-IDX) TO FACT-ENR
              PERFORM WRITE-FILE-FACT
           END-PERFORM.

      ***************************************
      * ECRITURE  DES INFOS DE COMMANDE     *
      ***************************************
       WRITE-PAGE-ORDER.
           CALL 'DATETEXT' USING WS-DATE
           MOVE SPACE        TO P-DATE
           STRING
                'New York, ' DELIMITED BY SIZE
                WS-DATE      DELIMITED BY SIZE
           INTO P-DATE
           MOVE EORD-O-NO    TO O-NO
           MOVE L-ORDER-TEXT TO P-O-NO
           MOVE EORD-O-DATE  TO DATE-TEXT
           MOVE L-DATE-TEXT  TO P-O-DATE
           MOVE SPACE        TO P-CONTACT
           STRING
                'Your contact within the department ' DELIMITED BY
                   SIZE
                EDEP-DNAME (1:EDEP-DNAME-LEN) DELIMITED BY SIZE
                ' : '                         DELIMITED BY SIZE
                EEMP-LNAME (1:EEMP-LNAME-LEN) DELIMITED BY SIZE
                ', '                          DELIMITED BY SIZE
                EEMP-FNAME (1:EEMP-FNAME-LEN) DELIMITED BY SIZE
           INTO P-CONTACT
           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 9
              MOVE PO-LINES(WS-IDX) TO FACT-ENR
              PERFORM WRITE-FILE-FACT
           END-PERFORM.

      ***************************************
      * ECRITURE DU HEADER DES PRODUITS     *
      ***************************************
       WRITE-PAGE-PRODUCT-HEADER.
           MOVE PP-LINE-HEADER TO FACT-ENR
           PERFORM WRITE-FILE-FACT.
           MOVE PP-LINE-LIB TO FACT-ENR
           PERFORM WRITE-FILE-FACT.

      ***************************************
      * ECRITURE DU DETAIL  DES PRODUITS    *
      ***************************************
       WRITE-PAGE-PRODUCT-CONTENT.
           MOVE EPRO-P-NO TO P-P-NO
           MOVE EPRO-DESCRIPTION TO P-DESCRIPTION
           MOVE EITE-QUANTITY    TO P-QUANTITY
           MOVE EPRO-PRICE       TO P-PRICE
           MOVE WS-LINE-PRICE    TO P-LINE-TOTAL
           MOVE PP-PRODUCT TO FACT-ENR.
           PERFORM WRITE-FILE-FACT.

      ***************************************
      * FIN DE LA SECTION PRODUIT DE LA     *
      * FACTURE                             *
      ***************************************
       WRITE-PAGE-PRODUCT-FOOTER.
           MOVE PP-LINE-FOOTER TO FACT-ENR
           PERFORM WRITE-FILE-FACT.

      ***************************************
      * ECRITURE DU TOTAL DE LA COMMANDE    *
      ***************************************
       WRITE-PAGE-TOTAL.
           MOVE WS-SUB-TOTAL     TO P-SUB-TOTAL
           MOVE E-ST-RATE        TO ST-RATE-VAL
           MOVE L-ST-RATE        TO P-ST-RATE
           MOVE WS-ST-VALUE      TO P-ST-VALUE
           COMPUTE E-COM-RATE = WS-EMP-COM * 100,0
           MOVE E-COM-RATE       TO COM-RATE-VAL
           MOVE L-COM-RATE       TO P-COM-RATE
           MOVE WS-COM-VALUE     TO P-COM-VALUE
           MOVE WS-TOTAL         TO P-TOTAL

           PERFORM VARYING WS-IDX FROM 1 BY 1 UNTIL WS-IDX > 10
              MOVE PT-LINES(WS-IDX) TO FACT-ENR
              PERFORM WRITE-FILE-FACT
           END-PERFORM.

      ******************************************
      * FERMETURE DU PROGRAMME EN CAS D'ERREUR *
      ******************************************
        ABEND-PROG.
           DISPLAY 'ABEND PROG !'
           COMPUTE WS-ANO = 1 / WS-ANO.
