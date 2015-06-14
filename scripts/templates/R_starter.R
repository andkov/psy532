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



## @knitr tweak_data



## @kntir basic_table


## @knitr basic_graph