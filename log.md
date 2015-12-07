## 7 Dec 2015
- [student presentations](./projects/final/README.md)

## 23 November 2015
 - see [final project guidelines](https://github.com/andkov/psy532/tree/master/projects) to help with your development    
 - study an [example](https://github.com/andkov/Longitudinal_Models_of_Religiosity_NLSY97/tree/master/Data) of a "data creation" report for NLSY97  

## 19 November 2015

- RStudio cheatsheet for [building dynamic documents](https://www.rstudio.com/wp-content/uploads/2015/02/rmarkdown-cheatsheet.pdf)  
- official documentation to [rmarkdown](http://rmarkdown.rstudio.com/) with illustrative examples  
- download and save [dsL_nlsy97.R](https://raw.githubusercontent.com/andkov/psy532/master/scripts/data/dsL_nlsy97.R)
- download and save [dsL_nlsy97_annotated.Rmd](https://raw.githubusercontent.com/andkov/psy532/master/projects/nlsy97/data_creation_report/dsL_nlsy97_annotated.Rmd) 
- download and save this [archived file](https://github.com/IALSA/COAG-colloquium-2014F/blob/master/Data/Extract/NLSY97_Attend_20141021.zip) and unzip it in you `./data/raw` folder

## 16 November 2015
- Exam II  results: [html](http://htmlpreview.github.io/?https://raw.githubusercontent.com/andkov/psy532/master/materials/evaluation/exam_ii/exam_ii.html), [md](https://github.com/andkov/psy532/blob/master/materials/evaluation/exam_ii/exam_ii.md)  
- interactive visualization of [effect size](http://rpsychologist.com/d3/cohend/) and [NSHT](http://rpsychologist.com/d3/NHST/)


## Nov 2 2015
 - Review my lecture on [data manipulation](http://ialsa.github.io/COAG-colloquium-2014F/2014-10-21-Data-Manipulation.html) using NLSY97 data.    
 - Reproduce and enchance the script ([dsL_nlsy97.R](https://github.com/andkov/psy532/blob/master/scripts/data/dsL_nlsy97.R)) that produces the presentation above.   
 - We will be replicating Hadley's script ([case-study.r](https://github.com/hadley/tidy-data/blob/master/case-study/case-study.r)) that accompanied his paper on tidy data.   
 - We will slightly adjusting it ([case-study-andkov.R](https://github.com/andkov/psy532/blob/master/materials/cases/tidy_data/case-study-andkov.r)) to fit our environment and annotate it better.    
 

## 29 Oct 2015
- Student projects example: HRS retirement  [README](https://github.com/andkov/psy532/tree/master/data/hrs)  
- use [hrs_starter](https://github.com/andkov/psy532/blob/master/projects/hrs/hrs_starter.R)  to get the data in and see the first few graphs  
- consult [Issue #15](https://github.com/andkov/psy532/issues/15) for ```geom_smooth``` vocabulary

## 26 Oct 201
- how to create graphing functions, examplified with [Boston case](https://github.com/andkov/psy532/blob/master/materials/cases/ISLR_Boston/Boston_end.R) 
- Handling model objects (S3/S4) [glm_starter.R](./scripts/modeling/glm_starter.R)  
- combine multiple graphs with `grid.arrange`  
- Introduction to data for potential class projects: [HRS](https://github.com/andkov/psy532/tree/master/data/hrs) and [NLSY97](https://github.com/andkov/psy532/tree/master/data/nlsy97)

## 22 October 2015
- have cheatsheets on [ggplot](https://www.rstudio.com/wp-content/uploads/2015/08/ggplot2-cheatsheet.pdf) and [data wrangling](https://www.rstudio.com/wp-content/uploads/2015/02/data-wrangling-cheatsheet.pdf) in quick access  
- refer to the documentation on [geom_smooth()](http://docs.ggplot2.org/0.9.3.1/stat_smooth.html), by Hadley Wickham  
- exploring [smoothers in graphs](http://www.ats.ucla.edu/stat/r/faq/smooths.htm), UCLA  
- simple example of adding [polynomials](http://stackoverflow.com/questions/11949331/adding-a-3rd-order-polynomial-and-its-equation-to-a-ggplot-in-r) to ggplot smoother  
- read up on the difference between [geom_smooth](http://www.rdocumentation.org/packages/ggplot2/functions/geom_smooth) and [stat_smooth](http://www.rdocumentation.org/packages/ggplot2/functions/stat_smooth) on the RDocumentation. 

#### In-Class Progression
0. Load the script from './scripts/reports/R_starter.R`  
1. Create object 'ds' from 'MASS::Boston'  
2. Inspect and explore data  
	- QUESTIONS: what is the key determinant(s) of crime?   
	- inspect linear model using all variables as predictors of crime  
3. Create a basic scatter plot with `x=lstat` and `y=crime`  
4. Walk through all predictors with ggplot  
5. What predictor(s) could be mapped to color?   
6. Make `chasF` a factor and add level labels  
7. As you walk through models again, 
	a) add custom color values 
	b) modify `goem_point` to optimize visual exploration
	c) add custom title to the color scale
8. Create a function to generate a graph with `y=crime`
 - remember to use `aes_string`
9. Map another variable to color (`radF`) 
10. make the adjustements to the graph to accomodate `rad` variable
11. Create a dynamic title in `labs()` using `paste0()' 
12. Subset data to remove target level of the predictor
13. Re-analyze
	



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
