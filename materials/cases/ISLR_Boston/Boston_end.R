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
# create a graphing functions
crime_graph <- function(df,predictor){
g <- ggplot2::ggplot(data=d, aes_string(x= predictor, y="crim")) +
  geom_point(aes(color=radF), size=5, alpha=.45) + 
  # scale_color_manual(values=c("Yes"="red", "No"="black"))+
  main_theme 
  labs(title=paste0("crime ~ ",predictor), color="Road Access Index \n  (low = easy)")
  g 
}


d <- ds
# d <- dplyr::filter(ds, rad <= 8)
(g <- crime_graph(d, predictor="black")); str(ds)
#





# 
names(ds)
p <- ggplot2::ggplot(data=ds, aes(x=lstat, y=crim, color=chasF)) +
  geom_point() + 
  geom_smooth(
              method="lm", 
              formula = y ~ x, 
              se=FALSE
              ) +
  facet_grid(.~chasF)+
  main_theme
p

# Use these options to explore  geom_smooth
 method="loess", ="lm", ="gml"
 formula = y ~ x + I(x^2) + I(x^3), # equivalent to line below
 formula = y ~ poly(x,3), # equivalent to line above
 color="blue",  # the color of the smoothing line
 size=1,  # thickness of the smoothing line
 fill="gray80", # color of the confidence band
 alpha=.3,  # transparancy of the confidence band
 na.rm=T, # remove missing observations 
 se = FALSE # removes the CI band
 span = .5 # smoothness of the line         


# create a blank plot to insert into grid
blankPlot <- ggplot()+geom_blank(aes(1,1)) +
  cowplot::theme_nothing()
# arrange several plots into a composite graphic
gridExtra::grid.arrange(p,blankPlot,g,
                        ncol=3,  nrow=1,
                        widths=c(1,.1,1),
                        hieghts=c(1,1,1))
