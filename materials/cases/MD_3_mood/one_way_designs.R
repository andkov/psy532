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


#create a list containing  group means using lapply
(group_mean <- lapply(ds, mean))
str(group_mean)
str(group_mean["pleasant"])
str(group_mean[["pleasant"]])
str(group_mean["pleasant"][[1]])
as.numeric(group_mean)

#create a list containing standard deviations using lapply
(SD <- lapply(ds, sd))
str(SD)
as.numeric(SD)

# compute grand mean
(grand_mean <- mean(c(ds$pleasant, ds$neutral, ds$unpleasant)))

#################################################


# compute error of each group 

y1 <- ds$pleasant
e1 <- y1-mean(y1)
es1 <- e1^2
(ds_pleasant <- as.data.frame(cbind(y1, e1, es1)))

y2 <- ds$neutral
e2 <- y2-mean(y2)
es2 <- e2^2
(ds_neutral <- as.data.frame(cbind(y2, e2, es2)))

y3 <- ds$unpleasant
e3 <- y3-mean(y3)
es3 <- e3^2
(ds_unpleasant <- as.data.frame(cbind(y3, e3, es3)))

# recreate the table 3.4 on the page 92 (Maxwell & Delaney, 2004)
table_3_4 <- cbind(ds_pleasant, ds_neutral, ds_unpleasant)
table_3_4
d <- table_3_4

# compute misfit of the FULL model
(EF <- sum(es1 + es2 + es3))
# compute misfit of the REDUCED model
(ER <- sum( (y1-grand_mean)^2 + (y2-grand_mean)^2 + (y3-grand_mean)^2))
# count the degrees of freedom of the FULL model
dfF <- 27
# count the degrees of freedom of the REDUCED model
dfR <- 29

# load areaF function
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/areaF_graphing.R")
areaF(EF, dfF, ER, dfR )

#   
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
dsL$group_mean <- dsL$m1 + dsL$m2 + dsL$m3
head(dsL, 22)

# keep only specific variables
dsL <- dsL[c("y", "group","d1","d2","d3","group_mean")]

# create a variable with grand/total mean
dsL$grand_mean <- round(mean(dsL$y),2)
head(dsL, 22)

################################
m1 <- lm(y ~  group, data=dsL)
summary(m1)
 
m2 <- glm(y ~ 1 + group, data=dsL)
summary(m2)

dsL$yhat <- predict(m1)
dsL$yhat2 <- predict(m2)
dsL
###################################

## @knitr eq65
SSw <- sum((dsL$y - dsL$group_mean)^2) # SS Between
EF <- SSw # Full model

## 
SSt <- sum((dsL$y - dsL$grand_mean)^2) # SS Within
ER <- SSt # Restricted model

##
SSb <- sum((dsL$grand_mean - dsL$group_mean)^2)
delta_E <- ER - EF
all.equal(SSb,delta_E)

# load areaF function
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/areaF_graphing.R")
areaF(SSw, dfF, SSt, dfR )


## Manual computation of the F statistic
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


