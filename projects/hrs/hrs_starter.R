rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\f") # clear console



# @knitr load_packages
library(dplyr) # for data manipulation
library(ggplot2) # for graphing
library(ISLR) # book

# @knitr load_sources --------------------------------------- 
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/main_theme.R")

# @knitr declare_globals ---------------------------------------
filePath <- "./data/hrs/hrs_retirement.sav"

# @knitr load_data ---------------------------------------
ds <- Hmisc::spss.get(filePath, use.value.labels = TRUE)

# @knitr inspect_data ---------------------------------------
ds %>% dplyr::count() %>% n_distinct(hhidpn)
# @knitr tweak_data ---------------------------------------

# @kntir basic_table ---------------------------------------

# @knitr basic_graph ---------------------------------------

# @knitr new_chunk ---------------------------------------

