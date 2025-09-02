       01  MAP1LOGI.
           02  FILLER PIC X(12).
           02  DATEJLGL    COMP  PIC  S9(4).
           02  DATEJLGF    PICTURE X.
           02  FILLER REDEFINES DATEJLGF.
             03 DATEJLGA    PICTURE X.
           02  FILLER   PICTURE X(4).
           02  DATEJLGI  PIC X(8).
           02  LIBMAPLGL    COMP  PIC  S9(4).
           02  LIBMAPLGF    PICTURE X.
           02  FILLER REDEFINES LIBMAPLGF.
             03 LIBMAPLGA    PICTURE X.
           02  FILLER   PICTURE X(4).
           02  LIBMAPLGI  PIC X(24).
           02  HEURELGL    COMP  PIC  S9(4).
           02  HEURELGF    PICTURE X.
           02  FILLER REDEFINES HEURELGF.
             03 HEURELGA    PICTURE X.
           02  FILLER   PICTURE X(4).
           02  HEURELGI  PIC X(8).
           02  LOGINLGL    COMP  PIC  S9(4).
           02  LOGINLGF    PICTURE X.
           02  FILLER REDEFINES LOGINLGF.
             03 LOGINLGA    PICTURE X.
           02  FILLER   PICTURE X(4).
           02  LOGINLGI  PIC X(5).
           02  PASSLGL    COMP  PIC  S9(4).
           02  PASSLGF    PICTURE X.
           02  FILLER REDEFINES PASSLGF.
             03 PASSLGA    PICTURE X.
           02  FILLER   PICTURE X(4).
           02  PASSLGI  PIC X(15).
           02  MESS1LGL    COMP  PIC  S9(4).
           02  MESS1LGF    PICTURE X.
           02  FILLER REDEFINES MESS1LGF.
             03 MESS1LGA    PICTURE X.
           02  FILLER   PICTURE X(4).
           02  MESS1LGI  PIC X(55).
           02  MESS2LGL    COMP  PIC  S9(4).
           02  MESS2LGF    PICTURE X.
           02  FILLER REDEFINES MESS2LGF.
             03 MESS2LGA    PICTURE X.
           02  FILLER   PICTURE X(4).
           02  MESS2LGI  PIC X(56).
       01  MAP1LOGO REDEFINES MAP1LOGI.
           02  FILLER PIC X(12).
           02  FILLER PICTURE X(3).
           02  DATEJLGC    PICTURE X.
           02  DATEJLGP    PICTURE X.
           02  DATEJLGH    PICTURE X.
           02  DATEJLGV    PICTURE X.
           02  DATEJLGO  PIC X(8).
           02  FILLER PICTURE X(3).
           02  LIBMAPLGC    PICTURE X.
           02  LIBMAPLGP    PICTURE X.
           02  LIBMAPLGH    PICTURE X.
           02  LIBMAPLGV    PICTURE X.
           02  LIBMAPLGO  PIC X(24).
           02  FILLER PICTURE X(3).
           02  HEURELGC    PICTURE X.
           02  HEURELGP    PICTURE X.
           02  HEURELGH    PICTURE X.
           02  HEURELGV    PICTURE X.
           02  HEURELGO  PIC X(8).
           02  FILLER PICTURE X(3).
           02  LOGINLGC    PICTURE X.
           02  LOGINLGP    PICTURE X.
           02  LOGINLGH    PICTURE X.
           02  LOGINLGV    PICTURE X.
           02  LOGINLGO PIC X(5).
           02  FILLER PICTURE X(3).
           02  PASSLGC    PICTURE X.
           02  PASSLGP    PICTURE X.
           02  PASSLGH    PICTURE X.
           02  PASSLGV    PICTURE X.
           02  PASSLGO  PIC X(15).
           02  FILLER PICTURE X(3).
           02  MESS1LGC    PICTURE X.
           02  MESS1LGP    PICTURE X.
           02  MESS1LGH    PICTURE X.
           02  MESS1LGV    PICTURE X.
           02  MESS1LGO  PIC X(55).
           02  FILLER PICTURE X(3).
           02  MESS2LGC    PICTURE X.
           02  MESS2LGP    PICTURE X.
           02  MESS2LGH    PICTURE X.
           02  MESS2LGV    PICTURE X.
           02  MESS2LGO  PIC X(56).
