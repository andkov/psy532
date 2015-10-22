rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\f") # clear console



# @knitr load_packages
library(dplyr) # for data manipulation
library(ggplot2) # for graphing
library(ISLR) # book


# @knitr load_sources --------------------------------------- 
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/main_theme.R")


# @knitr declare_globals ---------------------------------------


# @knitr load_data ---------------------------------------
ds <- MASS::Boston 

# @knitr inspect_data
head(ds)
str(ds)
mdl <- lm(crim ~ ., ds)
summary(mdl)

# @knitr tweak_data ---------------------------------------
ds$chasF <- factor(ds$chas, levels=c(0, 1), labels=c("No", "Yes"))
levels(ds$chasF)
ds$radF <- factor(ds$rad)

# @kntir basic_table ---------------------------------------
summary(ds)


# @knitr basic_graph ---------------------------------------

crime_graph <- function(df,predictor){
g <- ggplot2::ggplot(data=d, aes_string(x= predictor, y="crim")) +
  geom_point(aes(color=radF), size=5, alpha=.45) + 
  # scale_color_manual(values=c("Yes"="red", "No"="black"))+
  main_theme 
  # labs(title=paste0("crime ~ ",predictor), color="Road Access Index \n  (low = easy)")
  g 
}


d <- ds
d <- dplyr::filter(ds, rad <= 8)
(g <- crime_graph(d, predictor="black")); str(ds)
#





# 
# names(ds)
# g <- ggplot2::ggplot(data=ds, aes(x=lstat, y=crim, color=chasF)) +
#   geom_point() + 
#   geom_smooth(
#               method="lm", 
#               # formula = y ~ x + I(x^2) + I(x^3),
#               formula = y ~ poly(x,3), 
#               # formula = y ~ x, 
#               # span = .5,
#               se=FALSE
#               ) +
#   facet_grid(.~chasF)+
#   main_theme
# g
# 
# 
#  method="loess", 
#  color="blue", 
#  size=1, 
#  fill="gray80", 
#  alpha=.3, 
#  na.rm=T
#  se = FALSE # removes the CI band
#  span = .5 # smoothness of the line         



# @knitr reproduce ---------------------------------------
#   rmarkdown::render(input = "./reports/report.Rmd" ,
#                     output_format="html_document", clean=TRUE)