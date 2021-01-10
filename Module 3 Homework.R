library(Lahman)
library(dplyr)
library(ggplot2)

Pitching0019 <- filter(Pitching, yearID == 2000 | yearID == 2019)
Year <- as.character(Pitching0019$yearID)

#Question 1
ggplot(Pitching0019, aes(x = SO, y = W)) +
  geom_point() +
  theme_bw()

#Question 2
ggplot(Pitching0019, aes(x = SO, y = W, color = Year)) +
  geom_point() +
  theme_bw()

#Question 3
Batting <- Batting %>% 
  filter(yearID > 1999, lgID == "AL" | lgID == "NL")

ggplot(Batting, aes(x = X2B, y = X3B, color = lgID)) +
  geom_point()+
  theme_bw()
