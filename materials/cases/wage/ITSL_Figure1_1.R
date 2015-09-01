# replicate the Figure 1.1 from James et al, p.2.

rm(list=ls())


library(ISLR)
ds <- Wage
head(ds)

library(ggplot2)

## @knitr wage_by_age
g <- ggplot2::ggplot(data=ds, aes(x=age, y=wage))
g <- g + geom_point()
g <- g + geom_smooth(color="black", size=2)
g


## @knitr wage_by_year
g <- ggplot2::ggplot(data=ds, aes(x=year, y=wage))
g <- g + geom_point()
g <- g + geom_smooth(method=lm)
g

## @knitr wage_by_edu
g <- ggplot2::ggplot(data=ds, aes(x=education, y=wage))
g <- g + geom_violin(aes(fill=education), trim=TRUE)
g <- g + geom_boxplot(width=.1, fill="black", outlier.colour=NA)
g <- g + stat_summary(fun.y=mean, geom="point", fill="white", shape=21, size=2.5)
g
