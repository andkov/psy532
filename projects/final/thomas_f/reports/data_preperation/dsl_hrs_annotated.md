# Data preperation for final report - Thomas Ferguson
<!-- for more options study http://rmarkdown.rstudio.com/html_document_format.html  -->
<!-- The report is produced from
REPOSITORY: Finalproject
BRANCH: the-name-of-the-branch
PATH: ../Reports/
-->

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->


<!-- Set the report-wide options, and point to the external script file. -->


To load desired packages

```r
library(reshape2)
library(knitr)
library(dplyr) # for data manipulation
library(ggplot2) # for graphing
library(extrafont) # for main_theme
library(leaps) #for modeling
library(gam) 
```


```r
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/main_theme.R")
```

Find file path for data


Set file path for data

```r
# ds <- Hmisc::spss.get(filePath, use.value.labels = TRUE)
# saveRDS(ds, "./data/hrs/hrs_retirement.rds")
ds.prime<- readRDS("./data/raw/hrs_retirement.rds")
# ds <- readRDS("https://github.com/andkov/psy532/raw/master/data/hrs/hrs_retirement.rds")
# as.data.frame(table(ds.prime$wave)) #for wave selection, to see which group had the largest n
```

Examine data and select wave (describes what portion of sample...) - done because of file size

```r
names(ds.prime)
```

```
 [1] "hhidpn"   "wave"     "hacohort" "ragender" "rahispan" "raracem"  "rabmonth" "rabyear"  "radyear"  "raedyrs" 
[11] "wtresp"   "rahrsamp" "shlt"     "shltc"    "hltc"     "cesd"     "bmi"      "smokev"   "smoken"   "drink"   
[21] "hibp"     "diab"     "cancr"    "lung"     "heart"    "strok"    "psych"    "arthr"    "conde"    "r1adlww" 
[31] "r1iadlww" "adla"     "r1adlw"   "iadla"    "r2adlr10" "mstot2a"  "inpova"   "sayret"   "retemp"   "lbrf"    
[41] "jcocc"    "inlbrf"   "iyear"    "retdat"   "agey"     "cogtot"   "mstot"    "vigact"   "numb"     "biyear"  
[51] "bagey"    "blbrf"    "bcogtot"  "retire"   "oret"     "tret"     "wavey"    "cogsc"    "cogslope"
```

```r
ds <- ds.prime[ds.prime$wave==10, ] # keep only wave 10, to reduce ds size and make more managable (choose other value?)
distinct(dplyr::select(ds, hhidpn)) %>% count()
```

```
Source: local data frame [1 x 1]

      n
  (int)
1 20337
```

```r
# length(unique(ds[ , "hhidpn"]))
# psych::describe(ds)
# head(ds)
columnnames <- read.csv("./data/raw/hrs_column_names.csv",sep="\t")
# View(columnnames)
```


```r
# @kntir basic_table ---------------------------------------
#Variables of interest - BMI as Y, Potential X's are -- rabyear, ragender, wtresp, raedyrs, shlt, cesd, smoken, drink, hibp, inpova, agey, cogtot, mstot, vigact, tret, conde, hacort (?)
# pairs(ds$bmi ~ ds$wtresp + ds$agey + ds$conde + ds$cogtot + ds$mstot + ds$raedyrs + ds$cesd + ds$shlt + ds$ragender + ds$raracem + ds$tret) #may need to change
#Note: that conde, cogtot, mstot, wtresp, tret, cesd, shlt and ragender may be linear
#Var's that appear to be related to BMI - hard to tell, most of them do seem related, no reason to exclude 

#Plots of these variables - note move this after model selection stuff? May want to...
summary(ds) #pretty good, see if you can clean it up...
```

