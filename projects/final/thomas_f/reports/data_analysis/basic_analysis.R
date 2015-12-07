# For annotations to this file visit ./projects/nlsy97/annotate_data_creation/ -- modify!
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
base::require(gam)
base::require(leaps)

# @knitr load_sources --------------------------------------- 
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/main_theme.R")

# @knitr DeclareGlobals --------------------


# @knitr LoadData --------------------
# load a derived dataset
dsL <- readRDS("./data/derived/hrs_drv_dsL.rds")


# @knitr LoadGraphSettings --------------------
# load themes used to style graphs
source("./scripts/graphs/graph_themes.R")


# @knitr model_selection ---------------------------------------
#variables used - bmi + rabyear + wtresp+ + shlt + cesd+ conde+ agey+ cogtot+ mstot+ vigact + smokev + drink + shltc
#full
ds.prime<- readRDS("./data/raw/hrs_retirement.rds")
ds <- ds.prime[ds.prime$wave==10, ]
selectVars <- c("hhidpn", "bmi", "conde",  "agey", "cogtot", "mstot", "raedyrs", "cesd", "shlt", "ragender", "raracem", "smokev", "drink", "wtresp", "shltc")
ds2 <- ds[,selectVars]
ds3 <- mutate(ds2, shltnum = substring(shlt, 1, 1)) #change the \\D command
ds4 <- dplyr::mutate(ds3, gendernum = substring(ragender, 1, 1)) #decide if needed...
ds5 <- dplyr::mutate(ds4, racenum = substring(raracem, 1, 1))
ds6 <- dplyr::mutate(ds5, smokenum = substring(smokev, 1, 1))
ds7 <- dplyr::mutate(ds6, drinknum = substring(drink, 1, 1))
ds8 <- select(ds7, -shlt) 
ds9 <- select(ds8, -ragender) 
ds10 <- select(ds9, -raracem)
ds11 <- select(ds10, -smokev)
ds12 <- select(ds11, -drink)

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


