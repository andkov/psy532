rm(list=ls(all=TRUE)) #Clear the memory of variables from previous run. This is not called by knitr, because it's above the first chunk.
cat("\014")

#### Input data ####

# enter the observed scored into a vector object

# compute the variance of iq

# compute the mean of iq

# choose the value of reference for iq

#  transform the vector iq into a dataset 




#### FULL model ####
# Create a column containing the predictions of the FULL model

# compute discrepancy between observed data and prediction of the FULL model 

# compute square errors of the FULL




#### RESTRICTED model  ####
# Create a column containing the predictions of the RESTRICTED model

# compute discrepancy between observed data and prediction of the RESTRICTED model 

# compute square errors of the RESTRICTED




#### MISFIT ####
# compute sum of squared discrepancies from the FULL 


# compute sum of squared discrepancies from the RESTRICTED 


# compute the loss of misfit



#### PARSIMONY ####
# count the number of parameters in the FULL model

# count the number of parameters in the RESTRICTED model

# compute degrees of freedom of the Full model


# compute degrees of freedom of the Restricted model





#### MEAN SQUARES ####
# compute mean squared error of the FULL model 

# compute mean squared error of RESTRICTED model 

# compute mean square error of the DIFFERENCE




#### F test ####
# Compute the observed value of the F statistics


# estimate the model using lm() function from the stats package

# estimate the model using glm() function from the stats package

# print brief results of the fitted model

# print summary of the fitted model

# create a column that stores the predicted values of the FULL model from lm() and glm() 







  
  