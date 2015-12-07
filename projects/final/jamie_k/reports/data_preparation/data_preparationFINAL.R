# For annotations to this file visit ./projects/nlsy97/annotate_data_creation/ 
# Clear memory from previous runs
base::rm(list=base::ls(all=TRUE))
cat("\f")


# @knitr LoadPackages --------------------
# Load the necessary packages.
base::require(base)


# install.packages("knitr")
# install.packages("markdown")
# install.packages("testit")
# install.packages("dplyr")
# install.packages("reshape2")
# install.packages("stats")
# install.packages("ggplot2")
# install.packages("extrafont")
base::require(markdown)
base::require(testit)
base::require(dplyr)
base::require(plyr)
base::require(reshape2)
base::require(stringr)
base::require(stats)
base::require(ggplot2)
base::require(extrafont)
base::require(lattice)
base::require(ggplot2)




# @knitr LoadRename --------------------
#We are going to load, rename and Subset the data to just the variables we need: 
#smell and taste across waves 3, 5, 6, and 7.

#### The first one: S06, IPT, wave 3 ####
#can load from the internet or have downloaded them in advance as seen below
pathDir <- getwd()
load(file.path(pathDir,"data/raw/03843-0006-Data.rda"))
# load("~/Jamie/532final/data/raw/03843-0006-Data.rda")

#06 S, wave 3
S06 <- c("TWINNR", "XSMELL", "XTASTE")
satsa06 <- da03843.0006[S06]

#need to add new variable 'wave' with 3 as value for all
satsa06$WAVE <- 3 

#save and export your file for use later, optional
#save(satsa06,file="./data/derived/satsa06.csv")
#save(satsa06,file=".data/derived/satsa06.rda")

#now this needs to be done for each of the waves
#we skip S10 because it only has 40 participants

#11 R, Wave 5
load(file.path(pathDir,"data/raw/03843-0011-Data.rda"))
S11 <- c("TWINNR", "RSMELL", "RTASTE")
satsa11 <- da03843.0011[S11]

#rename - the variables to XSMELL and XTASTE so that they are the same as in the rest
names(satsa11)[names(satsa11)=="RSMELL"] <- "XSMELL" # change to smell
names(satsa11)[names(satsa11)=="RTASTE"] <- "XTASTE" # change to taste             

#add a column with wave 5 
satsa11$WAVE <- 5 # 

#save and export your file for use later
#save(satsa13,file="satsa13.csv")
#save(satsa13,file="satsa13.rda")


#13 S, Wave 6
load(file.path(pathDir,"data/raw/03843-0013-Data.rda"))
S13 <- c("TWINNR", "SSMELL", "STASTE")
satsa13 <- da03843.0013[S13]

#rename - these are SSMELL as oppsed to XSMELL that are in the rest
names(satsa13)[names(satsa13)=="SSMELL"] <- "XSMELL"
names(satsa13)[names(satsa13)=="STASTE"] <- "XTASTE"               

#add a column with wave 6
satsa13$WAVE <- 6

#save and export your file for use later
#save(satsa13,file="satsa13.csv")
#save(satsa13,file="satsa13.rda")


#15 U, wave 7
load(file.path(pathDir,"data/raw/03843-0015-Data.rda"))
S15 <- c("TWINNR", "USMELL", "UTASTE")
satsa15 <- da03843.0015[S15]

#rename - these are SSMELL as oppsed to XSMELL that are in the rest
names(satsa15)[names(satsa15)=="USMELL"] <- "XSMELL"
names(satsa15)[names(satsa15)=="UTASTE"] <- "XTASTE"               

satsa15$WAVE <- 7 

#save and export your file for use later
#save(satsa13,file=".data/derived/satsa13.csv")
#save(satsa15,file="satsa15.rda")

####now we need to combine all these data waves together####

#add rows to the bottom for the additional waves of data
#these are all variables with id, and wave data added
#there is no need to merge by id here as we are adding more rows/participants
satsa3567 <- rbind(satsa06, satsa11, satsa13, satsa15)
# save(satsa3567,file="./data/derived/satsa3567.rda")

#now we have long format data with smell and taste for waves 3, 5, 6, and 7

#now add the administrative data
####import administrative data S01####
load(file.path(pathDir,"data/raw/03843-0001-Data.rda"))
S01 <- c("TWINNR", "PAIRID", "SEX", "YRBORN2")
satsa01 <- da03843.0001[S01]
#save(satsa01,file="satsa01.rda")

#now merge this into the complete smell data by id so we have smell in 4 waves plus the admin info
satsa_ds <- merge(satsa3567, satsa01, by="TWINNR")
#save(satsa_ds,file="satsads.rda")