# @knitr add_graphs ---------------------------------------
#Conde (by race) Graph - ideal one...
plot.1 <- ggplot2::ggplot(data=dsL, aes(x=conde, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(xlab="Number of chronic Health Conditions")+
  guides(fill=guide_legend(title="Race"))
plot.1a <- plot.1 +  facet_grid(. ~ raracem) #may want to take this out....
plot.1a

#age (by race) Graph
plot.2 <- ggplot2::ggplot(data=dsL, aes(x=agey, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Race"))
plot.2
plot.2 +  facet_grid(. ~ raracem) #may want to take this out....

#cogtot by race 
plot.3 <- ggplot2::ggplot(data=dsL, aes(x=cogtot, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Race"))
plot.3
plot.3 +  facet_grid(. ~ raracem) #may want to take this out....

#education in years by race
plot.4 <- ggplot2::ggplot(data=dsL, aes(x=raedyrs, y=bmi, fill=raracem)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("red", "blue", "green"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Race"))
plot.4
plot.4 +  facet_grid(. ~ raracem) #may want to take this out....


#Conde (by drinks).
plot.5 <- ggplot2::ggplot(data=dsL, aes(x=conde, y=bmi, fill=drink)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("lightgreen", "indianred"))+
  # labs(xlab="Number of chronic Health Conditions")+
  guides(fill=guide_legend(title="Drink"))
plot.5
plot.5 +  facet_grid(. ~ drink) #may want to take this out....

#age by if drinks
plot.6 <- ggplot2::ggplot(data=dsL, aes(x=agey, y=bmi, fill=drink)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("lightgreen", "indianred"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Drink"))
plot.6
plot.6 +  facet_grid(. ~ drink) #may want to take this out....

#cogtot by if drinks
plot.7 <- ggplot2::ggplot(data=dsL, aes(x=cogtot, y=bmi, fill=drink)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("lightgreen", "indianred"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Drink"))
plot.7
plot.7 +  facet_grid(. ~ drink) #may want to take this out....

#education in years by if drinks
plot.8 <- ggplot2::ggplot(data=dsL, aes(x=raedyrs, y=bmi, fill=drink)) + 
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
plot.9 <- ggplot2::ggplot(data=dsL, aes(x=conde, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(xlab="Number of chronic Health Conditions")+
  guides(fill=guide_legend(title="Gender"))
plot.9
plot.9 +  facet_grid(. ~ ragender) #may want to take this out....

#age (by gender Graph
plot.10 <- ggplot2::ggplot(data=dsL, aes(x=agey, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Gender"))
plot.10
plot.10 +  facet_grid(. ~ ragender) #may want to take this out....

#cogtot by gender
plot.11 <- ggplot2::ggplot(data=dsL, aes(x=cogtot, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Gender"))
plot.11
plot.11 +  facet_grid(. ~ ragender) #may want to take this out....

#education in years by gender
plot.12 <- ggplot2::ggplot(data=dsL, aes(x=raedyrs, y=bmi, fill=ragender)) + 
  scale_shape_identity()+ 
  geom_jitter(shape=21, alpha=.5)+ 
  main_theme + 
  scale_fill_manual(values=c("darkorchid", "dodgerblue3"))+
  # labs(color="Race")+
  guides(fill=guide_legend(title="Gender"))
plot.12
plot.12 +  facet_grid(. ~ ragender) #may want to take this out....


# @knitr get_prediction_function  ------------

# 
# #Original Model from hrs starter, bmi not of interest - note:delete/modify 
# # See Chang (2013), section 5.7
# # See psy532-Issue-15: https://github.com/andkov/psy532/issues/15
# # Given a model, predict values of yvar from xvar
# # This supports one predictor and one predicted variable
# # xrange: If NULL, determine the x range from the model object. If a vector with
# # two numbers, use those as the min and max of the prediction range.
# # samples: Number of samples across the x range.
# # ...: Further arguments to be passed to predict()
# predictvals <- function(model, xvar, yvar, xrange=NULL, samples=100, ...) {
#   # If xrange isn't passed in, determine xrange from the models.
#   # Different ways of extracting the x range, depending on model type
#   if (is.null(xrange)) {
#     if (any(class(model) %in% c("lm", "glm")))
#       xrange <- range(model$model[[xvar]])
#     else if (any(class(model) %in% "loess")) #may need to change loess to GAM
#       xrange <- range(model$x)
#   }
#   newdata <- data.frame(x = seq(xrange[1], xrange[2], length.out = samples))
#   names(newdata) <- xvar
#   newdata[[yvar]] <- predict(model, newdata = newdata, ...)
#   newdata
# }


# @knitr define_models --------------------------------------

fit.1 <- glm(bmi~conde,data=dsL)
fit.2 <- lm(bmi~poly(conde,2),data=dsL)
fit.3 <- lm(bmi~poly(conde,3),data=dsL)
fit.4 <- lm(bmi~poly(conde,4),data=dsL)
fit.5 <- lm(bmi~poly(conde,5),data=dsL)
anova(fit.1,fit.2,fit.3,fit.4,fit.5)

fit.1 <- lm(bmi~agey,data=dsL)
fit.2 <- lm(bmi~poly(agey,2),data=dsL)
fit.3 <- lm(bmi~poly(agey,3),data=dsL)
fit.4 <- lm(bmi~poly(agey,4),data=dsL)
fit.5 <- lm(bmi~poly(agey,5),data=dsL)
anova(fit.1,fit.2,fit.3,fit.4,fit.5) #simplest way to explain...quadratic

#Raedyrs

fit.1 <- lm(bmi~raedyrs,data=dsL)
fit.2 <- lm(bmi~poly(raedyrs,2),data=dsL)
fit.3 <- lm(bmi~poly(raedyrs,3),data=dsL)
fit.4 <- lm(bmi~poly(raedyrs,4),data=dsL)
fit.5 <- lm(bmi~poly(raedyrs,5),data=dsL)
anova(fit.1,fit.2,fit.3,fit.4,fit.5) #quadratic...


#Cogtot

fit.1 <- lm(bmi~cogtot,data=dsL)
fit.2 <- lm(bmi~poly(cogtot,2),data=dsL)
fit.3 <- lm(bmi~poly(cogtot,3),data=dsL)
fit.4 <- lm(bmi~poly(cogtot,4),data=dsL)
fit.5 <- lm(bmi~poly(cogtot,5),data=dsL)
anova(fit.1,fit.2,fit.3,fit.4,fit.5) #quadratic

# @knitr add_model_data --------------------------------------
# attach  a line to the graph produced in the previous chunk
#add CI/jitter to lines -- stat.smooth stuff I believe
#after visual examination - cubic chosen for number of health conditions (conde) and for agey (age of participant), linear chosen for education (in years)

#For Condition (by Race) 
plot.1ab <- plot.1 + stat_smooth(method="lm", formula= y ~ ns(x,1))
plot.1ab

plot.2ab <- plot.2 + stat_smooth(method="lm", formula= y ~ ns(x,2))
plot.2ab

plot.3ab <- plot.3 + stat_smooth(method="lm", formula= y ~ ns(x,2))
plot.3ab

plot.4ab <- plot.4 + stat_smooth(method="lm", formula= y ~ ns(x,2))
plot.4ab

# @knitr CleanUp --------------------
# # remove all but specified dataset
rm(list=setdiff(ls(), c("dsL")))
dsL <- readRDS("./data/derived/hrs_drv_dsL.rds")

