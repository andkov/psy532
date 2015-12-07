rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\f") # clear console
#Note: move all notes to annotated after work complete

# install.packages("reshape2")
# install.packages("knitr")
# install.packages("dplyr")
# install.packages("ggplot2")
# install.packages("extrafont")
# install.packages("psych")
# install.packages("leaps")
# install.packages("gam")

# @knitr load_packages
library(reshape2)
library(knitr)
library(dplyr) # for data manipulation
library(ggplot2) # for graphing
library(extrafont) # for main_theme
library(leaps) #for modeling
library(gam) 

# @knitr load_sources --------------------------------------- 
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/main_theme.R")

# @knitr declare_globals ---------------------------------------
filePath <- "./data/raw/hrs_retirement.sav"

# @knitr load_data ---------------------------------------
# ds <- Hmisc::spss.get(filePath, use.value.labels = TRUE)
# saveRDS(ds, "./data/hrs/hrs_retirement.rds")
ds.prime<- readRDS("./data/raw/hrs_retirement.rds")
# ds <- readRDS("https://github.com/andkov/psy532/raw/master/data/hrs/hrs_retirement.rds")
# as.data.frame(table(ds.prime$wave)) #for wave selection, to see which group had the largest n

# @knitr inspect_data ---------------------------------------
names(ds.prime)
ds <- ds.prime[ds.prime$wave==10, ] # keep only wave 10, to reduce ds size and make more managable (choose other value?)
distinct(dplyr::select(ds, hhidpn)) %>% count()
# length(unique(ds[ , "hhidpn"]))
# psych::describe(ds)
# head(ds)
columnnames <- read.csv("./data/raw/hrs_column_names.csv",sep="\t")
# View(columnnames)

# @knitr tweak_data ---------------------------------------


# @kntir basic_table ---------------------------------------
#Variables of interest - BMI as Y, Potential X's are -- rabyear, ragender, wtresp, raedyrs, shlt, cesd, smoken, drink, hibp, inpova, agey, cogtot, mstot, vigact, tret, conde, hacort (?)
# pairs(ds$bmi ~ ds$wtresp + ds$agey + ds$conde + ds$cogtot + ds$mstot + ds$raedyrs + ds$cesd + ds$shlt + ds$ragender + ds$raracem + ds$tret) #may need to change
#Note: that conde, cogtot, mstot, wtresp, tret, cesd, shlt and ragender may be linear
#Var's that appear to be related to BMI - hard to tell, most of them do seem related, no reason to exclude 

#Plots of these variables - note move this after model selection stuff? May want to...
summary(ds) #pretty good, see if you can clean it up...
# dev.off() #use when invalid graphics

# plot1 <- ggplot2::ggplot(data=ds, aes(x=conde, y=bmi, color=shlt, shape=20)) + geom_point() +scale_shape_identity()+ geom_jitter()+ main_theme
#ds$bmi2 <- round(ds$bmi/5)*5 #due to having so many data points
# ds$conde2 <- round(ds$conde/5)*5

#May want to remove
plot1 <- ggplot2::ggplot(data=ds, aes(x=conde, y=bmi)) + 
  scale_shape_identity()+ 
#   geom_jitter(color="forestgreen", shape=21, alpha=.5)+ 
  geom_jitter(aes(color=smokev), shape=21, alpha=.5)+ 
#   scale_color_manual(values=c("forestgreen"))+  
  main_theme + 
#   theme(legend.position="none") +
  labs(color="Smoke")
plot1 

#May want to keep
#Conde plot
plot1 <- ggplot2::ggplot(data=ds, aes(x=conde, y=bmi)) + 
  scale_shape_identity()+ 
     geom_jitter(color="forestgreen", shape=21, alpha=.5)+ 
  main_theme + 
    theme(legend.position="none") +
   labs(xlab("Number of Chronic Health Conditions"), ylab ="BMI")
plot1 