```
     hhidpn               wave                   hacohort        ragender                rahispan    
 Min.   :     3010   Min.   :10   0.hrs/ahead ovrlap :  38   1.male  : 8791   0. not hispanic:17677  
 1st Qu.: 56274040   1st Qu.:10   1.ahead            :1253   2.female:11546   1. hispanic    : 2636  
 Median :202628020   Median :10   2.coda             :1178                    NA's           :   24  
 Mean   :306713930   Mean   :10   3.hrs              :7695                                           
 3rd Qu.:521444010   3rd Qu.:10   4.warbabies        :2068                                           
 Max.   :959738010   Max.   :10   5.early babyboomers:3979                                           
                                  6.mid babyboomers  :4126                                           
                     raracem         rabmonth         rabyear        radyear         raedyrs          wtresp     
 1.white/caucasian       :14777   Min.   : 1.000   Min.   :1901   Min.   :2010    Min.   : 0.00   Min.   :  437  
 2.black/african american: 3908   1st Qu.: 4.000   1st Qu.:1935   1st Qu.:2011    1st Qu.:12.00   1st Qu.: 2040  
 3.other                 : 1604   Median : 7.000   Median :1944   Median :2011    Median :12.00   Median : 3670  
 NA's                    :   48   Mean   : 6.594   Mean   :1943   Mean   :2011    Mean   :12.61   Mean   : 4663  
                                  3rd Qu.:10.000   3rd Qu.:1953   3rd Qu.:2012    3rd Qu.:15.00   3rd Qu.: 5887  
                                  Max.   :12.000   Max.   :1959   Max.   :2013    Max.   :18.00   Max.   :19408  
                                                                  NA's   :19526   NA's   :93                     
                           rahrsamp               shlt          shltc                        hltc           cesd      
 0.not in sample               :14814   1. excellent:1998   Min.   :-4.000   1. much better    :   0   Min.   :0.000  
 1.in samp,hrs92 resp b.1931-41: 5523   2. very good:5989   1st Qu.: 0.000   2. somewhat better:1472   1st Qu.:0.000  
                                        3. good     :6423   Median : 0.000   3. same           :9301   Median :1.000  
                                        4. fair     :4272   Mean   : 0.024   4. somewhat worse :4068   Mean   :1.511  
                                        5. poor     :1646   3rd Qu.: 0.000   5. much worse     :   0   3rd Qu.:2.000  
                                        NA's        :   9   Max.   : 4.000   NA's              :5496   Max.   :8.000  
                                                            NA's   :5482                               NA's   :1010   
      bmi           smokev        smoken        drink                                     hibp      
 Min.   : 7.00   0. no : 8773   0.no :17173   0.no : 8936   1. yes                          :12156  
 1st Qu.:24.40   1. yes:11480   1.yes: 3077   1.yes:11399   0. no                           : 8151  
 Median :27.50   NA's  :   84   NA's :   87   NA's :    2   2. tia/possible stroke          :    0  
 Mean   :28.51                                              3. disp prev record and has cond:    0  
 3rd Qu.:31.60                                              4. disp prev record and no cond :    0  
 Max.   :79.10                                              (Other)                         :    0  
 NA's   :379                                                NA's                            :   30  
                               diab                                    cancr      
 0. no                           :15598   0. no                           :17429  
 1. yes                          : 4725   1. yes                          : 2890  
 2. tia/possible stroke          :    0   2. tia/possible stroke          :    0  
 3. disp prev record and has cond:    0   3. disp prev record and has cond:    0  
 4. disp prev record and no cond :    0   4. disp prev record and no cond :    0  
 (Other)                         :    0   (Other)                         :    0  
 NA's                            :   14   NA's                            :   18  
                               lung                                    heart      
 0. no                           :18247   0. no                           :15521  
 1. yes                          : 2076   1. yes                          : 4799  
 2. tia/possible stroke          :    0   2. tia/possible stroke          :    0  
 3. disp prev record and has cond:    0   3. disp prev record and has cond:    0  
 4. disp prev record and no cond :    0   4. disp prev record and no cond :    0  
 (Other)                         :    0   (Other)                         :    0  
 NA's                            :   14   NA's                            :   17  
                              strok                                    psych      
 0. no                           :18865   0. no                           :16710  
 1. yes                          : 1346   1. yes                          : 3599  
 2. tia/possible stroke          :  115   2. tia/possible stroke          :    0  
 3. disp prev record and has cond:    0   3. disp prev record and has cond:    0  
 4. disp prev record and no cond :    0   4. disp prev record and no cond :    0  
 (Other)                         :    0   (Other)                         :    0  
 NA's                            :   11   NA's                            :   28  
                              arthr           conde          r1adlww         r1iadlww          adla       
 1. yes                          :11433   Min.   :0.000   Min.   :0.000   Min.   :0.000   Min.   :0.0000  
 0. no                           : 8874   1st Qu.:1.000   1st Qu.:0.000   1st Qu.:0.000   1st Qu.:0.0000  
 2. tia/possible stroke          :    0   Median :2.000   Median :0.000   Median :0.000   Median :0.0000  
 3. disp prev record and has cond:    0   Mean   :2.109   Mean   :0.045   Mean   :0.497   Mean   :0.3537  
 4. disp prev record and no cond :    0   3rd Qu.:3.000   3rd Qu.:0.000   3rd Qu.:1.000   3rd Qu.:0.0000  
 (Other)                         :    0   Max.   :8.000   Max.   :3.000   Max.   :3.000   Max.   :5.0000  
 NA's                            :   30   NA's   :3       NA's   :13243   NA's   :13287   NA's   :111     
     r1adlw          iadla           r2adlr10         mstot2a                            inpova     
 Min.   :0.000   Min.   :0.0000   Min.   : 0.000   Min.   : 2.00   0.hh inc above pov thresh:17747  
 1st Qu.:0.000   1st Qu.:0.0000   1st Qu.: 3.000   1st Qu.:12.00   1.hh inc below pov thresh: 2590  
 Median :0.000   Median :0.0000   Median : 4.000   Median :14.00                                    
 Mean   :0.118   Mean   :0.1587   Mean   : 4.302   Mean   :12.99                                    
 3rd Qu.:0.000   3rd Qu.:0.0000   3rd Qu.: 6.000   3rd Qu.:15.00                                    
 Max.   :5.000   Max.   :3.0000   Max.   :10.000   Max.   :15.00                                    
 NA's   :13242   NA's   :119      NA's   :19168    NA's   :19168                                    
                   sayret                             retemp                 lbrf     
 0.not ret            :7208   0.no retire empstat        :11283   1.works ft   :5339  
 1.completely retired :9055   1.only retire empstat      : 7498   2.works pt   :1195  
 2.partly retired     :2426   2.retire plus other empstat: 1384   3.unemployed : 798  
 3.question irrelevant: 926   NA's                       :  172   4.partly ret :1486  
 NA's                 : 722                                       5.retired    :9902  
                                                                  6.disabled   : 540  
                                                                  7.not in lbrf:1077  
                            jcocc         inlbrf          iyear          retdat           agey            cogtot     
 02.prof specialty opr/tech sup:  589   0:no :11349   Min.   :2010   Min.   :1943    Min.   : 50.33   Min.   : 0.00  
 04.clerical/admin supp        :  435   1:yes: 8818   1st Qu.:2011   1st Qu.:1995    1st Qu.: 57.25   1st Qu.:19.00  
 01.managerial specialty oper  :  382   NA's :  170   Median :2011   Median :2002    Median : 65.75   Median :22.00  
 03.sales                      :  302                 Mean   :2011   Mean   :2000    Mean   : 66.90   Mean   :21.55  
 09.personal svc               :  180                 3rd Qu.:2011   3rd Qu.:2007    3rd Qu.: 74.92   3rd Qu.:25.00  
 (Other)                       :  718                 Max.   :2012   Max.   :2012    Max.   :109.00   Max.   :35.00  
 NA's                          :17731                                NA's   :11654                    NA's   :5370   
     mstot           vigact           numb            biyear         bagey           blbrf          bcogtot     
 Min.   : 0.00   Min.   : NA     Min.   : 1.000   Min.   :1992   Min.   :36.92   Min.   :1.000   Min.   : 4.00  
 1st Qu.:11.00   1st Qu.: NA     1st Qu.: 1.000   1st Qu.:1993   1st Qu.:52.92   1st Qu.:1.000   1st Qu.:20.00  
 Median :13.00   Median : NA     Median : 7.000   Median :1999   Median :55.25   Median :1.000   Median :24.00  
 Mean   :12.29   Mean   :NaN     Mean   : 5.446   Mean   :2001   Mean   :57.54   Mean   :2.771   Mean   :23.19  
 3rd Qu.:14.00   3rd Qu.: NA     3rd Qu.: 9.000   3rd Qu.:2010   3rd Qu.:59.17   3rd Qu.:5.000   3rd Qu.:26.00  
 Max.   :15.00   Max.   : NA     Max.   :10.000   Max.   :2012   Max.   :93.50   Max.   :7.000   Max.   :35.00  
 NA's   :5370    NA's   :20337                                                   NA's   :219     NA's   :9098   
     retire            oret           tret             wavey            cogsc           cogslope      
 Min.   :0.0000   Min.   :1936   Min.   :-74.661   Min.   : 0.000   Min.   : 1.823   Min.   :-0.9870  
 1st Qu.:0.0000   1st Qu.:1995   1st Qu.:-15.747   1st Qu.: 0.000   1st Qu.:19.717   1st Qu.:-0.2908  
 Median :0.0000   Median :2002   Median : -8.911   Median :11.750   Median :22.249   Median :-0.2508  
 Mean   :0.4405   Mean   :2000   Mean   :-10.621   Mean   : 9.368   Mean   :21.721   Mean   :-0.2474  
 3rd Qu.:1.0000   3rd Qu.:2008   3rd Qu.: -3.081   3rd Qu.:17.667   3rd Qu.:24.290   3rd Qu.:-0.1961  
 Max.   :1.0000   Max.   :2013   Max.   :  2.672   Max.   :19.083   Max.   :32.389   Max.   : 0.3368  
 NA's   :172      NA's   :8114   NA's   :8114                       NA's   :1858     NA's   :2293     
```

