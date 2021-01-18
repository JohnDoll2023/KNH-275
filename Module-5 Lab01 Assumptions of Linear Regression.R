### Module-5 Lab01 Assumptions of Linear Regression

#!!!!! The following packages have been installed and loaded. 
#!!!!! No need to redo it if you choose to work in this R script. 
install.packages("Lahman")
install.packages("dplyr")
install.packages("lmtest")
library(Lahman)
library(dplyr)
library(lmtest)

## select the 2019 season of team stats ####
View(Teams)
Teams_WP <- mutate(Teams, WP = W/G)
Teams19 <- filter(Teams_WP, yearID==2019)

## OLS Regression Model ####
ModelR <- lm(WP~R, Teams19) 
summary(ModelR) 

## plot() show four plots: 
  #Residuals vs Fitted Plot, 
  #Normal Q-Q Plot,
  #Scale-Location Plot,  
  #Residuals vs Leverage Plot (to identify the influential variable)
plot(ModelR)

## Ramsey's RESET (Regression Equation Specification Error Test) Test _ Linearity Assumption， embedded in the package of lmtest #### 
resettest(WP~R, 3, type="regressor", Teams19)

## Shapiro-Wilks Test _ Normality Assumption, embedded in R base ####
shapiro.test(ModelR$residuals) # or shapiro.test(ModelR[["residuals"]])

## Breush-Pagan Test _ Homoscedasticity, embedded in the package of lmtest ####
bptest(ModelR)

