#### Module-5 Lab02 Multiple Linear Regression and PER ####

#!!!!! The following packages have been installed and loaded. 
#!!!!! No need to redo it if you choose to work in this R script. 
install.packages("dplyr")
install.packages("ggplot2")
install.packages("car") #to use vif()
install.packages("GGally") #to use ggpairs() and ggcorr(). Optional content.
install.packages("leaps") #to use regsubsets(). Optional content.
install.packages("pastecs") #to use stat.desc(). Optional content.
install.packages("jtools") #to use summ() and export_summs() which can generate the well-formatted table for regression models. Optional content.
install.packages("huxtable") #to use export_summs(). Optional content.
install.packages("broom") #to use export_summs(). Optional content.
library(dplyr)
library(GGally) 
library(leaps) 
library(ggplot2)
library(car) 
library(pastecs) 
library(jtools) 
library(huxtable) 
library(broom) 

#Optional: getwd() #to see the working directory, the default folder saving your data and R script.
#Optional: setwd("put the address of your working directory here such as C:/Users/Week-3/Data") to set your working directory where your data will store.


#### Import Data ####
PS19 <- read.csv("NBA Player Per Game Stats 2019-20.csv") 
View(PS19)



#### Descriptive analytics ####
summary(PS19)
PS19.numeric<-PS19[, c(-2, -3)] #round() will round the digit after the point. It doesn't work with character variables, so we remove the 2nd column of NAME and the 3rd column of POS.
# you can also use select() in the package of dyplr
  ##PS19.numeric<-select(PS19, -NAME, -POS)
cor(PS19.numeric)
round(cor(PS19.numeric),2) #cor(PS19.numeric) is the original correlation matrix 

## Optional descriptive analytics
stat.desc(PS19)
round(stat.desc(PS19.numeric), 2) 
          
PS19.select<-select(PS19,MIN,PTS,FG.,FT.,REB,AST,STL,BLK,TO, PER) #we select a portion of columns to better display graphs in slides
ggcorr(PS19.select, method = c("everything", "pearson")) 
ggpairs(PS19.select)
ggpairs(select(PS19,POS,PTS,FG.,REB,PER), ggplot2::aes(colour=POS)) #we select a portion of columns to better display graphs in slides



#### Variable Selection ####

## full model with all available independent variables
Model.full <- lm(PER~MIN+PTS+FGM+FGA+FG.+X3PM+X3PA+X3P.+FTM+FTA+FT.+REB+AST+STL+BLK+TO, PS19)
summary(Model.full)

## best subset selection
Model.sub <- regsubsets(PER~MIN+PTS+FGM+FGA+FG.+X3PM+X3PA+X3P.+FTM+FTA+FT.+REB+AST+STL+BLK+TO, PS19, nvmax = 16) #if don't specify the method, the default setting is exhaustive (i.e., best subset) selection.
summary(Model.sub)
summary(Model.sub)$adjr2 #select the element "adjr2" from the data "summary(Model.sub)"; to see the adjust R^2 of each of best models(e.g., the best 1-predictor model ...., the best 16-predictor model)
#View(summary(Model.sub))
plot(summary(Model.sub)$adjr2) #use plot() to see the adjr2 distribution of best models
which.max(summary(Model.sub)$adjr2) #which.max() to tell which value is the biggest among a numeric vector.

## forward stepwise selection
Model.forw <- regsubsets(PER~MIN+PTS+FGM+FGA+FG.+X3PM+X3PA+X3P.+FTM+FTA+FT.+REB+AST+STL+BLK+TO, PS19, nvmax = 16, method = "forward")
summary(Model.forw)
summary(Model.forw)$adjr2
plot(summary(Model.forw)$adjr2)
which.max(summary(Model.forw)$adjr2)

## forward stepwise selection
Model.back <- regsubsets(PER~MIN+PTS+FGM+FGA+FG.+X3PM+X3PA+X3P.+FTM+FTA+FT.+REB+AST+STL+BLK+TO, PS19, nvmax = 16, method = "backward")
summary(Model.back)
summary(Model.back)$adjr2
plot(summary(Model.back)$adjr2)
which.max(summary(Model.back)$adjr2)

## The best model with 13-predictor
Model.13 <- lm(PER ~ MIN + PTS + FG. + X3PM + X3PA + FTM + FTA + FT. + REB + AST + STL + BLK + TO, PS19)
summary(Model.13)
vif(Model.13)

## The best model with 10-predictor
Model.10 <- lm(PER ~ MIN + PTS + FGM + FG.  + FT. + REB + AST + STL + BLK + TO, PS19)
summary(Model.10)
vif(Model.10)

## The best model with 9-predictor
Model.9 <- lm(PER ~ MIN + PTS + FG. + FT. + REB + AST + STL + BLK + TO, PS19)
summary(Model.9)
vif(Model.9)
plot(Model.9) 
#this data have minor normality issue and outlier issues, which don't substantially impact results and significance level (by checking against the results of robust regression). 
#in this class, let's just consider these minor issues as the limitations of our analytics.

## Exporting well-formatted regression table by using summ() and export_summs() that are in the package of "jtools"
summ(Model.9) #the table for an individual model; 
summ(Model.9, vifs=T)#you can use vifs argument to include the vif value of each variable
export_summs(Model.9, Model.10 , Model.13, Model.full, scale = F, digits = 3) #the table for multiple model comparisons; the scale argument means standardization transformation
plot(Model.9)


#### Examine the robustness of Model.9 with the 18-19 season data #### 

PS18 <- read.csv("NBA Player Per Game Stats 2018-19.csv") 
PS17 <- read.csv("NBA Player Per Game Stats 2017-18.csv") #use read.csv() to load the csv data (comma-separated values) from the working directory, a file path on your computer that sets the default location of any files you read into R, or save out of R. 
                                                          #use read_excel() to load the excel data, but you need to install and load the package of "readxl".
    #For your info,
       #use getwd() to get the path of working directory;no arguments in parentheses  
          #getwd() #the corresponding R output: > getwd()  [1] "C:/Users/wangj/Dropbox/20 Fall/Labs"
       #use setwd() to revise the path of working directory if needed;
          #setwd("C:/Users/wangj/Dropbox/20 Fall/NewWD") #assign the folder of "NewWD" as the new working directory.

## prediction of Model.9 with 18-19 and 17-18 season data 
PS18.new<-mutate(PS18, PER_pre = -.3522 -0.475*MIN + 0.771*PTS + 0.269*FG. + 0.056*FT. + 0.623*REB + 1.052*AST + 1.533*STL + 1.202*BLK - 2.068*TO)
PS17.new<-mutate(PS17, PER_pre = -.3522 -0.475*MIN + 0.771*PTS + 0.269*FG. + 0.056*FT. + 0.623*REB + 1.052*AST + 1.533*STL + 1.202*BLK - 2.068*TO)
Model.9.2018<-lm(PER~PER_pre, PS18.new)
summary(Model.9.2018)
Model.9.2017<-lm(PER~PER_pre, PS17.new)
summary(Model.9.2017)

## to predict the PER of individual players in 18-19 and 17-18 seasons 
predict(Model.9, PS18, interval = "prediction") #use interval = "prediction" to ask for 95% prediction interval
                                                #use interval = "confidence" to ask for 95% confidence interval
predict(Model.9, PS17, interval = "prediction")