```r
# dev.off() #use when invalid graphics

# plot1 <- ggplot2::ggplot(data=ds, aes(x=conde, y=bmi, color=shlt, shape=20)) + geom_point() +scale_shape_identity()+ geom_jitter()+ main_theme
#ds$bmi2 <- round(ds$bmi/5)*5 #due to having so many data points
# ds$conde2 <- round(ds$conde/5)*5

#May want to remove
plot1 <- ggplot2::ggplot(data=ds, aes(x=conde, y=bmi)) + 
  scale_shape_identity()+ 
#   geom_jitter(color="forestgreen", shape=21, alpha=.5)+ 
  geom_jitter(aes(color=smokev), shape=21, alpha=.5)+ 
#   scale_color_manual(values=c("forestgreen"))+  
  main_theme + 
#   theme(legend.position="none") +
  labs(color="Smoke")
plot1 
```

![](figure_rmd/tweak_data-1.png) 

```r
#May want to keep
#Conde plot
plot1 <- ggplot2::ggplot(data=ds, aes(x=conde, y=bmi)) + 
  scale_shape_identity()+ 
     geom_jitter(color="forestgreen", shape=21, alpha=.5)+ 
  main_theme + 
    theme(legend.position="none") +
   labs(xlab("Number of Chronic Health Conditions"), ylab ="BMI")
plot1 
```

![](figure_rmd/tweak_data-2.png) 

```r
#Age Plot
plot2 <- ggplot2::ggplot(data=ds, aes(x=agey, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="red", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Age (years)"), ylab ="BMI")
plot2 
```

![](figure_rmd/tweak_data-3.png) 

```r
#Education Plot
plot3 <- ggplot2::ggplot(data=ds, aes(x=raedyrs, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="brown", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Education (years)"), ylab ="BMI")
plot3 
```

![](figure_rmd/tweak_data-4.png) 

```r
#Cogtot Plot
plot4 <- ggplot2::ggplot(data=ds, aes(x=cogtot, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="blue", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Cognition"), ylab ="BMI")
plot4 
```

![](figure_rmd/tweak_data-5.png) 

```r
#MsTot Plot
plot5 <- ggplot2::ggplot(data=ds, aes(x=mstot, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="orange", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Mental Status (score)"), ylab ="BMI")
plot5 
```

![](figure_rmd/tweak_data-6.png) 

```r
#Depressive Symptoms
plot6 <- ggplot2::ggplot(data=ds, aes(x=cesd, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="purple", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Depressive Symptoms"), ylab ="BMI")
plot6 
```

![](figure_rmd/tweak_data-7.png) 

```r
#Self-rated Health Score
plot7 <- ggplot2::ggplot(data=ds, aes(x=shlt, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="deeppink", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Self-rated Health Score"), ylab ="BMI")
plot7 
```

![](figure_rmd/tweak_data-8.png) 

```r
#Change in Self-rated Health Score
plot12 <- ggplot2::ggplot(data=ds, aes(x=smokev, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="navyblue", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Change in Self-rated Health Score"), ylab ="BMI")
plot12 
```

![](figure_rmd/tweak_data-9.png) 

```r
#Gender
plot8 <- ggplot2::ggplot(data=ds, aes(x=ragender, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="lightgreen", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Gender (1=male, 2=female)"), ylab ="BMI")
plot8 
```

![](figure_rmd/tweak_data-10.png) 

```r
#Race
plot9 <- ggplot2::ggplot(data=ds, aes(x=raracem, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="black", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Race (1=White, 2=Black, 3=Other"), ylab ="BMI")
plot9
```

![](figure_rmd/tweak_data-11.png) 

```r
#Drink
plot10 <- ggplot2::ggplot(data=ds, aes(x=drink, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="cornflowerblue", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Ever Drink"), ylab ="BMI")
plot10 
```

![](figure_rmd/tweak_data-12.png) 

```r
#Smoke
plot11 <- ggplot2::ggplot(data=ds, aes(x=smokev, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="cyan2", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Ever Smoke"), ylab ="BMI")
plot11 
```

![](figure_rmd/tweak_data-13.png) 

Inspect data and examine relationships between data



```r
# with $
a <- ds$bmi # extracts column "bmi" from dataset "ds0"
class(a)
```

```
[1] "numeric"
```

```r
str(a)
```

```
 num [1:20337] 24 25.7 21.3 34.4 29.3 ...
```

Create vector  containing only variables of interest to BMI
#These variables are 

```r
# Manually create the vector that contains the names of the variables you would like to keep. 
selectVars <- c("hhidpn", "bmi", "conde",  "agey", "cogtot", "mstot", "raedyrs", "cesd", "shlt", "ragender", "raracem", "smokev", "drink", "wtresp", "shltc")
ds2 <- ds[,selectVars]
```




```r
ds3 <- mutate(ds2, shltnum = substring(shlt, 1, 1)) #change the \\D command
```