#Age Plot
plot2 <- ggplot2::ggplot(data=ds, aes(x=agey, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="red", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Age (years)"), ylab ="BMI")
plot2 

#Education Plot
plot3 <- ggplot2::ggplot(data=ds, aes(x=raedyrs, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="brown", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Education (years)"), ylab ="BMI")
plot3 

#Cogtot Plot
plot4 <- ggplot2::ggplot(data=ds, aes(x=cogtot, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="blue", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Cognition"), ylab ="BMI")
plot4 

#MsTot Plot
plot5 <- ggplot2::ggplot(data=ds, aes(x=mstot, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="orange", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Mental Status (score)"), ylab ="BMI")
plot5 

#Depressive Symptoms
plot6 <- ggplot2::ggplot(data=ds, aes(x=cesd, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="purple", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Depressive Symptoms"), ylab ="BMI")
plot6 


#Self-rated Health Score
plot7 <- ggplot2::ggplot(data=ds, aes(x=shlt, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="deeppink", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Self-rated Health Score"), ylab ="BMI")
plot7 


#Change in Self-rated Health Score
plot12 <- ggplot2::ggplot(data=ds, aes(x=smokev, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="navyblue", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Change in Self-rated Health Score"), ylab ="BMI")
plot12 

#Gender
plot8 <- ggplot2::ggplot(data=ds, aes(x=ragender, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="lightgreen", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Gender (1=male, 2=female)"), ylab ="BMI")
plot8 

#Race
plot9 <- ggplot2::ggplot(data=ds, aes(x=raracem, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="black", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Race (1=White, 2=Black, 3=Other"), ylab ="BMI")
plot9

#Drink
plot10 <- ggplot2::ggplot(data=ds, aes(x=drink, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="cornflowerblue", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Ever Drink"), ylab ="BMI")
plot10 

#Smoke
plot11 <- ggplot2::ggplot(data=ds, aes(x=smokev, y=bmi)) + 
  scale_shape_identity()+ 
  geom_jitter(color="cyan2", shape=21, alpha=.5)+ 
  main_theme + 
  theme(legend.position="none") +
  labs(xlab("Ever Smoke"), ylab ="BMI")
plot11 




# @knitr query_data --------------------
# with $
a <- ds$bmi # extracts column "bmi" from dataset "ds0"
class(a)
str(a)

# @knitr arrivedsW1 --------------------
# Manually create the vector that contains the names of the variables you would like to keep. 
selectVars <- c("hhidpn", "bmi", "conde",  "agey", "cogtot", "mstot", "raedyrs", "cesd", "shlt", "ragender", "raracem", "smokev", "drink", "wtresp", "shltc")
ds2 <- ds[,selectVars]

# @knitr remove_na -------------------- 

# @knitr Melt01 --------------------

# @knitr Melt02 --------------------

# @knitr Melt03 --------------------

# @knitr Melt04 --------------------

# @knitr Melt05 --------------------

# @knitr Cast01 --------------------

# @knitr mutate_data1 --------------------
ds3 <- mutate(ds2, shltnum = substring(shlt, 1, 1)) #change the \\D command

# @knitr mutate_data2 --------------------
ds4 <- dplyr::mutate(ds3, gendernum = substring(ragender, 1, 1)) #decide if needed...

# @knitr mutate_data3 --------------------
ds5 <- dplyr::mutate(ds4, racenum = substring(raracem, 1, 1))

# @knitr mutate_data4 --------------------
ds6 <- dplyr::mutate(ds5, smokenum = substring(smokev, 1, 1))

# @knitr mutate_data5 --------------------
ds7 <- dplyr::mutate(ds6, drinknum = substring(drink, 1, 1))

# @knitr arrivedsW2 --------------------
# Removes columns of redundant information - e.g. shlt -- turned into numbers rather than individual categories, find out if ok... 
ds8 <- select(ds7, -shlt) 
ds9 <- select(ds8, -ragender) 
ds10 <- select(ds9, -raracem)
ds11 <- select(ds10, -smokev)
ds12 <- select(ds11, -drink)



# @knitr LoadGraphSettings --------------------
# load themes used to style graphs
source("./scripts/graphs/graph_themes.R")

#table settings


# @knitr selectdsM --------------------



# @knitr model_selection ---------------------------------------
#variables used - bmi + rabyear + wtresp+ + shlt + cesd+ conde+ agey+ cogtot+ mstot+ vigact + smokev + drink + shltc
#full
regft.full <- regsubsets(ds12$bmi~., data = ds12, nvmax=18)
summary(regft.full)
#Var's of interest - agey, conde,racenum2 (african-american), drinknum1 (yes), cogtot, raedyrs, shltnum4, smokenum1 (yes)
names(regft.full)
coef(regft.full,18) 
#coefficiants say...

regfull.sum <- summary(regft.full)
names(regfull.sum)


par(mfrow=c(2,2))
rsq <-regfull.sum$rsq
plot(rsq,col="purple",xlab= "Num of Vars",ylab="R-Squared",  pch=19, type="l")
which.min(rsq)
points(1, rsq[1], pch=4, col="black", lwd=5)

rss <- regfull.sum$rss
plot(rss,col="purple",xlab= "Num of Vars",ylab="RSS" , pch=19)
lines(rss, col="red",lty=2, lwd=1)
which.min(rss)
points(18, rss[18], pch=4, col="black", lwd=5)

cp <- regfull.sum$cp
plot(cp,col="purple",xlab= "Num of Vars",ylab="Cp", pch=19 )
lines(cp, col="red",lty=2, lwd=1)
which.min(cp)
points(13, cp[13], pch=4, col="black", lwd=5)

bic <- regfull.sum$bic
plot(bic,col="purple",xlab= "Num of Vars",ylab="BIC" , pch=19)
lines(bic, col="red",lty=2,lwd=1)
which.min(bic)
points(12, bic[12], pch=4, col="black", lwd=5)

#12 or 13 variable model is what best subset says

#cross-validation -why doesn't it work
# set.seed(1)
# train <- sample(c(TRUE,FALSE), nrow(ds10), rep=TRUE)
# test <- (!train)
# 
# regft.best <- regsubsets(bmi~.,data=ds10[train,],nvmax=12)
# test.mat <- model.matrix(bmi~.,data=ds10[test,])
# 
# val.errors = rep(NA,12)
# for (i in 1:12){
#   +   coefi=coef(regft.best, id=i)
#   +   pred=test.mat[,names(coefi)]%*%coefi
#   +   val.error[i]=mean((ds10$bmi[test]-pred)^2)
# }
# 
# #second try...
# pred.regsubsets = function(object,newdata,id,...){
#   + form=as.formula(object$call[[2]])
#   + mat=model.matrix(form,newdata)
#   + coefi=coef(object,id=id)
#   + xvars=names(coefi)
#   + mat[,xvars]%*%coefi
# }
# 
# regft.best <- regsubsets(bmi~.,data=ds10,nvmax=12)
# coef(regfit.best,10)
# 
# k =10
# set.seed(1)
# folds = sample(1:k, nrow(ds10), replace=TRUE)
# cv.errors = matrix(NA,k,12,dimnames=list(NULL, paste(1:12)))
# 
# for (j in 1:k){
#   + best.fit = regsubsets(bmi~.,data=ds10[folds!=j,], nvmax=12)
#     + for(i in 1:12){
#       +pred = predict(best.fit,ds10[folds==j,],id=i)
#       + cv.errors[j,i]=mean( (ds10$bmi[folds==j]-pred)^2)
#     }
# }
# 
# mean.cv.errors = apply(cv.errors,2,mean)
# mean.cv.errors
# kable(summary(out)$coef, digits=2) #to make table for models!!! can have summary and what not...all that jazz
#i.e. make summary tables

#look at univariate models for the significant variables - they are: 

# @knitr add_models_smoothers ---------------------------------------

# d <- ds2 %>% dplyr::select(hhidpn, bmi, agey, conde, raedyrs, raracem, drink, cogtot, ragender) #this needs to be updated...
# head(d)
# str(d$bmi) #what does this do...?
# summary(ds2$bmi) #may want to remove
# names(ds2)

#Omit Na's from data
ds12a <- na.omit(ds12)
ds7a <- na.omit(ds7)

#these could possibly be called from above?


#Conde (by race) Graph - ideal one...
plot.1 <- ggplot2::ggplot(data=ds7a, aes(x=conde, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(xlab="Number of chronic Health Conditions")+
  guides(fill=guide_legend(title="Race"))
plot.1a <- plot.1 +  facet_grid(. ~ raracem) #may want to take this out....
plot.1a

#age (by race) Graph
plot.2 <- ggplot2::ggplot(data=ds7a, aes(x=agey, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Race"))
plot.2
plot.2 +  facet_grid(. ~ raracem) #may want to take this out....

#cogtot by race 
plot.3 <- ggplot2::ggplot(data=ds7a, aes(x=cogtot, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Race"))
plot.3
plot.3 +  facet_grid(. ~ raracem) #may want to take this out....

#education in years by race
plot.4 <- ggplot2::ggplot(data=ds7a, aes(x=raedyrs, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Race"))
plot.4
plot.4 +  facet_grid(. ~ raracem) #may want to take this out....


#Conde (by drinks).
plot.5 <- ggplot2::ggplot(data=ds7a, aes(x=conde, y=bmi, fill=drink)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("lightgreen", "indianred"))+
  # labs(xlab="Number of chronic Health Conditions")+
  guides(fill=guide_legend(title="Drink"))
plot.5
plot.5 +  facet_grid(. ~ drink) #may want to take this out....

#age by if drinks
plot.6 <- ggplot2::ggplot(data=ds7a, aes(x=agey, y=bmi, fill=drink)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("lightgreen", "indianred"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Drink"))
plot.6
plot.6 +  facet_grid(. ~ drink) #may want to take this out....

#cogtot by if drinks
plot.7 <- ggplot2::ggplot(data=ds7a, aes(x=cogtot, y=bmi, fill=drink)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("lightgreen", "indianred"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Drink"))
plot.7
plot.7 +  facet_grid(. ~ drink) #may want to take this out....

#education in years by if drinks
plot.8 <- ggplot2::ggplot(data=ds7a, aes(x=raedyrs, y=bmi, fill=drink)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("lightgreen", "indianred"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Drink"))
plot.8
plot.8 +  facet_grid(. ~ drink) #may want to take this out....

#Gender

#Conde (by gender) Graph - ideal one...
plot.9 <- ggplot2::ggplot(data=ds7a, aes(x=conde, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(xlab="Number of chronic Health Conditions")+
  guides(fill=guide_legend(title="Gender"))
plot.9
plot.9 +  facet_grid(. ~ ragender) #may want to take this out....

#age (by gender Graph
plot.10 <- ggplot2::ggplot(data=ds7a, aes(x=agey, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Gender"))
plot.10
plot.10 +  facet_grid(. ~ ragender) #may want to take this out....

#cogtot by gender
plot.11 <- ggplot2::ggplot(data=ds7a, aes(x=cogtot, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Gender"))
plot.11
plot.11 +  facet_grid(. ~ ragender) #may want to take this out....

#education in years by gender
plot.12 <- ggplot2::ggplot(data=ds7a, aes(x=raedyrs, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Gender"))
plot.12
plot.12 +  facet_grid(. ~ ragender) #may want to take this out....


# @knitr get_prediction_function  ------------


#Original Model from hrs starter, bmi not of interest - note:delete/modify 
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
    else if (any(class(model) %in% "loess")) #may need to change loess to GAM
      xrange <- range(model$x)
  }
  newdata <- data.frame(x = seq(xrange[1], xrange[2], length.out = samples))
  names(newdata) <- xvar
  newdata[[yvar]] <- predict(model, newdata = newdata, ...)
  newdata
}


# @knitr define_models --------------------------------------


#to omit NA's from data! Ask Dr. Koval about this...var selection

 #Conde
# set.seed(1)
# train=sample(14608,14608/2)
# fit1 <- lm(bmi~conde,data=ds11,subset=train)
# mean((ds11$bmi-predict(fit1,ds11))[-train]^2)
# fit2 <- lm(bmi~poly(conde,2),data=ds11,subset=train)
# mean((ds11$bmi-predict(fit2,ds11))[-train]^2) #lowest...
# fit3 <- lm(bmi~poly(conde,3),data=ds11,subset=train)
# mean((ds11$bmi-predict(fit3,ds11))[-train]^2)
# fit4 <- lm(bmi~poly(conde,4),data=ds11,subset=train)
# mean((ds11$bmi-predict(fit4,ds11))[-train]^2)
# fit5 <- lm(bmi~poly(conde,5),data=ds11,subset=train)
# mean((ds11$bmi-predict(fit5,ds11))[-train]^2)
# 


fit.1 <- glm(bmi~conde,data=ds12a)
fit.2 <- lm(bmi~poly(conde,2),data=ds12a)
fit.3 <- lm(bmi~poly(conde,3),data=ds12a)
fit.4 <- lm(bmi~poly(conde,4),data=ds12a)
fit.5 <- lm(bmi~poly(conde,5),data=ds12a)
anova(fit.1,fit.2,fit.3,fit.4,fit.5)

#USE AIC i guess..
# fit.1
# regsum1 <- summary(fit.1)
# aic1 <- regsum1$aic
# 
# regsum2 <- summary(fit.2)
# aic2 <- regsum2$aic
# 
# regsum3 <- summary(fit.3)
# aic3 <- regsum3$aic
# 
# regsum4 <- summary(fit.4)
# aic4 <- regsum4$aic
# 
# regsum5 <- summary(fit.5)
# aic5 <- regsum5$aic
# 
# plot(1, aic1, col="purple",xlab= "Variable shape",ylab="AIC" ,xlim=c(1, 5), ylim=c(0, 100000), pch=20) 
# points(2,aic2, col="purple",pch=20)
# points(3,aic3, col="purple",pch=20)
# points(4,aic4, col="purple",pch=20)
# points(5,aic5, col="purple",pch=20)

#seems like linear fit is the way to go for conde?
#Dr. Koval says use something like BIC...

#Rest of Var's...
#Age
# set.seed(1)
# train=sample(14608,7304)
# fit1 <- lm(bmi~agey,data=ds12a,subset=train)
# mean((ds12a$bmi-predict(fit1,ds12a))[-train]^2)
# 
# fit2 <- lm(bmi~poly(agey,2),data=ds7a,subset=train)
# mean((ds7a$bmi-predict(fit2,ds7a))[-train]^2) 
# 
# fit3 <- lm(bmi~poly(agey,3),data=ds7a,subset=train)
# mean((ds7a$bmi-predict(fit3,ds7a))[-train]^2)
# 
# fit4 <- lm(bmi~poly(agey,4),data=ds12a,subset=train)
# mean((ds12a$bmi-predict(fit4,ds12a))[-train]^2)
# fit5 <- lm(bmi~poly(agey,5),data=ds12a,subset=train)
# mean((ds12a$bmi-predict(fit5,ds12a))[-train]^2) #remove this stuff


fit.1 <- lm(bmi~agey,data=ds12a)
fit.2 <- lm(bmi~poly(agey,2),data=ds12a)
fit.3 <- lm(bmi~poly(agey,3),data=ds12a)
fit.4 <- lm(bmi~poly(agey,4),data=ds12a)
fit.5 <- lm(bmi~poly(agey,5),data=ds12a)
anova(fit.1,fit.2,fit.3,fit.4,fit.5) #simplest way to explain...quadratic

#Raedyrs

fit.1 <- lm(bmi~raedyrs,data=ds12a)
fit.2 <- lm(bmi~poly(raedyrs,2),data=ds12a)
fit.3 <- lm(bmi~poly(raedyrs,3),data=ds12a)
fit.4 <- lm(bmi~poly(raedyrs,4),data=ds12a)
fit.5 <- lm(bmi~poly(raedyrs,5),data=ds12a)
anova(fit.1,fit.2,fit.3,fit.4,fit.5) #quadratic...


#Cogtot

fit.1 <- lm(bmi~cogtot,data=ds12a)
fit.2 <- lm(bmi~poly(cogtot,2),data=ds12a)
fit.3 <- lm(bmi~poly(cogtot,3),data=ds12a)
fit.4 <- lm(bmi~poly(cogtot,4),data=ds12a)
fit.5 <- lm(bmi~poly(cogtot,5),data=ds12a)
anova(fit.1,fit.2,fit.3,fit.4,fit.5) #quadratic



#For each variable -- 


#decide if adding race and gender, might want to
#Conde...
m_1c <- glm(formula= bmi ~  conde , data = ds7a )
p_1c <- predictvals(m_1c, "conde", "bmi")
#Age
m_2a <- glm(formula= bmi ~  agey + I(agey^2) , data = ds7a )
p_2a <- predictvals(m_2a, "agey", "bmi")
#Education
m_2e <- glm(formula= bmi ~ raedyrs + I(raedyrs^2), data = ds7a )
p_2e <- predictvals(m_2e, "raedyrs", "bmi")
#Cognitive Total
m_2ct <- glm(formula= bmi ~ cogtot + I(cogtot^2), data = ds7a )
p_2ct <- predictvals(m_2ct, "cogtot", "bmi")


# @knitr add_model_data --------------------------------------
# attach  a line to the graph produced in the previous chunk
#add CI/jitter to lines -- stat.smooth stuff I believe
#after visual examination - cubic chosen for number of health conditions (conde) and for agey (age of participant), linear chosen for education (in years)

#For Condition (by Race) 
# model <- lm(bmi ~ conde + factor(raracem), data=ds7a)
# grid <- with(ds7a, expand.grid(
#   conde = seq(min(conde), max(conde), length = 8),
#   raracem = levels(factor(raracem))
# ))
# grid$bmi <- stats::predict(model, newdata=grid)
# err <- stats::predict(model, newdata=grid, se = TRUE)
# grid$ucl <- err$fit + 1.96 * err$se.fit
# grid$lcl <- err$fit - 1.96 * err$se.fit
# plot.1 + geom_smooth(aes(ymin = lcl, ymax = ucl), data=grid, stat="identity")
# plot.1 + geom_line(data=p_1c, colour="black", size=1.0) 
# plot.1
plot.1ab <- plot.1 + stat_smooth(method="lm", formula= y ~ ns(x,1))
plot.1ab

#For Age (by Race) 
# model2 <- lm(bmi ~ agey + factor(raracem), data=ds7a)
# grid2 <- with(ds7a, expand.grid(
#   agey = seq(min(agey), max(agey), length = 120),
#   raracem = levels(factor(raracem))
# ))
# grid2$bmi <- stats::predict(model2, newdata=grid2) #problem with code right here...
# err <- stats::predict(model2, newdata=grid2, se = TRUE)
# grid2$ucl <- err$fit + 1.96 * err$se.fit
# grid2$lcl <- err$fit - 1.96 * err$se.fit
# plot.2 + geom_smooth(aes(ymin = lcl, ymax = ucl), data=grid2, stat="identity")
# plot.2 + geom_line(data=p_2a, colour="black", size=1.0)

plot.2ab <- plot.2 + stat_smooth(method="lm", formula= y ~ ns(x,2))
plot.2ab

#For Education (by Race) - Not working...
# model3 <- lm(bmi ~ raedyrs + factor(raracem), data=ds7a)
# grid3 <- with(ds7a, expand.grid(
#   raedyrs = seq(min(raedyrs), max(raedyrs), length = 20),
#   raracem = levels(factor(raracem))
# ))
# grid3$bmi <- stats::predict(model3, newdata=grid3)
# err <- stats::predict(model3, newdata=grid3, se = TRUE)
# grid3$ucl <- err$fit + 1.96 * err$se.fit
# grid3$lcl <- err$fit - 1.96 * err$se.fit
# plot.3 + geom_smooth(aes(ymin = lcl, ymax = ucl), data=grid3, stat="identity")

plot.3ab <- plot.3 + stat_smooth(method="lm", formula= y ~ ns(x,2))
plot.3ab

#For Cognition (by Race) - Not working for some reason...
# model4 <- lm(bmi ~ cogtot + factor(raracem), data=ds7a)
# grid4 <- with(ds7a, expand.grid(
#   cogtot = seq(min(cogtot), max(cogtot), length = 30),
#   raracem = levels(factor(raracem))
# ))
# grid4$bmi <- stats::predict(model4, newdata=grid4)
# err <- stats::predict(model4, newdata=grid4, se = TRUE)
# grid4$ucl <- err$fit + 1.96 * err$se.fit
# grid4$lcl <- err$fit - 1.96 * err$se.fit
# plot.4 + geom_smooth(aes(ymin = lcl, ymax = ucl), data=grid4, stat="identity")

plot.4ab <- plot.4 + stat_smooth(method="lm", formula= y ~ ns(x,2))
plot.4ab

# @knitr arrivedsW3 --------------------
# Manually create the vector that contains the names of the variables you would like to keep. 
selectVars <- c("hhidpn", "bmi",  "conde",  "agey",  "raedyrs", "cogtot", "drink",  "raracem", "ragender")
dsL <- ds7a[,selectVars]
head(dsL) 

# @knitr SaveDerivedData --------------------

#Creates derived data which contains only variables of interest for the 3 models

pathdsLhrscsv <- "./data/derived/hrs_drv_dsL.csv"
write.csv(dsL,pathdsLhrscsv,  row.names=FALSE)

pathdsLhrsrds <- "./data/derived/hrs_drv_dsL.rds"
saveRDS(object=dsL, file=pathdsLhrsrds, compress="xz")

# @knitr AttemptDiffWave
#not sure if including!!!
# ds <- ds.prime[ds.prime$wave==10, ] # keep only wave 10, to reduce ds size and make more managable (choose other value?)
# distinct(dplyr::select(ds, hhidpn)) %>% count()

# @knitr CleanUp --------------------
# # remove all but specified dataset
#rm(list=setdiff(ls(), c("ds8","dsL")))