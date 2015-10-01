## 1 October 2015
- Validity in Research Design    
- new script added that allows you to [generate correlated data data](https://github.com/andkov/psy532/blob/master/scripts/data/generate_correlated_data.R), that is exact data that exhibit the specific interdependencies (correlations)
- Explore the data that lead Galton to discovery of [regression](https://github.com/andkov/psy532/blob/master/materials/lectures/correlation_regression/corr_reg.R) 


## 28 Sep 2015
- new script that explores the numeric example from Maxwell & Delaney (2004, p.91), [table 3.3 - mood induction study](https://github.com/andkov/psy532/blob/master/materials/cases/MD_3_mood/one_way_designs.R) 
- new starter script is added on using the [glm function](https://github.com/andkov/psy532/blob/master/scripts/modeling/glm_starter.R). Use it to get started with statistical modeling. 

- *areaF* : Quick graphs of model comparison. Copy/past the following content to get started.
```
rm(list=ls(all=TRUE)) # clear environment
cat("\f") # clear console
library(ggplot2) # load ggplot2 package for graphing
# load areaF function
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/areaF_graphing.R")
areaF(6136, 26, 6525, 29 )
```


## 24 Sep 2015
- we will be looking at the exercise from ISLR, chapter 2, number 8. 
- we will start with the [unofficial solution](https://raw.githubusercontent.com/asadoughi/stat-learning/master/ch2/applied.R)
- and end up with an expanded and [annotated version](https://github.com/andkov/psy532/blob/master/projects/homework/chapter2/hw_chapter_2_8.R)


##21 Sep 2015
- we will reproduce the example from Maxwell & Delaney (2004) p.77. Please open the following [script template](https://github.com/andkov/psy532/blob/master/materials/cases/MD_3_WISC-R/WISC_hyperactive_student.R) in RStudio.