```r
ds4 <- dplyr::mutate(ds3, gendernum = substring(ragender, 1, 1)) #decide if needed...
```


```r
ds5 <- dplyr::mutate(ds4, racenum = substring(raracem, 1, 1))
```


```r
ds6 <- dplyr::mutate(ds5, smokenum = substring(smokev, 1, 1))
```


```r
ds7 <- dplyr::mutate(ds6, drinknum = substring(drink, 1, 1))
```


```r
# Removes columns of redundant information - e.g. shlt -- turned into numbers rather than individual categories, find out if ok... 
ds8 <- select(ds7, -shlt) 
ds9 <- select(ds8, -ragender) 
ds10 <- select(ds9, -raracem)
ds11 <- select(ds10, -smokev)
ds12 <- select(ds11, -drink)
```

Load graph settings for creating figures

```r
# load themes used to style graphs
source("./scripts/graphs/graph_themes.R")

#table settings
```

Use GAM or Stepwise selection to select best model - Variables chosen are age in years, number of health conditions, eduction in years and self-rated health score

```r
#variables used - bmi + rabyear + wtresp+ + shlt + cesd+ conde+ agey+ cogtot+ mstot+ vigact + smokev + drink + shltc
#full
regft.full <- regsubsets(ds12$bmi~., data = ds12, nvmax=18)
summary(regft.full)
```

```
Subset selection object
Call: regsubsets.formula(ds12$bmi ~ ., data = ds12, nvmax = 18)
18 Variables  (and intercept)
           Forced in Forced out
hhidpn         FALSE      FALSE
conde          FALSE      FALSE
agey           FALSE      FALSE
cogtot         FALSE      FALSE
mstot          FALSE      FALSE
raedyrs        FALSE      FALSE
cesd           FALSE      FALSE
wtresp         FALSE      FALSE
shltc          FALSE      FALSE
shltnum2       FALSE      FALSE
shltnum3       FALSE      FALSE
shltnum4       FALSE      FALSE
shltnum5       FALSE      FALSE
gendernum2     FALSE      FALSE
racenum2       FALSE      FALSE
racenum3       FALSE      FALSE
smokenum1      FALSE      FALSE
drinknum1      FALSE      FALSE
1 subsets of each size up to 18
Selection Algorithm: exhaustive
          hhidpn conde agey cogtot mstot raedyrs cesd wtresp shltc shltnum2 shltnum3 shltnum4 shltnum5 gendernum2
1  ( 1 )  " "    " "   "*"  " "    " "   " "     " "  " "    " "   " "      " "      " "      " "      " "       
2  ( 1 )  " "    "*"   "*"  " "    " "   " "     " "  " "    " "   " "      " "      " "      " "      " "       
3  ( 1 )  " "    "*"   "*"  " "    " "   " "     " "  " "    " "   " "      " "      " "      " "      " "       
4  ( 1 )  " "    "*"   "*"  " "    " "   "*"     " "  " "    " "   " "      " "      " "      " "      " "       
5  ( 1 )  " "    "*"   "*"  "*"    " "   "*"     " "  " "    " "   " "      " "      " "      " "      " "       
6  ( 1 )  " "    "*"   "*"  "*"    " "   "*"     " "  " "    " "   " "      " "      " "      " "      " "       
7  ( 1 )  " "    "*"   "*"  "*"    " "   "*"     " "  " "    " "   " "      " "      " "      " "      "*"       
8  ( 1 )  " "    "*"   "*"  "*"    " "   "*"     " "  " "    " "   " "      " "      "*"      " "      "*"       
9  ( 1 )  " "    "*"   "*"  "*"    " "   "*"     " "  " "    " "   " "      "*"      "*"      " "      "*"       
10  ( 1 ) " "    "*"   "*"  "*"    " "   "*"     " "  " "    " "   "*"      "*"      "*"      " "      "*"       
11  ( 1 ) " "    "*"   "*"  "*"    " "   "*"     " "  " "    " "   "*"      "*"      "*"      "*"      "*"       
12  ( 1 ) " "    "*"   "*"  "*"    " "   "*"     " "  " "    "*"   "*"      "*"      "*"      "*"      "*"       
13  ( 1 ) " "    "*"   "*"  "*"    " "   "*"     " "  " "    "*"   "*"      "*"      "*"      "*"      "*"       
14  ( 1 ) " "    "*"   "*"  "*"    "*"   "*"     " "  " "    "*"   "*"      "*"      "*"      "*"      "*"       
15  ( 1 ) " "    "*"   "*"  "*"    "*"   "*"     " "  " "    "*"   "*"      "*"      "*"      "*"      "*"       
16  ( 1 ) "*"    "*"   "*"  "*"    "*"   "*"     " "  " "    "*"   "*"      "*"      "*"      "*"      "*"       
17  ( 1 ) "*"    "*"   "*"  "*"    "*"   "*"     "*"  " "    "*"   "*"      "*"      "*"      "*"      "*"       
18  ( 1 ) "*"    "*"   "*"  "*"    "*"   "*"     "*"  "*"    "*"   "*"      "*"      "*"      "*"      "*"       
          racenum2 racenum3 smokenum1 drinknum1
1  ( 1 )  " "      " "      " "       " "      
2  ( 1 )  " "      " "      " "       " "      
3  ( 1 )  "*"      " "      " "       " "      
4  ( 1 )  "*"      " "      " "       " "      
5  ( 1 )  "*"      " "      " "       " "      
6  ( 1 )  "*"      " "      " "       "*"      
7  ( 1 )  "*"      " "      " "       "*"      
8  ( 1 )  "*"      " "      " "       "*"      
9  ( 1 )  "*"      " "      " "       "*"      
10  ( 1 ) "*"      " "      " "       "*"      
11  ( 1 ) "*"      " "      " "       "*"      
12  ( 1 ) "*"      " "      " "       "*"      
13  ( 1 ) "*"      " "      "*"       "*"      
14  ( 1 ) "*"      " "      "*"       "*"      
15  ( 1 ) "*"      "*"      "*"       "*"      
16  ( 1 ) "*"      "*"      "*"       "*"      
17  ( 1 ) "*"      "*"      "*"       "*"      
18  ( 1 ) "*"      "*"      "*"       "*"      
```

