rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\f") # clear console



# @knitr load_packages
library(dplyr) # for data manipulation
library(ggplot2) # for graphing


# @knitr load_sources --------------------------------------- 
source("./scripts/graphs/main_theme.R")
source("./scripts/graphs/areaF_graphing.R")

# @knitr declare_globals ---------------------------------------



# @knitr load_data ---------------------------------------
filePath <- "./data/ISLR/Auto.data" 
ds <- read.table(filePath, header=T, na.strings="?")
head(ds)
dim(ds)

# @knitr tweak_data ---------------------------------------
ds <- na.omit(ds)
dim(ds)

# @knitr basic_table ---------------------------------------
summary(ds)

# @knitr basic_graph ---------------------------------------

# @knitr itsl_6_8 ---------------------------------------
mlm <- lm(mpg ~ horsepower, data=ds)
summary(mlm)

mglm <- glm(formula=mpg ~ horsepower,data=ds )
summary(mglm)


# @knitr reproduce ---------------------------------------
  rmarkdown::render(input = "./projects/homework/chapter3/hw_chapter_3.Rmd" ,
                    output_format="html_document", clean=TRUE)