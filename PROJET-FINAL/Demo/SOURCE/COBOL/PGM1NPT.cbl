       IDENTIFICATION DIVISION.
       PROGRAM-ID     PGM1NPT.
      **********************************************
       ENVIRONMENT DIVISION.
      **********************************************
       DATA DIVISION.
       WORKING-STORAGE SECTION.

      **********************************************
      * DESCRIPTION DES TOUCHES FONCTIONS          *
      **********************************************
       COPY DFHAID.
      **********************************************
      * DESCRIPTION DES ATTRIBUTS                  *
      **********************************************
       COPY DFHBMSCA.
      **********************************************
      * DESCRIPTION DE LA MAP                      *
      **********************************************
       COPY MS1NPT.
      **********************************************
      * DESCRIPTION DES FICHIERS                   *
      **********************************************
       COPY NEWPARTS.

       COPY ZONE.

       77 WS-TEMPS       PIC S9(15) COMP-3.
       77 WS-CD-ERR      PIC 99.
       77 WS-CD-ERR2     PIC 99.
       77 WS-ERR-MESS    PIC X(50) VALUE 'FIN NORMALE'.

       77 WS-MSG         PIC X(50).

      *************************************************
      * VARIABLES POUR VERIFIER LA SAISIE *
      *************************************************

       01 FILLER PIC 9.
          88 ALL-ZONES-OK  VALUE 0.
          88 MANQUE-ZONE   VALUE 1.

       77 UNDERSCORE    PIC X(79) VALUE ALL '_'.

       LINKAGE SECTION.
       01 DFHCOMMAREA PIC X(70).

       PROCEDURE DIVISION USING DFHCOMMAREA.

            EVALUATE EIBTRNID
                WHEN 'T1E2'
                     IF EIBCALEN = ZERO
                            MOVE 'NON AUTHENTIFIE!'
                              TO WS-ERR-MESS
                            PERFORM FIN-TOTALE
                     ELSE
                            MOVE DFHCOMMAREA TO ZONE
                            IF LOGGED AND PREV-PGM = 'PGM1LOG'
                               MOVE LOW-VALUE TO MAP1NPTO
                               PERFORM ENVOI-ECRAN
                            END-IF
                            PERFORM GESTION-TOUCHES
                     END-IF
                WHEN OTHER
                     MOVE LOW-VALUE TO MAP1NPTO
            END-EVALUATE
            PERFORM ENVOI-ECRAN.
      *************************************************
      * PARAGRAPHES                                   *
      *************************************************
       ENVOI-ECRAN.
            MOVE 'AJOUT PARTS ' TO LIBMAPNPO
            EXEC CICS ASKTIME
                  ABSTIME (WS-TEMPS)
            END-EXEC

            EXEC CICS
               FORMATTIME ABSTIME (WS-TEMPS)
               DDMMYY (DATEJNPO)
               DATESEP('/')
               TIME (HEURENPO)
               TIMESEP(':')
            END-EXEC

            EXEC CICS
              SEND MAP('MAP1NPT')
                   MAPSET('MS1NPT')
                   FROM (MAP1NPTO)
                   RESP (WS-CD-ERR)
                   ERASE
                   CURSOR
            END-EXEC

            IF WS-CD-ERR NOT EQUAL DFHRESP(NORMAL)
                         MOVE 'ERR SEND' TO WS-ERR-MESS
                         PERFORM FIN-TOTALE
            END-IF
            MOVE 'PGM1NPT' TO PREV-PGM
      * REAFFICHAGE DE LA TRANSACTION T1E1

            EXEC CICS
                 RETURN TRANSID ('T1E2')
                 COMMAREA (ZONE)
                 LENGTH (LENGTH OF ZONE)
            END-EXEC
            .

       LECT-ECRAN.
            EXEC CICS
                 RECEIVE MAP ('MAP1NPT')
                         MAPSET ('MS1NPT')
                         RESP (WS-CD-ERR)
            END-EXEC

            IF WS-CD-ERR NOT EQUAL DFHRESP(NORMAL)
                         MOVE 'ERR RECE' TO WS-ERR-MESS
                         PERFORM FIN-TOTALE
            END-IF.

       LECTURE-NPT.
            EXEC CICS
                 READ DATASET ('PARTS1')
                      INTO (ENR-NPT)
                      RIDFLD (PNONPI)
                      RESP (WS-CD-ERR)
            END-EXEC
            EVALUATE WS-CD-ERR
                WHEN ZERO
                     MOVE 'CODE PARTS EXISTE DEJA' TO MESS1NPI
                     MOVE DFHRED TO PNONPC
                     MOVE -1     TO PNONPL
                     PERFORM ENVOI-ECRAN
                WHEN 13
                     CONTINUE
                WHEN OTHER
                     MOVE 'ERREUR READ PARTS1' TO WS-ERR-MESS
                     PERFORM FIN-TOTALE
           END-EVALUATE.

       VERIF-SAISIE.
           INSPECT PNAMENPI  REPLACING ALL '_' BY SPACES
           INSPECT COLORNPI  REPLACING ALL '_' BY SPACES
           INSPECT CITYNPI   REPLACING ALL '_' BY SPACES
           INSPECT WEIGHTNPI REPLACING ALL '_' BY SPACES
           INSPECT PNONPI    REPLACING ALL '_' BY SPACES

           SET ALL-ZONES-OK TO TRUE

           IF WEIGHTNPI IS NOT NUMERIC OR WEIGHTNPI = SPACES
              SET MANQUE-ZONE TO TRUE
              MOVE DFHRED TO WEIGHTNPC
              MOVE 'WEIGHT DEVRAIT ETRE NUMERIQUE !' TO MESS1NPI
              MOVE ZERO TO WEIGHTNPI
           END-IF
           IF PNAMENPI = SPACES
              SET MANQUE-ZONE TO TRUE
              MOVE DFHRED TO PNAMENPC
              MOVE UNDERSCORE TO PNAMENPI
              MOVE 'LE CHAMP NAME EST OBLIGATOIRE !' TO MESS1NPI
           END-IF
           IF PNONPI = SPACES
              SET MANQUE-ZONE TO TRUE
              MOVE DFHRED TO PNONPC
              MOVE 'LE CHAMP ID EST OBLIGATOIRE !' TO MESS1NPI
           END-IF
           .

       AJOUT-NPT.
           IF ALL-ZONES-OK
                MOVE PNONPI    TO PNO-NPT
                MOVE PNAMENPI  TO PNAME-NPT
                MOVE COLORNPI  TO COLOR-NPT
                MOVE WEIGHTNPI TO WEIGHT-NPT
                MOVE CITYNPI   TO CITY-NPT

                EXEC CICS
                  WRITE DATASET ('PARTS1')
                        FROM (ENR-NPT)
                        RIDFLD(PNO-NPT)
                        RESP (WS-CD-ERR)
                        RESP2(WS-CD-ERR2)
                END-EXEC
                EVALUATE WS-CD-ERR
                   WHEN ZERO
                        MOVE 'AJOUT EFFECTUE ' TO MESS1NPI
                        MOVE DFHBLUE TO PNONPC
                        PERFORM ENVOI-ECRAN
                   WHEN 14
                        MOVE 'DOUBLON SUR ' TO MESS1NPI
                        MOVE PNONPI          TO MESS2NPI
                        PERFORM ENVOI-ECRAN
                   WHEN OTHER
                        STRING
                             'ERREUR WRITE PARTS1 '
                             WS-CD-ERR  DELIMITED BY SIZE
                             SPACE      DELIMITED BY SIZE
                             WS-CD-ERR2 DELIMITED BY SIZE
                        INTO WS-ERR-MESS
                        PERFORM FIN-TOTALE
                   END-EVALUATE
                END-IF
                .

       TRAIT-SAISIE.
           INITIALIZE MESS1NPO MESS2NPO
           PERFORM LECTURE-NPT
           PERFORM VERIF-SAISIE
           PERFORM AJOUT-NPT.

       TOUCHE-INVALIDE.
           INITIALIZE MESS1NPO MESS2NPO
           MOVE 'TOUCHE INVALIDE !' TO MESS1NPO
           MOVE DFHPINK TO MESS1NPC.

       GESTION-TOUCHES.
      * RECUPERE LA TOUCHE PRESSEE
      * TOUCHE CLEAR
           INITIALIZE WS-MSG
           EVALUATE TRUE
              WHEN EIBAID = DFHCLEAR
                   MOVE 'BYE' TO WS-ERR-MESS
                   PERFORM FIN-TOTALE
              WHEN EIBAID = DFHENTER
                   PERFORM LECT-ECRAN
                   PERFORM TRAIT-SAISIE
              WHEN OTHER
                   PERFORM TOUCHE-INVALIDE
           END-EVALUATE.

        FIN-TOTALE.
           EXEC CICS
              SEND FROM (WS-ERR-MESS)
                   LENGTH (LENGTH OF WS-ERR-MESS)
                   WAIT
                   ERASE
              END-EXEC
              EXEC CICS    RETURN     END-EXEC.
