# Clear memory from previous runs
base::rm(list=base::ls(all=TRUE))
cat("\f")

#install.packages("knitr")
#install.packages("markdown")
#install.packages("testit")
#install.packages("dplyr")
#install.packages("reshape2")
#install.packages("stats")
#install.packages("ggplot2")
#install.packages("extrafont")

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

# @knitr DeclareGlobals --------------------


# @knitr LoadData --------------------
# Link to the data source 
myExtract <- "./data/raw/Dial_PostTest_raw.csv"
pathSourceData <- paste0(myExtract) 
SourceData <- read.csv(pathSourceData,header=TRUE, skip=0,sep=",")
ds0 <- SourceData
ds0
names(ds0)
# @knitr RenameVariables --------------------
# rename variables for easier handling
ds0 <- plyr::rename(ds0, 
            c("SentPosition"="pos",
              "SentType"="type",
              "Accuracy"="accuracy",
              "TotalRT"="trt",
              "RTbyChar"="crt"))

# @knitr QueryData --------------------
# with $
class(ds0$trt)
str(ds0$trt)
ds0$trt
sort(ds0$trt, decreasing = FALSE)
# @knitr Filter --------------------
ds1<-subset(ds0, trt>1000)
dsf<-subset(ds1, trt<20000)
sort(dsf$trt, decreasing = FALSE)
# @knitr Aggregate1 --------------------
agrt <-aggregate(dsf$crt, by=list(dsf$type,dsf$pos), 
                    FUN=mean, na.rm=TRUE)
agac<-aggregate(dsf$accuracy, by=list(dsf$type,dsf$pos), 
                FUN=mean, na.rm=TRUE)
dssent <- merge(agrt, agac, by=c("Group.1", "Group.2"))
dssent
#rename new variables
dssent <- plyr::rename(dssent, 
                      c("x.x"="rt",
                        "x.y"="accuracy",
                        "Group.1"="type", 
                        "Group.2"="pos"))
# @knitr Aggregate2 --------------------
agrt2 <- aggregate(dsf$crt, by=list(dsf$type,dsf$Sub), 
                        FUN=mean, na.rm=TRUE)
agac2<-aggregate(dsf$accuracy, by=list(dsf$type,dsf$Sub), 
                FUN=mean, na.rm=TRUE)
dssub <- merge(agrt2, agac2, by=c("Group.1", "Group.2"))
dssub
#rename new variables
dssub <- plyr::rename(dssub, 
                       c("x.x"="rt",
                         "x.y"="accuracy",
                         "Group.1"="type", 
                         "Group.2"="subject"))
# @knitr SaveDerivedData --------------------
saveRDS(object=dssub, file="./data/derived/dialsubject.rds")
saveRDS(object=dssent, file="./data/derived/dialsentence.rds")
# @knitr CleanUp --------------------
