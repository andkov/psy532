# Preparing the Community Health Status Indicator Dataset
<!-- for more options study http://rmarkdown.rstudio.com/html_document_format.html  -->
<!-- The report is produced from
REPOSITORY: the-name-of-the-repository
BRANCH: the-name-of-the-branch
PATH: ../Reports/
-->

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->


<!-- Set the report-wide options, and point to the external script file. -->


By: **Myles A. Maillet**
![](http://www.huewire.com/wp-content/uploads/2014/04/Obamacare.jpg)
***

This dataset provides key health indicators for 
local communities and encourages dialogue about actions that can be taken to improve community health 
(e.g., obesity, heart disease, cancer). The CHSI and dataset, published in 2000, was designed not only for public health 
professionals but also for members of the community who are interested in the health of their community. 
The CHSI report contains over 200 measures for each of the 3,141 United States counties. Although CHSI presents 
indicators like deaths due to heart disease and cancer, it is imperative to understand that behavioral factors 
such as obesity, tobacco use, diet, physical activity, alcohol and drug use, sexual behavior and others substantially 
contribute to these deaths.

The CHSI data set can be examined and downloaded [here](https://catalog.data.gov/dataset/community-health-status-indicators-chsi-to-combat-obesity-heart-disease-and-cancer), and specific county data investigated [here](http://wwwn.cdc.gov/communityhealth).

***

First, we'll load the necessary packages.

```r
base::require(base)
base::require(knitr)
base::require(markdown)
base::require(testit)
base::require(dplyr)
base::require(reshape2)
base::require(stringr)
base::require(stats)
base::require(ggplot2)
base::require(extrafont)
base::require(data.table)
base::require(ggthemes)
```

Next, we'll load the data into R, and create both a full dataset and a dataset with just the variables of interest.

```r
# Link to the data source 
SourceDataDemo <- read.csv("./data/raw/DEMOGRAPHICS.csv",header=TRUE, skip=0,sep=",")
SourceDataLCD <- read.csv("./data/raw/LEADINGCAUSESOFDEATH.csv",header=TRUE, skip=0,sep=",")
SourceDataMBD <- read.csv("./data/raw/MEASURESOFBIRTHANDDEATH.csv",header=TRUE, skip=0,sep=",")
SourceDataPSU <- read.csv("./data/raw/PREVENTIVESERVICESUSE.csv",header=TRUE, skip=0,sep=",")
SourceDataRHI <- read.csv("./data/raw/RELATIVEHEALTHIMPORTANCE.csv",header=TRUE, skip=0,sep=",")
SourceDataRFAC <- read.csv("./data/raw/RISKFACTORSANDACCESSTOCARE.csv",header=TRUE, skip=0,sep=",")
SourceDataSMH <- read.csv("./data/raw/SUMMARYMEASURESOFHEALTH.csv",header=TRUE, skip=0,sep=",")
SourceDataVPEH <- read.csv("./data/raw/VUNERABLEPOPSANDENVHEALTH.csv",header=TRUE, skip=0,sep=",")

#create data sets
dsdemo =  SourceDataDemo
dslcd = SourceDataLCD
dsmbd = SourceDataMBD
dspsu = SourceDataPSU
dsrhi = SourceDataRHI
dsrfac = SourceDataRFAC
dssmh = SourceDataSMH
dsvpeh = SourceDataVPEH

#combine into one full dataset
fullds = cbind(dsdemo, dslcd[,-c(1:6)], dsmbd[,-c(1:6)], dspsu[,-c(1:6)], dsrhi[,-c(1:6)], 
               dsrfac[,-c(1:6)], dssmh[,-c(1:6)], dsvpeh[,-c(1:6)])

#select only data of interest
keepvar_dsdemo = dsdemo[, c("CHSI_County_Name","CHSI_State_Name",
                "Population_Size","Population_Density",
                "Poverty","Age_19_Under","Age_19_64","Age_65_84","Age_85_and_Over",
                "White","Black","Native_American","Asian","Hispanic")]
keepvar_dsmbd = dsmbd[, c("LBW","VLBW","Premature","Under_18","Over_40","Unmarried",
                "Homicide","Suicide","Injury")]
keepvar_dsrfac= dsrfac[, c("No_Exercise","Few_Fruit_Veg","Obesity","High_Blood_Pres",
                "Smoker","Diabetes","Prim_Care_Phys_Rate")]
keepvar_dssmh = dssmh[, c("ALE","Health_Status")]
keepvar_dsvpeh = dsvpeh[, c("No_HS_Diploma","Major_Depression","Unemployed")]

#dsm will be our dataset with only variables of interest
dsm = cbind(keepvar_dsdemo, keepvar_dsmbd, keepvar_dsrfac, keepvar_dssmh, keepvar_dsvpeh)
```

Next, we will examine the data to see what we have to work with.

```r
summary(dsm)
```

```
   CHSI_County_Name CHSI_State_Name Population_Size   Population_Density    Poverty          Age_19_Under  
 Washington:  32    Texas   : 254   Min.   :     62   Min.   :-2222.0    Min.   :-2222.20   Min.   : 1.40  
 Jefferson :  26    Georgia : 159   1st Qu.:  11211   1st Qu.:   17.0    1st Qu.:    9.80   1st Qu.:22.70  
 Franklin  :  25    Virginia: 134   Median :  25235   Median :   44.0    Median :   12.60   Median :24.60  
 Jackson   :  24    Kentucky: 120   Mean   :  94368   Mean   :  249.1    Mean   :   12.64   Mean   :24.81  
 Lincoln   :  24    Missouri: 115   3rd Qu.:  64040   3rd Qu.:  109.0    3rd Qu.:   16.20   3rd Qu.:26.40  
 Madison   :  20    Kansas  : 105   Max.   :9935475   Max.   :69390.0    Max.   :   36.20   Max.   :47.20  
 (Other)   :2990    (Other) :2254                                                                          
   Age_19_64       Age_65_84     Age_85_and_Over     White            Black        Native_American      Asian       
 Min.   :47.60   Min.   : 2.10   Min.   :0.100   Min.   :  4.70   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
 1st Qu.:58.30   1st Qu.:10.70   1st Qu.:1.500   1st Qu.: 82.80   1st Qu.: 0.500   1st Qu.: 0.200   1st Qu.: 0.300  
 Median :60.30   Median :12.50   Median :1.900   Median : 94.10   Median : 2.100   Median : 0.400   Median : 0.500  
 Mean   :60.29   Mean   :12.79   Mean   :2.115   Mean   : 87.02   Mean   : 8.987   Mean   : 1.974   Mean   : 1.123  
 3rd Qu.:62.30   3rd Qu.:14.70   3rd Qu.:2.600   3rd Qu.: 97.60   3rd Qu.:10.300   3rd Qu.: 0.900   3rd Qu.: 1.000  
 Max.   :83.30   Max.   :29.20   Max.   :7.600   Max.   :100.00   Max.   :86.000   Max.   :93.400   Max.   :55.900  
                                                                                                                    
    Hispanic           LBW                 VLBW            Premature            Under_18           Over_40        
 Min.   : 0.000   Min.   :-2222.200   Min.   :-2222.20   Min.   :-2222.200   Min.   :-2222.20   Min.   :-2222.20  
 1st Qu.: 1.100   1st Qu.:    6.300   1st Qu.:    1.00   1st Qu.:   10.200   1st Qu.:    2.90   1st Qu.:    1.10  
 Median : 2.300   Median :    7.300   Median :    1.30   Median :   11.700   Median :    4.30   Median :    1.50  
 Mean   : 7.018   Mean   :   -3.825   Mean   :  -75.13   Mean   :    5.446   Mean   :  -23.67   Mean   :  -44.67  
 3rd Qu.: 6.300   3rd Qu.:    8.600   3rd Qu.:    1.60   3rd Qu.:   13.200   3rd Qu.:    6.00   3rd Qu.:    2.10  
 Max.   :97.500   Max.   :   15.600   Max.   :    3.60   Max.   :   23.500   Max.   :   14.50   Max.   :    9.10  
                                                                                                                  
   Unmarried           Homicide          Suicide            Injury         No_Exercise      Few_Fruit_Veg    
 Min.   :-2222.20   Min.   :-2222.2   Min.   :-2222.2   Min.   :-2222.2   Min.   :-1111.1   Min.   :-1111.1  
 1st Qu.:   24.60   1st Qu.:-1111.1   1st Qu.:    8.4   1st Qu.:   18.7   1st Qu.:-1111.1   1st Qu.:-1111.1  
 Median :   30.40   Median :-1111.1   Median :   11.7   Median :   23.0   Median :   22.6   Median :   74.0  
 Mean   :   29.16   Mean   : -681.2   Mean   : -174.1   Mean   :  -42.2   Mean   : -312.1   Mean   : -389.7  
 3rd Qu.:   38.20   3rd Qu.:    5.3   3rd Qu.:   14.8   3rd Qu.:   27.9   3rd Qu.:   28.6   3rd Qu.:   80.2  
 Max.   :   77.90   Max.   :   46.0   Max.   :   91.3   Max.   :  236.2   Max.   :   52.4   Max.   :   96.4  
                                                                                                             
    Obesity        High_Blood_Pres       Smoker           Diabetes       Prim_Care_Phys_Rate      ALE          
 Min.   :-1111.1   Min.   :-1111.1   Min.   :-1111.1   Min.   :-1111.1   Min.   :  0.00      Min.   :-2222.20  
 1st Qu.:-1111.1   1st Qu.:-1111.1   1st Qu.:-1111.1   1st Qu.:    5.0   1st Qu.: 30.50      1st Qu.:   75.00  
 Median :   21.7   Median :-1111.1   Median :   20.3   Median :    7.0   Median : 50.60      Median :   76.50  
 Mean   : -307.3   Mean   : -559.9   Mean   : -292.5   Mean   : -142.5   Mean   : 57.56      Mean   :   74.86  
 3rd Qu.:   25.8   3rd Qu.:   26.1   3rd Qu.:   25.1   3rd Qu.:    9.1   3rd Qu.: 74.70      3rd Qu.:   77.70  
 Max.   :   42.6   Max.   :   47.1   Max.   :   46.2   Max.   :   20.8   Max.   :581.20      Max.   :   81.30  
                                                                                                               
 Health_Status     No_HS_Diploma     Major_Depression   Unemployed    
 Min.   :-1111.1   Min.   :  -2222   Min.   :     4   Min.   : -9999  
 1st Qu.:    8.9   1st Qu.:   1768   1st Qu.:   673   1st Qu.:   287  
 Median :   14.6   Median :   4106   Median :  1562   Median :   669  
 Mean   : -221.2   Mean   :  12046   Mean   :  5432   Mean   :  2382  
 3rd Qu.:   19.4   3rd Qu.:   8955   3rd Qu.:  3880   3rd Qu.:  1671  
 Max.   :   47.7   Max.   :1872316   Max.   :495905   Max.   :256472  
                                                                      
```

There are null values represented as large negative numbers in this dataset (e.g., -1111, -2222), so let's remove those.

```r
## set missing data values as NA, opposed to -1111,-2222,etc.
illegal<-as.numeric(c(-1111.1, -2222, -2222.2, -9999))
for( variable in names(dsm) ){
  dsm[,variable]=ifelse(dsm[,variable] %in% illegal,NA,dsm[,variable])}
```

High school diplomas, unemployment, and major depression are counts, so let's make new variables as percentages of the population.

```r
dsm$No_HS_Diploma_perc=dsm$No_HS_Diploma/dsm$Population_Size
dsm$Unemployed_perc=dsm$Unemployed/dsm$Population_Size
dsm$Major_Depression_perc=dsm$Major_Depression/dsm$Population_Size
```

Now lets see how the data looks after we've removed the null values and duplicated the count variables as percentages.

```r
summary(dsm)
```

```
 CHSI_County_Name CHSI_State_Name Population_Size   Population_Density    Poverty       Age_19_Under     Age_19_64    
 Min.   :   1     Min.   : 1.00   Min.   :     62   Min.   :    0.0    Min.   : 2.20   Min.   : 1.40   Min.   :47.60  
 1st Qu.: 487     1st Qu.:15.00   1st Qu.:  11211   1st Qu.:   17.0    1st Qu.: 9.80   1st Qu.:22.70   1st Qu.:58.30  
 Median : 926     Median :26.00   Median :  25235   Median :   44.0    Median :12.60   Median :24.60   Median :60.30  
 Mean   : 927     Mean   :27.26   Mean   :  94368   Mean   :  249.9    Mean   :13.35   Mean   :24.81   Mean   :60.29  
 3rd Qu.:1356     3rd Qu.:41.00   3rd Qu.:  64040   3rd Qu.:  109.2    3rd Qu.:16.20   3rd Qu.:26.40   3rd Qu.:62.30  
 Max.   :1847     Max.   :51.00   Max.   :9935475   Max.   :69390.0    Max.   :36.20   Max.   :47.20   Max.   :83.30  
                                                    NA's   :1          NA's   :1                                      
   Age_65_84     Age_85_and_Over     White            Black        Native_American      Asian           Hispanic     
 Min.   : 2.10   Min.   :0.100   Min.   :  4.70   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000   Min.   : 0.000  
 1st Qu.:10.70   1st Qu.:1.500   1st Qu.: 82.80   1st Qu.: 0.500   1st Qu.: 0.200   1st Qu.: 0.300   1st Qu.: 1.100  
 Median :12.50   Median :1.900   Median : 94.10   Median : 2.100   Median : 0.400   Median : 0.500   Median : 2.300  
 Mean   :12.79   Mean   :2.115   Mean   : 87.02   Mean   : 8.987   Mean   : 1.974   Mean   : 1.123   Mean   : 7.018  
 3rd Qu.:14.70   3rd Qu.:2.600   3rd Qu.: 97.60   3rd Qu.:10.300   3rd Qu.: 0.900   3rd Qu.: 1.000   3rd Qu.: 6.300  
 Max.   :29.20   Max.   :7.600   Max.   :100.00   Max.   :86.000   Max.   :93.400   Max.   :55.900   Max.   :97.500  
                                                                                                                     
      LBW              VLBW         Premature        Under_18        Over_40        Unmarried        Homicide     
 Min.   : 2.100   Min.   :0.200   Min.   : 5.10   Min.   : 0.30   Min.   :0.200   Min.   : 6.10   Min.   : 0.700  
 1st Qu.: 6.300   1st Qu.:1.000   1st Qu.:10.20   1st Qu.: 3.00   1st Qu.:1.100   1st Qu.:24.70   1st Qu.: 4.400  
 Median : 7.400   Median :1.300   Median :11.70   Median : 4.40   Median :1.500   Median :30.50   Median : 6.500  
 Mean   : 7.569   Mean   :1.374   Mean   :11.88   Mean   : 4.75   Mean   :1.743   Mean   :32.07   Mean   : 7.624  
 3rd Qu.: 8.600   3rd Qu.:1.600   3rd Qu.:13.20   3rd Qu.: 6.00   3rd Qu.:2.100   3rd Qu.:38.20   3rd Qu.: 9.600  
 Max.   :15.600   Max.   :3.600   Max.   :23.50   Max.   :14.50   Max.   :9.100   Max.   :77.90   Max.   :46.000  
 NA's   :31       NA's   :215     NA's   :17      NA's   :79      NA's   :130     NA's   :7       NA's   :1933    
    Suicide          Injury        No_Exercise    Few_Fruit_Veg      Obesity      High_Blood_Pres     Smoker     
 Min.   : 4.50   Min.   :  9.00   Min.   : 8.30   Min.   :63.10   Min.   : 4.20   Min.   : 7.20   Min.   : 3.60  
 1st Qu.:10.30   1st Qu.: 19.50   1st Qu.:21.90   1st Qu.:75.50   1st Qu.:21.10   1st Qu.:22.80   1st Qu.:19.40  
 Median :12.70   Median : 23.40   Median :26.00   Median :79.00   Median :24.30   Median :26.20   Median :23.00  
 Mean   :13.54   Mean   : 24.69   Mean   :26.51   Mean   :78.92   Mean   :24.15   Mean   :26.48   Mean   :23.11  
 3rd Qu.:15.70   3rd Qu.: 28.20   3rd Qu.:30.80   3rd Qu.:82.40   3rd Qu.:27.20   3rd Qu.:29.90   3rd Qu.:26.70  
 Max.   :91.30   Max.   :236.20   Max.   :52.40   Max.   :96.40   Max.   :42.60   Max.   :47.10   Max.   :46.20  
 NA's   :523     NA's   :184      NA's   :935     NA's   :1237    NA's   :917     NA's   :1619    NA's   :874    
    Diabetes     Prim_Care_Phys_Rate      ALE        Health_Status   No_HS_Diploma     Major_Depression
 Min.   : 0.50   Min.   :  0.00      Min.   :66.60   Min.   : 2.20   Min.   :      7   Min.   :     4  
 1st Qu.: 5.90   1st Qu.: 30.50      1st Qu.:75.00   1st Qu.:12.90   1st Qu.:   1772   1st Qu.:   673  
 Median : 7.50   Median : 50.60      Median :76.50   Median :16.40   Median :   4106   Median :  1562  
 Mean   : 7.81   Mean   : 57.56      Mean   :76.32   Mean   :17.32   Mean   :  12050   Mean   :  5432  
 3rd Qu.: 9.45   3rd Qu.: 74.70      3rd Qu.:77.70   3rd Qu.:20.90   3rd Qu.:   8956   3rd Qu.:  3880  
 Max.   :20.80   Max.   :581.20      Max.   :81.30   Max.   :47.70   Max.   :1872316   Max.   :495905  
 NA's   :422                         NA's   :2       NA's   :664     NA's   :1                         
   Unemployed     No_HS_Diploma_perc Unemployed_perc   Major_Depression_perc
 Min.   :     4   Min.   :0.01879    Min.   :0.01057   Min.   :0.04005      
 1st Qu.:   288   1st Qu.:0.10782    1st Qu.:0.02124   1st Qu.:0.05602      
 Median :   673   Median :0.13906    Median :0.02525   Median :0.05919      
 Mean   :  2411   Mean   :0.15060    Mean   :0.02617   Mean   :0.06060      
 3rd Qu.:  1674   3rd Qu.:0.19155    3rd Qu.:0.02971   3rd Qu.:0.06521      
 Max.   :256472   Max.   :0.59459    Max.   :0.07709   Max.   :0.08259      
 NA's   :8        NA's   :1          NA's   :8                              
```

Let's save the full data set and the modified data set to be used for analysis later.

```r
saveRDS(fullds, "./data/derived/fullds.rds")
saveRDS(dsm, "./data/derived/dsm.rds")
```

Lastly, lets clean up our mess.

```r
rm("dsdemo","fullds","dslcd","dsmbd","dspsu","dsrfac","dsrhi","dssmh",
   "dsvpeh","illegal","keepvar_dsdemo","keepvar_dsmbd","keepvar_dsrfac", 
   "keepvar_dssmh","keepvar_dsvpeh","SourceDataDemo","SourceDataLCD",
   "SourceDataMBD","SourceDataPSU","SourceDataRFAC","SourceDataRHI","SourceDataSMH", 
   "SourceDataVPEH","variable")
```
***
***
