rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.


iq <- c(96, 102, 104, 104, 108, 110)
iq

sigma <- sum(iq)
ybar <- mean(iq)


# create data set with one column IQ and another empty
ds <- as.data.frame(iq)

# Full 
ds$full <- mean(ds$iq)
ds$ef <- ds$iq - ds$full
ds$ef2 <- ds$ef^2

# Reduced
ds$reduced <- 98
ds$er <- ds$iq - ds$reduced 
ds$er2 <- ds$er^2



EF <- sum(ds$ef2) # sum of squared discrepancies from FULL
ER <- sum(ds$er2) # sum of squared discrepancies from REDUCED

dfF <- 5 # because we estimated the mean
dfR <- 6 # because there are 6 scores



MSR <- (ER - EF) / (dfR - dfF)

MSE <- EF / dfF

Ftest <- MSR / MSE

Ftest

sm <-  lm(formula = iq ~ 1, data = ds)
sm <- glm(formula = iq ~ 1, data =  ds)

sm
summary(sm)

ds$yhat <- predict(sm)


## Part II. Primitive models
ds <- ds[ ,c("iq","reduced","full")]


  
  
  