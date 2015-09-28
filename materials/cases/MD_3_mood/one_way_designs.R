rm(list=ls())

# enter the data from Maxwell & DeLaney (2004), table 3.3 on page 91
# outcome = global affect rating, higher = better mood
# groups : pleasant, neutral, and unpleasant

# load libraries we'll need for the project
library(dplyr)



# create three vectors each containing a set of scores from each
pleasant <- c(6,5,4,7,7,5,5,7,7,7)
neutral <- c(5,4,4,3,4,3,4,4,4,5)
unpleasant <- c(3,3,4,4,4,3,1,2,2,4)

#combine three vectors into a dataframe object named "ds"
ds <- cbind(pleasant, neutral, unpleasant)
ds <- as.data.frame(cbind(pleasant, neutral, unpleasant))
ds

#produce summary of variables with summary function from base package
(a <- summary(ds))
str(a)

#summarize variables with describe function from the psych package
(a <- psych::describe(ds))
str(a)
t(psych::describe(ds))


#compute the mean of each variable with dplyr
(a <- dplyr::summarise_each(ds, funs(mean)))
str(a)
a["pleasant"]

#create a list containing means using lapply
(M <- lapply(ds, mean))
str(M)
str(M["pleasant"])
str(M[["pleasant"]])
str(M["pleasant"][[1]])
as.numeric(M)

#create a list containing standard deviations using lapply
(SD <- lapply(ds, sd))
str(SD)
as.numeric(SD)

#################################################

# compute errors of pleasant group
(ds_pleasant <- as.data.frame(pleasant))
(ds_pleasant <- dplyr::rename(ds_pleasant, y = pleasant))
(ds_pleasant$error <- ds_pleasant$y - M["pleasant"][[1]])
(ds_pleasant$error2 <- ds_pleasant$error^2)
ds_pleasant


# compute errors of pleasant group
(ds_neutral <- as.data.frame(neutral))
(ds_neutral <- dplyr::rename(ds_neutral, y = neutral))
(ds_neutral$error <- ds_neutral$y - mean(ds_neutral$y))
(ds_neutral$error2 <- ds_neutral$error^2) 
ds_neutral 

y3 <- ds$unpleasant
e3 <- y3-mean(y3)
es3 <- e3^2
(ds_unpleasant <- as.data.frame(cbind(y3, e3, es3)))

y1 <- ds$pleasant
e1 <- y1-mean(y1)
es1 <- e1^2
(ds_pleasant <- as.data.frame(cbind(y1, e1, es1)))

y2 <- ds$neutral
e2 <- y2-mean(y2)
es2 <- e2^2
(ds_neutral <- as.data.frame(cbind(y2, e2, es2)))


# write a function that computes error four our file
compute_errors <- function(ds=ds, group="pleasant"){
  df <- as.data.frame(ds[group])
  names(df) <- "y"
  df$error <- df$y - mean(df$y) 
  df$error2 <- df$error^2
  return(df)
}
ds_pleasant <- compute_errors(ds=ds, group="pleasant")
ds_neutral <- compute_errors(ds=ds, group="neutral")
ds_unpleasant <- compute_errors(ds=ds, group="unpleasant")

table_3_4 <- cbind(ds_pleasant, ds_neutral, ds_unpleasant)
table_3_4

###################################################
# convert from wide to long 
ds
dsL <- tidyr::gather(ds, "group") #cheatsheet
dsL
head(dsL, 22)

# convert from wide to long (alternative)
dsL <- reshape2::melt(ds)
dsL <- dplyr::rename(dsL, group = variable)
dsL <- dplyr::rename(dsL, y = value )
str(dsL)
head(dsL, 22)

# create dummy variable
dsL$d1 <- ifelse(dsL$group=="pleasant", 1, 0)
dsL$d2 <- ifelse(dsL$group=="neutral", 1, 0)
dsL$d3 <- ifelse(dsL$group=="unpleasant", 1, 0)
head(dsL, 22)

# create dummy column with group means
dsL$m1 <- (sum(dsL$y * dsL$d1)/(sum(dsL$d1)))*dsL$d1
dsL$m2 <- (sum(dsL$y * dsL$d2)/(sum(dsL$d2)))*dsL$d2
dsL$m3 <- (sum(dsL$y * dsL$d3)/(sum(dsL$d3)))*dsL$d3
head(dsL, 22)

# create a column with group means
dsL$ybar <- dsL$m1 + dsL$m2 + dsL$m3
head(dsL, 22)

# keep only specific variables
dsL <- dsL[c("y", "group","d1","d2","d3","ybar")]

# create a variable with grand/total mean
dsL$ydot <- round(mean(dsL$y),2)
head(dsL, 22)

################################
m1 <- lm(y ~  group, data=dsL)
summary(m1)
 
m2 <- glm(y ~ + group, data=dsL)
summary(m2)

dsL$yhat <- predict(m1)
dsL$yhat2 <- predict(m2)
dsL
###################################

## @knitr eq65
SSw <- sum((dsL$y - dsL$ybar)^2) # SS Between
EF <- SSw # Full model

## 
SSt <- sum((dsL$y - dsL$ydot)^2) # SS Within
ER <- SSt # Restricted model

##
SSb <- sum((dsL$ydot - dsL$ybar)^2)
delta_E <- ER - EF
all.equal(SSb,delta_E)

##
N <- nrow(dsL) # length(dsL$y)
a <- length(levels(dsL$group))

dfR <- N - 1
dfF <- N - a

delta_df <- dfR - dfF

##
MSE <-  delta_E/delta_df
MSR <- EF/dfF

Ftest <- MSE/MSR
Ftest

mdl <- glm(y ~ + group, data=dsL)

(dfF <- mdl$df.residual)              # FULL            ( df ERROR)    
(dfR <- mdl$df.null)                  # RESTRICTED      ( df TOTAL)    

# misfit of the models
(SSE <- mdl$deviance);EF <- SSE       # FULL            (SS Error) - (EF)
(SST <- mdl$null.deviance); ER <- SST # RESTRICTED      (SS Total) - (ER)

source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/areaF_graphing.R")
areaF(6136, 26, 6525, 29 )
areaF(26, 27, 72.66667, 29)
areaF(100, 10, 200, 11, 20)


