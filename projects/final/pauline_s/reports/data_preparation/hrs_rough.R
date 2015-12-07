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

dsL = readRDS("./data/derived/dsL.rds")

ds = dplyr::select(dsL, shlt, psych, bmi, heart, lung, cancr, diab)

head(ds)

# @knitr LoadSources -----------
source("./scripts/graphs/graph_themes.R")

# @knitr inspectData -------------------

sapply(ds,class)

ds$diabF <- factor(ds$diab, levels=c(0,1), labels=c("No diabetes", "Diabetes"))

ds$psychF = factor(ds$psych, levels=c(0,1), labels=c("No psychiatric condition", "Psychiatric condition"))

ds$heartF = factor(ds$heart, levels=c(0,1), labels=c("No heart condition", "Heart condition"))
#error
ds$lungF = factor(ds$lung, levels=c(0,1), labels=c("No lung condition", "Lung condition"))
#error
ds$cancrF = factor(ds$cancr, levels=c(0,1), labels=c("No cancer", "Cancer"))
#what happened to the cancer graph? does not separate them according to category


# pairs(ds)


#shlt vs. bmi with psych as horizontal facet

p <- ggplot2::ggplot(data=ds, aes(x=bmi, y=shlt)) +
  geom_smooth()+
  stat_smooth(method="lm", formula = y ~ x, se=F, color="red", size=2) +
  theme1 +
  
  labs(x="Body Mass Index", y="Self-reported health", title="Exploration of Bivariate Relationship with Facets")
p

#finding slope and intercept to add to graph to fit linear line
# coef(lm(shlt ~ bmi, data = ds))
# p + geom_abline(intercept = 2.5, slope =.026)
# geom_abline(intercept = 2.5, slope =.026) +


# geom_line(aes(x=bmi, y=shlt),colour="red", linetype="dashed") +

g1 <- p + facet_grid(.~psychF)
g1


g2 <- p + facet_grid(heartF ~ psychF) +
  geom_point(aes( color=lungF), shape=21, fill=NA, size=3, alpha=.5) 
g2 

g3 <- p + facet_grid(lungF ~ diabF) +
  geom_point(aes( color=heartF), shape=21, fill=NA, size=3, alpha=.5) 
g3

g4 <- p + facet_grid(diabF ~ psychF) +
  geom_point(aes( color=lungF), shape=21, fill=NA, size=3, alpha=.5) 
g4 

g5 <- p + facet_grid(cancrF ~ psychF) +
  g5 

#shlt vs. bmi with heart as horizontal facet

g6 <- p + facet_grid(.~heartF)
g6

g7 <- p + facet_grid(psychF ~ heartF)
g7 

g8 <- p + facet_grid(lungF ~ heartF) +
  geom_point(aes( color=diabF), shape=21, fill=NA, size=3, alpha=.5) 
g8

g9 <- p + facet_grid(diabF ~ heartF) +
  geom_point(aes( color=cancrF), shape=21, fill=NA, size=3, alpha=.5) 

g9 

g10 <- p + facet_grid(cancrF ~ heartF)
g10 

#shlt vs. bmi with lungF as horizontal facet
g11 <- p + facet_grid(.~lungF)
g11

g12 <- p + facet_grid(heartF ~ lungF) + 
  geom_point(aes( color=psychF), shape=21, fill=NA, size=3, alpha=.5) 
g12

g13 <- p + facet_grid(psychF ~ lungF)
g13

g14 <- p + facet_grid(diabF ~ lungF)
g14

g15 <- p + facet_grid(cancrF ~ lungF)
g15

#shlt vs. bmi with diabF as horizontal facet
g16 <- p + facet_grid(.~diabF)
g16

g17 <- p + facet_grid(psychF ~ diabF)
g17

g18 <- p + facet_grid(heartF ~ diabF)
g18

g19 <- p + facet_grid(lungF ~ diabF)
g19

g20 <- p + facet_grid(cancrF ~ diabF)
g20

#shlt vs. bmi with cancr as horizontal facet
g21 <- p + facet_grid(.~cancrF)
g21

g22 <- p + facet_grid(cancrF ~ psychF)
g22

g23 <- p + facet_grid(cancrF ~ heartF)
g23

g24 <- p + facet_grid(cancrF ~ lungF)
g24

g25 <- p + facet_grid(cancrF ~ diabF)
g25










#shlt vs. psych
p = ggplot2::ggplot(data=ds, aes(x=psychF, y=shlt)) +
  geom_point()+
  geom_jitter()
p

#shlt vs. heart
p = ggplot2::ggplot(data=ds, aes(x=heartF, y=shlt)) +
  geom_point()+
  geom_jitter()
p
#shlt vs. lung
p = ggplot2::ggplot(data=ds, aes(x=lungF, y=shlt)) +
  geom_point()+
  geom_jitter()
p
#shlt vs. cancr
p = ggplot2::ggplot(data=ds, aes(x=cancrF, y=shlt)) +
  geom_point()+
  geom_jitter()
p
#shlt vs. diab
p = ggplot2::ggplot(data=ds, aes(x=diabF, y=shlt)) +
  geom_point()+
  geom_jitter()
p




lm.fit = lm(shlt~ bmi + psychF + heartF + lungF + cancrF + diabF, data=ds)
#not working anymore

summary(lm.fit)

# lm.all = lm(shlt~., data=ds)

# fwd.model = step(lm.all, direction='forward', scope=(shlt ~ bmi + psychF + heartF + lungF + cancrF + diabF))

#search ggplot graphs
#graphical themes to change background




# @knitr BasicGraph --------------------




# @knitr BasicModel --------------------

# @knitr SaveDerivedData --------------------


# @knitr CleanUp --------------------
