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
# Link to the data source 
pathDir <- getwd()
myExtract <- file.path(pathDir,"data/raw/hrs_retirement")
pathSourceData <- paste0(myExtract,".csv") 
SourceData <- read.csv(pathSourceData,header=TRUE, skip=0,sep=",")
ds0 <- SourceData


# @knitr RenameVariables --------------------
# rename variables for easier handling
ds0 <- plyr::rename(ds0, 
                    c("conde"="chronicc",
                      "hhidpn"="id",
                      "cesd"="depressivesym"
                    )
)






# @knitr selectdsM --------------------


dsM = ds0[ ,c("id", "wave", "chronicc","cogslope",  "depressivesym", "bmi", "cogsc", "agey", "smoken", "drink", "strok", "psych", "diab", "arthr", "cancr", "vigact")]

#knitr DeleteMissing ------------------------
sum(is.na(ds0$bmi))

dsM <- na.omit(dsM)



# @knitr summary --------------------

  summary(dsM)

# @knitr BasicGraph1 --------------------
plot(dsM$agey, dsM$bmi, main="Age and BMI", 
     xlab="Age in Years ", ylab="BMI ", pch=1)

# @knitr BasicGraph2 --------------------
plot(dsM$cogslope, dsM$bmi, main="Cognitive Slope and BMI", 
     xlab="Cognitive Slope ", ylab="BMI ", pch=1)


# @knitr SaveDerivedData --------------------

pathdsMcsv <- "./data/derived/dsM.csv"
write.csv(dsM,pathdsMcsv,  row.names=FALSE)

pathdsMrds <- "./data/derived/dsM.rds"
saveRDS(object=dsM, file=pathdsMrds, compress="xz")

# @knitr CleanUp --------------------
# # remove all but specified dataset
rm(list=setdiff(ls(), c("dsM")))

