# Data analysis for final report
Thomas Ferguson  
<!-- for more options study http://rmarkdown.rstudio.com/html_document_format.html  -->
<!-- The report is produced from
REPOSITORY: the-name-of-the-repository
BRANCH: the-name-of-the-branch
PATH: ../Reports/
-->

<!--  Set the working directory to the repository's base directory; this assumes the report is nested inside of only one directory.-->


<!-- Set the report-wide options, and point to the external script file. -->



Prepare RStudio environment for all tasks to follow. 

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
base::require(gam)
base::require(leaps)
```


```r
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/main_theme.R")
```



We load the data derived by the script "./reports/data_preparation/dsL_hrs.R"" 
Variables chosen are age in years, eduction in years, gender, race, if they drink currently, if they smoked ever,

```r
# load a derived dataset
dsL <- readRDS("./data/derived/hrs_drv_dsL.rds")
```

Load graph settings for creating figures

```r
# load themes used to style graphs
source("./scripts/graphs/graph_themes.R")
```

Chooses variables for model - End up with model of ~6 or 7 due to conflicting results (seemed reasonable - dropped the least significant factors which were gender, mstot, depressive symptoms and sample weight

```r
#variables used - bmi + rabyear + wtresp+ + shlt + cesd+ conde+ agey+ cogtot+ mstot+ vigact + smokev + drink + shltc
#full
ds.prime<- readRDS("./data/raw/hrs_retirement.rds")
ds <- ds.prime[ds.prime$wave==10, ]
selectVars <- c("hhidpn", "bmi", "conde",  "agey", "cogtot", "mstot", "raedyrs", "cesd", "shlt", "ragender", "raracem", "smokev", "drink", "wtresp", "shltc")
ds2 <- ds[,selectVars]
ds3 <- mutate(ds2, shltnum = substring(shlt, 1, 1)) #change the \\D command
ds4 <- dplyr::mutate(ds3, gendernum = substring(ragender, 1, 1)) #decide if needed...
ds5 <- dplyr::mutate(ds4, racenum = substring(raracem, 1, 1))
ds6 <- dplyr::mutate(ds5, smokenum = substring(smokev, 1, 1))
ds7 <- dplyr::mutate(ds6, drinknum = substring(drink, 1, 1))
ds8 <- select(ds7, -shlt) 
ds9 <- select(ds8, -ragender) 
ds10 <- select(ds9, -raracem)
ds11 <- select(ds10, -smokev)
ds12 <- select(ds11, -drink)

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
```


```r
#Variables coefficiants
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

![](figure_rmd/model_selection2-1.png) 

Create Plots of cognition versus BMI (with race as a factor)

```r
#Conde (by race)
plot.1 <- ggplot2::ggplot(data=dsL, aes(x=conde, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(xlab="Number of chronic Health Conditions")+
  guides(fill=guide_legend(title="Race"))
plot.1
```

![](figure_rmd/add_graphs1-1.png) 


```r
plot.1a <- plot.1 +  facet_grid(. ~ raracem) #may want to take this out....
plot.1a
```

![](figure_rmd/add_graphs2-1.png) 


```r
#age (by race) Graph
plot.2 <- ggplot2::ggplot(data=dsL, aes(x=agey, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Race"))
plot.2
```

![](figure_rmd/add_graphs3-1.png) 


```r
plot.2 +  facet_grid(. ~ raracem) #may want to take this out....
```

![](figure_rmd/add_graphs4-1.png) 


```r
#cogtot by race 
plot.3 <- ggplot2::ggplot(data=dsL, aes(x=cogtot, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Race"))
plot.3
```

![](figure_rmd/add_graphs5-1.png) 


```r
plot.3 +  facet_grid(. ~ raracem) #may want to take this out....
```

![](figure_rmd/add_graphs6-1.png) 


```r
#education in years by race
plot.4 <- ggplot2::ggplot(data=dsL, aes(x=raedyrs, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Race"))
plot.4
```

![](figure_rmd/add_graphs7-1.png) 


```r
plot.4 +  facet_grid(. ~ raracem) #may want to take this out....
```

![](figure_rmd/add_graphs8-1.png) 


```r
#Conde (by drinks).
plot.5 <- ggplot2::ggplot(data=dsL, aes(x=conde, y=bmi, fill=drink)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("lightgreen", "indianred"))+
  # labs(xlab="Number of chronic Health Conditions")+
  guides(fill=guide_legend(title="Drink"))
plot.5
```

![](figure_rmd/add_graphs9-1.png) 


```r
plot.5 +  facet_grid(. ~ drink) #may want to take this out....
```

