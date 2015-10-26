rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\014")


ds <- readRDS("./data/simulated/dsX.rds")
str(ds)
mdl <- glm(formula=iq ~ 1 + ses + parent_edu + house_cost, data=ds)
mdl

# useful functions working with GLM model objects
summary(mdl) # model summary
coefficients(mdl) # point estimates of model parameters (aka "model solution")
vcov(mdl) # covariance matrix of model parameters (inspect for colliniarity)
cov2cor(vcov(mdl)) # view the correlation matrix of model parameters
confint(mdl, level=0.95) # confidence intervals for the estimated parameters

predict(mdl); fitted(mld) # generate prediction of the full model (all effects)
residuals(mdl) # difference b/w observed and modeled values
anova(mdl) # put results into a familiary ANOVA table
influence(mdl) # regression diagnostics


# create a model summary object to query 
summod <- summary(mdl)

(a <- AIC(mdl))
(logLik<-logLik(mdl))
(dev<-deviance(mdl))
(AIC <- AIC(mdl)) 
(BIC <- BIC(mdl))
# (N<- mdl@devcomp$dims["N"]) # Number of data points 
# (p<- mdl@devcomp$dims["p"]) # Number of stimated parameters, verify
# (ids<- (summary(mdl))$ngrps) # Number of units on level-2, here: individuals
# (mInfo<- c("logLik"=logLik,"dev"=dev,"AIC"=AIC,"BIC"=BIC,"N"=N, "p"=p, "ids"=ids))
(mInfo<- c("logLik"=logLik,"dev"=dev,"AIC"=AIC,"BIC"=BIC))



# parameter estimates
summod$coefficients             

# degrees of freedom of the models
(dfF <- mdl$df.residual)              # FULL            ( df ERROR)    
(dfR <- mdl$df.null)                  # RESTRICTED      ( df TOTAL)    
(dfD <-dfR - dfF)                     # DIFFERENCE      ( df RESIDUAL) - gain in complexity / loss of simplicity

# misfit of the models
(SSE <- mdl$deviance);EF <- SSE       # FULL            (SS Error) - (EF)
(SST <- mdl$null.deviance); ER <- SST # RESTRICTED      (SS Total) - (ER)
(SSR <- SST - SSE)                    # DIFFERENCE      (SS Resisudal) - gain in accurcy / loss of misfit

# accuracy vs parsimony 
(MSE <- EF / dfF)                     # FULL            (Mean Square Error)  
(MST <- ER / dfR)                     # RESTRICTED      (Mean Square Total)
(MSR <- (ER - EF) / (dfR - dfF))      # DIFFERENCE      (Mean Square Residual); (MSR <-SSR/dfR)


(SS1 <-anova(mdl))             # (Type I SS): ignor below, control above
(SS3 <-Anova(mdl,type="III"))  # Type III SS, control for everything


# load areaF function
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/areaF_graphing.R")
areaF(EF, dfF, ER, dfR )