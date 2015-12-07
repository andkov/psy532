# For annotations to this file visit
#./projects/nlsy97/annotate_data_creation/
# what is this?!

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
# base::require(base)
# base::require(knitr)
# base::require(markdown)
# base::require(testit)
# base::require(dplyr)
# base::require(reshape2)
# base::require(stringr)
# base::require(stats)
# base::require(ggplot2)
# base::require(extrafont)

# @knitr DeclareGlobals --------------------


# @knitr LoadData --------------------
# Link to the data source
getwd()
pathDir <- getwd()
myExtract <- file.path(pathDir,"data/raw/hrs/hrs_retirement")
pathSourceData <- paste0(myExtract,".csv")
SourceData <- read.csv(pathSourceData,header=TRUE, skip=0,sep=",")
ds0 <- SourceData

# @knitr inspectData -------------------
dsL <- ds0
#select desired variables from data set
dsL <- dplyr::select(ds0, ragender, rahispan, raracem, rabyear, radyear, raedyrs, shlt, cesd, bmi, smokev,smoken, drink, hibp, diab, cancr, lung, heart, strok, psych, arthr, conde, inpova, cogtot, mstot, vigact, bcogtot, cogsc, cogslope)
dim(dsL)
summary(dsL)

#omit rows with missing data
dsL=na.omit(dsL)
#explore
# pairs(dsL) #too large for R to open

#create new subset with fewer variables
dsL1 = dplyr::select(dsL, shlt, psych, bmi, smokev, smoken, cesd, drink, hibp, diab, cancr, lung, heart, strok, arthr)
dim(dsL1)
#pairs(dsL1) #still too big

dsL2 = dplyr::select(dsL, shlt, psych, bmi, heart, lung, cancr, diab)
dsL4 = dplyr::sample_frac(dsL2, 0.5, replace = TRUE)

dim(dsL4)
summary(dsL4)
#smaller size to work with 


dim(dsL2)
#pairs(dsL2)

dsL3 = dplyr::select(dsL, shlt, psych, bmi)
dim(dsL3)
#pairs(dsL3) # not helpful

plot(dsL$shlt, dsL$bmi)
plot(dsL$shlt, dsL$psych)

dim(dsL4)

pairs(dsL4)

pairs(dsL3)

pairs(dsL2)

pairs(dsL1)


lm.fit = lm(shlt~ psych + bmi + heart + lung + cancr + diab, data=dsL2)
summary(lm.fit)

lm.all = lm(shlt~., data=dsL2)
#shlt vs. bmi
lm.1= lm(shlt~bmi, data=dsL2)
p = ggplot2::ggplot(data=dsL2, aes(x=bmi, y=shlt)) +
  geom_point()+
  geom_jitter()+
  abline(lm.1)
p
lm.1= lm(shlt~bmi, data=dsL2)
plot(dsL2$shlt, dsL2$bmi)
abline(lm.1)

#shlt vs. psych
p = ggplot2::ggplot(data=dsL2, aes(x=psych, y=shlt)) +
  geom_point()+
  geom_jitter()
p
#shlt vs. heart
p = ggplot2::ggplot(data=dsL2, aes(x=heart, y=shlt)) +
  geom_point()+
  geom_jitter()
p
#shlt vs. lung
p = ggplot2::ggplot(data=dsL2, aes(x=lung, y=shlt)) +
  geom_point()+
  geom_jitter()
p
#shlt vs. cancr
p = ggplot2::ggplot(data=dsL2, aes(x=cancr, y=shlt)) +
  geom_point()+
  geom_jitter()
p
#shlt vs. diab
p = ggplot2::ggplot(data=dsL2, aes(x=diab, y=shlt)) +
  geom_point()+
  geom_jitter()
p

fwd.model = step(lm.all, direction='forward', scope=(shlt ~ psych + bmi + heart + lung + cancr + diab))



plot(shlt ~ bmi, data = dsL2, col = "darkgrey")




















#cross-validation
set.seed(1)
train=sample (93310, 46655)

glm.fit=glm("shlt"~"bmi", data=dsL2)
set.seed(17)
cv.error.10=rep(0,10)
for (i in 1:10){
  + glm.fit=glm("shlt",poly("bmi", i),data=dsL2)
  + cv.error.10[i]=cv.glm(dsL2,glm.fit,K=10)$delta[1]
  }

set.seed(3)
deltas <- rep(NA, 10)
for (i in 1:10) {
  fit <- glm(shlt ~ poly(bmi, i), data = dsL4)
  deltas[i] <- cv.glm(dsL4, fit, K = 10)$delta[1]
}
plot(1:10, deltas, xlab = "Degree", ylab = "Test MSE", type = "l")
d.min <- which.min(deltas)
points(which.min(deltas), deltas[which.min(deltas)], col = "red", cex = 2, pch = 20)





# @knitr BasicGraph --------------------


# @knitr BasicModel --------------------

# @knitr SaveDerivedData --------------------

pathdsLcsv <- "./data/derived/dsL.csv"
write.csv(dsL,pathdsLcsv,  row.names=FALSE)

pathdsLrds <- "./data/derived/dsL.rds"
saveRDS(object=dsL, file=pathdsLrds, compress="xz")

# @knitr CleanUp --------------------
# # remove all but specified dataset
rm(list=setdiff(ls(), c("dsW","dsL")))