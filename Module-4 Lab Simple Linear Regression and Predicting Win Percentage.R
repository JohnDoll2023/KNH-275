### Module-4 Lab Simple Linear Regression and Predicting Win Percentage

# !!!!! The following packages have been installed and loaded. 
# !!!!! No need to redo it if you choose to work in this R script. 
install.packages("Lahman")
install.packages("dplyr")
install.packages("ggplot2")
library(Lahman)
library(dplyr)
library(ggplot2)

## Slides _ Simple Linear Regression
## select the 2019 season of team stats ####
View(Teams)
Teams_WP <- mutate(Teams, WP = W/G)
Teams19 <- filter(Teams_WP, yearID==2019)

## Page-16 Boxplot of Runs Scored ####
ggplot(Teams19, aes(factor(0),y=R)) + 
  geom_boxplot() +
  scale_y_continuous(name="Runs Scored") +
  theme_classic() +
  theme(axis.title = element_text(size=14, face="bold"),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank())

## Page-16 Boxplot of Win Percentage ####
ggplot(Teams19, aes(factor(0),y=WP)) + 
  geom_boxplot() +
  scale_y_continuous(name="Win Percentage") +
  theme_classic() +
  theme(axis.title = element_text(size=14, face="bold"),
        axis.title.x = element_blank(),
        axis.text.x = element_blank(),
        axis.ticks.x = element_blank())

## Page-16 Scatter plot of Runs Scored and Win Percentage ####
ggplot(Teams19, aes(R, WP)) + 
  geom_point() +
  scale_x_continuous(name="Runs Scored") +
  scale_y_continuous(name="Win Percentage") +
  theme_classic() +
  theme(axis.title = element_text(size=14, face="bold"))

## Page-17 Scatter plot with Mean Model, using Runs Scored to predict Win Percentage ####
ggplot(Teams19, aes(R, WP)) + 
  geom_point() +
  geom_hline(yintercept = mean(Teams19$WP), color="dark grey") +
  scale_x_continuous(name="Runs Scored") +
  scale_y_continuous(name="Win Percentage") +
  theme_classic() +
  theme(axis.title = element_text(size=14, face="bold"))

## Page-17 Scatter plot with OLS Regression Model, using Runs Scored to predict Win Percentage ####
ggplot(Teams19, aes(R, WP)) + 
  geom_point() +
  geom_smooth(method=lm, se=F, color="#C3142D") +
  scale_x_continuous(name="Runs Scored") +
  scale_y_continuous(name="Win Percentage") +
  theme_classic() +
  theme(axis.title = element_text(size=14, face="bold"))


## Page-18 Scatter plot with both Mean Model and OLS Regression Model, using Runs Scored to predict Win Percentage ####
ggplot(Teams19, aes(R, WP)) + 
  geom_point() +
  geom_smooth(method=lm, se=F, color="#C3142D") +
  geom_hline(yintercept = mean(Teams19$WP), color="dark grey") +
  scale_x_continuous(name="Runs Scored") +
  scale_y_continuous(name="Win Percentage") +
  theme_classic() +
  theme(axis.title = element_text(size=14, face="bold"))

## Slides _ R Code and Results of Simple Linear Regression
## Page-3 OLS Regression Model ####
ModelR <- lm(WP~R, Teams19) 
summary(ModelR) 
