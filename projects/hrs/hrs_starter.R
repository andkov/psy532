rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\f") # clear console



# @knitr load_packages
library(dplyr) # for data manipulation
library(ggplot2) # for graphing
library(extrafont) # for main_theme


# @knitr load_sources --------------------------------------- 
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/main_theme.R")

# @knitr declare_globals ---------------------------------------
filePath <- "./data/hrs/hrs_retirement.sav"

# @knitr load_data ---------------------------------------
# ds <- Hmisc::spss.get(filePath, use.value.labels = TRUE)
# saveRDS(ds, "./data/hrs/hrs_retirement.rds")
ds <- readRDS("./data/hrs/hrs_retirement.rds")
# ds <- readRDS("https://github.com/andkov/psy532/raw/master/data/hrs/hrs_retirement.rds")

# @knitr inspect_data ---------------------------------------
names(ds)
ds <- ds[ds$wave==2, ] # keep only wave 1
distinct(dplyr::select(ds, hhidpn)) %>% count()
length(unique(ds[ , "hhidpn"]))
psych::describe(ds)
head(ds)

# @knitr tweak_data ---------------------------------------

# @kntir basic_table ---------------------------------------
table(ds$shlt) # self-rated health
summary(ds$shltc) # self-rated health categories?
table(ds$ragender) # gender
table(ds$raracem) # race
table(ds$raedyrs) # years of education
summary(ds$bmi) # body mass index
summary(ds$tret) # time since retirement


# @knitr add_models_smoothers ---------------------------------------
d <- ds %>% dplyr::select(hhidpn, shltc, tret)
head(d)
str(d$shltc)
summary(ds$shltc)
names(ds)
p <- ggplot2::ggplot(data=ds, aes(x=tret, y=shltc, color=ragender)) +
  geom_point()+
  geom_jitter()+
#   geom_smooth(size=1.2, color="black", se=T, fill="grey", alpha=.5,
#               method="lm",  
#               formula = y ~ x, 
#               se=FALSE
#               ) +
#   geom_smooth(size=1.2, color="red", se=T, fill="salmon", alpha=.5,
#               method="lm",  
#               formula = y ~ x + I(x^2), 
#               se=FALSE
#               ) +
  main_theme
p

# @knitr get_prediction_function  ------------

# See Chang (2013), section 5.7
# See psy532-Issue-15: https://github.com/andkov/psy532/issues/15
# Given a model, predict values of yvar from xvar
# This supports one predictor and one predicted variable
# xrange: If NULL, determine the x range from the model object. If a vector with
# two numbers, use those as the min and max of the prediction range.
# samples: Number of samples across the x range.
# ...: Further arguments to be passed to predict()
predictvals <- function(model, xvar, yvar, xrange=NULL, samples=100, ...) {
# If xrange isn't passed in, determine xrange from the models.
# Different ways of extracting the x range, depending on model type
  if (is.null(xrange)) {
    if (any(class(model) %in% c("lm", "glm")))
    xrange <- range(model$model[[xvar]])
    else if (any(class(model) %in% "loess"))
    xrange <- range(model$x)
  }
  newdata <- data.frame(x = seq(xrange[1], xrange[2], length.out = samples))
  names(newdata) <- xvar
  newdata[[yvar]] <- predict(model, newdata = newdata, ...)
  newdata
}


# @knitr define_models --------------------------------------

m_1 <- glm(formula= shltc ~ tret ), data = ds )
p_1 <- predictvals(m_1, "tret", "shltc")

m_2 <- glm(formula= shltc ~ tret + I(tret^2), data = ds )
p_2 <- predictvals(m_2, "tret", "shltc")

m_3 <- glm(formula= shltc ~ tret + I(tret^2) + I(tret^3), data = ds )
p_3 <- predictvals(m_3, "tret", "shltc")

# @knitr add_model_data --------------------------------------
# attach  a line to the graph produced in the previous chunk
g <- p + geom_line(data=p_3, colour="red", size=.8) 

