rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\014")

## @knitr load_sources


## @knitr load_packages
library(dplyr) # for data manipulation
library(ggplot2) # for graphing
library(scales) #for formating values in graphs
library(HistData)
library(testit, quietly=TRUE) #For asserts
library(extrafont)

source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/main_theme.R")

## @knitr declare_globals



## @knitr load_data
# load Galton's data. read more: 
ds <- HistData::Galton 
head(ds)
nrow(ds)
??

## @knitr tweak_data
# ds$parent <- ds$parent * c(2.54)
# ds$child <- ds$child * c(2.54)
# head(ds)

## @kntir basic_table
g <- ggplot2::ggplot(ds, aes(x=child, y=parent))
g <- g + geom_point()
# g <- g + geom_smooth(method=lm, se=T)
g <- g + geom_smooth(method=lm, se=T)
g <- g + main_theme
g
??geom_smooth


## @knitr basic_graph_parent


(Sy <- sd(ds$parent))
(Sx <- sd(ds$child))
(Rxy <- cor(ds$parent, ds$child))
  
  
m1 <- glm(parent ~ 1 + child, data=ds)
summary(m1)
(b <- coef(m1)["child"][[1]])
b

bprime <- Rxy*(Sy/Sx)
