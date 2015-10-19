# Selected problems from Chapter 3

<!-- These two chunks should be added in the beginning of every .Rmd that you want to source an .R script -->
<!--  The 1st mandatory chunck  -->
<!--  Set the working directory to the repository's base directory -->


<!--  The 2nd mandatory chunck  -->
<!-- Set the report-wide options, and point to the external code file. -->




<!-- Load 'sourced' R files.  Suppress the output when loading packages. --> 

```r
library(dplyr) # for data manipulation
library(ggplot2) # for graphing
```

<!-- Load the sources.  Suppress the output when loading sources. --> 

```r
source("./scripts/graphs/main_theme.R")
source("./scripts/graphs/areaF_graphing.R")
```

<!-- Load any Global functions and variables declared in the R file.  Suppress the output. --> 


<!-- Declare any global functions specific to a Rmd output.  Suppress the output. --> 


## Load data
<!-- Load the datasets.   -->

```r
filePath <- "./data/ISLR/Auto.data" 
ds <- read.table(filePath, header=T, na.strings="?")
head(ds)
```

```
  mpg cylinders displacement horsepower weight acceleration year origin                      name
1  18         8          307        130   3504         12.0   70      1 chevrolet chevelle malibu
2  15         8          350        165   3693         11.5   70      1         buick skylark 320
3  18         8          318        150   3436         11.0   70      1        plymouth satellite
4  16         8          304        150   3433         12.0   70      1             amc rebel sst
5  17         8          302        140   3449         10.5   70      1               ford torino
6  15         8          429        198   4341         10.0   70      1          ford galaxie 500
```

```r
dim(ds)
```

```
[1] 397   9
```

<!-- Tweak the datasets.   -->

```r
ds <- na.omit(ds)
dim(ds)
```

```
[1] 392   9
```


<!-- Basic table view.   -->

```r
summary(ds)
```

```
      mpg          cylinders      displacement     horsepower        weight      acceleration        year      
 Min.   : 9.00   Min.   :3.000   Min.   : 68.0   Min.   : 46.0   Min.   :1613   Min.   : 8.00   Min.   :70.00  
 1st Qu.:17.00   1st Qu.:4.000   1st Qu.:105.0   1st Qu.: 75.0   1st Qu.:2225   1st Qu.:13.78   1st Qu.:73.00  
 Median :22.75   Median :4.000   Median :151.0   Median : 93.5   Median :2804   Median :15.50   Median :76.00  
 Mean   :23.45   Mean   :5.472   Mean   :194.4   Mean   :104.5   Mean   :2978   Mean   :15.54   Mean   :75.98  
 3rd Qu.:29.00   3rd Qu.:8.000   3rd Qu.:275.8   3rd Qu.:126.0   3rd Qu.:3615   3rd Qu.:17.02   3rd Qu.:79.00  
 Max.   :46.60   Max.   :8.000   Max.   :455.0   Max.   :230.0   Max.   :5140   Max.   :24.80   Max.   :82.00  
                                                                                                               
     origin                      name    
 Min.   :1.000   amc matador       :  5  
 1st Qu.:1.000   ford pinto        :  5  
 Median :1.000   toyota corolla    :  5  
 Mean   :1.577   amc gremlin       :  4  
 3rd Qu.:2.000   amc hornet        :  4  
 Max.   :3.000   chevrolet chevette:  4  
                 (Other)           :365  
```

<!-- Basic graph view.   -->


## Problem 8

```r
mlm <- lm(mpg ~ horsepower, data=ds)
summary(mlm)
```

```

Call:
lm(formula = mpg ~ horsepower, data = ds)

Residuals:
     Min       1Q   Median       3Q      Max 
-13.5710  -3.2592  -0.3435   2.7630  16.9240 

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) 39.935861   0.717499   55.66   <2e-16 ***
horsepower  -0.157845   0.006446  -24.49   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

Residual standard error: 4.906 on 390 degrees of freedom
Multiple R-squared:  0.6059,	Adjusted R-squared:  0.6049 
F-statistic: 599.7 on 1 and 390 DF,  p-value: < 2.2e-16
```

```r
mglm <- glm(formula=mpg ~ horsepower,data=ds )
summary(mglm)
```

```

Call:
glm(formula = mpg ~ horsepower, data = ds)

Deviance Residuals: 
     Min        1Q    Median        3Q       Max  
-13.5710   -3.2592   -0.3435    2.7630   16.9240  

Coefficients:
             Estimate Std. Error t value Pr(>|t|)    
(Intercept) 39.935861   0.717499   55.66   <2e-16 ***
horsepower  -0.157845   0.006446  -24.49   <2e-16 ***
---
Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

(Dispersion parameter for gaussian family taken to be 24.06645)

    Null deviance: 23819.0  on 391  degrees of freedom
Residual deviance:  9385.9  on 390  degrees of freedom
AIC: 2363.3

Number of Fisher Scoring iterations: 2
```


