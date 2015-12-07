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
library(psych)
library(leaps) #for modeling
library(gam) #not sure if needed....

# @knitr load_sources --------------------------------------- 
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/main_theme.R")

# @knitr declare_globals ---------------------------------------
filePath <- "./data/raw/hrs_retirement.sav"

# @knitr load_data ---------------------------------------
# ds <- Hmisc::spss.get(filePath, use.value.labels = TRUE)
# saveRDS(ds, "./data/hrs/hrs_retirement.rds")
ds.prime<- readRDS("./data/raw/hrs_retirement.rds")
# ds <- readRDS("https://github.com/andkov/psy532/raw/master/data/hrs/hrs_retirement.rds")
as.data.frame(table(ds.prime$wave)) #for wave selection, to see which group had the largest n

# @knitr inspect_data ---------------------------------------
names(ds.prime)
ds <- ds.prime[ds.prime$wave==10, ] # keep only wave 10, to reduce ds size and make more managable (choose other value?)
distinct(dplyr::select(ds, hhidpn)) %>% count()
length(unique(ds[ , "hhidpn"]))
psych::describe(ds)
head(ds)
columnnames <- read.csv("./data/raw/hrs_column_names.csv",sep="\t") #make sure this works!
View(columnnames)

# @knitr tweak_data ---------------------------------------


# @kntir basic_table ---------------------------------------
#Variables of interest - BMI as Y, Potential X's are -- rabyear, ragender, wtresp, raedyrs, shlt, shltc (?), cesd, smoken, drink, hibp, inpova, agey, cogtot, mstot, vigact, tret, conde, hacort (?)

table(ds$shlt) # self-rated health
summary(ds$shltc) # self-rated health categories?
table(ds$ragender) # gender
table(ds$raracem) # race
table(ds$raedyrs) # years of education
summary(ds$bmi) # body mass index
summary(ds$tret) # time since retirement


pairs(ds$bmi ~ ds$wtresp + ds$agey + ds$conde + ds$cogtot + ds$mstot + ds$raedyrs + ds$cesd + ds$shlt + ds$ragender) #note: may need to change
#Note: that conde, cogtot, mstot, wtresp, tret, cesd, shlt and ragender
#Var's that appear to be related to BMI (linear only?) - 

#Plots of these variables
plot(ds$wtresp, ds$bmi ) 
plot(ds$agey, ds$bmi )
plot(ds$conde, ds$bmi )
plot(ds$cogtot, ds$bmi )
plot(ds$mstot, ds$bmi )
plot(ds$raedyrs, ds$bmi )
plot(ds$shlt, ds$bmi )
plot(ds$ragender, ds$bmi )
#Variables to choose: (5-10?)

# @knitr query_data --------------------
# with $
a <- ds$bmi # extracts column "bmi" from dataset "ds0"
class(a)
str(a)

# @knitr arrivedsW1 --------------------
# Manually create the vector that contains the names of the variables you would like to keep. 
selectVars <- c("hhidpn", "bmi", "wtresp", "conde",  "agey", "cogtot", "mstot", "raedyrs", "cesd", "shlt", "ragender")
dsW <- ds[,selectVars]
head(dsW)

# @knitr remove_na -------------------- cogstot, mstot, bmi, cesd, shlt
# Remove NA values. 
#all variables that have NA - bmi,cogstot, mstot, cesd, shlt, conde, raedyrs
ds1 <- dplyr::filter(dsW,!is.na(bmi)) #way to automate?
ds2 <- dplyr::filter(ds1,!is.na(cogtot))
ds3 <- dplyr::filter(ds2,!is.na(mstot)) #remove? essentially same var as cogtot?
ds4 <- dplyr::filter(ds3,!is.na(cesd))
ds5 <- dplyr::filter(ds4,!is.na(shlt))
ds6 <- dplyr::filter(ds5,!is.na(conde))
ds7 <- dplyr::filter(ds6, !is.na(raedyrs))
dsmain <- ds7 #for some reason r can't find this guy...
head(dsmain)

#Figure out if needed!

# @knitr Melt01 --------------------
#require(dplyr)
#dplyr::filter(ds.main, bmi < 5) 


# @knitr Melt02 --------------------
##TIvars<-c("hhidpn", "wtresp", "conde",  "agey", "cogtot", "mstot", "raedyrs", "cesd", "shlt", "ragender") # Time Invariant (TI)
# id.vars tells what variables SHOULD NOT be stacked
##dsLong <- reshape2::melt(ds.main, id.vars=TIvars) # melt 
##dplyr::filter(dsLong)

# @knitr Melt03 --------------------
# nrow(dsLong)/length(unique(dsLong$id)) # should be integer
##dsLong <- dplyr::filter(dsLong,!is.na(id)) # remove obs with invalid id
# nrow(dsLong)/length(unique(dsLong$id)) # verify that melting is fine
# dplyr::filter(dsLong,id==1) # inspect

# @knitr Melt04 --------------------
# create varaible "year" by stripping the automatic ending in TV variables' names
# subset 4 characters from the end of the string a into new variable
##dsLong$year<-str_sub(dsLong$variable,-4,-1) 
##dplyr::filter(dsLong, id == 1)

