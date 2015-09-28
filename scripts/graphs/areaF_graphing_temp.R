rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\014")

# ds <- readRDS("./data/simulated/dsX.rds")
# mdl <- glm(formula=iq ~ 1 + ses + parent_edu + house_cost, data=ds)
# mdl
# summod <- summary(mdl)
# 
# # parameter estimates
# summod$coefficients             
# fit_full=100
# df_full=9
# fit_reduced=80
# df_reduced=8

library(ggplot2)
source("https://raw.githubusercontent.com/andkov/psy532/master/scripts/graphs/main_theme.R")
areaFcolors <- c( "Full"="blue", "Restricted" = "black","Difference" = "red")


create_data <- function(fun_EF=120, fun_dfF=5, fun_ER=336, fun_dfR=6){
# sample_size <- 6
# degrees of freedom of the models
(dfF <- fun_dfF)                     # FULL            ( df ERROR)    
(dfR <- fun_dfR)                  # RESTRICTED      ( df TOTAL)    
(dfD <- dfR - dfF)                   # DIFFERENCE      ( df RESIDUAL) - gain in complexity / loss of simplicity

# misfit of the models
(SSE <- fun_EF);EF <- SSE          # FULL            (SS Error) - (EF)
(SST <- fun_ER); ER <- SST      # RESTRICTED      (SS Total) - (ER)
(SSR <- SST - SSE)                   # DIFFERENCE      (SS Resisudal) - gain in accurcy / loss of misfit

# accuracy vs parsimony 
(MSE <- EF / dfF)                     # FULL            (Mean Square Error)  
(MST <- ER / dfR)                     # RESTRICTED      (Mean Square Total)
(MSR <- (ER - EF) / (dfR - dfF))      # DIFFERENCE      (Mean Square Residual); (MSR <-SSR/dfR)


# collect squared error in a vector 
(SS_value <- c( EF, ER, ER - EF)) # Full , Restricted, Difference
# collect degrees of freedom in a vector
(df_value <- c(dfF, dfR, dfD)) # Full , Restricted, Difference 
# collected average squared error in a vector
(MS_value <- c(MSE, MST, MSR)) # squared discrepancy per degree of freedom

# Counterparts 
model_label <- c("Full",    "Restricted",   "Difference")
SS_Label    <- c("Error",   "Total",        "Residual")
SS_label    <- c("SSE",     "SST",          "SSR")
MS_label    <- c("MSE",     "MST",          "MSR")
df_label    <- c("df(F)",   "df(R)",        "df(D)")

# misfit as area analogy: creating the squares
area <- SS_value
side <- sqrt(area) # sides of the SS square
origin <- rep(1,3) # the bottom left corner of each square
sideMS <- sqrt(MS_value) # side of the MS square

# Create dataset for graphing  
(d <- data.frame(model_label, SS_Label, SS_label, SS_value, 
                 df_label, df_value, MS_label, MS_value, origin, area, side, sideMS))
# create an auxilary column that numbers the models
(d$position <-  c(3, 1, 2))
# sort the dataframe in the descending order of model number
(d <- d[order(d$position),])
d$SS_value <- round(d$SS_value,2)
d$MS_value <- round(d$MS_value,2)
return(d)
}
# d <- create_data(120, 5, 336, 6)
# d <- create_data()


# SS_graph <- function(d, maxSS=sqrt(max(d$SS_value))){
SS_graph <- function(fit_full, df_full, fit_reduced , df_reduced){
  
d <- create_data(fun_EF = fit_full, fun_dfF = df_full, fun_ER = fit_reduced, fun_dfR = df_reduced)

unit_step <- sqrt(max(d$SS_value))/10
maxSS_value <- sqrt(max(d$SS_value)) + unit_step
maxMS_value <- sqrt(max(d$MS_value))
maxMS_value <- maxMS_value + unit_step*(maxMS_value/maxSS_value)

g <- ggplot2::ggplot() 
g <- g + ggtitle("Total misfit of the models")
g <- g + geom_rect(data=d, 
                   mapping=aes(xmin=origin, xmax=side, ymin=origin, ymax=side, 
                               color=model_label, fill=model_label), 
                   alpha=.1)
g <- g + scale_x_continuous(name="x", limits=c(0, scalemax))
g <- g + scale_y_continuous(name="y", limits=c(0, scalemax)) 
g <- g + scale_fill_manual(values = areaFcolors, guide=FALSE)
g <- g + scale_color_manual(values = areaFcolors, name="Model", guide=guide_legend(reverse=TRUE))
g <- g + main_theme
g <- g + theme(
             axis.title = element_blank(),
             legend.text =  element_text(),
             legend.position="bottom")
g
return(g)
}
# SS_graph(d, scalemax=200)
SS_graph(d)