```r
#Var's of interest - agey, conde,racenum2 (african-american), drinknum1 (yes), cogtot, raedyrs, shltnum4, smokenum1 (yes)
names(regft.full)
```

```
 [1] "np"        "nrbar"     "d"         "rbar"      "thetab"    "first"     "last"      "vorder"    "tol"      
[10] "rss"       "bound"     "nvmax"     "ress"      "ir"        "nbest"     "lopt"      "il"        "ier"      
[19] "xnames"    "method"    "force.in"  "force.out" "sserr"     "intercept" "lindep"    "nullrss"   "nn"       
[28] "call"     
```

```r
coef(regft.full,18) 
```

```
  (Intercept)        hhidpn         conde          agey        cogtot         mstot       raedyrs          cesd 
 3.881552e+01  5.646507e-10  8.072686e-01 -1.895553e-01  7.727136e-02  3.974560e-02 -1.310662e-01 -1.657343e-02 
       wtresp         shltc      shltnum2      shltnum3      shltnum4      shltnum5    gendernum2      racenum2 
-2.101632e-06 -2.685605e-01  9.923701e-01  1.354036e+00  1.710996e+00  1.421305e+00 -5.128229e-01  1.171970e+00 
     racenum3     smokenum1     drinknum1 
-2.648775e-01 -2.680000e-01 -4.866865e-01 
```

```r
#coefficiants say...

regfull.sum <- summary(regft.full)
names(regfull.sum)
```

```
[1] "which"  "rsq"    "rss"    "adjr2"  "cp"     "bic"    "outmat" "obj"   
```

```r
par(mfrow=c(2,2))
rsq <-regfull.sum$rsq
plot(rsq,col="purple",xlab= "Num of Vars",ylab="R-Squared",  pch=19, type="l")
which.min(rsq)
```

```
[1] 1
```

```r
points(1, rsq[1], pch=4, col="black", lwd=5)

rss <- regfull.sum$rss
plot(rss,col="purple",xlab= "Num of Vars",ylab="RSS" , pch=19)
lines(rss, col="red",lty=2, lwd=1)
which.min(rss)
```

```
[1] 18
```

```r
points(18, rss[18], pch=4, col="black", lwd=5)

cp <- regfull.sum$cp
plot(cp,col="purple",xlab= "Num of Vars",ylab="Cp", pch=19 )
lines(cp, col="red",lty=2, lwd=1)
which.min(cp)
```

```
[1] 13
```

```r
points(13, cp[13], pch=4, col="black", lwd=5)

bic <- regfull.sum$bic
plot(bic,col="purple",xlab= "Num of Vars",ylab="BIC" , pch=19)
lines(bic, col="red",lty=2,lwd=1)
which.min(bic)
```

```
[1] 12
```

```r
points(12, bic[12], pch=4, col="black", lwd=5)
```

![](figure_rmd/model_selection-1.png) 

```r
#12 or 13 variable model is what best subset says

#cross-validation -why doesn't it work
# set.seed(1)
# train <- sample(c(TRUE,FALSE), nrow(ds10), rep=TRUE)
# test <- (!train)
# 
# regft.best <- regsubsets(bmi~.,data=ds10[train,],nvmax=12)
# test.mat <- model.matrix(bmi~.,data=ds10[test,])
# 
# val.errors = rep(NA,12)
# for (i in 1:12){
#   +   coefi=coef(regft.best, id=i)
#   +   pred=test.mat[,names(coefi)]%*%coefi
#   +   val.error[i]=mean((ds10$bmi[test]-pred)^2)
# }
# 
# #second try...
# pred.regsubsets = function(object,newdata,id,...){
#   + form=as.formula(object$call[[2]])
#   + mat=model.matrix(form,newdata)
#   + coefi=coef(object,id=id)
#   + xvars=names(coefi)
#   + mat[,xvars]%*%coefi
# }
# 
# regft.best <- regsubsets(bmi~.,data=ds10,nvmax=12)
# coef(regfit.best,10)
# 
# k =10
# set.seed(1)
# folds = sample(1:k, nrow(ds10), replace=TRUE)
# cv.errors = matrix(NA,k,12,dimnames=list(NULL, paste(1:12)))
# 
# for (j in 1:k){
#   + best.fit = regsubsets(bmi~.,data=ds10[folds!=j,], nvmax=12)
#     + for(i in 1:12){
#       +pred = predict(best.fit,ds10[folds==j,],id=i)
#       + cv.errors[j,i]=mean( (ds10$bmi[folds==j]-pred)^2)
#     }
# }
# 
# mean.cv.errors = apply(cv.errors,2,mean)
# mean.cv.errors
# kable(summary(out)$coef, digits=2) #to make table for models!!! can have summary and what not...all that jazz
#i.e. make summary tables

#look at univariate models for the significant variables - they are: 
```

Create figures for modeling

```r
# d <- ds2 %>% dplyr::select(hhidpn, bmi, agey, conde, raedyrs, raracem, drink, cogtot, ragender) #this needs to be updated...
# head(d)
# str(d$bmi) #what does this do...?
# summary(ds2$bmi) #may want to remove
# names(ds2)

#Omit Na's from data
ds12a <- na.omit(ds12)
ds7a <- na.omit(ds7)

#these could possibly be called from above?


#Conde (by race) Graph - ideal one...
plot.1 <- ggplot2::ggplot(data=ds7a, aes(x=conde, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(xlab="Number of chronic Health Conditions")+
  guides(fill=guide_legend(title="Race"))
plot.1a <- plot.1 +  facet_grid(. ~ raracem) #may want to take this out....
plot.1a
```

![](figure_rmd/add_models_smoothers-1.png) 

```r
#age (by race) Graph
plot.2 <- ggplot2::ggplot(data=ds7a, aes(x=agey, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Race"))
plot.2
```

![](figure_rmd/add_models_smoothers-2.png) 

```r
plot.2 +  facet_grid(. ~ raracem) #may want to take this out....
```

![](figure_rmd/add_models_smoothers-3.png) 

```r
#cogtot by race 
plot.3 <- ggplot2::ggplot(data=ds7a, aes(x=cogtot, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Race"))
plot.3
```

![](figure_rmd/add_models_smoothers-4.png) 

```r
plot.3 +  facet_grid(. ~ raracem) #may want to take this out....
```

![](figure_rmd/add_models_smoothers-5.png) 

