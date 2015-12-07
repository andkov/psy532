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
dsL <-readRDS("./data/derived/dsL.rds")

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


# @knitr CleanUp --------------------
# # remove all but specified dataset
rm(list=setdiff(ls(), c("dsW","dsL")))
