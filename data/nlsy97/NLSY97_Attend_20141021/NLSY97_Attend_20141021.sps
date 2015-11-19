file handle pcdat/name='NLSY97_Attend_20141021.dat' /lrecl=57.
data list file pcdat free /
  R0000100 (F4)
  R0536300 (F2)
  R0536401 (F2)
  R0536402 (F4)
  R1482600 (F2)
  R4893400 (F2)
  R6520100 (F2)
  S0919300 (F2)
  S2987800 (F2)
  S4681700 (F2)
  S6316700 (F2)
  S8331500 (F2)
  T0739400 (F2)
  T2781700 (F2)
  T4495000 (F2)
  T6143400 (F2)
  T7637300 (F2)
.
* The following code works with current versions of SPSS.
missing values all (-5 thru -1).
* older versions of SPSS may require this:
* recode all (-5,-3,-2,-1=-4).
* missing values all (-4).
variable labels
  R0000100  "PUBID - YTH ID CODE 1997"
  R0536300  "KEY!SEX (SYMBOL) 1997"
  R0536401  "KEY!BDATE M/Y (SYMBOL) 1997"
  R0536402  "KEY!BDATE M/Y (SYMBOL) 1997"
  R1482600  "KEY!RACE_ETHNICITY (SYMBOL) 1997"
  R4893400  "HOW OFTEN R ATTEND WORSHIP SERV 2000"
  R6520100  "HOW OFTEN R ATTEND WORSHIP SERV 2001"
  S0919300  "HOW OFTEN R ATTEND WORSHIP SERV 2002"
  S2987800  "HOW OFTEN R ATTEND WORSHIP SERV 2003"
  S4681700  "HOW OFTEN R ATTEND WORSHIP SERV 2004"
  S6316700  "HOW OFTEN R ATTEND WORSHIP SERV 2005"
  S8331500  "HOW OFTEN R ATTEND WORSHIP SERV 2006"
  T0739400  "HOW OFTEN R ATTEND WORSHIP SERV 2007"
  T2781700  "HOW OFTEN R ATTEND WORSHIP SERV 2008"
  T4495000  "HOW OFTEN R ATTEND WORSHIP SERV 2009"
  T6143400  "HOW OFTEN R ATTEND WORSHIP SERV 2010"
  T7637300  "HOW OFTEN R ATTEND WORSHIP SERV 2011"
.

* Recode continuous values. 
* recode 
 R0000100 
    (0 thru 0 eq 0)
    (1 thru 999 eq 1)
    (1000 thru 1999 eq 1000)
    (2000 thru 2999 eq 2000)
    (3000 thru 3999 eq 3000)
    (4000 thru 4999 eq 4000)
    (5000 thru 5999 eq 5000)
    (6000 thru 6999 eq 6000)
    (7000 thru 7999 eq 7000)
    (8000 thru 8999 eq 8000)
    (9000 thru 9999 eq 9000)
.

