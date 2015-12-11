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
# install.packages("ggthemes")
# install.packages("quantreg")
# install.packages("gridExtra")
# install.packages("grid")
# install.packages("leaps")
# install.packages("ggvis")

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
base::require(ggthemes)
base::require(quantreg)
base::require(gridExtra)
base::require(grid)
# base::require(leaps)
base::require(shiny)
base::require(ggvis)

# @knitr LoadData --------------------

if(basename(getwd())=="shiny"){
dsm = readRDS("../../../../data/derived/dsm.rds")

}else{
dsm <- readRDS("projects/final/myles_m/shiny/dsm.rds")
}


# @knitr DataPrepForShiny --------------------
OBESITY = dsm$Obesity
POVERTY = dsm$Poverty
WHITE = dsm$White
BLACK = dsm$Black
HOMICIDE = dsm$Homicide
SUICIDE = dsm$Suicide
NO_EXERCISE = dsm$No_Exercise
FEW_FRUIT_VEG = dsm$Few_Fruit_Veg
SMOKER = dsm$Smoker
DIABETES = dsm$Diabetes
AVG_LIFE_EXPECTANCY = dsm$ALE
PERC_NO_HS_DIPLOMA = dsm$No_HS_Diploma_perc
PERC_MAJOR_DEPRESSION = dsm$Major_Depression_perc

chsi_data=c(OBESITY,POVERTY,WHITE,BLACK,HOMICIDE,SUICIDE,
            NO_EXERCISE,FEW_FRUIT_VEG,SMOKER,DIABETES,AVG_LIFE_EXPECTANCY,
            PERC_NO_HS_DIPLOMA,PERC_MAJOR_DEPRESSION)


# @knitr ShinyUI --------------------
selectInput("chsi_data", "Variable of Interest",
            c("OBESITY","POVERTY","WHITE","BLACK",
              "HOMICIDE","SUICIDE","NO_EXERCISE","FEW_FRUIT_VEG",
              "SMOKER","DIABETES","AVG_LIFE_EXPECTANCY","PERC_NO_HS_DIPLOMA",
              "PERC_MAJOR_DEPRESSION"))

# @knitr ShinyServer --------------------
renderPlot({
  d <- get(input$chsi_data)
  hist(d, breaks = 10, col = "red", border="black", 
       main="Histogram of Selected Variable Frequency Distribution", 
       xlab="The Variable You Picked")
})


# @knitr ggvis --------------------
dsm %>%
  ggvis(~Obesity) %>%
  layer_histograms(width =  input_slider(1, 20, step = 1, label = "width"))


# @knitr ggvis2 --------------------
dsm %>%
  ggvis(~Obesity, ~High_Blood_Pres) %>%
  layer_smooths(span = input_slider(0.05,1,step=0.05), se=TRUE) %>%
  layer_points(size := input_slider(1,50, step=1),
               fill := input_select(choices=c("red","blue","green","black")))


