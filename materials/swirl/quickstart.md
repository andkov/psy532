## Quick start with R

- [A GOOD PLACE TO START LEARNING R](http://www.rstudio.com/resources/training/online-learning/): RStudio team collects the best online resources. Check out every link they mention, it's worth it.  

- [Data Science Specialization](https://github.com/DataScienceSpecialization) well-composed series of courses on data science.  


Start learning R interactively with [swirl](http://swirlstats.com/students.html), an R package that creates a dialogue environment inside RStudio.  

To initiate a learning session, open your RStudio and execute the following code:  

```
install.packages("swirl")  
install.packages("Rtools")  
install.packages("devtools")  
devtools::install_github(c("swirldev/swirl", "swirldev/swirlify"))  
library(swirl)  
```

Follow the prompt and complete the first lesson.

A great [intro into swirl](https://www.youtube.com/watch?v=S1tBTlrx0JY) by its creator [Nick Carchedi](http://nickcarchedi.com/)

I also recommend completing two free interactive courses at DataCamp: [Introduction to R](https://www.datacamp.com/courses/introduction-to-r) and [Data Analysis and Statistical Inference](https://www.datacamp.com/courses/data-analysis-and-statistical-inference_mine-cetinkaya-rundel-by-datacamp). Their content partially overlaps with the training by two available courses by [swirl](http://swirlstats.com/students.html) package, but gives a different take and examples. 


