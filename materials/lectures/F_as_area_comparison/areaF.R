rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\014")

sample_size <- 6
EF <- 120
ER <- 336
parsF <- 1 # the number of estimated parameters in the Full model (mean)
parsR <- 0 # the number of estimated parameters in the Restricted model
#### MISFIT ####
SSE <- EF
SST <- ER
SSR <- SST - SSE


EF # sum of squared error for the Full Model
ER # sum of squaare error for the Restricted Model
ER - EF # gain in accurcy / loss of misfit
# collect squared error in a vector 
(SS_value <- c( EF, ER, ER - EF)) # Full , Restricted, Difference


dfF <-  sample_size - parsF # degrees of freedom of the Full model
dfR <- sample_size - parsR # degrees of freedom of the Restricted model
dfD <- dfR - dfF # gain in simplicity / loss of complexity
# collect degrees of freedom in a vector
(df_value <- c(dfF, dfR, dfD))  



(MSE <- EF / dfF) 
(MST <- ER / dfR) 
(MSR <- (ER - EF) / (dfR - dfF))
(MS_value <- c(MSE, MST, MSR)) # squared discrepancy per degree of freedom
(MS_value <-  SS_value / df_value) # alternative 


# Counterparts 
model_label <- c("Full",  "Restricted",  "Difference")
SS_Label     <- c("Error", "Total",       "Residual")
SS_label <-    c("SSE",   "SST",         "SSR")
MS_label <-    c("MSE",   "MST",         "MSR")
df_label <-    c("df(F)",   "df(R)",         "df(D)")



# area <- misfit # analogy
area <- SS_value
side <- sqrt(area) # sides of the squares
origin <- rep(1,3) # the bottom left corner of each square
sideMS <- sqrt(MS_value)



# Create dataset for graphing  
(d <- data.frame(model_label, SS_Label, SS_label, SS_value, 
                 df_label, df_value, MS_label, MS_value, origin, area, side, sideMS))
# create an auxilary column that numbers the models
(d$position <-  c(3, 1, 2))
# sort the dataframe in the descending order of model number
(d <- d[order(d$position),])

#### alt ds ####
# # Create ds for graphing (alt)
# model <-      rep(c("Full",  "Restricted",  "Difference"), 3)
# squares <-    rep(c("Error", "Total",       "Residual"), 3)
# label <-          c("SSE",   "SST",         "SSR", 
#                     "MSE",   "MST",         "MSR",
#                     "df(F)", "df(R)",       "df(D)")
# value <-          as.numeric(c( SSE,     SST,           SSR,
#                    # EF,      ER,            ER-EF,
#                      MSE,     MST,           MSR,
#                      dfF,     dfR,           dfD) )
# 
# 
# (d <- as.data.frame(cbind(model, squares, label),stringsAsFactors = F))
# (d$value <- as.numeric(value))
# str(d)
# d$origin <- rep(1, nrow(d))
# d$side <- sqrt(d$value)
# d$position <- rep(c(3,1,2),3)
# d[d$label %in% df_label,"origin"] <- NA
# d[d$label %in% df_label,"side"] <- NA
# d

#### GRAPH ####
# create graph presets
 
areaFcolors <- c( "Full"="blue", "Restricted" = "black","Difference" = "red")
Ftest <- d[d$MS_label=="MSR", "MS_value"] / d[d$MS_label=="MSE", "MS_value"]
Fcrit <- qf(.95, df1=dfD, df2=dfF) # find F critical
# Is observed F statistically significant? Must be greater than critical value
(statistical_significance <- Ftest >= Fcrit) 

step <- 1
library(ggplot2)
source("./scripts/graphs/main_theme.R")

