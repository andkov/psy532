# https://github.com/swirldev/swirl_courses

# if you haven't installed swirl before run
# install.packages("swirl")  
# install.packages("Rtools")  
# install.packages("devtools")  
# devtools::install_github(c("swirldev/swirl", "swirldev/swirlify"))  

# load the library
library(swirl)

# install individual course described at https://github.com/swirldev/swirl_courses 
install_from_swirl("Data_Analysis")
install_from_swirl("Exploratory_Data_Analysis")
install_from_swirl("Getting_and_Cleaning_Data")
install_from_swirl("Mathematical_Biostatistics_Boot_Camp")
install_from_swirl("Overview_of_Statistics")
install_from_swirl("R_Programming")
install_from_swirl("Regression_Models")
install_from_swirl("Statistical_Inference")
install_from_swirl("Writing_swirl_Courses")

# when you are ready to start swirling, type
swirl()

# | When you are at the R prompt with swirl (>):

# - skip()
# - play()
# - nxt() 
# - bye() 
# - main() 
# - info() 