####We need to add in the MMSE scores####
load(file.path(pathDir,"data/raw/03843-0052-Data.rda"))
S52 <- c("TWINNR", "MMSE7_IPT1", "MMSE7_IPT3", "MMSE7_IPT5", "MMSE7_IPT6", "MMSE7_IPT7") 
satsa52 <- da03843.0052[S52]

# dslong <- melt(satsa52, id.vars = c("TWINNR"),
#                variable.name = "WAVE2",
#                value.name = "MMSE")
# dscog <- c("TWINNR", "WAVE2", "MMSE")
# satsaMMSE <- dslong[dscog]


dslong <- melt(satsa52, id.vars = c("TWINNR"),
               variable.name = "WAVE",
               value.name = "MMSE"); head(dslong)
# dscog <- c("TWINNR", "WAVE2", "MMSE")
# satsaMMSE <- dslong[dscog]
dslong$WAVE <- stringr::str_sub(dslong$WAVE, start =  -1, end =  -1)

####Get MMSE score merged into the complete smell and adminstrative data####
# load("~/Jamie/SATSA/satsaMMSE.rda")
head(satsa_ds); head(dslong)
satsafull <- merge(satsa_ds, dslong, by=c("TWINNR", "WAVE"))
head(satsafull)

# @knitr show_values --------------------
ds <- satsafull
head(ds)
table(ds$WAVE)

table(ds[ds$WAVE==3,]$XSMELL)
table(ds[ds$WAVE==5,]$XSMELL)
table(ds[ds$WAVE==6,]$XSMELL)
table(ds[ds$WAVE==7,]$XSMELL)

# @knitr RenameSex --------------------
####Rename variable levels in SEX, XSMELL and XTASTE####
#clear your golbal environment of everything but the satsafull dataset
rm(list=(ls()[ls()!="satsafull"]))
# recode SEX 
satsafull$sex <- plyr::revalue(satsafull$SEX,replace =  c("(1) male"="1", "(2) female"="2"))
table(satsafull$sex)
# make sex a factor
satsafull$sex <- factor(satsafull$sex,levels = c(1, 2), labels = c("male","female"))
levels(satsafull$sex)
table(satsafull$sex)


# @knitr RenameVariables --------------------
#next we do the same thing to XSMELL and XTASTE
#first convert 'XSMELL' to 'smell' as integer only
head(satsafull)

#recode XSMELL
#smell is coded with different numerical values in the different waves, you must use the words as the basis for the value
# do not use the number as the basis for the value as it is the question number not a value
#we recode everything to be 3 = good, 2= pretty good and not so good 1=bad

satsafull$smell <- plyr::revalue(satsafull$XSMELL,replace =  c("(1) Good"="3", "(1) good"="3", "(2) Pretty Good"="2", "(3) Bad"="1", "(3) good"="3", "(4) not so good"="2", "(2) not so good"="2", "(5) bad"="1", "(3) bad"="1"))
table(satsafull$smell)
#make smell a factor
satsafull$smell <- factor(satsafull$smell,levels = c(3, 2, 1), labels = c("Good", "Pretty Good", "Bad"))
levels(satsafull$smell)
table(satsafull$smell)

#to make a better looking table we can use this code
#knitr::kable(satsafull, format, digits = getOption("digits"), row.names = NA, col.names = colnames(satsafull$smell), align, caption = NULL, format.args = list(), escape=TRUE)

#using this code to check the provided frequency tables from SATSA
ds <- satsafull
head(ds)
table(ds$WAVE)
d <- ds[ds$WAVE==3,]
table(d$WAVE)
table(d$XSMELL)
#table(d$smell)

#recode XTASTE
#taste is coded the same as smell above.
table(satsafull$XTASTE)
satsafull$taste <- plyr::revalue(satsafull$XTASTE,replace =  c("(1) Good"="3", "(1) good"="3", "(2) Pretty Good"="2", "(3) Bad"="1", "(3) good"="3", "(4) not so good"="2", "(2) not so good"="2", "(5) bad"="1", "(3) bad"="1"))
table(satsafull$taste)

#make taste a factor
satsafull$taste <- factor(satsafull$taste,levels = c(3, 2, 1), labels = c("Good", "Pretty Good", "Bad"))
levels(satsafull$taste)
table(satsafull$taste)

# @knitr SaveDerivedData --------------------

save(satsafull,file="./data/derived/dsLong.rda")

# @knitr CleanUp --------------------
# # clean up environment
rm(list=(ls()[ls()!="satsafull"]))
#base::rm(list=base::ls(all=TRUE))
cat("\f")


#### THE END ####