```r
#education in years by race
plot.4 <- ggplot2::ggplot(data=ds7a, aes(x=raedyrs, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Race"))
plot.4
```

![](figure_rmd/add_models_smoothers-6.png) 

```r
plot.4 +  facet_grid(. ~ raracem) #may want to take this out....
```

![](figure_rmd/add_models_smoothers-7.png) 

```r
#Conde (by drinks).
plot.5 <- ggplot2::ggplot(data=ds7a, aes(x=conde, y=bmi, fill=drink)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("lightgreen", "indianred"))+
  # labs(xlab="Number of chronic Health Conditions")+
  guides(fill=guide_legend(title="Drink"))
plot.5
```

![](figure_rmd/add_models_smoothers-8.png) 

```r
plot.5 +  facet_grid(. ~ drink) #may want to take this out....
```

![](figure_rmd/add_models_smoothers-9.png) 

```r
#age by if drinks
plot.6 <- ggplot2::ggplot(data=ds7a, aes(x=agey, y=bmi, fill=drink)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("lightgreen", "indianred"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Drink"))
plot.6
```

![](figure_rmd/add_models_smoothers-10.png) 

```r
plot.6 +  facet_grid(. ~ drink) #may want to take this out....
```

![](figure_rmd/add_models_smoothers-11.png) 

```r
#cogtot by if drinks
plot.7 <- ggplot2::ggplot(data=ds7a, aes(x=cogtot, y=bmi, fill=drink)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("lightgreen", "indianred"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Drink"))
plot.7
```

![](figure_rmd/add_models_smoothers-12.png) 

```r
plot.7 +  facet_grid(. ~ drink) #may want to take this out....
```

![](figure_rmd/add_models_smoothers-13.png) 

```r
#education in years by if drinks
plot.8 <- ggplot2::ggplot(data=ds7a, aes(x=raedyrs, y=bmi, fill=drink)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("lightgreen", "indianred"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Drink"))
plot.8
```

![](figure_rmd/add_models_smoothers-14.png) 

```r
plot.8 +  facet_grid(. ~ drink) #may want to take this out....
```

![](figure_rmd/add_models_smoothers-15.png) 

```r
#Gender

#Conde (by gender) Graph - ideal one...
plot.9 <- ggplot2::ggplot(data=ds7a, aes(x=conde, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(xlab="Number of chronic Health Conditions")+
  guides(fill=guide_legend(title="Gender"))
plot.9
```

![](figure_rmd/add_models_smoothers-16.png) 

```r
plot.9 +  facet_grid(. ~ ragender) #may want to take this out....
```

![](figure_rmd/add_models_smoothers-17.png) 

```r
#age (by gender Graph
plot.10 <- ggplot2::ggplot(data=ds7a, aes(x=agey, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Gender"))
plot.10
```

![](figure_rmd/add_models_smoothers-18.png) 

```r
plot.10 +  facet_grid(. ~ ragender) #may want to take this out....
```

![](figure_rmd/add_models_smoothers-19.png) 

```r
#cogtot by gender
plot.11 <- ggplot2::ggplot(data=ds7a, aes(x=cogtot, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Gender"))
plot.11
```

![](figure_rmd/add_models_smoothers-20.png) 

```r
plot.11 +  facet_grid(. ~ ragender) #may want to take this out....
```

![](figure_rmd/add_models_smoothers-21.png) 

```r
#education in years by gender
plot.12 <- ggplot2::ggplot(data=ds7a, aes(x=raedyrs, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Gender"))
plot.12
```

![](figure_rmd/add_models_smoothers-22.png) 

```r
plot.12 +  facet_grid(. ~ ragender) #may want to take this out....
```

![](figure_rmd/add_models_smoothers-23.png) 

Creates prediction function for models

```r
#Original Model from hrs starter, bmi not of interest - note:delete/modify 
# See Chang (2013), section 5.7
# See psy532-Issue-15: https://github.com/andkov/psy532/issues/15
# Given a model, predict values of yvar from xvar
# This supports one predictor and one predicted variable
# xrange: If NULL, determine the x range from the model object. If a vector with
# two numbers, use those as the min and max of the prediction range.
# samples: Number of samples across the x range.
# ...: Further arguments to be passed to predict()
predictvals <- function(model, xvar, yvar, xrange=NULL, samples=100, ...) {
  # If xrange isn't passed in, determine xrange from the models.
  # Different ways of extracting the x range, depending on model type
  if (is.null(xrange)) {
    if (any(class(model) %in% c("lm", "glm")))
      xrange <- range(model$model[[xvar]])
    else if (any(class(model) %in% "loess")) #may need to change loess to GAM
      xrange <- range(model$x)
  }
  newdata <- data.frame(x = seq(xrange[1], xrange[2], length.out = samples))
  names(newdata) <- xvar
  newdata[[yvar]] <- predict(model, newdata = newdata, ...)
  newdata
}
```

Creates models of variables of interest

```r
#to omit NA's from data! Ask Dr. Koval about this...var selection

 #Conde
# set.seed(1)
# train=sample(14608,14608/2)
# fit1 <- lm(bmi~conde,data=ds11,subset=train)
# mean((ds11$bmi-predict(fit1,ds11))[-train]^2)
# fit2 <- lm(bmi~poly(conde,2),data=ds11,subset=train)
# mean((ds11$bmi-predict(fit2,ds11))[-train]^2) #lowest...
# fit3 <- lm(bmi~poly(conde,3),data=ds11,subset=train)
# mean((ds11$bmi-predict(fit3,ds11))[-train]^2)
# fit4 <- lm(bmi~poly(conde,4),data=ds11,subset=train)
# mean((ds11$bmi-predict(fit4,ds11))[-train]^2)
# fit5 <- lm(bmi~poly(conde,5),data=ds11,subset=train)
# mean((ds11$bmi-predict(fit5,ds11))[-train]^2)
# 


fit.1 <- glm(bmi~conde,data=ds12a)
fit.2 <- lm(bmi~poly(conde,2),data=ds12a)
fit.3 <- lm(bmi~poly(conde,3),data=ds12a)
fit.4 <- lm(bmi~poly(conde,4),data=ds12a)
fit.5 <- lm(bmi~poly(conde,5),data=ds12a)
anova(fit.1,fit.2,fit.3,fit.4,fit.5)
```

