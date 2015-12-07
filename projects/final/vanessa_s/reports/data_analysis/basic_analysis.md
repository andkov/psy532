# Data analysis for final report - Thomas Ferguson
<!-- for more options study http://rmarkdown.rstudio.com/html_document_format.html  -->
<!-- The report is produced from
REPOSITORY: the-name-of-the-repository
BRANCH: the-name-of-the-branch
PATH: ../Reports/
-->

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->


<!-- Set the report-wide options, and point to the external script file. -->


##Load Packages
Prepare RStudio environment for all tasks to follow. 






We load the data derived by the script "./reports/data_preparation/dsL_hrs.R"" 
Variables chosen are age in years, eduction in years, gender, race, if they drink currently, if they smoked ever,


Load graph settings for creating figures


Chooses variables for model - End up with model of ~6 or 7 due to conflicting results (seemed reasonable - dropped the least significant factors which were gender, mstot, depressive symptoms and sample weight

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

```
 [1] "np"        "nrbar"     "d"         "rbar"      "thetab"    "first"     "last"      "vorder"    "tol"      
[10] "rss"       "bound"     "nvmax"     "ress"      "ir"        "nbest"     "lopt"      "il"        "ier"      
[19] "xnames"    "method"    "force.in"  "force.out" "sserr"     "intercept" "lindep"    "nullrss"   "nn"       
[28] "call"     
```

```
  (Intercept)        hhidpn         conde          agey        cogtot         mstot       raedyrs          cesd 
 3.881552e+01  5.646507e-10  8.072686e-01 -1.895553e-01  7.727136e-02  3.974560e-02 -1.310662e-01 -1.657343e-02 
       wtresp         shltc      shltnum2      shltnum3      shltnum4      shltnum5    gendernum2      racenum2 
-2.101632e-06 -2.685605e-01  9.923701e-01  1.354036e+00  1.710996e+00  1.421305e+00 -5.128229e-01  1.171970e+00 
     racenum3     smokenum1     drinknum1 
-2.648775e-01 -2.680000e-01 -4.866865e-01 
```

```
[1] "which"  "rsq"    "rss"    "adjr2"  "cp"     "bic"    "outmat" "obj"   
```

```
[1] 1
```

```
[1] 18
```

```
[1] 13
```

```
[1] 12
```

![](figure_rmd/model_selection-1.png) 
Create Plots of cognition, number of chronic conditions, education in years and age in years by BMI (with gender, if they drank, and race included as factors)
![](figure_rmd/add_graphs-1.png) ![](figure_rmd/add_graphs-2.png) ![](figure_rmd/add_graphs-3.png) ![](figure_rmd/add_graphs-4.png) ![](figure_rmd/add_graphs-5.png) ![](figure_rmd/add_graphs-6.png) ![](figure_rmd/add_graphs-7.png) ![](figure_rmd/add_graphs-8.png) ![](figure_rmd/add_graphs-9.png) ![](figure_rmd/add_graphs-10.png) ![](figure_rmd/add_graphs-11.png) ![](figure_rmd/add_graphs-12.png) ![](figure_rmd/add_graphs-13.png) ![](figure_rmd/add_graphs-14.png) ![](figure_rmd/add_graphs-15.png) ![](figure_rmd/add_graphs-16.png) ![](figure_rmd/add_graphs-17.png) ![](figure_rmd/add_graphs-18.png) ![](figure_rmd/add_graphs-19.png) ![](figure_rmd/add_graphs-20.png) ![](figure_rmd/add_graphs-21.png) ![](figure_rmd/add_graphs-22.png) ![](figure_rmd/add_graphs-23.png) 

Creates prediction function for models


Creates models of variables of interest

```r
fit.1 <- glm(bmi~conde,data=dsL)
fit.2 <- lm(bmi~poly(conde,2),data=dsL)
fit.3 <- lm(bmi~poly(conde,3),data=dsL)
fit.4 <- lm(bmi~poly(conde,4),data=dsL)
fit.5 <- lm(bmi~poly(conde,5),data=dsL)
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
fit.1 <- lm(bmi~agey,data=dsL)
fit.2 <- lm(bmi~poly(agey,2),data=dsL)
fit.3 <- lm(bmi~poly(agey,3),data=dsL)
fit.4 <- lm(bmi~poly(agey,4),data=dsL)
fit.5 <- lm(bmi~poly(agey,5),data=dsL)
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

fit.1 <- lm(bmi~raedyrs,data=dsL)
fit.2 <- lm(bmi~poly(raedyrs,2),data=dsL)
fit.3 <- lm(bmi~poly(raedyrs,3),data=dsL)
fit.4 <- lm(bmi~poly(raedyrs,4),data=dsL)
fit.5 <- lm(bmi~poly(raedyrs,5),data=dsL)
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

fit.1 <- lm(bmi~cogtot,data=dsL)
fit.2 <- lm(bmi~poly(cogtot,2),data=dsL)
fit.3 <- lm(bmi~poly(cogtot,3),data=dsL)
fit.4 <- lm(bmi~poly(cogtot,4),data=dsL)
fit.5 <- lm(bmi~poly(cogtot,5),data=dsL)
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

Adds models to figures produced above
![](figure_rmd/add_model_data-1.png) ![](figure_rmd/add_model_data-2.png) ![](figure_rmd/add_model_data-3.png) ![](figure_rmd/add_model_data-4.png) 

## Conclusions

### Health conditions

Data show that the more health conditions you have, the higher your BMI. Given the high co-incidence of obesity (see Patterson et al., 2004) with certain health conditions such as diabetes and heart disease, this is not a surprising finding.

### Age

Data show that the older you are, the lower your BMI is. This is not a suprising finding, given that people who live longer tend to have better health, which would ideally correlate with a lower BMI.

###Cogtot

Data show that the higher your cognition, the lower your BMI.

###Education

Data seem show that the more years of education you have, the higher your BMI. This is somewhat suprising given that conventional wisdom (my bias?) says that education tends to correlate with wealth which correlates with better health. This could either indicate a problem with my conflation of BMI as a measurement of overall health or with differences in the retired population.

###Race

Race seems to show that being african american correlates with a higher BMI, this is not a super suprising finding, somewhat expected.

###Drink

Drinking data seems to show that when participants drink, they are more likely to have a lower BMI. This is a very suprising finding, although it could indicate a problem with their definition of drinking. Unfortunately I was unable to find the operation definition of if a participant drank or not, which could mean either quite a bit of drinking or just a certain number of drinks per week. 


###Shlt

Participants rating of their health (self-rated health score) indicates that people who rate their health lower tend to have a higher BMI.


## Appendix

Removes all variables except variables conisdered for models


