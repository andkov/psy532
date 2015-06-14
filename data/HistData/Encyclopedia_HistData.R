rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.


## @knitr load_sources




## @knitr load_packages
library(dplyr)
library(ggplot2)
library(reshape2)
library(HistData)
library(testit, quietly=TRUE) #For asserts



## @knitr declare_globals



## @knitr load_data
data("Galton")
ds <- Galton


## @knitr tweak_data



## @kntir basic_table
str(ds)

dplyr::tbl_df(ds)


## @knitr basic_graph
with(Galton, 
	{
	sunflowerplot(parent,child, xlim=c(62,74), ylim=c(62,74))
	reg <- lm(child ~ parent)
	abline(reg)
	lines(lowess(parent, child), col="blue", lwd=2)
	if(require(car)) {
	dataEllipse(parent,child, xlim=c(62,74), ylim=c(62,74), plot.points=FALSE)
		}
  })


# rmarkdown::render(input = "./data/HistData/Encyclopedia_HistData.Rmd", output_format="html_document", clean=TRUE)

