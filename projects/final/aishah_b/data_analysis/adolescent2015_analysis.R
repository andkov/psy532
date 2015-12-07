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
base::require(gridExtra)

# @knitr LoadData --------------------
data <- read.csv("./data/derived/data.csv")

# @knitr ClusterAnalysis --------------------
# kmeanstests and numclustertests functions written by Hallett et al. (2011)
source("scripts/kmeanstests.R")
source("scripts/numclustertests.R")
membership = as.data.frame(data$SuperCluster, k = 2:10)
ClusterData = data.frame(cbind(scale(data[c("con_rdw", "pro_rdw", "procon_tot")]), membership))
koutput <- kmeanstests(ClusterData[,1:3],membership)
koutput$means$Clusters4

# @knitr DescriptiveCluster --------------------
library(gmodels)
CrossTable(data$Gender, data$SuperCluster, chisq=TRUE)

# @knitr MergeData --------------------
# in dsL procon_tot, con_rdw, pro_rdw are updated with new values from above cluster analysis
# new labels = procon_tot.y, con_rdw.y, con_rdw.y
dsL = merge(data,ClusterData, by="row.names")
rownames(dsL) <- dsL$ID

# @knitr DataForModel --------------------
# Select variable of interest and work with a smaller dataset. There's more to delete than select. 
dsA <- subset(dsL, , select= c("Subject",
                                "School",
                                "Gender",
                                "Age",
                                "con_tot",
                                "pro_tot",
                                "procon_tot.y",
                                "MSC_Tot",
                                "MathSuccess_Ability",
                                "MathSuccess_Effort",
                                "MathSuccess_External",
                                "MathFailure_Ability",
                                "MathFailure_Effort",
                                "MathFailure_External",
                                "Mastery_Tot",
                                "PApproach_Tot",
                                "PAvoid_Tot",
                                "con_rdw.y",
                                "pro_rdw.y",
                                "SuperCluster",
                                "Work_Con",
                                "Work_Pro"))
dsA$clusterF= factor(dsA$SuperCluster)
dsA$SuperCluster <- factor(dsA$SuperCluster,
                    levels = c(1,2,3,4),
                    labels = c("con", "hi", "lo", "pro"))

# @knitr SubsetSelection --------------------
library(leaps)
regfit.best=regsubsets(procon_tot.y~MSC_Tot+
                        MathSuccess_Ability+
                        MathSuccess_Effort+
                        MathSuccess_External+
                        MathFailure_Ability+
                        MathFailure_Effort+
                        MathFailure_External+
                        Mastery_Tot+
                        PApproach_Tot+
                        PAvoid_Tot, data=dsA)
reg.summary=summary(regfit.best)
which.max(reg.summary$adjr2)
which.min(reg.summary$cp)
which.min(reg.summary$bic)
par(mfrow=c(1,3))
plot(reg.summary$adjr2 ,xlab="Number of Variables ",ylab="Adjusted RSq",type="l")
plot(reg.summary$cp ,xlab="Number of Variables ",ylab="Cp", type="l")
plot(reg.summary$bic ,xlab="Number of Variables ",ylab="BIC",type="l")
# Given the statistics above, a model that includes 3 variables is best
coef(regfit.best,3)


# @knitr BasicGraph1 --------------------
# mainTheme is written by Github user- andkov 
source("scripts/mainTheme.R")
# plot 1
g1 <- ggplot(data=dsA, aes(x=MSC_Tot,y=procon_tot.y)) + 
  geom_point(aes(color=factor(SuperCluster), aplha=.4)) + 
  geom_smooth(method="lm", se=FALSE, size=0.5, color="red", alpha=.5) +
  main_theme +
  labs(x="Fraction Performance", y="Math Self-Concept") +
  guides(color = guide_legend(title="Cluster Membership")) 
