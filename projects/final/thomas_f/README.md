Final Project Read Me file 
--- 
##Summary of Final project
 
 This file has links to the data, the reports and the presentation 

###Links

links to data folder: [data link](./data)

links to data (raw): [data link](./data/raw)

links to data (derived): [data link 2](./data/derived)

links to data preperation code: [data prep R](./data_preperation/dsl_hrs_annotated.R)

links to data preperation (Rmd): [data prep Rmd](./data_preperation/dsl_hrs_annotated.Rmd)

link to data preperation report (html): [data prep html](./data_preperation/dsl_hrs_annotated.html)

links to data analysis code: [data analysis R](./data_analysis/basic_analysis.R)

links to data analysis (Rmd): [data analysis Rmd](./data_analysis/basic_analysis.Rmd)

link to data analysis report (html): [data analysis html](./data_analysis/basic_analysis.html)

###About the project

This project attempts to model BMI (Body mass index) versus a number of different predictor variables (such as educatior (in years), age, cognition score (a measure that combines working memory and a number of other variables)). Best sub-set selection is used to identify the ideal number of variables to include in the model. Cross-validation was attempted but did not work due to technical errors. Instead, 4 coefficiants (Rss, Rsquared, BIC and Cp) were calculated to assess model fit. Significant variables had their shape (linear, quadratic, cubic, etc.) assessed to determine the most appropriate relationship to BMI. In the end, no multivariate models were modeled, however a number of univariate models of variables that were identified to be significant were used (using the appropriate variable form determined above) and had their relationship to BMI plotted (along with factors that were determined to be significant such as if the participant drank, race or gender)
