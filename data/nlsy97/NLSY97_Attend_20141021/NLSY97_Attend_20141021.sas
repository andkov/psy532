options nocenter validvarname=any;

*---Read in space-delimited ascii file;

data new_data;


infile 'NLSY97_Attend_20141021.dat' lrecl=57 missover DSD DLM=' ' print;
input
  R0000100
  R0536300
  R0536401
  R0536402
  R1482600
  R4893400
  R6520100
  S0919300
  S2987800
  S4681700
  S6316700
  S8331500
  T0739400
  T2781700
  T4495000
  T6143400
  T7637300
;
array nvarlist _numeric_;


*---Recode missing values to SAS custom system missing. See SAS
      documentation for use of MISSING option in procedures, e.g. PROC FREQ;

do over nvarlist;
  if nvarlist = -1 then nvarlist = .R;  /* Refused */
  if nvarlist = -2 then nvarlist = .D;  /* Dont know */
  if nvarlist = -3 then nvarlist = .I;  /* Invalid missing */
  if nvarlist = -4 then nvarlist = .V;  /* Valid missing */
  if nvarlist = -5 then nvarlist = .N;  /* Non-interview */
end;

  label R0000100 = "PUBID - YTH ID CODE 1997";
  label R0536300 = "KEY!SEX (SYMBOL) 1997";
  label R0536401 = "KEY!BDATE M/Y (SYMBOL) 1997";
  label R0536402 = "KEY!BDATE M/Y (SYMBOL) 1997";
  label R1482600 = "KEY!RACE_ETHNICITY (SYMBOL) 1997";
  label R4893400 = "HOW OFTEN R ATTEND WORSHIP SERV 2000";
  label R6520100 = "HOW OFTEN R ATTEND WORSHIP SERV 2001";
  label S0919300 = "HOW OFTEN R ATTEND WORSHIP SERV 2002";
  label S2987800 = "HOW OFTEN R ATTEND WORSHIP SERV 2003";
  label S4681700 = "HOW OFTEN R ATTEND WORSHIP SERV 2004";
  label S6316700 = "HOW OFTEN R ATTEND WORSHIP SERV 2005";
  label S8331500 = "HOW OFTEN R ATTEND WORSHIP SERV 2006";
  label T0739400 = "HOW OFTEN R ATTEND WORSHIP SERV 2007";
  label T2781700 = "HOW OFTEN R ATTEND WORSHIP SERV 2008";
  label T4495000 = "HOW OFTEN R ATTEND WORSHIP SERV 2009";
  label T6143400 = "HOW OFTEN R ATTEND WORSHIP SERV 2010";
  label T7637300 = "HOW OFTEN R ATTEND WORSHIP SERV 2011";

/*---------------------------------------------------------------------*
 *  Crosswalk for Reference number & Question name                     *
 *---------------------------------------------------------------------*
 * Uncomment and edit this RENAME statement to rename variables
 * for ease of use.  You may need to use  name literal strings
 * e.g.  'variable-name'n   to create valid SAS variable names, or 
 * alter variables similarly named across years.
 * This command does not guarantee uniqueness

 * See SAS documentation for use of name literals and use of the
 * VALIDVARNAME=ANY option.     
 *---------------------------------------------------------------------*/
  /* *start* */

* RENAME
  R0000100 = 'PUBID_1997'n
  R0536300 = 'KEY!SEX_1997'n
  R0536401 = 'KEY!BDATE_M_1997'n
  R0536402 = 'KEY!BDATE_Y_1997'n
  R1482600 = 'KEY!RACE_ETHNICITY_1997'n
  R4893400 = 'YSAQ-282A_2000'n
  R6520100 = 'YSAQ-282A_2001'n
  S0919300 = 'YSAQ-282A_2002'n
  S2987800 = 'YSAQ-282A_2003'n
  S4681700 = 'YSAQ-282A_2004'n
  S6316700 = 'YSAQ-282A_2005'n
  S8331500 = 'YSAQ-282A_2006'n
  T0739400 = 'YSAQ-282A_2007'n
  T2781700 = 'YSAQ-282A_2008'n
  T4495000 = 'YSAQ-282A_2009'n
  T6143400 = 'YSAQ-282A_2010'n
  T7637300 = 'YSAQ-282A_2011'n
;
  /* *finish* */

run;

proc means data=new_data n mean min max;
run;


/*---------------------------------------------------------------------*
 *  FORMATTED TABULATIONS                                              *
 *---------------------------------------------------------------------*
 * You can uncomment and edit the PROC FORMAT and PROC FREQ statements 
 * provided below to obtain formatted tabulations. The tabulations 
 * should reflect codebook values.
 * 
 * Please edit the formats below reflect any renaming of the variables
 * you may have done in the first data step. 
 *---------------------------------------------------------------------*/

