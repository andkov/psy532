# replicate the Figure 1.1 from James et al, p.2.

rm(list=ls())
cat("\f")

library(ISLR)
library(ggplot2)

filePath <- file.path(getwd(),"materials/cases/ITSL_advertising/Advertising.csv")
Advertising <- read.csv(filePath) 
ds <- Advertising
head(ds)

## @knitr sales_tv
g <- ggplot2::ggplot(data=ds, ggplot2::aes(x=TV, y=Sales))
g <- g + geom_point()
g <- g + geom_smooth(method=lm)
g
