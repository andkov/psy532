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

# @knitr LoadData ---------------------
dsM <- readRDS("./data/derived/dsM.rds")

# @knitr LoadSources -----------
source("./scripts/graphs/graph_themes.R")

# @knitr histogram -------------------------
hist(dsM$bmi, xlab="BMI", main="BMI")

hist(dsM$agey, xlab="Age in Years", main="Age Distribution")

hist(dsM$cogtot, xlab="Cognition", main="Cognition")

hist(dsM$raedyrs, xlab="Years of Education", main="Years of Education")

hist(dsM$ragender, xlab="Gender, 1=male, 2=female", main="Gender")

hist(dsM$vigact, xlab="0=No Vigorous Activity, 1=Vigorous Activity", main="Vigorous Activity")

hist(dsM$psych, xlab="0=No Psychiatric Issues, 1=Psychiatric Issues", main="Psychiatric Issues")


# @knitr Scatterplot1 -------------------------
# d <- dplyr::sample_n(dsM, 1000)
set.seed(41)
d <- dsM %>% dplyr::sample_n(1000)
p <- ggplot2::ggplot(data=d, aes(x=cogtot, y=bmi))+
  geom_point(shape=21, fill=NA, alpha=.4, size=4)+
  geom_smooth(method="lm", formula = y ~ x, se=F)+
  labs(title="Cognition and BMI")+
  xlab("Cognition")+
  ylab("BMI")+
  theme1
p

# @knitr Scatterplot2 -------------------------
set.seed(41)
d <- dsM %>% dplyr::sample_n(1000)
p <- ggplot2::ggplot(data=d, aes(x=agey, y=bmi)) +
  geom_point(shape=21, fill=NA, alpha=.4, size=4)+
  geom_smooth(method="lm", formula = y ~ x, se=F)+
  labs(title="Age and BMI")+
  xlab("Age in Years")+
  ylab("BMI")+
  theme1
p


# @knitr Scatterplot3 -------------------------
set.seed(41)
d <- dsM %>% dplyr::sample_n(1000)
p <- ggplot2::ggplot(data=d, aes(x=raedyrs, y=bmi)) +
  geom_point(shape=21, fill=NA, alpha=.4, size=4)+
  geom_smooth(method="lm", formula = y ~ x, se=F)+
  labs(title="Years of Education and BMI")+
  xlab("Years of Education")+
  ylab("BMI")+
  theme1
p


# @knitr Dataview -----------------------------

head(dsM)

# @knitr Bestsubsetselection ----------------
library(leaps)
regfit.full=regsubsets(bmi~agey + cogtot + raedyrs + vigact + ragender + psych, data=dsM, nvmax =10)
summary(regfit.full)
reg.summary=summary(regfit.full)

# @knitr SubsetSelectionForward -------------------------
library(leaps)
leaps = regsubsets(bmi ~ raedyrs + vigact + psych + agey + cogtot + ragender, data = dsM, nvmax = 10, method = "forward")
summary(leaps)

# @knitr SubsetSelectionBackward -------------------------
library(leaps)
leaps = regsubsets(bmi ~ raedyrs + vigact + psych + agey + cogtot + ragender, data = dsM, nvmax = 10, method = "backward")
summary(leaps)

# @knitr adjustedrsquared ------------------
which.max(reg.summary$adjr2)


# @knitr cp-----------------------
which.min(reg.summary$cp)


# @knitr bic --------------------
which.min(reg.summary$bic)


# @knitr plottingadjr2-----------------
par(mfrow =c(2,2))
plot(reg.summary$adjr2, xlab ="Number of Variables",
       ylab="Adjusted RSquared", type="l")
points(5, reg.summary$adjr2[5], pch = 4, col = "red", lwd = 7)

# @knitr plottingcp-----------------

par(mfrow =c(2,2))
plot(reg.summary$bic, xlab="Number of Variables", ylab="BIC",
     type="l")
points(4, reg.summary$bic[4], pch = 4, col = "red", lwd = 7)

# @knitr plottingbic-----------------

par(mfrow =c(2,2))
plot(reg.summary$cp, xlab ="Number of Variables",
     ylab="Cp", type="l")
points(4, reg.summary$cp[4], pch = 4, col = "red", lwd = 7)


# @knitr Analysis1 ----------------------
lm.all = lm(bmi~raedyrs + vigact + agey + ragender + cogtot + psych + raedyrs, data=dsM)
summary(lm.all)

# @knitr Analysis2 ---------------------
lm.fit5 = lm(bmi~ raedyrs + vigact + agey + ragender + psych, data=dsM)
summary(lm.fit5)

# @knitr Analysis3 ---------------------
lm.fit4 = lm(bmi~ raedyrs + vigact + agey + ragender, data=dsM)
summary(lm.fit4)

# @knitr Analysis4 ---------------------
lm.fit3 = lm(bmi~ raedyrs + vigact + agey, data=dsM)
summary(lm.fit3)

# @knitr Analysis5 ---------------------
lm.fit2 = lm(bmi~ raedyrs + agey, data=dsM)
summary(lm.fit2)

# @knitr Analysis6 ---------------------
lm.fit1 = lm(bmi~ agey, data=dsM)
summary(lm.fit1)

# @knitr Analysis7 --------------------------
lm.fit1.1 = lm(bmi ~ cogtot, data=dsM)
summary(lm.fit1.1)

# @knitr Analysis8 ---------------------------
lm.fit1.2 = lm(bmi ~ psych, data=dsM)
summary(lm.fit1.2)

# @knitr Analysis9 ---------------------------
lm.fit2.1 = lm(bmi ~ cogtot + psych, data=dsM)
summary(lm.fit2.1)

# @knitr Finalanalysis-------------------------
lm.fit4.1 = lm(bmi~ raedyrs + vigact + agey + ragender, data=dsM)
summary(lm.fit4.1)

