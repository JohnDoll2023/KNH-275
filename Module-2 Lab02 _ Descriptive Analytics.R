# Module-2 Lab02 Descriptive Analytics

#!!! RStudio Cloud users,
#!!! The following packages have been installed and loaded. No need to redo it if you choose to work in this R script.

#!!! RStudio (desktop) users,
#!!! You need to install and load the following packages. 

### Packages used in this lab
install.packages("Lahman")
library(Lahman)
install.packages("stargazer")
library(stargazer)
head(Batting)
install.packages("dplyr")
library(dplyr)
install.packages("magrittr")
library(magrittr)

mean(Batting$HR) # "$" is used to select a variable from a data frame. Code format is: data$variable

median(Batting$HR)

quantile(Batting$HR, 0.25)
quantile(Batting$HR, 0.75)
quantile(Batting$HR, 0.80)

IQR(Batting$HR)

var(Batting$HR)

sd(Batting$HR)

by(Batting, Batting$teamID, summary)

max(Batting$HR)
min(Batting$HR)
max(Batting$HR) - min(Batting$HR)

summary(Batting$HR)

#stargazer() produce tidy and well-formatted tables for summary statistics and regression analysis
?stargazer
Batting %>% select(AB, R, H, HR) %>% stargazer(type="text")
Batting %>% select(AB, R, H, HR) %>% stargazer(type="text", omit.summary.stat= c("p25", "p75"))
