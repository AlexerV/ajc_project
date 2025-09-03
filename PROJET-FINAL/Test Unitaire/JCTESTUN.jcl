000001 //API2CUNI JOB (ACCT#),'ALEXIS',CLASS=A,MSGCLASS=H,REGION=4M,          
000002 //             MSGLEVEL=(1,1),NOTIFY=&SYSUID,COND=(4,LT),TIME=(,30)    
000003 //* COMPIL CONVDATE POUR LE TEST UNITAIRE                              
000004 //STEP1     EXEC IGYWCL,PARM.COBOL=(NODYNAM,ADV,OBJECT,LIB,TEST,APOST) 
000005 //COBOL.SYSIN  DD DSN=API2.COB.SRC(CONVDATE),DISP=SHR                  
000006 //COBOL.SYSLIB DD DSN=CEE.SCEESAMP,DISP=SHR                            
000007 //             DD DSN=API2.COB.CPY,DISP=SHR                            
000008 //* LINKEDIT                                                           
000009 //LKED.SYSLMOD DD DSN=API2.COB.LOAD(CONVDATE),DISP=OLD                 
000010 //LKED.SYSLIB  DD DSN=API2.COB.LOAD,DISP=SHR                           
000011 //             DD DSN=CEE.SCEELKED,DISP=SHR                            
000012 //LKED.SYSIN   DD *                                                    
000013  NAME CONVDATE(R)                                                      
000014 /*                                                                     
000015 //* COMPIL ASSEQX POUR LE TEST UNITAIRE                                
000016 //STEP2     EXEC IGYWCL,PARM.COBOL=(NODYNAM,ADV,OBJECT,LIB,TEST,APOST) 
000017 //COBOL.SYSIN  DD DSN=API2.COB.SRC(ASSEQX),DISP=SHR                    
000018 //COBOL.SYSLIB DD DSN=CEE.SCEESAMP,DISP=SHR                            
000019 //         DD DSN=API2.COB.CPY,DISP=SHR                                
000020 //* LINKEDIT                                                           
000021 //LKED.SYSLMOD DD DSN=API2.COB.LOAD(ASSEQX),DISP=SHR                   
000022 //LKED.SYSLIB  DD DSN=API2.COB.LOAD,DISP=SHR                           
000023 //             DD DSN=CEE.SCEELKED,DISP=SHR                            
000024 //LKED.SYSIN   DD *                                                    
000025  NAME ASSEQX(R)                                                        
000026 /*                                                                     
000027 //* COMPIL TESTUNCD POUR LE TEST UNITAIRE                              
000028 //STEP3     EXEC IGYWCL,PARM.COBOL=(NODYNAM,ADV,OBJECT,LIB,TEST,APOST) 
000029 //COBOL.SYSIN  DD DSN=API2.COB.SRC(TESTUNCD),DISP=SHR                  
000030 //COBOL.SYSLIB DD DSN=CEE.SCEESAMP,DISP=SHR                            
000031 //             DD DSN=API2.COB.CPY,DISP=SHR                            
000032 //* LINKEDIT                                                           
000033 //LKED.SYSLMOD DD DSN=API2.COB.LOAD(TESTUNCD),DISP=SHR                 
000034 //LKED.SYSLIB  DD DSN=API2.COB.LOAD,DISP=SHR                           
000035 //             DD DSN=CEE.SCEELKED,DISP=SHR                            
000036 //LKED.SYSIN   DD *                                                    
000037  NAME TESTUNCD(R)  
000038 /*                 