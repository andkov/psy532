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
# @knitr LoadData --------------------
# Link to the data source 
dssent <- readRDS("./data/derived/dialsentence.rds")
dssub <- readRDS("./data/derived/dialsubject.rds")
# @knitr T-test1 --------------------
tac<-t.test(dssub$accuracy~dssub$type)
tac
# @knitr Best1 --------------------
library(BEST)
bestout<-BESTmcmc(dssub$accuracy, dssub$type, verbose=FALSE)
summary(bestout)
plot(bestout)

# @knitr Graph1 --------------------
names(dssent)
#Accuracy by temporal trial 
SentenceType <- factor(dssent$type)
SentAC<-ggplot(dssent, aes(x = dssent$pos, y = dssent$accuracy, colour =SentenceType)) + geom_point(size=5)+
  ggtitle("Accuracy by Trial")+
  labs(x="Sentence Position", y="Accuracy(%)")+
  theme_bw()+ theme(axis.title=element_text(face="bold.italic", 
                                            size="12", color="brown"), legend.position="top")
SentAC
# @knitr Graph2 --------------------
SentenceType<-dssub$type
means.barplot <- qplot(x=dssub$subject, y=dssub$accuracy, fill=SentenceType, width=0.7,
                       data=dssub, geom="bar", stat="identity",
                       position="dodge")+
  theme_bw()+
  scale_fill_hue(name="Sentence Type")+
  xlab("Subject") +
  ylab("Accuracy") +
  ggtitle("Accuracy By Subject") 

means.barplot

# @knitr Graph3 --------------------
SentenceType <- factor(dssent$type)
SentRT<-ggplot(dssent, aes(x = dssent$pos, y = dssent$rt, colour =SentenceType)) + geom_point(size=5)+
  ggtitle("Reaction Time by Trial")+
  labs(x="Sentence Position", y="Reaction Time(ms/char)")+
  theme_bw()+ theme(axis.title=element_text(face="bold.italic", 
                                            size="12", color="brown"), legend.position="top")
SentRT

# @knitr T-test2 --------------------
Trt<-t.test(dssub$rt~dssub$type)
Trt

# @knitr Graph4 --------------------
SentenceType <- factor(dssent$type)
RtAC<-ggplot(dssub, aes(x = dssent$accuracy, y = dssent$rt, colour =SentenceType)) + geom_point(size=5)+
  ggtitle("Reaction Time and Accuracy")+
  labs(x="Accuracy", y="Reaction Time")+
  theme_bw()+ theme(axis.title=element_text(face="bold.italic", 
                                            size="12", color="brown"), legend.position="top")
RtAC

