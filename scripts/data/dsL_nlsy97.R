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

# @knitr DeclareGlobals --------------------


# @knitr LoadData --------------------
# Link to the data source 
pathDir <- getwd()
myExtract <- file.path(pathDir,"data/nlsy97/NLSY97_Attend_20141021/NLSY97_Attend_20141021")
# myExtract <- "./data/nlsy97/NLSY97_Attend_20141021/NLSY97_Attend_20141021"
# myExtract <- "https://raw.githubusercontent.com/IALSA/COAG-colloquium-2014F/master/Data/Extract/NLSY97_Attend_20141021/NLSY97_Attend_20141021"
pathSourceData <- paste0(myExtract,".csv") 
SourceData <- read.csv(pathSourceData,header=TRUE, skip=0,sep=",")
ds0 <- SourceData

# @knitr ImportVarLabels --------------------
### NLSY97 variable "id" is linked to the descriptive label in the header of the STATA formated data file.dtc" ###
pathSourceLabels <- paste0(myExtract,".dct")
SourceLabels<-read.csv(pathSourceLabels,header=TRUE, skip=0,nrow=17, sep="")
SourceLabels$X.<-NULL # remove extra column
SourceLabels
# rename columns to match NLS Web Investigator format
SourceLabels<-plyr::rename(SourceLabels,
                     replace=c("infile"="RNUM","dictionary"="VARIABLE_TITLE")
) 
# sort for visual inspection
SourceLabels<-SourceLabels[ with(SourceLabels, order(RNUM)), ]
SourceLabels

# @knitr RenameVariables --------------------
# rename variables for easier handling
ds0 <- plyr::rename(ds0, 
            c("R0000100"="id",
              "R0536300"="sex",
              "R1482600"="race",
              "R0536402"="byear",
              "R0536401"="bmonth",
              "R4893400"="attend_2000",
              "R6520100"="attend_2001",
              "S0919300"="attend_2002",
              "S2987800"="attend_2003",
              "S4681700"="attend_2004",
              "S6316700"="attend_2005",
              "S8331500"="attend_2006",
              "T0739400"="attend_2007",
              "T2781700"="attend_2008",
              "T4495000"="attend_2009",
              "T6143400"="attend_2010",
              "T7637300"="attend_2011"
              )
            )

# @knitr QueryData1 --------------------
# with $
a <- ds0$id # extracts column "id" from dataset "ds0"
class(a)
str(a)

# @knitr QueryData2 --------------------
# with [ ]
a <- ds0[,c("id","sex")] # extracts column "id" from dataset "ds0"
class(a)
str(a)

# @knitr QueryData3 --------------------
# with dplyr package
require(dplyr)
dplyr::filter(ds0, id<5) %>% dplyr::select(id, sex, race)

# @knitr arrivedsW --------------------
# Manually create the vector that contains the names of the variables you would like to keep. 
attend_years <- paste0("attend_",c(2000:2011))
selectVars <- c("id", "sex", "race", "byear", "bmonth", attend_years)
dsW <- ds0[,selectVars]
head(dsW)

# @knitr RemoveIllegal  --------------------
# Remove illegal values. See codebook for description of missingness
illegal<-as.integer(c(-5:-1,997,998,999))
for( variable in names(dsW) ){
  dsW[,variable]=ifelse(dsW[,variable] %in% illegal,NA,dsW[,variable])
}
# Include only records with a valid birth year
dsW <- dsW[dsW$byear %in% 1980:1984, ]
#Include only records with a valid ID
dsW <- dsW[dsW$id != "V", ] # rows that do NOT(!) equal string 'V"
dsW$id <- as.integer(dsW$id) # forced to be integer
rm(list=setdiff(ls(), c("ds0","dsW")))
# cat("\014") # clears console
# str(dsW)



# @knitr Melt01 --------------------
require(dplyr)
dplyr::filter(dsW, id < 5) 


# @knitr Melt02 --------------------
TIvars<-c("id", "sex","race", "bmonth","byear") # Time Invariant (TI)
# id.vars tells what variables SHOULD NOT be stacked
dsLong <- reshape2::melt(dsW, id.vars=TIvars) # melt 
dplyr::filter(dsLong, id == 1)