# @knitr Melt05 --------------------
# remove the automatic ending 
##removePattern <- paste0("_",c(2000:2011))
##for (i in removePattern){
##  dsLong$variable <- gsub(pattern=i, replacement="", x=dsLong$variable) 
##}
##dsLong$year <- as.integer(dsLong$year) # Convert to a number.
##dplyr::filter(dsLong,id==1) # inspect




# @knitr Cast01 --------------------
##require(reshape2)
##dsLong <- dcast(ds.main, bmi + wtresp + agey + conde + cogtot + mstot + raedyrs + cesd + shlt + ragender ~ variable, value.var = "value")
##dplyr::filter(dsL,id==1)

#####

# @knitr mutate_data1 --------------------
#dsmain1 <- mutate(dsmain, shltnum = as.numeric(gsub("\\D", "", shlt)))
#dplyr::filter(dsmain1) %>% select(bmi,wtresp,agey,conde,cogtot,mstot,raedyrs,cesd,shlt,ragender, shltnum)
#sqm <- as.numeric(gsub("\\D", "", dsmain$shlt)) 
#sqm

# @knitr mutate_data2 --------------------
#dsmain2 <- dplyr::mutate(dsmain1, gendernum = as.numeric(gsub("\\D", "", ragender)))

# @knitr arrivedsW2 --------------------
# Manually create the vector that contains the names of the variables you would like to keep. 
selectVars <- c("bmi", "wtresp", "conde",  "agey", "cogtot", "mstot", "raedyrs", "cesd", "shltc", "ragender")
ds.main <- ds.main[,selectVars]
head(ds.main)
View(ds.main) #may want to remove?


# @knitr LoadGraphSettings --------------------
# load themes used to style graphs
source("./scripts/graphs/graph_themes.R")  #is graph themes needed? 


#NOTE: not sure if needed
# @knitr selectdsM --------------------
##dsM <- dplyr::filter(dsL,id==47) %>%
##  select(id,byear, year, attend, attendF)
##dsM

######################


# @knitr model_selection ---------------------------------------
#GAM models

gam1 <- lm(bmi ~s(raedyrs, 2)+ s(wtresp, 10)+ s(cesd, 8)+ s(conde, 1)+ s(agey, 4)+ s(cogtot, 1)+ s(mstot, 1)+ s(shltnum, 1)+ s(gendernum, 1),data=ds.main)
summary(gam1)
par(mfrow=c(2,2))
plot.gam(gam1, se=TRUE, col="red")

gam2 <- gam(bmi ~  s(wtresp, 10)+ s(conde, 1) + s(agey, 4),data=ds.main)
summary(gam2)

#variables used - bmi + rabyear + wtresp+ + shlt + cesd+ conde+ agey+ cogtot+ mstot+ vigact + tret
#full
regft.full <- regsubsets(ds.main$bmi~., data = ds.main, nvmax=9)
summary(regft.full)
coef(regft.full,9)
#Forward stepwise selection
mean(ds.main$bmi) #for test
regft.fwd <- regsubsets(ds.main$bmi~., data = ds.main, nvmax=5, method="forward")
summary(regft.fwd)
coef(regft.fwd,5)
#Backward Stepwise selection
regft.bwd <- regsubsets(ds.main$bmi~., data = ds.main, nvmax=5, method="backward")
summary(regft.bwd)
coef(regft.fwd,5)


#x <- #make your own x....? will contain agey, conde, shltnum, wtresp(?) or raedyrs(?)

# @knitr add_models_smoothers ---------------------------------------

#d <- ds.main %>% dplyr::select(hhidpn, shltc, tret)
#head(d)
#str(d$shltc)
#summary(ds$shltc)
#names(ds.main)


#p <- ggplot2::ggplot(data=ds10, aes(x=tret+, y=bmi, color=shlt)) +
 # geom_point()+
  #geom_jitter()+
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
 # main_theme
#p

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

#m_1 <- glm(formula= bmi ~ tret , data = ds10 )
#p_1 <- predictvals(m_1, "tret", "bmi")

#m_2 <- glm(formula= bmi ~ tret + I(tret^2), data = ds10 )
#p_2 <- predictvals(m_2, "tret", "bmi")

#m_3 <- glm(formula= bmi ~ tret + I(tret^2) + I(tret^3), data = ds10 )
#p_3 <- predictvals(m_3, "tret", "bmi")

# @knitr add_model_data --------------------------------------
# attach  a line to the graph produced in the previous chunk
#g <- p + geom_line(data=p_3, colour="black", size=1.0) 
#g

#Note: not sure if working...must be modified

# @knitr SaveDerivedData --------------------

#need to create dsL!!! from hrs dsl data?

pathdsLhrscsv <- "./data/derived/hrs_drv_dsL.csv"
write.csv(ds.main,pathdsLhrscsv,  row.names=FALSE)

pathdsLhrsrds <- "./data/derived/hrs_drv_dsL.rds"
saveRDS(object=ds.main, file=pathdsLhrsrds, compress="xz")

# @knitr CleanUp --------------------
# # remove all but specified dataset
#rm(list=setdiff(ls(), c("dsW","dsL")))