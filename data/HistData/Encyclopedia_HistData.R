rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.


## @knitr load_sources




## @knitr load_packages
library(dplyr)
library(ggplot2)
library(tidyr)
library(HistData)
library(testit, quietly=TRUE) #For asserts
library(rmarkdown)
library(tufterhandout)



## @knitr declare_globals
source("./scripts/graphs/main_theme.R")

unit_theme <- main_theme  + 
  theme(axis.ticks.length = grid::unit(0, "cm"))
# unit_themeBar <- unit_theme
# unit_themeBox <- unit_theme + 
#   theme(axis.ticks.x.length = grid::unit(0, "cm"))

data("Galton")

## @knitr load_data

## @knitr tweak_data

## @kntir basic_table


## @knitr basic_graph

## @knitr dummy
#####################################
## @knitr Galton_1
ds <- Galton
str(ds)
head(ds)

ggplot(ds, aes(x=1, y=parent)) +
  geom_boxplot(width=.5,fill="royalblue4", outlier.shape=1, outlier.size=4, outlier.colour="gray40", alpha=.5, na.rm=T) +
  stat_summary(fun.data=TukeyBoxplot, geom='boxplot', width=.5, fill="royalblue4", outlier.shape=1, outlier.size=4, outlier.colour="gray40", alpha=.5, na.rm=T) +
  scale_x_continuous(breaks=NULL, limits=c(.5, 1.5)) +
  unit_theme +
  theme(legend.position=c(0, 1), legend.justification=c(0, 1)) +
  labs(x=NULL, y="Number of Lifts (at Time 1)")


## @knitr dummy
#####################################
## @knitr Galton_2
ds <- Galton
dsL <- ds %>% tidyr::gather("person","height",1:2) %>% dplyr::arrange(person)
head(dsL)
g <- ggplot(dsL, aes(x=person, y=height, fill=person)) +
  geom_boxplot(outlier.shape=1, outlier.size=4,  alpha=.5, type=1) +  
  # stat_summary(fun.data=TukeyBoxplot, geom='boxplot', outlier.shape=1, outlier.size=4, alpha=.5) +
  scale_fill_manual(values=PalettePregancyDelivery) +
  unit_theme +
  theme(legend.position="none") + labs(x=NULL, y="Baby Birth Weight (in kg)")
g


# rmarkdown::render(input = "./data/HistData/Encyclopedia_HistData.Rmd", output_format="html_document", clean=TRUE)

