# Quick start with R

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



# Courses

## R
- [Introduction to R](https://www.datacamp.com/courses/introduction-to-r)  by DataCamp   
- [Introduction to R](http://ateucher.github.io/rcourse_site/)  by [Andy Teucher](https://github.com/ateucher)
- [Programming with R](http://swcarpentry.github.io/r-novice-inflammation/)  by [Software carpentry](http://software-carpentry.org/)

## Statistics
- [Data Analysis and Statistical Inference](https://www.datacamp.com/courses/data-analysis-and-statistical-inference_mine-cetinkaya-rundel-by-datacamp) by DataCamp  
- [statistical computing for biostatistics](http://www.biostat.jhsph.edu/~hji/courses/statcomputing/)  by Honkgkai Ji , Ph.D., at Johns Hopkins Bloomberg School of Public Health  
- Collection of [R Tutorials](http://www.cyclismo.org/tutorial/R/) by Kelly Black at Clarkson Univeristy. Approximately covers an intro to stats undergrad course.
- [Introduction to Biostatistics](http://stronginference.com/Bios6301/)  taught at Vanderbilt by [Chris Fonnesbeck](https://github.com/fonnesbeck?tab=repositories)
- [Statistical Computing in R](http://www.pitt.edu/~njc23/) a biostatistics course by   Nicholas Christian at University of Pittsburgh.  Great series of slides on essential programming vocabulary and techniques  for statistical modeling. Exemplifies SWEAVE for report generation.  
- [Introductory modeling course](http://statpower.net/310LectureSlides.html) introductory course in Statistical Inference for graduate students in Psychological Sciences  by James Steiger  


# Collections 

- [RStudio cheatsheets](http://www.rstudio.com/resources/cheatsheets/) such a great resource I have put it into a single [pdf](./materials/pdf/R_Studio_Cheat_Sheets.pdf) and keep it on my Desktop.
- [R by Example](http://www.mayin.org/ajayshah/KB/R/) organized example scripts 
- [Most useful R commands](http://www.personality-project.org/r/r.commands.html) according to [personality-project.org](http://www.personality-project.org/index.html) ([William Revelle](http://www.personality-project.org/revelle.html))
- [Resources Opinions](https://github.com/OuhscBbmc/RedcapExamplesAndPatterns/blob/master/DocumentationGlobal/ResourcesOpinions.md)  Will Beasley gives  brief reviews of key books and resources
- [Quick-R](http://www.statmethods.net/) - thorough and convenient resource for R reference

## Videos
- [twotorials](http://www.twotorials.com/) A collection of video tutorials on R
- [Hastie and Tibshirani](http://www.r-bloggers.com/in-depth-introduction-to-machine-learning-in-15-hours-of-expert-videos/) narrate their book.  

## Data 

- Excellent [collection of datasets](http://www.statsci.org/datasets.html) 
- [HistData](./data/HistData/Encyclopedia_HistData.md) Wiki overviews some of the historic datasets from the [HistData](./data/HistData/README.md) package that will be used in the course.


## Extra

-  [Statistical Collaboration with GitHub](http://htmlpreview.github.io/?https://raw.githubusercontent.com/OuhscBbmc/StatisticalComputing/master/2014_Presentations/05_May/BeasleyScugGitHub2014-05.html#/) presentation by Will Beasley.




# Skill sets
  Links grouped by the skillset. 


## Data Management

-  [Introduction to data cleaning in R](http://cran.r-project.org/doc/contrib/de_Jonge+van_der_Loo-Introduction_to_data_cleaning_with_R.pdf), a discussion paper by Edwin de Jonge and 
Mark van der Loo.

## Graph Production
- Winston Chan's [R Cookbook](http://shop.oreilly.com/product/9780596809164.do) is a perfect book to get you started with producing graphs with RStudio

## Statistical Modeling

### Package support  

- [lm]()  
- [glm]()  

## Dynamic reporting

- in-browser [live markdown and R](https://demo.ocpu.io/markdownapp/www/) simulation. Great for immediate feedback on finding the right line editing.

### Markdown
- [markdown in R](http://jeromyanglim.blogspot.ca/2012/05/getting-started-with-r-markdown-knitr.html) : a blog entry on getting started with **rmarkdown** - a version of markdown enhanced for the use with RStudio.  By Jeromy Anglim.
- [markdown guide](http://daringfireball.net/projects/markdown/) : a well-written "breaking into" guide. Gives ample verbal description. Recommended for newbies. By John Gruber.  
- [markdown cheat-sheet](http://support.mashery.com/docs/customizing_your_portal/Markdown_Cheat_Sheet) : brief, simple, parallel view of what the code is doing.By Mashery group.   
- [markdown simulator](https://demo.ocpu.io/markdownapp/www/), created in javascript by  [Jeroen Ooms](http://jeroenooms.github.io/). 


### Slides  
- RStudio provides a native format for creating presentations - **.Rpres**, availible in the "New file" option. For a quick start with .Rpres see this [article](https://support.rstudio.com/hc/en-us/articles/200486468-Authoring-R-Presentations)
 

 
# Views and conventions 

- I do my best to follow the [Best Practices for Scientific Computing](http://journals.plos.org/plosbiology/article?id=10.1371/journal.pbio.1001745)

# More 


 
 
 
 
 