# @knitr Melt03 --------------------
# nrow(dsLong)/length(unique(dsLong$id)) # should be integer
dsLong <- dplyr::filter(dsLong,!is.na(id)) # remove obs with invalid id
# nrow(dsLong)/length(unique(dsLong$id)) # verify that melting is fine
# dplyr::filter(dsLong,id==1) # inspect

# @knitr Melt04 --------------------
# create varaible "year" by stripping the automatic ending in TV variables' names
# subset 4 characters from the end of the string a into new variable
dsLong$year<-str_sub(dsLong$variable,-4,-1) 
dplyr::filter(dsLong, id == 1)

# @knitr Melt05 --------------------
# remove the automatic ending 
removePattern <- paste0("_",c(2000:2011))
for (i in removePattern){
  dsLong$variable <- gsub(pattern=i, replacement="", x=dsLong$variable) 
}
dsLong$year <- as.integer(dsLong$year) # Convert to a number.
dplyr::filter(dsLong,id==1) # inspect


# @knitr Cast01 --------------------
require(reshape2)
dsL <- dcast(dsLong, id + sex + race + bmonth + byear + year ~ variable, value.var = "value")
dplyr::filter(dsL,id==1)

# @knitr MutateData01 --------------------
#
dplyr::filter(dsL,id==1) %>% select(id,byear,year,attend)


# @knitr MutateData02 --------------------
dsL <- dplyr::mutate(dsL, age = year - byear)
dplyr::filter(dsL,id==1) %>% select(id,byear,year,attend, age)


# @knitr LabelFactors --------------------
dsF <- dsL # add factors to the dataset
source("./scripts/data/labeling_factor_levels.R")
dsL <- dsF
rm(dsF)
dplyr::filter(dsL,id==1)




# @knitr LoadGraphSettings --------------------
# load themes used to style graphs
source("./scripts/graphs/graph_themes.R")



# @knitr selectdsM --------------------
dsM <- dplyr::filter(dsL,id==47) %>%
  select(id,byear, year, attend, attendF)
dsM

# @knitr BasicGraph --------------------
p <- ggplot(dsM, aes(x=year,y=attend, color=factor(id)))
p <- p + geom_line(size=.4)
p <- p + geom_point(size=2)
p <- p + scale_y_continuous("Church attendance",
                         limits=c(0, 8),
                         breaks=c(1:8))
p <- p + scale_x_continuous("Year of observation",
                         limits=c(2000,2011),
                         breaks=c(2000:2011))
p <- p + scale_color_manual(values=c("purple"))
p <- p + labs(title=paste0("In the past year, how often have you attended a worship service?"))
p <- p + guides(color = guide_legend(title="Respondents"))
p <- p + theme1
p

# @knitr DataForModel --------------------
dsM <- dplyr::filter(dsL,id==47) %>%
  select(id,byear, year, attend, attendF) 
dsM$model <-  predict(lm(attend~year,dsM))


# @knitr BasicModel --------------------
p <- ggplot(dsM, aes(x=year,y=attend, color=factor(id)))
p <- p + geom_line(size=.4)
p <- p + geom_point(size=2)
p <- p + geom_line(aes(y=model),colour="red", linetype="dashed")
p <- p + scale_y_continuous("Church attendance",
                            limits=c(0, 8),
                            breaks=c(1:8))
p <- p + scale_x_continuous("Year of observation",
                            limits=c(2000,2011),
                            breaks=c(2000:2011))
p <- p + scale_color_manual(values=c("purple"))
p <- p + labs(title=paste0("In the past year, how often have you attended a worship service?"))
p <- p + guides(color = guide_legend(title="Respondents"))
p <- p + theme1
p


# @knitr SaveDerivedData --------------------

pathdsLcsv <- "./data/nlsy97/dsL.csv"
write.csv(dsL,pathdsLcsv,  row.names=FALSE)

pathdsLrds <- "./data/nlsy97/dsL.rds"
saveRDS(object=dsL, file=pathdsLrds, compress="xz")

# @knitr CleanUp --------------------
# # remove all but specified dataset
rm(list=setdiff(ls(), c("dsW","dsL")))