![](figure_rmd/add_graphs10-1.png) 


```r
#age by if drinks
plot.6 <- ggplot2::ggplot(data=dsL, aes(x=agey, y=bmi, fill=drink)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("lightgreen", "indianred"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Drink"))
plot.6
```

![](figure_rmd/add_graphs11-1.png) 


```r
plot.6 +  facet_grid(. ~ drink) #may want to take this out....
```

![](figure_rmd/add_graphs12-1.png) 


```r
#cogtot by if drinks
plot.7 <- ggplot2::ggplot(data=dsL, aes(x=cogtot, y=bmi, fill=drink)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("lightgreen", "indianred"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Drink"))
plot.7
```

![](figure_rmd/add_graphs13-1.png) 


```r
plot.7 +  facet_grid(. ~ drink) #may want to take this out....
```

![](figure_rmd/add_graphs14-1.png) 


```r
#education in years by if drinks
plot.8 <- ggplot2::ggplot(data=dsL, aes(x=raedyrs, y=bmi, fill=drink)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("lightgreen", "indianred"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Drink"))
plot.8
```

![](figure_rmd/add_graphs15-1.png) 


```r
plot.8 +  facet_grid(. ~ drink) #may want to take this out....
```

![](figure_rmd/add_graphs16-1.png) 


```r
#Conde (by gender) Graph - ideal one...
plot.9 <- ggplot2::ggplot(data=dsL, aes(x=conde, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(xlab="Number of chronic Health Conditions")+
  guides(fill=guide_legend(title="Gender"))
plot.9
```

![](figure_rmd/add_graphs17-1.png) 


```r
plot.9 +  facet_grid(. ~ ragender) #may want to take this out....
```

![](figure_rmd/add_graphs18-1.png) 


```r
#age (by gender Graph
plot.10 <- ggplot2::ggplot(data=dsL, aes(x=agey, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Gender"))
plot.10
```

![](figure_rmd/add_graphs19-1.png) 


```r
plot.10 +  facet_grid(. ~ ragender) #may want to take this out....
```

![](figure_rmd/add_graphs20-1.png) 


```r
#cogtot by gender
plot.11 <- ggplot2::ggplot(data=dsL, aes(x=cogtot, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Gender"))
plot.11
```

![](figure_rmd/add_graphs21-1.png) 


```r
plot.11 +  facet_grid(. ~ ragender) #may want to take this out....
```

![](figure_rmd/add_graphs22-1.png) 


```r
#education in years by gender
plot.12 <- ggplot2::ggplot(data=dsL, aes(x=raedyrs, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Gender"))
plot.12
```

![](figure_rmd/add_graphs23-1.png) 


```r
plot.12 +  facet_grid(. ~ ragender) #may want to take this out....
```

![](figure_rmd/add_graphs24-1.png) 
Creates prediction function for models


Creates models of variables of interest

```r
fit.1 <- glm(bmi~conde,data=dsL)
fit.2 <- lm(bmi~poly(conde,2),data=dsL)
fit.3 <- lm(bmi~poly(conde,3),data=dsL)
fit.4 <- lm(bmi~poly(conde,4),data=dsL)
fit.5 <- lm(bmi~poly(conde,5),data=dsL)
anova(fit.1,fit.2,fit.3,fit.4,fit.5) #linear is the way to go...?
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

```r
# attach  a line to the graph produced in the previous chunk
#add CI/jitter to lines -- stat.smooth stuff I believe
#after visual examination - cubic chosen for number of health conditions (conde) and for agey (age of participant), linear chosen for education (in years)

#For Condition (by Race) 
plot.1ab <- plot.1 + stat_smooth(method="lm", formula= y ~ ns(x,1))
plot.1ab
```

![](figure_rmd/add_model_data1-1.png) 


```r
plot.2ab <- plot.2 + stat_smooth(method="lm", formula= y ~ ns(x,2))
plot.2ab
```

![](figure_rmd/add_model_data2-1.png) 


```r
plot.3ab <- plot.3 + stat_smooth(method="lm", formula= y ~ ns(x,2))
plot.3ab
```

![](figure_rmd/add_model_data3-1.png) 


```r
plot.4ab <- plot.4 + stat_smooth(method="lm", formula= y ~ ns(x,2))
plot.4ab
```

![](figure_rmd/add_model_data4-1.png) 

### Conclusions

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

```r
# # remove all but specified dataset
rm(list=setdiff(ls(), c("dsL")))
dsL <- readRDS("./data/derived/hrs_drv_dsL.rds")
```

