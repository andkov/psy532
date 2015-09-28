## 28 Sep 2015

*areaF* - Quick graphs of model comparison
```
rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\014")

library(ggplot2)

# load areaF function
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/areaF_graphing.R")

BuildMosaic(120, 5, 336, 6, 20 )
areaF(6136, 26, 6525, 29 )
```


## 24 Sep 2015
- we will be looking at the exercise from ISLR, chapter 2, number 8. 
- we will start with the [unofficial solution](https://raw.githubusercontent.com/asadoughi/stat-learning/master/ch2/applied.R)
- and end up with an expanded and [annotated version](https://github.com/andkov/psy532/blob/master/projects/homework/chapter2/hw_chapter_2_8.R)


##21 Sep 2015
- we will reproduce the example from Maxwell & Delaney (2004) p.77. Please open the following [script template](https://github.com/andkov/psy532/blob/master/materials/cases/MD_3_WISC-R/WISC_hyperactive_student.R) in RStudio.