#   ggtitle("Fraction performance as a function of\nmath self-concept") +
#   theme(plot.title = element_text(lineheight=.8, face="bold"))
# plot 2
g2 <- ggplot(data=dsA, aes(x=MathSuccess_Ability, y=procon_tot.y)) + 
  geom_point(aes(color=factor(SuperCluster), aplha=.4)) + 
  geom_smooth(method="lm", se=FALSE, size=0.5, color="red", alpha=.5) +
  main_theme +
  labs(x="Fraction Performance", y="MathSuccess_Ability") +
  guides(color = guide_legend(title="Cluster Membership")) 
#   ggtitle("Fraction performance as a function of\nability attribution for math success") +
#   theme(plot.title = element_text(lineheight=.8, face="bold"))
# plot 3
g3 <- ggplot(data=dsA, aes(x=Mastery_Tot, y=procon_tot.y)) + 
  geom_point(aes(color=factor(SuperCluster), aplha=.4)) +
  geom_smooth(method="lm", se=FALSE, size=0.5, color="red", alpha=.5) +
  main_theme +
  labs(x="Fraction Performance", y="Mastery Goal") +
  guides(color = guide_legend(title="Cluster Membership")) 
#   ggtitle("Fraction performance as a function of\nmastery goal orientation") +
#   theme(plot.title = element_text(lineheight=.8, face="bold"))
# g1
# g2
# g3
# plot all
grid.arrange(g1,g2,g3, ncol=2, nrow=2, heights=3000, widths=50)


# @knitr MeanComparison1--------------------
anova <- aov(MSC_Tot ~ clusterF, data=dsA)
summary(anova)
# run post-hoc comparison
with(dsA, pairwise.t.test(MSC_Tot, clusterF, p.adj="bonferroni", paired=F))

# @knitr MSCPlot--------------------
plot(MSC_Tot~factor(SuperCluster), data=dsA)

# @knitr MeanComparison2 --------------------
# For past successes
dsRepL <- readRDS("./data/derived/dsRepL.rds")
dsRep.Success <- dsRepL[grep("MathSuccess-*", dsRepL$attribution.type), ]
aov.rep = aov(attribution.score ~ attribution.type * factor(SuperCluster) + Error(Subject/attribution.type), data=dsRep.Success)
summary(aov.rep)

# @knitr AttributionPlot1 --------------------
par(mfrow=c(1,3))
plot(MathSuccess_Ability~factor(SuperCluster), data=dsA, xlab="Cluster")
plot(MathSuccess_Effort~factor(SuperCluster), data=dsA, xlab="Cluster")
plot(MathSuccess_External~factor(SuperCluster), data=dsA, xlab="Cluster")

# @knitr MeanComparison2_2 --------------------
# For past failures
dsRep.Fail <- dsRepL[grep("MathFail-*", dsRepL$attribution.type), ]
aov.rep2 = aov(attribution.score ~ attribution.type * factor(SuperCluster) + Error(Subject/attribution.type), data=dsRep.Fail)
summary(aov.rep2)

# @knitr AttributionPlot2 --------------------
par(mfrow=c(1,3))
plot(MathFailure_Ability~factor(SuperCluster), data=dsA, xlab="Cluster")
plot(MathFailure_Effort~factor(SuperCluster), data=dsA, xlab="Cluster")
plot(MathFailure_External~factor(SuperCluster), data=dsA, xlab="Cluster")

# @knitr MeanComparison3 --------------------
dsRepGoal <- readRDS("./data/derived/dsRepGoal.rds")
aov.rep3 = aov(goal.score ~ goal.type * factor(SuperCluster) + Error(Subject/goal.type), data=dsRepGoal)
summary(aov.rep3)

# @knitr SaveDerivedData --------------------
pathdsLcsv <- "./data/derived/dsA.csv"
write.csv(dsA,pathdsLcsv,  row.names=FALSE)

# @knitr CleanUp --------------------
rm(list=setdiff(ls(), c("dsA", "dsL")))