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
dsL = readRDS("./data/derived/dsL.rds")

# @knitr LoadSources -----------
source("./scripts/graphs/graph_themes.R")

# @knitr inspectData -------------------

ds2 = dplyr::select(dsL, shlt, psych, bmi, heart, lung, cancr, diab)
head(ds2)

sapply(ds2,class)

# @knitr inspectData2 -------------------
ds2$diabF <- factor(ds2$diab, levels=c(0,1), labels=c("nDiab", "Diab"))
ds2$psychF = factor(ds2$psych, levels=c(0,1), labels=c("nPsyc", "Psyc"))
ds2$heartF = factor(ds2$heart, levels=c(0,1), labels=c("nHeart", "Heart"))
ds2$lungF = factor(ds2$lung, levels=c(0,1), labels=c("nLung", "Lung"))
ds2$cancrF = factor(ds2$cancr, levels=c(0,1), labels=c("nCancer", "Cancer"))

ds = dplyr::select(ds2, shlt, bmi, psychF, heartF, lungF, cancrF, diabF)

sapply(ds,class)

# @knitr BasicModel --------------------

lm.fit = lm(shlt~ bmi + psychF + heartF + lungF + cancrF + diabF, data=ds)
summary(lm.fit)

# @knitr BasicGraph1 --------------------


basic_bar <- function(df, predictor, fill_label){
  p <-  ggplot2::ggplot(data=df, aes_string(x=predictor, y="shlt", fill=predictor)) +
    geom_bar(stat="identity") +
    facet_grid(.~shlt)+ theme1 +
    labs(y="Count", x = "Self-reported deterioration in perceived health", fill = fill_label)+
    theme(axis.text.x = element_text(angle = 0, hjust = 1),
          legend.position="top")
  p }

basic_bar(df=ds, predictor="psychF", fill_label="Psychiatric condition")

# @knitr BasicGraph3 --------------------
basic_bar(df=ds, predictor="lungF", fill_label="Lung condition")

# @knitr BasicGraph4 --------------------
basic_bar(df=ds, predictor="heartF", fill_label="Heart condition")

# @knitr BasicGraph5 --------------------
basic_bar(df=ds, predictor="cancrF", fill_label="Cancer condition")

# @knitr BasicGraph6 --------------------
basic_bar(df=ds, predictor="diabF", fill_label="Diabetes condition")

# @knitr BasicGraph7 --------------------
# smooth and linear relationship between self reported health and bmi
p <- ggplot2::ggplot(data=ds, aes(x=bmi, y=shlt)) +
  geom_smooth()+
  stat_smooth(method="lm", formula = y ~ x, se=F, color="red", size=2) +
  theme1 +
  labs(x="Body Mass Index", y="Self-reported health (deterioration)", title="Exploration of Variables Contributing to Self-reported Health")
p

# @knitr BasicGraph8 --------------------
#bmi, lungF, heartF, diabF --> shlt
g1 <- p + facet_grid(lungF ~ heartF) +
  geom_point(aes( color=diabF), shape=21, fill=NA, size=3, alpha=.5) 
g1

# @knitr BasicGraph9 --------------------
#bmi, lungF, psychF, diabF --> shlt
g2 <- p + facet_grid(lungF ~ psychF) +
  geom_point(aes( color=heartF), shape=21, fill=NA, size=3, alpha=.5) 
g2 

# @knitr BasicGraph10 --------------------
#bmi, heartF, psychF, diabF --> shlt
g5 <- p + facet_grid(lungF ~ diabF) +
  geom_point(aes( color=heartF), shape=21, fill=NA, size=3, alpha=.5) 
g5 

# @knitr BasicGraph11 --------------------
#bmi, heartF, psychF, lungF --> shlt
g3 <- p + facet_grid(heartF ~ psychF) +
  geom_point(aes( color=lungF), shape=21, fill=NA, size=3, alpha=.5) 
g3 

# @knitr BasicGraph12 --------------------
#bmi, heartF, psychF, diabF --> shlt
g4 <- p + facet_grid(heartF ~ diabF) +
  geom_point(aes( color=psychF), shape=21, fill=NA, size=3, alpha=.5) 
g4 

# @knitr BasicGraph13 --------------------
#bmi, heartF, psychF, diabF --> shlt
g6 <- p + facet_grid(heartF ~ lungF) +
  geom_point(aes( color=psychF), shape=21, fill=NA, size=3, alpha=.5) 
g6


# @knitr SaveDerivedData --------------------


# @knitr CleanUp --------------------
