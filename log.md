## 22 October 2015
- have cheatsheets on [ggplot](https://www.rstudio.com/wp-content/uploads/2015/08/ggplot2-cheatsheet.pdf) and [data wrangling](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) in quick access  
- refer to the documentation on [geom_smooth()](http://docs.ggplot2.org/0.9.3.1/stat_smooth.html), by Hadley Wickham  
- exploring [smoothers in graphs](http://www.ats.ucla.edu/stat/r/faq/smooths.htm), UCLA  
- simple example of adding [polynomials](http://stackoverflow.com/questions/11949331/adding-a-3rd-order-polynomial-and-its-equation-to-a-ggplot-in-r) to ggplot smoother  
- read up on the difference between [geom_smooth]() and [stat_smooth](http://www.rdocumentation.org/packages/ggplot2/functions/stat_smooth) on the RDocumentation. 

#### In-Class Progression
0. Load the script from ```./scripts/reports/R_starter.R```
1. create object ```ds``` from ```MASS::Boston```
2. inspect and explore data
3. make ```chas``` a factor and add level labels



## 15 October 2015
- More on GLM and coefficient estimation. Check out this lecture on [basic matrix algebra](http://www.statpower.net/Content/313/Lecture%20Notes/RMatrix.pdf) in R by James Steiger.   
- Case : [Advertising](https://github.com/andkov/psy532/blob/master/materials/cases/ITSL_advertising/ITSL_Figure2_1.R), replicating the figures and graphs   
- [R_starter.R](./scripts/reports/R_starter.R)   
- [glm_starter.R](./scripts/modeling/glm_starter.R)

## 8 October 2015
- Exam I  results: [html](http://htmlpreview.github.io/?https://raw.githubusercontent.com/andkov/psy532/master/materials/evaluation/exam_i/exam_i.html), [md](https://github.com/andkov/psy532/blob/master/materials/evaluation/exam_i/exam_i.md)

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
