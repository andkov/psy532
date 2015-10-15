rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\f") # clear console

@knitr load_sources ---------------------------------------



# @knitr load_packages
library(dplyr) # for data manipulation
library(ggplot2) # for graphing
library(scales) #for formating values in graphs
library(HistData)
library(testit, quietly=TRUE) #For asserts

# @knitr load_custom --------------------------------------- 
source("./scripts/graphs/main_theme.R")


# @knitr declare_globals ---------------------------------------



# @knitr load_data ---------------------------------------



# @knitr tweak_data ---------------------------------------



# @kntir basic_table ---------------------------------------


# @knitr basic_graph ---------------------------------------


# @knitr reproduce ---------------------------------------
#   rmarkdown::render(input = "./reports/report.Rmd" ,
#                     output_format="html_document", clean=TRUE)