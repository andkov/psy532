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

# @knitr LoadSources ---------------------

source("./scripts/graphs/graph_themes.R")

# @knitr LoadData ---------------------
dsM <- readRDS("./data/derived/dsM.rds")

# @knitr SelectWave
ds <- dsM %>% dplyr::filter(wave==4) %>%
  dplyr::select(-wave)
head(ds)

# @knitr SummarizeWave2
summary(ds)

# @knitr hist_1 ---------------------
hist(ds$bmi, xlab="BMI", main="BMI Histogram")

# @knitr hist_2 ---------------------
hist(ds$chronicc, xlab="Chronic Conditions", main="Chronic Conditions Histogram")

table(ds$chronicc)

# @knitr hist_3
hist(ds$smoken, xlab="Smoken", main="Currently Smoke Histogram")


table(ds$smoken)

# @knitr bestss ---------------------


library(leaps)
d <- ds %>% dplyr::select(-id)
regfit.full=regsubsets(bmi~.,d, nvmax=13)
summary(regfit.full)
reg.summary=summary(regfit.full)

# @knitr R2 ----------------------
reg.summary$rsq 

# @knitr PlotRSS
par(mfrow=c(1,1))
plot(reg.summary$rss, xlab="Number of Variables", ylab="RSS", type="l")

# @knitr Plotadjr2
plot(reg.summary$adjr2, xlab="Number of Variables", ylab= "Adjusted Rsq", type="l")

which.max(reg.summary$adjr2)
#Add a point to indicate the model with the largest adjusted R^2 statistic
points (13, reg.summary$adjr2[13], col="red", cex=2, pch=20)

# @knitr Plotcp
plot(reg.summary$cp, xlab="Number of Variables", ylab="Cp", type="l")
which.min(reg.summary$cp)

points (13, reg.summary$cp[13], col="red", cex=2, pch=20)

# @knitr Plotbic
plot(reg.summary$bic, xlab="Number of Variables", ylab="Bic", type="l")
which.min(reg.summary$bic)
points (11, reg.summary$bic[11], col="red", cex=2, pch=20)


# @knitr Coefficients13

coef(regfit.full, 13)


# @knitr Coefficients7
coef(regfit.full, 11)

# @knitr lm ---------------------
d <- ds %>% dplyr::select(-id)
head(d)
lm.fit = lm(bmi ~ chronicc + cogslope + depressivesym + cogsc + agey + smoken + drink + strok + psych + diab + arthr + cancr + vigact, data=d)
m13 <-lm.fit
summary(lm.fit)

# @knitr lm2 ---------------------

lm.fit2 = lm(bmi~chronicc + cogsc + agey + smoken + drink + strok + psych + diab + arthr + cancr + vigact, data=d)
m11 <- lm.fit2
summary(lm.fit2)

ds$bmi_m13 <- predict(m13)
ds$bmi_m11 <- predict(m11)
head(ds)

# @knitr ggplot ---------------------
ds %>% dplyr::select(id, bmi, bmi_m13, bmi_m11) %>% dplyr::top_n(10)

p <- ggplot2::ggplot(data=ds, aes(x=agey, y=bmi)) +
  geom_point(shape=21, fill=NA, alpha=.5)+
  geom_smooth(aes(y=bmi_m11),  color="red", size=1.5, se=F)+ 
  geom_smooth(aes(y=bmi_m13), color="green", size=1.0, se=F)


p

# @knitr ggplot2 ---------------------

ds %>% dplyr::select(id, bmi, bmi_m13, bmi_m11) %>% dplyr::top_n(10)

p <- ggplot2::ggplot(data=ds, aes(x=chronicc, y=bmi)) +
  geom_point(shape=21, fill=NA, alpha=.5)+
  geom_smooth(aes(y=bmi_m11),  method= 'lm', formula = y ~ x, color="red", size=1.5, se=F)+ 
  geom_smooth(aes(y=bmi_m13), method= 'lm', formula = y ~ x, color="green", size=1.0, se=F)


p


# @knitr ggplot3 ---------------------

ds %>% dplyr::select(id, bmi, bmi_m13, bmi_m11) %>% dplyr::top_n(10)

p <- ggplot2::ggplot(data=ds, aes(x=smoken, y=bmi)) +
  geom_point(shape=21, fill=NA, alpha=.5)+
  geom_smooth(aes(y=bmi_m11),  method= 'lm', formula = y ~ x, color="red", size=1.5, se=F)+ 
  geom_smooth(aes(y=bmi_m13), method= 'lm', formula = y ~ x, color="green", size=1.0, se=F)

p


# @knitr explorem11.1 ---------------------
p <- ggplot2::ggplot(data=dsM, aes(x=chronicc, y=vigact)) +
  geom_point()+
  geom_jitter()
p

# @knitr explorem11.2 ---------------------

lm.fit3 = lm(bmi~chronicc, data=d)
summary(lm.fit3)

# @knitr explorem11.3 ---------------------

lm.fit4 = lm(vigact~chronicc, data=d)
summary(lm.fit4)

# @knitr explorem11.4 ---------------------
lm.fit5 = lm(bmi~vigact, data=d)
summary(lm.fit5)
# @knitr explorem11.5 ---------------------
lm.fit6 = lm(bmi~vigact + chronicc, data=d)
summary(lm.fit6)
