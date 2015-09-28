rm(list=ls(all=TRUE))

# load custom functions
source("http://statpower.net/Content/312/R%20Stuff/Steiger%20R%20Library%20Functions.txt")

# Generate data for classroom examples 
N <- 30 # observations
p <- 4 # variables 
varnames<-c("Intelligence"="iq",
            "Socio-Economic Status"="ses",
            "Parent Education"="parent_edu",
            "Cost of House"="house_cost")
varmeans <- c(100, 7, 15, 272.9) # assign the values of the means
varstds  <- c(15,  3, 3,   70.0) # and standard deviations 

# target correlation matrix                  IQ
correlations <- CompleteCorrelationMatrix(c(.20,#SES
                                            .13,.10,#PEd
                                            .12,.10,.15))#CoH
colnames(correlations) <- varnames # label columns
rownames(correlations) <- varnames # label rows
# rescale correlations into covariances
covariances <- diag(varstds) %*% correlations %*% diag(varstds)

# generate data using Steiger's custom functions
X <- MakeExactData(varmeans, covariances, N)
colnames(X)<-varnames; rownames(X)<-c(1:N) # label columns and rows
X <- data.frame(X) # create dataframe
summary(X) # gets basic descriptives of data
cor(X) # output correlations
correlations # input correlations

write.csv(X, "./data/simulated/dsX.csv")
saveRDS(X, "./data/simulated/dsX.rds")
