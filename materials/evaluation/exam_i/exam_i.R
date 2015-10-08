rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.


## @knitr load_sources



## @knitr load_packages
library(dplyr) # for data manipulation
library(tidyr)
library(ggplot2) # for graphing
library(scales) #for formating values in graphs
library(testit, quietly=TRUE) #For asserts
library(corrplot)
library("PerformanceAnalytics") # for item analysis

## @knitr declare_globals

## @knitr load_custom
source("./scripts/graphs/main_theme.R")

## @knitr load_data
# exam_i_results_wide <- read.csv("C:/Users/koval_000/Google Drive/Courses/UVic-PSY-532-Univariate-GLM/materials/exams/exam_i/exam_i_results.csv")
# dsL <- tidyr::gather(ds,student,score,7:18)


exam_i_results <- read.csv("C:/Users/koval_000/Google Drive/Courses/UVic-PSY-532-Univariate-GLM/materials/exams/exam_i/exam_i_results.csv")

ds <- exam_i_results
# names(ds[1])
ds <- ds[!ds$name=="Andriy",]
ds <- ds[-1] # remove the name


## @knitr tweak_data
# head(ds) 
ds$total <- rowSums(ds) # compute the total
# head(ds)


## @knitr summary_stats
# head(ds)
sapply(ds,summary)





## @knitr corr_table
corr <- cor(ds)
corr 

## @knitr corr_graph
# see basics of corrplot
# https://cran.r-project.org/web/packages/corrplot/vignettes/corrplot-intro.html
# corrplot::corrplot(corr) 
corrplot::corrplot(corr,type="upper")
# corrplot::corrplot(corr,type="upper", method="number") 
corrplot::corrplot(corr,type="upper", method="pie") 
# corrplot::corrplot.mixed(corr, upper="pie", lower="number", tl.pos = "lt") 
# corrplot::corrplot(corr, order = "hclust", addrect = 3, method="pie")
# corrplot::corrplot.mixed(corr, order = "FPC", upper="pie", lower="number", tl.pos="lt")

# corrplotCustom <- function (corr, lower="number", upper="pie", bg="white", addgrid.col="gray", tl.cex=2)  {
#   n <- nrow(corr)
#   corrplot(corr, type="upper", method=upper, diag=TRUE, tl.pos="n", tl.cex=tl.cex)
#   corrplot(corr, add=TRUE, type="lower", method=lower, tl.pos="lt")
# }
# corrplotCustom(corr, tl.cex=1.2)  


## @knitr item_performance 
# http://www.sthda.com/english/wiki/factominer-and-factoextra-principal-component-analysis-visualization-r-software-and-data-mining#at_pco=smlwn-1.0&at_si=56168e3a61660900&at_ab=-&at_pos=0&at_tot=1
PerformanceAnalytics::chart.Correlation(ds, histogram=TRUE, pch=1)
  



###############################

## @knitr item_graphs
# for( i in 1:ncol(ds) ) {
  for( i in 1:15 ) {

  item  <- ds[i]
  item_name <- colnames(item)
  item_mean <-   round(mean(ds[,i]),2)
  item_sd <-  round(sd(ds[,i]),2)
  middle <- 3

  # d_bivariate_study <- ds_bivariate_pretty[ds_bivariate_pretty$study==study_name, ]
  # d_bivariate_study <- d_bivariate_study[ , -(1:2)]
  cat("") #Force a new line
  cat(paste0("### ", item_name))
  cat("\n") #Force a new line

#   mean(item)
#   sd(item)
#   cat("") #Force a new line
# #   cat(paste0("### ", gender))
#   cat("\n") #Force a new line

  g <- ggplot2::ggplot(item, aes_string(x=item_name))
  g <- g + geom_dotplot(aes(stat="identity"))
  # g <- g + geom_histogram(aes(stat="identity"))
  g <- g + geom_density(aes(stat="identity"), color="red")
  g <- g + geom_vline(xintercept = mean)
  g <- g + annotate(geom="text",x=item_mean, y=middle, label=paste0(item_mean," (",item_sd,")"))
  g <- g + main_theme
  print(g)
  cat("\n\n") #Force a new line
}


## @knitr spread_graph
ds

  g <- ggplot2::ggplot(item, aes(x=total, y=total))
  g <- g + geom_point(size=2, color="blue")
  g <- g + geom_text(aes(label=total), vjust=-2)
  # g <- g + geom_histogram(aes(stat="identity"))
  # g <- g + geom_density(aes(stat="identity"), color="red")
  # g <- g + geom_vline(xintercept = mean)
  # g <- g + annotate(geom="text",x=item_mean, y=middle, label=paste0(item_mean," (",item_sd,")"))
  g <- g + main_theme
  g

####################################  
# d <- tidyr::spread(dsL,name,score)
# head(d)

## @kntir basic_table
dsL <- tidyr::gather(ds, item_name, item_score, 1:15)



## @knitr basic_graph
g <- ggplot2::ggplot(dsL, aes(x=score))
g <- g + geom_boxplot(aes(y=name))
g <- g + geom_point(aes(y=name))
# g <- g + facet_grid(.~name)
g <- g + main_theme
g
####################################  




## @knitr reproduce
  rmarkdown::render(input = "./materials/evaluation/exam_i/exam_i.Rmd" ,
                    output_format="html_document", clean=TRUE)
  