rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\14")

# Load package libraries for the project
library(ISLR)

#### 8.(a) ####
pathDir <- getwd() # locate the working directory (root, home)
pathFile <- file.path(pathDir,"/data/ISLR/College.csv") # locate the file to import
college <- read.csv(pathFile) # import
??College # request additional information about the dataset
ds <- college # create generic object for brevity of reference


#### 8.(b) ####
fix(ds) # Open interaction pop-up window
rownames(ds) = ds[,1] # give names to the rows
ds = ds[,-1] # remove the first column

#### 8.(c).i. ####
summary(ds) # print summary
sapply(ds,mean) # see unit on lapply and sapply in R Programming swirl course
sapply(ds,sd) # standard deviation for each column
table(ds$Private) # one way frequency

####  8.(c).ii. #### 
pairs(ds[,1:10]) # print scatterplot matrix

# equivalent in ggplot 
library(GGally)
GGally::ggpairs(ds, columns=1:10)

#### 8.(c).iii. #### 
plot(ds$Private, ds$Outstate) # print bivariate distribution


library(ggplot2)
# ggplot anatomy  - http://sape.inf.usi.ch/quick-reference/ggplot2

# load custom graphical themes
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/main_theme.R")
# custom graphical options https://github.com/andkov/psy532/blob/master/scripts/graphs/main_theme.R

## Boxplot 
g <- ggplot2::ggplot(data=ds, mapping=aes(x=Private, y=Outstate))
# geoms for distributions http://www.cookbook-r.com/Graphs/Plotting_distributions_(ggplot2)/
g <- g + geom_boxplot(aes(fill=Private)) 
# scale options http://www.cookbook-r.com/Graphs/Axes_(ggplot2)/
g <- g + scale_y_continuous(limits=c(2200, 22000), # range 
                            breaks= seq(from=2000, to=25000, by=2000) ) # tick marks 
g <- g + scale_x_discrete(limits=c("Yes","No")) # sorting discrete scale
g <- g + coord_flip() # flipping vertical and horizontal dimensions
# use of color in ggplot http://www.cookbook-r.com/Graphs/Colors_(ggplot2)/ 
# g <- g + scale_fill_manual(values=c("Yes"="green", "No"="red")) # set custom color
# smart colors http://www.colorbrewer2.org/ 
g <- g + scale_fill_manual(values=c("Yes"="#99d594", "No"="#fc8d59")) 
g <- g +  main_theme # apply predefined theme, 
g

## Histogram 
# http://blog.datacamp.com/make-histogram-ggplot2/
g <- ggplot2::ggplot(data=ds, aes(x=Outstate, fill=Private))
g <- g + geom_histogram(stat="bin", binwidth=1000) 
g <- g +  main_theme 
g

## Density
g <- ggplot2::ggplot(data=ds, aes(x=Outstate, fill=Private))
g <- g + geom_density(alpha=.7) 
g <- g +  main_theme 
g



#### 8.(c).iv. ####
Elite = rep("No", nrow(ds))
Elite[ds$Top10perc>50] = "Yes"
Elite = as.factor(Elite)
ds = data.frame(ds, Elite)
summary(ds$Elite)
plot(ds$Elite, ds$Outstate)

# alternative in ggplot 
g <- ggplot2::ggplot(data=ds,aes(x=Outstate, fill=Elite))
g <- g + geom_density(alpha=.7) 
g <- g +  main_theme 
g


####  8.(c).v. #### 
par(mfrow=c(2,2))
hist(ds$Apps)
hist(ds$perc.alumni, col=2)
hist(ds$S.F.Ratio, col=3, breaks=10)
hist(ds$Expend, breaks=100)

# easy alternative in ggplot requires some data manipulation
# omitted for now

#### 8.(c).vi. ####
par(mfrow=c(1,1))
plot(ds$Outstate, ds$Grad.Rate)

# alternative in ggplot
# http://www.cookbook-r.com/Graphs/Scatterplots_(ggplot2)/
g <- ggplot2::ggplot(data=ds,aes(x=Outstate, y=Grad.Rate))
g <- g + geom_point()
g <- g + geom_smooth(alpha=.7, color="red", size=1)
g <- g +  main_theme 
g

# High tuition correlates to high graduation rate.
plot(ds$Accept / ds$Apps, ds$S.F.Ratio)

# alternative in ggplot
# http://www.cookbook-r.com/Graphs/Scatterplots_(ggplot2)/
g <- ggplot2::ggplot(data=ds,aes(x=Accept/Apps, y=S.F.Ratio))
g <- g + geom_point()
g <- g + geom_smooth(alpha=.7, color="red", size=1)
g <- g +  main_theme 
g


# dss with low acceptance rate tend to have low S:F ratio.
plot(ds$Top10perc, ds$Grad.Rate)
# Colleges with the most students from top 10% perc don't necessarily have
# the highest graduation rate. Also, rate > 100 is erroneous!

# alternative in ggplot
# http://www.cookbook-r.com/Graphs/Scatterplots_(ggplot2)/
g <- ggplot2::ggplot(data=ds,aes(y=Grad.Rate, x=Top10perc))
g <- g + geom_point()
g <- g + geom_smooth(alpha=.7, color="red", size=1)
g <- g +  main_theme 
g
