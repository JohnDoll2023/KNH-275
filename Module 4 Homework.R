library(Lahman)
library(dplyr)

#Question 1
Teams2 <- Teams %>% 
  filter(yearID == 2015 | yearID == 2016 | yearID == 2017 | yearID == 2018 | yearID == 2019)

WP_BPT = ((Teams2$R ^ 2) / ((Teams2$R ^ 2) + (Teams2$RA ^ 2)))

WP = Teams2$W / Teams2$G

Win <- lm(WP~WP_BPT, Teams2)
summary(Win)

#Question 2
RunDif = Teams2$R - Teams2$RA

Win2 <- lm(WP ~ RunDif, Teams2)
summary(Win2)