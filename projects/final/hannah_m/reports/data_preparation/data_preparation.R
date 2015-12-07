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

# @knitr LoadData --------------------
pathDir <- getwd()
myExtract <- file.path(pathDir,"data/raw/hrs_retirement")
# myExtract <- "./data/raw/hrs_retirement"
pathSourceData <- paste0(myExtract,".csv") 
SourceData <- read.csv(pathSourceData,header=TRUE, skip=0,sep=",")
ds0 <- SourceData

# @knitr LoadGraphSettings --------------------
source("./scripts/graphs/graph_themes.R")

# @knitr selectdsM --------------------
dsM <- ds0[ ,c("psych", "ragender", "vigact", "cogtot", "agey", "bmi", "raedyrs", "wave")]

# @knitr summary ----------------------
summary(dsM)

# @knitr deletemissinginfo ------------------
dsM <-na.omit(dsM)

# @knitr Timepoint ------------
dsM <- dsM %>% dplyr::filter(wave==5)

# @knitr newsummary ---------------------
summary(dsM)

# @knitr SaveDerivedData --------------------
pathdsMcsv <- "./data/derived/dsM.csv"
write.csv(dsM,pathdsMcsv,  row.names=FALSE)

pathdsMrds <- "./data/derived/dsM.rds"
saveRDS(object=dsM, file=pathdsMrds, compress="xz")

# @knitr CleanUp --------------------
rm(list=setdiff(ls(), c("dsM")))