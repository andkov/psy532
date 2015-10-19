# replicate the Figure 1.1 from James et al, p.2.

rm(list=ls())
cat("\f")

library(ISLR)
library(ggplot2)
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/main_theme.R")

 
filePath <- file.path(getwd(),"materials/cases/ITSL_advertising/Advertising.csv")
Advertising <- read.csv(filePath) 
ds <- Advertising
head(ds)

# @knitr sales_tv ----------
g <- ggplot2::ggplot(data=ds, ggplot2::aes(x=TV, y=Sales))
g <- g + geom_point(shape=21, color="red", size=4)
g <- g + geom_smooth(method=lm, fill="white", color = "red", size=1.5)
g <- g + main_theme 
g <- g + scale_x_continuous(breaks=seq(from=0, to=300, by=50))
g <- g + labs(title="Advertising", x = "Television", y = "Sales in $")
g


# @knitr define_graph_function -----

make_graph <- function(ds, outcome){
  g <- ggplot2::ggplot(data=ds, ggplot2::aes_string(x=outcome, y="Sales"))
  g <- g + geom_point(shape=21, color="red", size=4)
  g <- g + geom_smooth(method="lm", fill="white", color = "red", size=1.5)
  g <- g + main_theme 
  g <- g + scale_x_continuous(breaks=seq(from=0, to=300, by=50))
  g <- g + labs(title="Advertising", x = "Television", y = "Sales in $")
  return(g)
}
g <- make_graph(ds,outcome="Newspaper")
g 