```
Analysis of Deviance Table

Model: gaussian, link: identity

Response: bmi

Terms added sequentially (first to last)

      Df Deviance Resid. Df Resid. Dev
NULL                   9416     294329
conde  1    12985      9415     281344
```

```r
#USE AIC i guess..
# fit.1
# regsum1 <- summary(fit.1)
# aic1 <- regsum1$aic
# 
# regsum2 <- summary(fit.2)
# aic2 <- regsum2$aic
# 
# regsum3 <- summary(fit.3)
# aic3 <- regsum3$aic
# 
# regsum4 <- summary(fit.4)
# aic4 <- regsum4$aic
# 
# regsum5 <- summary(fit.5)
# aic5 <- regsum5$aic
# 
# plot(1, aic1, col="purple",xlab= "Variable shape",ylab="AIC" ,xlim=c(1, 5), ylim=c(0, 100000), pch=20) 
# points(2,aic2, col="purple",pch=20)
# points(3,aic3, col="purple",pch=20)
# points(4,aic4, col="purple",pch=20)
# points(5,aic5, col="purple",pch=20)

#seems like linear fit is the way to go for conde?
#Dr. Koval says use something like BIC...

#Rest of Var's...
#Age
# set.seed(1)
# train=sample(14608,7304)
# fit1 <- lm(bmi~agey,data=ds12a,subset=train)
# mean((ds12a$bmi-predict(fit1,ds12a))[-train]^2)
# 
# fit2 <- lm(bmi~poly(agey,2),data=ds7a,subset=train)
# mean((ds7a$bmi-predict(fit2,ds7a))[-train]^2) 
# 
# fit3 <- lm(bmi~poly(agey,3),data=ds7a,subset=train)
# mean((ds7a$bmi-predict(fit3,ds7a))[-train]^2)
# 
# fit4 <- lm(bmi~poly(agey,4),data=ds12a,subset=train)
# mean((ds12a$bmi-predict(fit4,ds12a))[-train]^2)
# fit5 <- lm(bmi~poly(agey,5),data=ds12a,subset=train)
# mean((ds12a$bmi-predict(fit5,ds12a))[-train]^2) #remove this stuff


fit.1 <- lm(bmi~agey,data=ds12a)
fit.2 <- lm(bmi~poly(agey,2),data=ds12a)
fit.3 <- lm(bmi~poly(agey,3),data=ds12a)
fit.4 <- lm(bmi~poly(agey,4),data=ds12a)
fit.5 <- lm(bmi~poly(agey,5),data=ds12a)
anova(fit.1,fit.2,fit.3,fit.4,fit.5) #simplest way to explain...quadratic
```

```
Analysis of Variance Table

Model 1: bmi ~ agey
Model 2: bmi ~ poly(agey, 2)
Model 3: bmi ~ poly(agey, 3)
Model 4: bmi ~ poly(agey, 4)
Model 5: bmi ~ poly(agey, 5)
  Res.Df    RSS Df Sum of Sq      F Pr(>F)
1   9415 278859                           
2   9414 278825  1    34.151 1.1529 0.2830
3   9413 278800  1    24.797 0.8371 0.3602
4   9412 278797  1     2.895 0.0977 0.7546
5   9411 278761  1    36.072 1.2178 0.2698
```

```r
#Raedyrs

fit.1 <- lm(bmi~raedyrs,data=ds12a)
fit.2 <- lm(bmi~poly(raedyrs,2),data=ds12a)
fit.3 <- lm(bmi~poly(raedyrs,3),data=ds12a)
fit.4 <- lm(bmi~poly(raedyrs,4),data=ds12a)
fit.5 <- lm(bmi~poly(raedyrs,5),data=ds12a)
anova(fit.1,fit.2,fit.3,fit.4,fit.5) #quadratic...
```

```
Analysis of Variance Table

Model 1: bmi ~ raedyrs
Model 2: bmi ~ poly(raedyrs, 2)
Model 3: bmi ~ poly(raedyrs, 3)
Model 4: bmi ~ poly(raedyrs, 4)
Model 5: bmi ~ poly(raedyrs, 5)
  Res.Df    RSS Df Sum of Sq      F  Pr(>F)  
1   9415 292709                              
2   9414 292521  1   188.573 6.0691 0.01377 *
3   9413 292441  1    79.904 2.5717 0.10883  
4   9412 292429  1    11.532 0.3711 0.54240  
5   9411 292410  1    19.719 0.6347 0.42567  
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
#Cogtot

fit.1 <- lm(bmi~cogtot,data=ds12a)
fit.2 <- lm(bmi~poly(cogtot,2),data=ds12a)
fit.3 <- lm(bmi~poly(cogtot,3),data=ds12a)
fit.4 <- lm(bmi~poly(cogtot,4),data=ds12a)
fit.5 <- lm(bmi~poly(cogtot,5),data=ds12a)
anova(fit.1,fit.2,fit.3,fit.4,fit.5) #quadratic
```

```
Analysis of Variance Table

Model 1: bmi ~ cogtot
Model 2: bmi ~ poly(cogtot, 2)
Model 3: bmi ~ poly(cogtot, 3)
Model 4: bmi ~ poly(cogtot, 4)
Model 5: bmi ~ poly(cogtot, 5)
  Res.Df    RSS Df Sum of Sq       F   Pr(>F)    
1   9415 293276                                  
2   9414 292787  1    489.14 15.7247 7.38e-05 ***
3   9413 292746  1     41.22  1.3250   0.2497    
4   9412 292744  1      2.40  0.0771   0.7812    
5   9411 292743  1      1.00  0.0321   0.8579    
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
```

```r
#For each variable -- 


#decide if adding race and gender, might want to
#Conde...
m_1c <- glm(formula= bmi ~  conde , data = ds7a )
p_1c <- predictvals(m_1c, "conde", "bmi")
#Age
m_2a <- glm(formula= bmi ~  agey + I(agey^2) , data = ds7a )
p_2a <- predictvals(m_2a, "agey", "bmi")
#Education
m_2e <- glm(formula= bmi ~ raedyrs + I(raedyrs^2), data = ds7a )
p_2e <- predictvals(m_2e, "raedyrs", "bmi")
#Cognitive Total
m_2ct <- glm(formula= bmi ~ cogtot + I(cogtot^2), data = ds7a )
p_2ct <- predictvals(m_2ct, "cogtot", "bmi")
```

