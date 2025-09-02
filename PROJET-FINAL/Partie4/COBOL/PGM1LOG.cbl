       IDENTIFICATION DIVISION.
       PROGRAM-ID     PGM1LOG.
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
       COPY MS1LOG.
      **********************************************
      * DESCRIPTION DES FICHIERS                   *
      **********************************************
       COPY EMPLOYEE.

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
                WHEN 'T1E1'
                     IF EIBCALEN = ZERO
                            MOVE LOW-VALUE TO MAP1LOGO
                            PERFORM ENVOI-ECRAN
                     ELSE
                            MOVE DFHCOMMAREA TO ZONE
                            PERFORM GESTION-TOUCHES
                     END-IF
                WHEN OTHER
                     MOVE DFHCOMMAREA TO ZONE
                     MOVE LOW-VALUE TO MAP1LOGO
            END-EVALUATE
            PERFORM ENVOI-ECRAN.
      *************************************************
      * PARAGRAPHES                                   *
      *************************************************
       ENVOI-ECRAN.
            MOVE 'AJOUT PARTS ' TO LIBMAPLGO
            EXEC CICS ASKTIME
                  ABSTIME (WS-TEMPS)
            END-EXEC

            EXEC CICS
               FORMATTIME ABSTIME (WS-TEMPS)
               DDMMYY (DATEJLGO)
               DATESEP('/')
               TIME (HEURELGO)
               TIMESEP(':')
            END-EXEC

            EXEC CICS
              SEND MAP('MAP1LOG')
                   MAPSET('MS1LOG')
                   FROM (MAP1LOGO)
                   RESP (WS-CD-ERR)
                   ERASE
                   CURSOR
            END-EXEC

            IF WS-CD-ERR NOT EQUAL DFHRESP(NORMAL)
                         MOVE 'ERR SEND' TO WS-ERR-MESS
                         PERFORM FIN-TOTALE
            END-IF

            IF LOGGED THEN
                MOVE 'PGM1LOG' TO PREV-PGM
                EXEC CICS
                     RETURN TRANSID('T1E2')
                     COMMAREA(ZONE)
                     LENGTH(LENGTH OF ZONE)
                END-EXEC
            ELSE
      * REAFFICHAGE DE LA TRANSACTION T1E1
                 EXEC CICS
                     RETURN TRANSID ('T1E1')
                     COMMAREA (ZONE)
                     LENGTH (LENGTH OF ZONE)
                 END-EXEC
            END-IF.

       LECT-ECRAN.
            EXEC CICS
                 RECEIVE MAP ('MAP1LOG')
                         MAPSET ('MS1LOG')
                         RESP (WS-CD-ERR)
            END-EXEC

            IF WS-CD-ERR NOT EQUAL DFHRESP(NORMAL)
                         MOVE 'ERR RECE' TO WS-ERR-MESS
                         PERFORM FIN-TOTALE
            END-IF.

        LECTURE-LOG.
             EXEC CICS
                  READ DATASET ('USERS1')
                       INTO (ENR-EMP)
                       RIDFLD (LOGINLGI)
                       RESP (WS-CD-ERR)
             END-EXEC
             EVALUATE WS-CD-ERR
                 WHEN ZERO
                      CONTINUE
                 WHEN 13
                      MOVE 'IDENTIFIANT / PASSWORD INCORRECT(S)'
                            TO MESS1LGI
                      MOVE DFHRED TO LOGINLGC
                      MOVE SPACES TO PASSLGI
                      PERFORM ENVOI-ECRAN
                 WHEN OTHER
                      MOVE 'ERREUR READ USERS1' TO WS-ERR-MESS
                      PERFORM FIN-TOTALE
             END-EVALUATE.
             IF PASSLGO = PREN-EMP
                SET LOGGED TO TRUE
                MOVE 'IDENTIFICATION SUCCES' TO MESS1LGI
                MOVE SPACES TO PASSLGI
                PERFORM ENVOI-ECRAN
             ELSE
                MOVE 'IDENTIFIANT / PASSWORD INCORRECT(S)'
                           TO MESS1LGI
                MOVE DFHRED TO LOGINLGC
                MOVE SPACES TO PASSLGI
                PERFORM ENVOI-ECRAN
             END-IF.

       VERIF-SAISIE-LOG.
           INSPECT LOGINLGI  REPLACING ALL '_' BY SPACES

           SET ALL-ZONES-OK TO TRUE

           IF LOGINLGI = SPACES
              SET MANQUE-ZONE TO TRUE
              MOVE DFHRED TO LOGINLGC
              MOVE UNDERSCORE TO LOGINLGI
              MOVE 'VEUILLEZ ENTRER UN IDENTIFIANT' TO MESS1LGI
           END-IF
           IF PASSLGI = SPACES
              SET MANQUE-ZONE TO TRUE
              MOVE DFHRED TO PASSLGC
              MOVE 'VEUILLEZ ENTRER UN MOT DE PASSE' TO MESS1LGI
           END-IF
           .

       TRAIT-SAISIE.
           INITIALIZE MESS1LGO MESS2LGO
           PERFORM VERIF-SAISIE-LOG
           PERFORM LECTURE-LOG.

       TOUCHE-INVALIDE.
           INITIALIZE MESS1LGO MESS2LGO
           MOVE 'TOUCHE INVALIDE !' TO MESS1LGO
           MOVE DFHPINK TO MESS1LGC.

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
