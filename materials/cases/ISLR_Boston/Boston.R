rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\f") # clear console



# @knitr load_packages
library(dplyr) # for data manipulation
library(ggplot2) # for graphing
library(ISLR)


# @knitr load_sources --------------------------------------- 
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/main_theme.R")


# @knitr declare_globals ---------------------------------------


# @knitr load_data ---------------------------------------
ds <- MASS::Boston 
head(ds)


# @knitr tweak_data ---------------------------------------
ds$chasF <- factor(ds$chas, levels=c(0, 1), labels=c("No river", "River"))

levels(ds$chasF)

# @kntir basic_table ---------------------------------------
summary(ds)

# @knitr basic_graph ---------------------------------------
g <- ggplot2::ggplot(data=ds, aes(x=lstat, y=crim)) +
  geom_point()
g


# @knitr reproduce ---------------------------------------
#   rmarkdown::render(input = "./reports/report.Rmd" ,
#                     output_format="html_document", clean=TRUE)