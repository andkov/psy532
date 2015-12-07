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




# @knitr BasicGraph --------------------


# @knitr BasicModel --------------------

# @knitr SaveDerivedData --------------------

pathdsLcsv <- "./data/derived/dsL.csv"
write.csv(dsL,pathdsLcsv,  row.names=FALSE)

pathdsLrds <- "./data/derived/ds.rds"
saveRDS(object=dsL, file=pathdsLrds, compress="xz")

# @knitr CleanUp --------------------
# # remove all but specified dataset
rm(list=setdiff(ls(), c("dsW","dsL","ds")))