SS_graph <- function(d){
step <- max(d$SS_value)/100
g <- ggplot2::ggplot() 
g <- g + scale_x_continuous(name="x")
g <- g + scale_y_continuous(name="y") 
g <- g + geom_rect(data=d, 
                   mapping=aes(xmin=origin, xmax=side, ymin=origin, ymax=side, color=model_label, fill=model_label), 
                   alpha=.1)
g <- g + geom_text(mapping=aes(x = origin + (step*.5), 
                               y = side - (step*.5), 
                               label = paste0(
                                 d$SS_label, " = ",  d$SS_value, "  ",
                                 d$df_label, " = ",  d$df_value, "  ",
                                 d$MS_label, " = ",  d$MS_value )),hjust=0)
g <- g + geom_text(aes(x=step*1.5, y =step*4, label = paste0("F (",dfD,",",dfF,") = ", round(Ftest,2),"  (observed)")),hjust=0)
g <- g + geom_text(aes(x=step*1.5, y =step*3, label = paste0("F (",dfD,",",dfF,") = ", round(Fcrit,2), "  (95% crit)")),hjust=0)
g <- g + scale_color_manual(values = areaFcolors)
g <- g + scale_fill_manual(values = areaFcolors)
g <- g + main_theme
g
return(g)
}
SS_graph(d)


MS_graph <- function(d){
step <- max(d$MS_value)/100
g <- ggplot2::ggplot() 
g <- g + scale_x_continuous(name="x")
g <- g + scale_y_continuous(name="y") 
g <- g + geom_rect(data=d, 
                   mapping=aes(xmin=origin, xmax=sideMS, ymin=origin, ymax=sideMS, color=model_label, fill=model_label), 
                   alpha=.1)
g <- g + geom_text(mapping=aes(x = origin + (step*.4), 
                               y = sideMS - (step*.3), 
                               label = paste0(
                                 d$SS_label, " = ",  d$SS_value, "  ",
                                 d$df_label, " = ",  d$df_value, "  ",
                                 d$MS_label, " = ",  d$MS_value )),hjust=0)
g <- g + geom_text(aes(x=step*1.5, y =step*4, label = paste0("F (",dfD,",",dfF,") = ", round(Ftest,2),"  (observed)")),hjust=0)
g <- g + geom_text(aes(x=step*1.5, y =step*3, label = paste0("F (",dfD,",",dfF,") = ", round(Fcrit,2), "  (95% crit)")),hjust=0)
g <- g + scale_color_manual(values = areaFcolors)
g <- g + scale_fill_manual(values = areaFcolors)
g <- g + main_theme
return(g)
}
MS_graph(d)



# See example:  http://sape.inf.usi.ch/quick-reference/ggplot2/geom_rect
# scale_x_continuous(name="x") + 
# scale_y_continuous(name="y") +
# geom_rect(data=d, mapping=aes(xmin=x1, xmax=x2, ymin=y1, ymax=y2, fill=t), color="black", alpha=0.5) +
# geom_text(data=d, aes(x=x1+(x2-x1)/2, y=y1+(y2-y1)/2, label=r), size=4) +
# opts(title="geom_rect", plot.title=theme_text(size=40, vjust=1.5))



#######################
## @knitr define_multi_plot_function

# Multiple plot function
#
## http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/
# ALTERNATIVELY: sources this function
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)

  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)

  numPlots = length(plots)

  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                    ncol = cols, nrow = ceiling(numPlots/cols))
  }

 if (numPlots==1) {
    print(plots[[1]])

  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}



areaF_graph <- function(d){
   a <- SS_graph(d)
   b <- MS_graph(d)
  
#     a <- basic_tile(ds,"study_name")
#     b <- basic_tile(ds,"physical_measure")
#     c <- basic_tile(ds,"model_type")
#     d <- basic_tile(ds,"subgroup")
    # d <- d + theme(axis.text.y = element_text(vjust=1, angle=0, hjust=0))
   a <- a + scale_y_continuous(limits=c(0,15))
   a <- a + scale_x_continuous(limits=c(0,15))
   b <- b + scale_y_continuous(limits=c(0,15))
   b <- b + scale_x_continuous(limits=c(0,15))
    # names <- names_tile(ds,"physical_measure")
    multiplot(a, b, cols=2)
    # return(g)
}
areaF_graph(d)



