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

# @knitr LoadData --------------------
pathDir <- getwd()
myExtract <- file.path(pathDir,"data/raw/Adolescent_Nov2015")
pathSourceData <- paste0(myExtract,".csv") 
SourceData <- read.csv(pathSourceData,header=TRUE, skip=0,sep=",")
ds0 <- SourceData
  
# @knitr CleanData --------------------
# Remove ethnicity data because of data collection issue
ds0$Ethnicity <- NULL
# Remove cases tagged as "Exclude". Exclusion is based on various reasons not reflected in data. 
data <- ds0[(ds0$Include_Filter==1),]


# @knitr DataInspection --------------------
dim(data)
names(data)

# @knitr DataManipulation --------------------
# working with smaller datasets
# if interested in looking at motivational variables only, use this dataset
dsMot <- subset(data, , select= c("Subject",
                               "School",
                               "Gender",
                               "Age",
                               "con_tot",
                               "pro_tot",
                               "procon_tot",
                               "MSC_Tot",
                               "MathSuccess_Ability",
                               "MathSuccess_Effort",
                               "MathSuccess_External",
                               "MathFailure_Ability",
                               "MathFailure_Effort",
                               "MathFailure_External",
                               "Mastery_Tot",
                               "PApproach_Tot",
                               "PAvoid_Tot"))
head(dsMot)
str(dsMot)

# if interested in looking at Math IAT test only, use this dataset
dsIAT0 <- subset(data, , select= c("Subject",
                                  "School",
                                  "Gender",
                                  "Age",
                                  "con_tot",
                                  "pro_tot",
                                  "procon_tot",
                                  "GenderMath",
                                  "GenderReading",
                                  "Gender3",
                                  "IAT_Tot",
                                  "SpeedInd",
                                  "SelfExpMath",
                                  "SelfExpReading"))
dsIAT = na.omit(dsIAT0)
str(dsIAT)
head(dsIAT)

# Repeated Measure for Attribution Scale
dsRep <- subset(data, , select= c("Subject","Gender","Age", 
                                  "con_tot", "pro_tot","procon_tot",
                                  "MathSuccess_Ability",
                                  "MathSuccess_Effort",
                                  "MathSuccess_External",
                                  "MathFailure_Ability",
                                  "MathFailure_Effort",
                                  "MathFailure_External",
                                  "SuperCluster"))
dsRepL<- melt(dsRep, id.vars = c("Subject", "Gender", "Age", "con_tot", "pro_tot","procon_tot", "SuperCluster"), 
              variable.name = "attribution.type", value.name = "attribution.score")
head(dsRepL)

# Repeated Measure for Goal Orientation Scale
dsRepGoal <- subset(data, , select= c("Subject","Gender","Age", 
                                  "con_tot", "pro_tot","procon_tot",
                                  "Mastery_Tot",
                                  "PApproach_Tot",
                                  "PAvoid_Tot",
                                  "SuperCluster"))
colnames(dsRepGoal)[7] <- "goal.orient1"
colnames(dsRepGoal)[8] <- "goal.orient2"
colnames(dsRepGoal)[9] <- "goal.orient3"
dsRepGoal<- melt(dsRepGoal, id.vars = c("Subject", "Gender", "Age", "con_tot", "pro_tot","procon_tot", "SuperCluster"), 
                 variable.name = "goal.type", value.name = "goal.score")
head(dsRepGoal)

# @knitr SaveDerivedData --------------------
pathdsLcsv <- "./data/derived/data.csv"
write.csv(data,pathdsLcsv,  row.names=FALSE)

pathdsLrds <- "./data/derived/data.rds"
saveRDS(object=data, file=pathdsLrds, compress="xz")
saveRDS(dsMot,"./data/derived/dsMot.rds")
saveRDS(dsIAT,"./data/derived/dsIAT.rds")
saveRDS(dsRepL,"./data/derived/dsRepL.rds")
saveRDS(dsRepGoal,"./data/derived/dsRepGoal.rds")


# @knitr CleanUp --------------------
rm(list=setdiff(ls(), c("data","dsMot","dsIAT")))
