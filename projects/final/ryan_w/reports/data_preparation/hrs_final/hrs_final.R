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
#install.packages("leaps")

# @knitr LoadPackages --------------------
# Load the necessary packages.
base::require(base)
base::require(knitr)
base::require(markdown)
base::require(testit)
base::require(plyr)
base::require(dplyr)
base::require(reshape2)
base::require(stringr)
base::require(stats)
base::require(ggplot2)
base::require(extrafont)
base::require(gamair)
base::require(lme4)
base::require(nlme)
base::require(leaps)

# @knitr LoadData --------------------
# Link to the data source 
pathDir <- getwd()
myExtract <- file.path(pathDir,"data/raw/hrs_data/hrs_retirement")
pathSourceData <- paste0(myExtract,".csv") 
SourceData <- read.csv(pathSourceData,header=TRUE, skip=0,sep=",")
ds0 <- SourceData

# @knitr LoadGraphSettings --------------------
# load themes used to style graphs
source("./scripts/graphs/graph_themes.R")

# @knitr RenameVariables --------------------
# rename variables for easier handling
ds0 <- plyr::rename(ds0, 
                    c("hhidpn"="id",
                      "ragender"="sex",
                      "raracem"="race",
                      "rabyear"="byear",
                      "agey"="age"
                    )
)

# @knitr GroupID
ds0 <- dplyr::group_by(ds0,id)

# @knitr SubsetData
ds1 <- subset(ds0, id<10050000)
dsM <- subset(ds1, id>2000)

# @knitr BasicGraph --------------------
n <- ggplot(dsM, aes(x=bmi))
n <- n + geom_histogram(fill = "blue")
n <- n + labs(title="Distribution of BMI")
n

# @knitr DataForModel --------------------
dsM <- dplyr::filter(dsM) %>%
  select(id, wave, age, sex, bmi, arthr) 

# @knitr RemoveMissing -------------
hrs_analysis <- na.omit(dsM)

# @knitr SaveDerivedData --------------------
pathdsLcsv <- "./data/derived/hrs/hrs_analysis.csv"
write.csv(hrs_analysis,pathdsLcsv,  row.names=FALSE)

pathdsLrds <- "./data/derived/hrs/hrs_analysis.rds"
saveRDS(object=hrs_analysis, file=pathdsLrds, compress="xz")

# @knitr CleanUp --------------------
# # remove all but specified dataset
rm(list=setdiff(ls(), "hrs_analysis"))

# @knitr BMIvsAge
h <- ggplot(hrs_analysis, aes(age, bmi))
h <- h + geom_smooth(method=lm, 
                     size=.9,
                     color="red")+
        geom_point()
h <- h + theme1
h <- h + labs(title="Relationship of BMI and Age")
h

# @knitr BMIvsArt
a <- ggplot(hrs_analysis, aes(arthr, bmi))
a <- a + geom_smooth(method=lm, 
                     size=.9,
                     color="red")+
        geom_point()
a <- a + theme1
a <- a + labs(title="Relationship of BMI and Arthritis")
a

# @knitr AnalysisStart-----------
p <- ggplot(hrs_analysis)
p <- p + geom_point(aes
                    (x=age,y=bmi
                    ))
p <- p + labs(title="Relationship of BMI and Age for Individuals")
p <- p + theme1
p <- p + facet_wrap(~id)
p

# @knitr MakingModel00 -----------
m00 <- lm(bmi~age, data=hrs_analysis)
AIC00 <- AIC(m00)
BIC00 <- BIC(m00)
dev00 <- deviance(m00)
(m00_sum <- summary(m00))

# @knitr MakingModel0
# empty model. Only intercept is modeled as random
m0 <- lme4::lmer(formula = bmi ~ 1 + (1|id), data=hrs_analysis)
AIC0 <- AIC(m0)
BIC0 <- BIC(m0)
dev0 <- deviance(m0)
(m0_sum <- summary(m0))

# @knitr MakingModel1 -----------
# age is modeled as fixed
m1 <- lme4::lmer(formula = bmi ~ 1 + age + (1|id), data=hrs_analysis)
AIC1 <- AIC(m1)
BIC1 <- BIC(m1)
dev1 <- deviance(m1)
(m1_sum <- summary(m1))

# @knitr MakingModel2 -----------
# intercept and slope of ages is random (estimated for each person)
m2 <- lme4::lmer(formula = bmi ~ 1 + age + (1 + age |id), data=hrs_analysis)
AIC2 <- AIC(m2)
BIC2 <- BIC(m2)
dev2 <- deviance(m2)
(m2_sum <- summary(m2))