* value labels
 R0000100
    0 "0"
    1 "1 TO 999"
    1000 "1000 TO 1999"
    2000 "2000 TO 2999"
    3000 "3000 TO 3999"
    4000 "4000 TO 4999"
    5000 "5000 TO 5999"
    6000 "6000 TO 6999"
    7000 "7000 TO 7999"
    8000 "8000 TO 8999"
    9000 "9000 TO 9999"
    /
 R0536300
    1 "Male"
    2 "Female"
    0 "No Information"
    /
 R0536401
    1 "1: January"
    2 "2: February"
    3 "3: March"
    4 "4: April"
    5 "5: May"
    6 "6: June"
    7 "7: July"
    8 "8: August"
    9 "9: September"
    10 "10: October"
    11 "11: November"
    12 "12: December"
    /
 R1482600
    1 "Black"
    2 "Hispanic"
    3 "Mixed Race (Non-Hispanic)"
    4 "Non-Black / Non-Hispanic"
    /
 R4893400
    1 "Never"
    2 "Once or twice"
    3 "Less than once a month / 3-12 times"
    4 "About once a month / 12 times"
    5 "About twice a month / 24 times"
    6 "About once a week"
    7 "Several times a week"
    8 "Everyday"
    /
 R6520100
    1 "Never"
    2 "Once or twice"
    3 "Less than once a month / 3-12 times"
    4 "About once a month / 12 times"
    5 "About twice a month / 24 times"
    6 "About once a week"
    7 "Several times a week"
    8 "Everyday"
    /
 S0919300
    1 "Never"
    2 "Once or twice"
    3 "Less than once a month / 3-12 times"
    4 "About once a month / 12 times"
    5 "About twice a month / 24 times"
    6 "About once a week"
    7 "Several times a week"
    8 "Everyday"
    /
 S2987800
    1 "Never"
    2 "Once or twice"
    3 "Less than once a month"
    4 "About once a month"
    5 "About twice a month"
    6 "About once a week"
    7 "Several times a week"
    8 "Everyday"
    /
 S4681700
    1 "Never"
    2 "Once or twice"
    3 "Less than once a month"
    4 "About once a month"
    5 "About twice a month"
    6 "About once a week"
    7 "Several times a week"
    8 "Everyday"
    /
 S6316700
    1 "Never"
    2 "Once or twice"
    3 "Less than once a month"
    4 "About once a month"
    5 "About twice a month"
    6 "About once a week"
    7 "Several times a week"
    8 "Everyday"
    /
 S8331500
    1 "Never"
    2 "Once or twice"
    3 "Less than once a month"
    4 "About once a month"
    5 "About twice a month"
    6 "About once a week"
    7 "Several times a week"
    8 "Everyday"
    /
 T0739400
    1 "Never"
    2 "Once or twice"
    3 "Less than once a month"
    4 "About once a month"
    5 "About twice a month"
    6 "About once a week"
    7 "Several times a week"
    8 "Everyday"
    /
 T2781700
    1 "Never"
    2 "Once or twice"
    3 "Less than once a month"
    4 "About once a month"
    5 "About twice a month"
    6 "About once a week"
    7 "Several times a week"
    8 "Everyday"
    /
 T4495000
    1 "Never"
    2 "Once or twice"
    3 "Less than once a month"
    4 "About once a month"
    5 "About twice a month"
    6 "About once a week"
    7 "Several times a week"
    8 "Everyday"
    /
 T6143400
    1 "Never"
    2 "Once or twice"
    3 "Less than once a month"
    4 "About once a month"
    5 "About twice a month"
    6 "About once a week"
    7 "Several times a week"
    8 "Everyday"
    /
 T7637300
    1 "Never"
    2 "Once or twice"
    3 "Less than once a month"
    4 "About once a month"
    5 "About twice a month"
    6 "About once a week"
    7 "Several times a week"
    8 "Everyday"
    /
.
/* Crosswalk for Reference number & Question name
 * Uncomment and edit this RENAME VARIABLES statement to rename variables for ease of use.
 * This command does not guarantee uniqueness
 */  /* *start* */

* RENAME VARIABLES
  (R0000100 = PUBID_1997) 
  (R0536300 = KEY_SEX_1997)   /* KEY!SEX */
  (R0536401 = KEY_BDATE_M_1997)   /* KEY!BDATE_M */
  (R0536402 = KEY_BDATE_Y_1997)   /* KEY!BDATE_Y */
  (R1482600 = KEY_RACE_ETHNICITY_1997)   /* KEY!RACE_ETHNICITY */
  (R4893400 = YSAQ_282A_2000)   /* YSAQ-282A */
  (R6520100 = YSAQ_282A_2001)   /* YSAQ-282A */
  (S0919300 = YSAQ_282A_2002)   /* YSAQ-282A */
  (S2987800 = YSAQ_282A_2003)   /* YSAQ-282A */
  (S4681700 = YSAQ_282A_2004)   /* YSAQ-282A */
  (S6316700 = YSAQ_282A_2005)   /* YSAQ-282A */
  (S8331500 = YSAQ_282A_2006)   /* YSAQ-282A */
  (T0739400 = YSAQ_282A_2007)   /* YSAQ-282A */
  (T2781700 = YSAQ_282A_2008)   /* YSAQ-282A */
  (T4495000 = YSAQ_282A_2009)   /* YSAQ-282A */
  (T6143400 = YSAQ_282A_2010)   /* YSAQ-282A */
  (T7637300 = YSAQ_282A_2011)   /* YSAQ-282A */
.
  /* *end* */

descriptives all.

*--- Tabulations using reference number variables;
*freq var=R0000100, 
  R0536300, 
  R0536401, 
  R0536402, 
  R1482600, 
  R4893400, 
  R6520100, 
  S0919300, 
  S2987800, 
  S4681700, 
  S6316700, 
  S8331500, 
  T0739400, 
  T2781700, 
  T4495000, 
  T6143400, 
  T7637300.

*--- Tabulations using qname variables;
*freq var=PUBID_1997, 
  KEY_SEX_1997, 
  KEY_BDATE_M_1997, 
  KEY_BDATE_Y_1997, 
  KEY_RACE_ETHNICITY_1997, 
  YSAQ_282A_2000, 
  YSAQ_282A_2001, 
  YSAQ_282A_2002, 
  YSAQ_282A_2003, 
  YSAQ_282A_2004, 
  YSAQ_282A_2005, 
  YSAQ_282A_2006, 
  YSAQ_282A_2007, 
  YSAQ_282A_2008, 
  YSAQ_282A_2009, 
  YSAQ_282A_2010, 
  YSAQ_282A_2011.
