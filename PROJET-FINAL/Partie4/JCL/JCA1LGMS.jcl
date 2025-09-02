//A1NLGMS JOB DPTM,VSAM,MSGLEVEL=(1,1),MSGCLASS=H,CLASS=A,
//   NOTIFY=&SYSUID,TIME=(0,5)
//         JCLLIB  ORDER=SDJ.FORM.PROCLIB
//         EXEC    COMPMAP,MAP=MS1LOG
//*----------------------------------------------------------*
//*                                                          *
//* COMPIL / LINK / COPY MAP CICS TS 2.2                     *
//*                                                          *
//*----------------------------------------------------------*
//*
//STEPEXT.SYSUT1   DD DSN=API1.SOURCE.BMS(&MAP),DISP=SHR
//STEPCOP.SYSPUNCH DD DSN=API1.SOURCE.COPY(&MAP),DISP=SHR
