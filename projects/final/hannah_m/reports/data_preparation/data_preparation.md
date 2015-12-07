# Data Preparation
<!-- for more options study http://rmarkdown.rstudio.com/html_document_format.html  -->
<!-- The report is produced from
REPOSITORY: the-name-of-the-repository
BRANCH: the-name-of-the-branch
PATH: ../Reports/
-->

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->


<!-- Set the report-wide options, and point to the external script file. -->



```r
# Load the necessary packages.
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
```
#Load [Healthy Retirement Study Data](http://hrsonline.isr.umich.edu/)

```r
pathDir <- getwd()
myExtract <- file.path(pathDir,"data/raw/hrs_retirement")
# myExtract <- "./data/raw/hrs_retirement"
pathSourceData <- paste0(myExtract,".csv") 
SourceData <- read.csv(pathSourceData,header=TRUE, skip=0,sep=",")
ds0 <- SourceData
```
#Load themes used to style graphs

```r
source("./scripts/graphs/graph_themes.R")
```
#Select variables from dataset
Selected variables that look at psychiatric issues, gender, vigorous activity, cognition, age and bmi. Also included 'wave' variable so I could pick one timepoint in the dataset to look at

[Information on assessing BMI](http://www.cdc.gov/healthyweight/assessing/bmi/)

I am interested in looking at which variables are predictive of BMI. 

```r
dsM <- ds0[ ,c("psych", "ragender", "vigact", "cogtot", "agey", "bmi", "raedyrs", "wave")]
```

#Look at summary of variables

```r
summary(dsM)
```

```
     psych           ragender         vigact          cogtot           agey             bmi            raedyrs     
 Min.   :0.0000   Min.   :1.000   Min.   :0.00    Min.   : 0.00   Min.   : 22.00   Min.   :  7.00   Min.   : 0.00  
 1st Qu.:0.0000   1st Qu.:1.000   1st Qu.:0.00    1st Qu.:19.00   1st Qu.: 58.67   1st Qu.: 23.70   1st Qu.:11.00  
 Median :0.0000   Median :2.000   Median :0.00    Median :22.00   Median : 65.92   Median : 26.60   Median :12.00  
 Mean   :0.1502   Mean   :1.568   Mean   :0.37    Mean   :21.82   Mean   : 67.49   Mean   : 27.46   Mean   :12.16  
 3rd Qu.:0.0000   3rd Qu.:2.000   3rd Qu.:1.00    3rd Qu.:25.00   3rd Qu.: 75.17   3rd Qu.: 30.30   3rd Qu.:14.00  
 Max.   :1.0000   Max.   :2.000   Max.   :1.00    Max.   :35.00   Max.   :109.67   Max.   :102.70   Max.   :18.00  
 NA's   :1272                     NA's   :98631   NA's   :94802                    NA's   :2519     NA's   :278    
      wave       
 Min.   : 1.000  
 1st Qu.: 4.000  
 Median : 6.000  
 Mean   : 6.319  
 3rd Qu.: 9.000  
 Max.   :11.000  
                 
```

##Delete missing information

```r
dsM <-na.omit(dsM)
```

##Select one timepoint (wave=4)

```r
dsM <- dsM %>% dplyr::filter(wave==5)
```

#Look at summary of variables now that missing info is gone and one timepoint has been selected
Gender, psychiatric issues, and vigorous activity are all categorical variables

```r
summary(dsM)
```

```
     psych           ragender         vigact           cogtot           agey             bmi           raedyrs     
 Min.   :0.0000   Min.   :1.000   Min.   :0.0000   Min.   : 0.00   Min.   : 23.67   Min.   :12.60   Min.   : 0.00  
 1st Qu.:0.0000   1st Qu.:1.000   1st Qu.:0.0000   1st Qu.:18.00   1st Qu.: 68.67   1st Qu.:23.10   1st Qu.:10.00  
 Median :0.0000   Median :2.000   Median :0.0000   Median :22.00   Median : 73.67   Median :25.80   Median :12.00  
 Mean   :0.1195   Mean   :1.589   Mean   :0.4024   Mean   :21.62   Mean   : 74.54   Mean   :26.43   Mean   :11.86  
 3rd Qu.:0.0000   3rd Qu.:2.000   3rd Qu.:1.0000   3rd Qu.:25.00   3rd Qu.: 79.50   3rd Qu.:29.10   3rd Qu.:14.00  
 Max.   :1.0000   Max.   :2.000   Max.   :1.0000   Max.   :35.00   Max.   :104.33   Max.   :75.50   Max.   :17.00  
      wave  
 Min.   :5  
 1st Qu.:5  
 Median :5  
 Mean   :5  
 3rd Qu.:5  
 Max.   :5  
```

#Save derived data

```r
pathdsMcsv <- "./data/derived/dsM.csv"
write.csv(dsM,pathdsMcsv,  row.names=FALSE)

pathdsMrds <- "./data/derived/dsM.rds"
saveRDS(object=dsM, file=pathdsMrds, compress="xz")
```
#Remove all datasets except for dsM

```r
rm(list=setdiff(ls(), c("dsM")))
```
