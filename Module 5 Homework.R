library(dplyr)
library(ISLR)
library(leaps) 
library(car) 

Model.reg <- regsubsets(Salary ~ AtBat + Hits + HmRun + Runs + RBI + Walks + Years + CAtBat + CHits + CHmRun + CRuns + CRBI + CWalks + League + Division + PutOuts + Assists + Errors + NewLeague, Hitters, nvmax = 20)
summary(Model.reg)
plot(summary(Model.reg)$adjr2)
which.max(summary(Model.reg)$adjr2)
#model 11 biggest, then model 10

Model.lm10 <- lm(Salary ~ AtBat + Hits + Walks + CAtBat + CRuns + CRBI + CWalks + Division + PutOuts + Assists, Hitters)
Model.lm11 <- lm(Salary ~ AtBat + Hits + Walks + CAtBat + CRuns + CRBI + CWalks + Division + PutOuts + Assists + League, Hitters)

Model.for <- regsubsets(Salary ~ AtBat + Hits + HmRun + Runs + RBI + Walks + Years + CAtBat + CHits + CHmRun + CRuns + CRBI + CWalks + League + Division + PutOuts + Assists + Errors + NewLeague, Hitters, nvmax = 20, method = "forward")
Model.back <- regsubsets(Salary ~ AtBat + Hits + HmRun + Runs + RBI + Walks + Years + CAtBat + CHits + CHmRun + CRuns + CRBI + CWalks + League + Division + PutOuts + Assists + Errors + NewLeague, Hitters, nvmax = 20, method = "backward")
summary(Model.for) #model10 same, model11 same
summary(Model.back) #model10 same, model11 same


vif(Model.lm10)
vif(Model.lm11)
AIC(Model.lm10)
AIC(Model.lm11)
BIC(Model.lm10)
BIC(Model.lm11)
summary(Model.lm10)
summary(Model.lm11)
