# replicate the Figure 1.1 from James et al, p.2.

rm(list=ls())


library(ISLR)
filePath <- file.path(getwd(),"materials/cases/advertising_sales/Advertising.csv")
Advertising <- read.csv(filePath) 
ds <- Advertising
head(ds)

## @knitr sales_tv
g <- ggplot2::ggplot(data=ds, aes(x=TV, y=Sales))
g <- g + geom_point()
g <- g + geom_smooth(method=lm)
g