/*
proc format; 
value vx0f
  0='0'
  1-999='1 TO 999'
  1000-1999='1000 TO 1999'
  2000-2999='2000 TO 2999'
  3000-3999='3000 TO 3999'
  4000-4999='4000 TO 4999'
  5000-5999='5000 TO 5999'
  6000-6999='6000 TO 6999'
  7000-7999='7000 TO 7999'
  8000-8999='8000 TO 8999'
  9000-9999='9000 TO 9999'
;
value vx1f
  1='Male'
  2='Female'
  0='No Information'
;
value vx2f
  1='1: January'
  2='2: February'
  3='3: March'
  4='4: April'
  5='5: May'
  6='6: June'
  7='7: July'
  8='8: August'
  9='9: September'
  10='10: October'
  11='11: November'
  12='12: December'
;
value vx4f
  1='Black'
  2='Hispanic'
  3='Mixed Race (Non-Hispanic)'
  4='Non-Black / Non-Hispanic'
;
value vx5f
  1='Never'
  2='Once or twice'
  3='Less than once a month / 3-12 times'
  4='About once a month / 12 times'
  5='About twice a month / 24 times'
  6='About once a week'
  7='Several times a week'
  8='Everyday'
;
value vx6f
  1='Never'
  2='Once or twice'
  3='Less than once a month / 3-12 times'
  4='About once a month / 12 times'
  5='About twice a month / 24 times'
  6='About once a week'
  7='Several times a week'
  8='Everyday'
;
value vx7f
  1='Never'
  2='Once or twice'
  3='Less than once a month / 3-12 times'
  4='About once a month / 12 times'
  5='About twice a month / 24 times'
  6='About once a week'
  7='Several times a week'
  8='Everyday'
;
value vx8f
  1='Never'
  2='Once or twice'
  3='Less than once a month'
  4='About once a month'
  5='About twice a month'
  6='About once a week'
  7='Several times a week'
  8='Everyday'
;
value vx9f
  1='Never'
  2='Once or twice'
  3='Less than once a month'
  4='About once a month'
  5='About twice a month'
  6='About once a week'
  7='Several times a week'
  8='Everyday'
;
value vx10f
  1='Never'
  2='Once or twice'
  3='Less than once a month'
  4='About once a month'
  5='About twice a month'
  6='About once a week'
  7='Several times a week'
  8='Everyday'
;
value vx11f
  1='Never'
  2='Once or twice'
  3='Less than once a month'
  4='About once a month'
  5='About twice a month'
  6='About once a week'
  7='Several times a week'
  8='Everyday'
;
value vx12f
  1='Never'
  2='Once or twice'
  3='Less than once a month'
  4='About once a month'
  5='About twice a month'
  6='About once a week'
  7='Several times a week'
  8='Everyday'
;
value vx13f
  1='Never'
  2='Once or twice'
  3='Less than once a month'
  4='About once a month'
  5='About twice a month'
  6='About once a week'
  7='Several times a week'
  8='Everyday'
;
value vx14f
  1='Never'
  2='Once or twice'
  3='Less than once a month'
  4='About once a month'
  5='About twice a month'
  6='About once a week'
  7='Several times a week'
  8='Everyday'
;
value vx15f
  1='Never'
  2='Once or twice'
  3='Less than once a month'
  4='About once a month'
  5='About twice a month'
  6='About once a week'
  7='Several times a week'
  8='Everyday'
;
value vx16f
  1='Never'
  2='Once or twice'
  3='Less than once a month'
  4='About once a month'
  5='About twice a month'
  6='About once a week'
  7='Several times a week'
  8='Everyday'
;
*/

/* 
 *--- Tabulations using reference number variables;
proc freq data=new_data;
tables _ALL_ /MISSING;
  format R0000100 vx0f.;
  format R0536300 vx1f.;
  format R0536401 vx2f.;
  format R1482600 vx4f.;
  format R4893400 vx5f.;
  format R6520100 vx6f.;
  format S0919300 vx7f.;
  format S2987800 vx8f.;
  format S4681700 vx9f.;
  format S6316700 vx10f.;
  format S8331500 vx11f.;
  format T0739400 vx12f.;
  format T2781700 vx13f.;
  format T4495000 vx14f.;
  format T6143400 vx15f.;
  format T7637300 vx16f.;
run;
*/

/*
*--- Tabulations using default named variables;
proc freq data=new_data;
tables _ALL_ /MISSING;
  format 'PUBID_1997'n vx0f.;
  format 'KEY!SEX_1997'n vx1f.;
  format 'KEY!BDATE_M_1997'n vx2f.;
  format 'KEY!RACE_ETHNICITY_1997'n vx4f.;
  format 'YSAQ-282A_2000'n vx5f.;
  format 'YSAQ-282A_2001'n vx6f.;
  format 'YSAQ-282A_2002'n vx7f.;
  format 'YSAQ-282A_2003'n vx8f.;
  format 'YSAQ-282A_2004'n vx9f.;
  format 'YSAQ-282A_2005'n vx10f.;
  format 'YSAQ-282A_2006'n vx11f.;
  format 'YSAQ-282A_2007'n vx12f.;
  format 'YSAQ-282A_2008'n vx13f.;
  format 'YSAQ-282A_2009'n vx14f.;
  format 'YSAQ-282A_2010'n vx15f.;
  format 'YSAQ-282A_2011'n vx16f.;
run;
*/