label define vlR0000100   0 "0"
label values R0000100 vlR0000100
label define vlR0536300   1 "Male"  2 "Female"  0 "No Information"
label values R0536300 vlR0536300
label define vlR0536401   1 "1: January"  2 "2: February"  3 "3: March"  4 "4: April"  5 "5: May"  6 "6: June"  7 "7: July"  8 "8: August"  9 "9: September"  10 "10: October"  11 "11: November"  12 "12: December"
label values R0536401 vlR0536401
label define vlR1482600   1 "Black"  2 "Hispanic"  3 "Mixed Race (Non-Hispanic)"  4 "Non-Black / Non-Hispanic"
label values R1482600 vlR1482600
label define vlR4893400   1 "Never"  2 "Once or twice"  3 "Less than once a month / 3-12 times"  4 "About once a month / 12 times"  5 "About twice a month / 24 times"  6 "About once a week"  7 "Several times a week"  8 "Everyday"
label values R4893400 vlR4893400
label define vlR6520100   1 "Never"  2 "Once or twice"  3 "Less than once a month / 3-12 times"  4 "About once a month / 12 times"  5 "About twice a month / 24 times"  6 "About once a week"  7 "Several times a week"  8 "Everyday"
label values R6520100 vlR6520100
label define vlS0919300   1 "Never"  2 "Once or twice"  3 "Less than once a month / 3-12 times"  4 "About once a month / 12 times"  5 "About twice a month / 24 times"  6 "About once a week"  7 "Several times a week"  8 "Everyday"
label values S0919300 vlS0919300
label define vlS2987800   1 "Never"  2 "Once or twice"  3 "Less than once a month"  4 "About once a month"  5 "About twice a month"  6 "About once a week"  7 "Several times a week"  8 "Everyday"
label values S2987800 vlS2987800
label define vlS4681700   1 "Never"  2 "Once or twice"  3 "Less than once a month"  4 "About once a month"  5 "About twice a month"  6 "About once a week"  7 "Several times a week"  8 "Everyday"
label values S4681700 vlS4681700
label define vlS6316700   1 "Never"  2 "Once or twice"  3 "Less than once a month"  4 "About once a month"  5 "About twice a month"  6 "About once a week"  7 "Several times a week"  8 "Everyday"
label values S6316700 vlS6316700
label define vlS8331500   1 "Never"  2 "Once or twice"  3 "Less than once a month"  4 "About once a month"  5 "About twice a month"  6 "About once a week"  7 "Several times a week"  8 "Everyday"
label values S8331500 vlS8331500
label define vlT0739400   1 "Never"  2 "Once or twice"  3 "Less than once a month"  4 "About once a month"  5 "About twice a month"  6 "About once a week"  7 "Several times a week"  8 "Everyday"
label values T0739400 vlT0739400
label define vlT2781700   1 "Never"  2 "Once or twice"  3 "Less than once a month"  4 "About once a month"  5 "About twice a month"  6 "About once a week"  7 "Several times a week"  8 "Everyday"
label values T2781700 vlT2781700
label define vlT4495000   1 "Never"  2 "Once or twice"  3 "Less than once a month"  4 "About once a month"  5 "About twice a month"  6 "About once a week"  7 "Several times a week"  8 "Everyday"
label values T4495000 vlT4495000
label define vlT6143400   1 "Never"  2 "Once or twice"  3 "Less than once a month"  4 "About once a month"  5 "About twice a month"  6 "About once a week"  7 "Several times a week"  8 "Everyday"
label values T6143400 vlT6143400
label define vlT7637300   1 "Never"  2 "Once or twice"  3 "Less than once a month"  4 "About once a month"  5 "About twice a month"  6 "About once a week"  7 "Several times a week"  8 "Everyday"
label values T7637300 vlT7637300
/* Crosswalk for Reference number & Question name
 * Uncomment and edit this RENAME statement to rename variables for ease of use.
 * This command does not guarantee uniqueness
 */
  /* *start* */
/*
  rename R0000100 PUBID_1997 
  rename R0536300 KEY!SEX_1997 
  rename R0536401 KEY!BDATE_M_1997 
  rename R0536402 KEY!BDATE_Y_1997 
  rename R1482600 KEY!RACE_ETHNICITY_1997 
  rename R4893400 YSAQ_282A_2000   // YSAQ-282A
  rename R6520100 YSAQ_282A_2001   // YSAQ-282A
  rename S0919300 YSAQ_282A_2002   // YSAQ-282A
  rename S2987800 YSAQ_282A_2003   // YSAQ-282A
  rename S4681700 YSAQ_282A_2004   // YSAQ-282A
  rename S6316700 YSAQ_282A_2005   // YSAQ-282A
  rename S8331500 YSAQ_282A_2006   // YSAQ-282A
  rename T0739400 YSAQ_282A_2007   // YSAQ-282A
  rename T2781700 YSAQ_282A_2008   // YSAQ-282A
  rename T4495000 YSAQ_282A_2009   // YSAQ-282A
  rename T6143400 YSAQ_282A_2010   // YSAQ-282A
  rename T7637300 YSAQ_282A_2011   // YSAQ-282A
*/
  /* *end* */  
/* To convert variable names to lower case use the TOLOWER command 
 *      (type findit tolower and follow the links to install).
 * TOLOWER VARLIST will change listed variables to lower case; 
 *  TOLOWER without a specified variable list will convert all variables in the dataset to lower case
 */
/* tolower */
