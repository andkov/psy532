* Written by R;
*  write.foreign(X, "MR.txt", "MR.sas", package = "SAS") ;

DATA  rdata ;
INFILE  "MR.txt" 
     DSD 
     LRECL= 71 ;
INPUT
 IQ
 SES
 PEd
 CoH
;
RUN;
