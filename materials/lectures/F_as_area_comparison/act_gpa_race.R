rm(list=ls())

list = id <- 1:24
act <- c(21, 22, 26, 23, 21, 26, 19, 18, 24, 18, 19, 25, 19, 20, 14, 21, 29, 27, 28, 23, 25,25, 23, 20)
gpa <- c(3.5,	2.9,	3.8,	2.8,	3.6,	3.1,	3.2,	2.4,	3.5,	3.1,	2.9,	2.5,	3.5,	3.1,	2.9,	2.6,	2.8,	3.2,	3.5,	3.9,	3.8,	3.1,	3.2,	2.8)

act_white <- c(21, 22, 26, 23, 21, 26, 19, 18)
act_black <- c(24, 18, 19, 25, 19, 20, 14, 21)
act_asian <- c(29, 27, 28, 23, 25, 25, 23, 20)

ds_act <- cbind(act_white, act_black, act_asian)
ds_act <- as.data.frame(ds_act)
ds <- ds_act

group <- c(rep(1,8), rep(2, 8), rep(3, 8))
ds <- as.data.frame(cbind(id, act, gpa, group))
str(ds)

# Random Assignment
ds$group <- factor(ds$group, levels = c(1, 2, 3),
                   labels = c("Control", "Drug A", "Drug B"))
# 
# ds$group <- factor(ds$group, levels = c("1" = "White", "2" = "Black, "3" = "Asian"))

str(ds)
ds

m0 <- glm(act ~ 1, data = ds)
summary(m0)



##########

anova(ds0)
