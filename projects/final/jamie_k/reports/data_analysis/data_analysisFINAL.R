# For annotations to this file visit ./projects/nlsy97/annotate_data_creation/ 
# Clear memory from previous runs
base::rm(list=base::ls(all=TRUE))
cat("\f")

# install.packages("knitr")
# install.packages("markdown")
# install.packages("testit")
# install.packages("dplyr")
# install.packages("reshape2")
# install.packages("stats")
# install.packages("ggplot2")
# install.packages("extrafont")

# @knitr LoadPackages --------------------
# Load the necessary packages.
base::require(base)
base::require(knitr)
base::require(markdown)
base::require(testit)
base::require(dplyr)
base::require(reshape2)
base::require(stringr)
base::require(stats)
base::require(ggplot2)
base::require(extrafont)
base::require(lattice)

# @knitr Intro --------------------

# @knitr LoadData --------------------
# Link to the data source 
pathDir <- getwd()
load(file.path(pathDir,"data/derived/dsLong.rda"))


# @knitr Subset --------------------
####Subset a random sample of participants including all Variables and waves####
#first omit any missing data
satsasm <- na.omit(satsafull)
#the generate a random sample
idx2 <- sample(unique(satsasm$TWINNR), 15)
idfsample2 <- satsasm[satsasm$TWINNR %in% idx2, ]
attach(idfsample2)
save(idfsample2,file="./data/derived/idfsample2.rda")

#if we want to sample individual people we can use this code
#id234 <- satsafull[satsafull$TWINNR==234, ]

# @knitr LongitudinalExploration --------------------

#### Empirical growth plots ####
#plots of MMSE and smell
#use the id sampling dataset to run plots so you dont't crash your computer
xyplot(idfsample2$smell ~ idfsample2$WAVE | idfsample2$TWINNR, data=idfsample2, as.table=T)
xyplot(idfsample2$MMSE ~ idfsample2$WAVE | idfsample2$TWINNR, data=idfsample2, as.table=T)

#### Fitted OLS trajectories superimposed on the empirical growth plots.####

#We can look at the full data set if there are not too many subjects, but it may crash your computer...
# xyplot(smell ~ WAVE | TWINNR, data=satsafull, 
#        panel = function(x, y){
#          panel.xyplot(x, y)
#          panel.lmline(x, y)
#        }, ylim=c(0, 4), as.table=T)

#examine a smaller subet of the data
#can we facet wrap xyplots? this would give id variable
xyplot(smell ~ WAVE | TWINNR, data=idfsample2, 
       panel = function(x, y){
         panel.xyplot(x, y)
         panel.lmline(x, y)
       }, ylim=c(0, 4), as.table=T)


xyplot(taste ~ WAVE | TWINNR, data=idfsample2, 
       panel = function(x, y){
         panel.xyplot(x, y)
         panel.lmline(x, y)
       }, ylim=c(0,4), as.table=T)

#we can see that smell and taste are reported nearly identically in each individual.

#here we can get the id number for each person in the smaller sample set
p <- ggplot(idfsample2)
p <- p + geom_point(aes(x=WAVE, y=smell))
p <- p + facet_wrap(~TWINNR)
print(p)
 
# Fitting separate within person OLS regression models by id
#error - factors are not allowed
#by(idfsample2, idfsample2$TWINNR, function(x) summary(lm(idfsample2$smell ~ idfsample2$WAVE, data=x)))

# @knitr DatabyID --------------------
#this is not picking up all the waves for the id number 
#factors not allowed in model - Andrey: how to get around this? 
id1 <- satsafull[satsafull$TWINNR==112212, ]
id1$model <-  predict(lm(smell~WAVE,id1))

# @knitr CleanUp --------------------
# # remove all but specified dataset
#rm(list=(ls()[ls()!="satsafull"]))

#remove everything from the environment
base::rm(list=base::ls(all=TRUE))


####THE END####

####Future Analysis####
#look at whether smell can predict dementia
#code dementia to binomial group: yes dementia or no dementia.
#random effect that takes into account baseline smell
#lmer(dementia ~ WAVE*smell + sex + (WAVE|subject), data=satsafull) #lme4
#lme(smell ~ WAVE*dementia + sex + (WAVE|subject), data=satsafull) #lme4