F_text <- function(fun_EF, fun_dfF, fun_ER , fun_dfR ){
  d <- create_data(fun_EF = fit_full, fun_dfF = df_full, fun_ER = fit_reduced, fun_dfR = df_reduced)
  
  dfD <- d[d$MS_label=="MSR", "df_value"]
  dfF <- d[d$MS_label=="MSE", "df_value"]   
  g <- ggplot2::ggplot(data=d)
  g <- g + scale_x_continuous(limits=c(0,4))
  # g <- g + scale_y_continuous(limits=c(-1,4))
  g <- g + geom_text(mapping=aes(x = 0, y = rev(position)+1, color = model_label,
                                 label = paste0(
                                  d$SS_label, " = ",  d$SS_value, "  ",
                                  d$df_label, " = ",  d$df_value, "  ",
                                  d$MS_label, " = ",  d$MS_value )),
                     hjust=0)
  g <- g + geom_text(aes(x=0, y = 1, label = paste0("F (",dfD,",",dfF,") = ", round(Ftest,2),"  (observed)")),hjust=0)
  g <- g + geom_text(aes(x=0, y = 0, label = paste0("F (",dfD,",",dfF,") = ", round(Fcrit,2), "  (95% crit)")),hjust=0)
  g <- g + scale_color_manual(values=areaFcolors)
  g <- g + main_theme
  g <- g + theme(axis.text.y =  element_blank(),
               axis.text.x =  element_blank(),
               axis.title.x = element_blank(),
               axis.title.y = element_blank(),
               legend.title = element_blank(),
               legend.text =  element_text(),
               legend.position="none",
               panel.grid = element_blank(),
               panel.border = element_blank(),
               axis.ticks = element_blank())
  return(g)
}
# F_text(d)

MS_graph <- function(d, maxMS=sqrt(max(d$MS_value))){
  g <- ggplot2::ggplot() 
  g <- g + ggtitle("Misfit per degree of freedom")
  g <- g + geom_rect(data=d,
                     mapping=aes(xmin=origin, xmax=sideMS, 
                                 ymin=origin, ymax=sideMS, color=model_label, fill=model_label), 
                     alpha=.1)
g <- g + scale_x_continuous(name="x", limits=c(0, maxMS))
g <- g + scale_y_continuous(name="y", limits=c(0, maxMS)) 
  g <- g + scale_fill_manual(values = areaFcolors, guide=FALSE)
  g <- g + scale_color_manual(values = areaFcolors, name="Model", guide=guide_legend(reverse=TRUE))
  g <- g + main_theme
  g <- g + theme(
             # legend.title = element_text(),
             legend.text =  element_text(),
             legend.position="bottom")
  return(g)
}
# MS_graph(d, max=200)
# MS_graph(d)

vpLayout <- function(rowIndex, columnIndex) { return( viewport(layout.pos.row=rowIndex, layout.pos.col=columnIndex) ) }
BuildMosaic <- function(fit_full, df_full, fit_reduced, df_reduced, scalemax){
  
# d <- create_data(fun_EF = fit_full, fun_dfF = df_full, fun_ER = fit_reduced, fun_dfR = df_reduced)
#   
#   Ftest <- d[d$MS_label=="MSR", "MS_value"] / d[d$MS_label=="MSE", "MS_value"]
#   Fcrit <- qf(.95, df1=d[d$MS_label=="MSR", "df_value"], df2=d[d$MS_label=="MSE", "df_value"]) # find F critical
#   # Is observed F statistically significant? Must be greater than critical value
#   (statistical_significance <- Ftest >= Fcrit) 
# 
  


  a <- SS_graph(fit_full=fit_full, df_full=df_full, fit_reduced=fit_reduced, df_reduced=df_reduced, scalemax=scalemax)
  # b <- MS_graph(d, maxMS = max)
  # c <- F_text(d)
  
#    grid.newpage()    
#   #Defnie the relative proportions among the panels in the mosaic.
#   layout <- grid.layout(nrow=3, ncol=3,
#                         widths=unit(c(.36, .28, .36) ,c("null", "null","null")),
#                         heights=unit(c(.38, .32, .2), c("null", "null", "null")))
#   pushViewport(viewport(layout=layout))
#   print(a, vp=viewport(layout.pos.col=1))
#   print(c, vp=vpLayout(2, 2))
#   print(b, vp=viewport(layout.pos.col=3))
#   popViewport(0)
}
# BuildMosaic(d, max = 300)
BuildMosaic(120, 5, 336, 6, max=100)

############# Alternative, using multiplot function ##############

# See example:  http://sape.inf.usi.ch/quick-reference/ggplot2/geom_rect
# scale_x_continuous(name="x") + 
# scale_y_continuous(name="y") +
# geom_rect(data=d, mapping=aes(xmin=x1, xmax=x2, ymin=y1, ymax=y2, fill=t), color="black", alpha=0.5) +
# geom_text(data=d, aes(x=x1+(x2-x1)/2, y=y1+(y2-y1)/2, label=r), size=4) +
# opts(title="geom_rect", plot.title=theme_text(size=40, vjust=1.5))




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

# 
# # maximum <- sqrt(max(d$SS_value))
# maximum <- 100
# 
# areaF_graph_squares <- function(d){
#    a <- SS_graph(d)
#    b <- MS_graph(d)
#    c <- F_text(d)
#    a <- a + scale_y_continuous(limits=c(0,maximum))
#    a <- a + scale_x_continuous(limits=c(0,maximum))
#    b <- b + scale_y_continuous(limits=c(0,maximum))
#    b <- b + scale_x_continuous(limits=c(0,maximum))
#     # names <- names_tile(ds,"physical_measure")
#     multiplot(a,c,b, cols=3)
#     # return(g)
# }
# squares <- areaF_graph_squares(d)

# areaF_graph <- function(d){
#   squares <- areaF_graph_squares(d)
#   text_graph <- F_text(d)
#   g <- multiplot(squares, text_graph, cols=2)
#   return(g)
# }
# g <- areaF_graph(d)

############# alternative  ends #############