Adds models to figures produced above

```r
# attach  a line to the graph produced in the previous chunk
#add CI/jitter to lines -- stat.smooth stuff I believe
#after visual examination - cubic chosen for number of health conditions (conde) and for agey (age of participant), linear chosen for education (in years)

#For Condition (by Race) 
# model <- lm(bmi ~ conde + factor(raracem), data=ds7a)
# grid <- with(ds7a, expand.grid(
#   conde = seq(min(conde), max(conde), length = 8),
#   raracem = levels(factor(raracem))
# ))
# grid$bmi <- stats::predict(model, newdata=grid)
# err <- stats::predict(model, newdata=grid, se = TRUE)
# grid$ucl <- err$fit + 1.96 * err$se.fit
# grid$lcl <- err$fit - 1.96 * err$se.fit
# plot.1 + geom_smooth(aes(ymin = lcl, ymax = ucl), data=grid, stat="identity")
# plot.1 + geom_line(data=p_1c, colour="black", size=1.0) 
# plot.1
plot.1ab <- plot.1 + stat_smooth(method="lm", formula= y ~ ns(x,1))
plot.1ab
```

![](figure_rmd/add_model_data-1.png) 

```r
#For Age (by Race) 
# model2 <- lm(bmi ~ agey + factor(raracem), data=ds7a)
# grid2 <- with(ds7a, expand.grid(
#   agey = seq(min(agey), max(agey), length = 120),
#   raracem = levels(factor(raracem))
# ))
# grid2$bmi <- stats::predict(model2, newdata=grid2) #problem with code right here...
# err <- stats::predict(model2, newdata=grid2, se = TRUE)
# grid2$ucl <- err$fit + 1.96 * err$se.fit
# grid2$lcl <- err$fit - 1.96 * err$se.fit
# plot.2 + geom_smooth(aes(ymin = lcl, ymax = ucl), data=grid2, stat="identity")
# plot.2 + geom_line(data=p_2a, colour="black", size=1.0)

plot.2ab <- plot.2 + stat_smooth(method="lm", formula= y ~ ns(x,2))
plot.2ab
```

![](figure_rmd/add_model_data-2.png) 

```r
#For Education (by Race) - Not working...
# model3 <- lm(bmi ~ raedyrs + factor(raracem), data=ds7a)
# grid3 <- with(ds7a, expand.grid(
#   raedyrs = seq(min(raedyrs), max(raedyrs), length = 20),
#   raracem = levels(factor(raracem))
# ))
# grid3$bmi <- stats::predict(model3, newdata=grid3)
# err <- stats::predict(model3, newdata=grid3, se = TRUE)
# grid3$ucl <- err$fit + 1.96 * err$se.fit
# grid3$lcl <- err$fit - 1.96 * err$se.fit
# plot.3 + geom_smooth(aes(ymin = lcl, ymax = ucl), data=grid3, stat="identity")

plot.3ab <- plot.3 + stat_smooth(method="lm", formula= y ~ ns(x,2))
plot.3ab
```

![](figure_rmd/add_model_data-3.png) 

```r
#For Cognition (by Race) - Not working for some reason...
# model4 <- lm(bmi ~ cogtot + factor(raracem), data=ds7a)
# grid4 <- with(ds7a, expand.grid(
#   cogtot = seq(min(cogtot), max(cogtot), length = 30),
#   raracem = levels(factor(raracem))
# ))
# grid4$bmi <- stats::predict(model4, newdata=grid4)
# err <- stats::predict(model4, newdata=grid4, se = TRUE)
# grid4$ucl <- err$fit + 1.96 * err$se.fit
# grid4$lcl <- err$fit - 1.96 * err$se.fit
# plot.4 + geom_smooth(aes(ymin = lcl, ymax = ucl), data=grid4, stat="identity")

plot.4ab <- plot.4 + stat_smooth(method="lm", formula= y ~ ns(x,2))
plot.4ab
```

![](figure_rmd/add_model_data-4.png) 

## Conclusions

### Health conditions

Data seem show that the more health conditions you have, the higher your BMI, while people's self assessment of their health corresponds to the amount of health conditions they have (i.e. they assess their health as being worse the more health conditions they have) ###

### Age

Data seem show that the older you are, the lower your BMI is, no change between the genders###

###Education

Data seem show that the more education you have, the lower your BMI is (only a slight relationship though, not super strong), while race seems to ###

###Cognition

Data seem show that the higher your cognition, the higher your body mass. a bit surprising.... The relationship with race seems to show
###

###Race
Appears that race is related to BMI, with blacks/african americans having the strongest  relation

## Appendix

Removes all variables except variables conisdered for models

```r
# Manually create the vector that contains the names of the variables you would like to keep. 
selectVars <- c("hhidpn", "bmi",  "conde",  "agey",  "raedyrs", "cogtot", "drink",  "raracem", "ragender")
dsL <- ds7a[,selectVars]
head(dsL) 
```

```
    hhidpn  bmi conde     agey raedyrs cogtot drink           raracem ragender
1     3010 24.0     1 74.66666      12     17  0.no 1.white/caucasian   1.male
2     3020 25.7     3 72.00000      16     25  0.no 1.white/caucasian 2.female
3 10001010 21.3     0 71.33334      12     26  0.no 1.white/caucasian   1.male
5 10004010 29.3     3 70.50000      16     27 1.yes 1.white/caucasian   1.male
7 10013010 32.2     3 72.08334      12     20  0.no 1.white/caucasian   1.male
9 10038010 23.9     3 74.33334      16     29 1.yes 1.white/caucasian   1.male
```

Creates an rds and a csv file that contains only the variables of interest for models (reduces data set size)

```r
#Creates derived data which contains only variables of interest for the 3 models

pathdsLhrscsv <- "./data/derived/hrs_drv_dsL.csv"
write.csv(dsL,pathdsLhrscsv,  row.names=FALSE)

pathdsLhrsrds <- "./data/derived/hrs_drv_dsL.rds"
saveRDS(object=dsL, file=pathdsLhrsrds, compress="xz")
```


```r
# # remove all but specified dataset
#rm(list=setdiff(ls(), c("ds8","dsL")))
```