# @knitr MakingModel3 -----------
# random intercept and slope + use arthritis to predict random intercept
m3 <- lme4::lmer(formula = bmi ~ 1 + age + arthr + (1 + age |id), data=hrs_analysis)
AIC3 <- AIC(m3)
BIC3 <- BIC(m3)
dev3 <- deviance(m3)
(m3_sum <- summary(m3))

# @knitr MakingModel4 -----------
# enter arthritis as predictor on second level for both intercept and slope
m4 <- lme4::lmer(formula = bmi ~ 1 + age + arthr + age:arthr + (1 + age |id), data=hrs_analysis)
AIC4 <- AIC(m4)
BIC4 <- BIC(m4)
dev4 <- deviance(m4)
(m4_sum <- summary(m4))

# @knitr CombiningFits
AIC <- c(AIC00, AIC0, AIC1, AIC2, AIC3, AIC4)
BIC <- c(BIC00, BIC0, BIC1, BIC2, BIC3, BIC4)
Devall <- c(dev00, dev0, dev1, dev2, dev3, dev4)


# @knitr GeneratePredictions -------
hrs_analysis$m0 <- predict(m0)
hrs_analysis$m1 <- predict(m1)
hrs_analysis$m2 <- predict(m2)
hrs_analysis$m3 <- predict(m3)
hrs_analysis$m4 <- predict(m4)

head(hrs_analysis)

dsPred <- tidyr::gather(hrs_analysis, "model", "predicted_bmi", 7:11)
head(dsPred)

# @knitr GraphPredictions
pg <- ggplot2::ggplot(dsPred, aes(x=age, y=bmi)) +
  geom_point() +
  geom_line(aes(y=predicted_bmi, group=model, color=model))+
  facet_wrap(~id)+
  scale_color_manual(values=c("m0"="black", "m1"="#ff7f00", "m2"="#e41a1c", "m3"="#4daf4a",
                              "m4"="#377eb8"))+
  theme1 
pg <- pg + labs(title="Relationship of BMI and Age for Individuals")
pg

# @knitr GraphFits
d <- data.frame(Model=0:5, AIC=0:5, BIC=0:5, dev=0:5)
d$AIC <- AIC
d$BIC <- BIC
d$dev <- Devall
d$Model <- factor(d$Model)
d$Model <- as.character(d$Model)
d$Model[d$Model == "0"] <- "Fixed Only"
d$Model[d$Model == "1"] <- "M0"
d$Model[d$Model == "2"] <- "M1"
d$Model[d$Model == "3"] <- "M2"
d$Model[d$Model == "4"] <- "M3"
d$Model[d$Model == "5"] <- "M4"
d <- melt(d, Model="Model", AIC="AIC", BIC="BIC", dev="dev")


f <- ggplot2::ggplot(d, aes(x=Model, y=value, 
                            group = variable, colour = variable)) +
  geom_point(size=4, shape=21, fill="white") +
  geom_line(aes(y=value, group=variable, color=variable))+
  theme1
f <- f + labs(title="Fit Indices for All Models")
f
  
# @knitr PredictModels -------
hrs_analysis$m0 <- predict(m0)
p0 <- p +geom_line(aes
                  (x=age,y=m0),data=hrs_analysis,
                  colour="#d95f02", lty="solid", size=1, alpha=1)

hrs_analysis$m1 <- predict(m1)
p <- p +geom_line(aes
                  (x=age,y=m1),data=hrs_analysis,
                  colour="#1b9e77", lty="solid")

hrs_analysis$m2 <- predict(m2)
p <- p +geom_line(aes
                  (x=age,y=m2),data=hrs_analysis,
                  colour="red", lty="solid")

hrs_analysis$m3 <- predict(m3)
p <- p +geom_line(aes
                  (x=age,y=m3),data=hrs_analysis,
                  colour="blue", lty="solid")

hrs_analysis$m4 <- predict(m4)
p <- p +geom_line(aes
                  (x=age,y=m4),data=hrs_analysis,
                  colour="yellow", lty="solid")
p

# @knitr LoadAnalysisData ----------------
pathDir <- getwd()
myExtract <- file.path(pathDir,"data/derived/hrs/hrs_analysis")
pathSourceData <- paste0(myExtract,".csv") 
SourceData <- read.csv(pathSourceData,header=TRUE, skip=0,sep=",")
hrs_analysis <- SourceData
