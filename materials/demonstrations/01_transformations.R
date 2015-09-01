cat("\f")
rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
options(digits = 3)

## @knitr load_sources



## @knitr load_packages
library(dplyr) # for data manipulation
library(ggplot2) # for graphing
library(scales) #for formating values in graphs
library(HistData)
library(testit, quietly=TRUE) #For asserts
library(ISLR)

## @knitr declare_globals


## @knitr load_data
# https://stat.ethz.ch/R-manual/R-devel/library/datasets/html/women.html
ds <- datasets::women
ds$id <- seq_along(ds$height)
ds <- ds[,c("id","height","weight")]
ds

## @knitr inspect_ds
str(ds)
head(ds, 15)

## @knitr tweak_data


## @knitr in_to_cm
ds$h_cm <- ds$height * 2.54
## @knitr lbs_to_kg
ds$w_kg <- ds$weight * .454 

## @knitr into_z
ds$h_z <- (ds$height - mean(ds$height))/sd(ds$height)
ds$w_z <- (ds$weight - mean(ds$weight))/sd(ds$weight)

## @knitr scale_function
ds$h_s <- base::scale(ds$height, center = TRUE, scale = TRUE)
ds$w_s <- base::scale(ds$weight, center = TRUE, scale = TRUE)

## @knitr remove_column_from_ds
drop <- c("h_s","w_s")
ds <- ds[!(names(ds) %in% drop)]


## @knitr
# ds <- datasets::women
# ds <- ds[-2]

## @knitr
Mh <- mean(ds$height)
Mw <- mean(ds$weight)
Mh; Mw

## @knitr
SDh <- sd(ds$height)
SDw <- sd(ds$weight)
SDh; SDw

## @knitr
ds$mean <-mean(ds$height)
ds$SD <- sd(ds$height)
ds$deviation <- ds$mean - ds$height
ds$z <- ds$deviation / ds$SD
ds

## @kntir basic_table


## @knitr basic_graph



m1 <- lm(height ~ 1, ds)

ds$m1 <- predict(m1)
ds


m1a <- lm(z ~ 1, ds)
ds$m1a <- predict(m1a)
ds




##################### dev script below this line











