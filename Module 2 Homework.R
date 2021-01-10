library(Lahman)
library(dplyr)
library(magrittr)
library(stargazer)

#Question 1
head(Pitching)

#Question 2
filter(Pitching, SHO > 11)

df <- Pitching %>% 
  filter(SHO > 11 & ERA < 2) 

#Question 3
df1 <- slice(Pitching, 20:50)

df2 <- slice(Pitching, 20:50) %>%
  select(playerID, SHO, ERA)

df3 <- slice(Pitching, 20:50) %>% 
  mutate(SOBB = SO/BB) %>% 
  select(playerID, SHO, ERA, SOBB)

df4 <- bind_rows(df2, df3)

#Question 4
mean(Pitching$SHO)
median(Pitching$SHO)
var(Pitching$SHO)
sd(Pitching$SHO)
IQR(Pitching$SHO)

df5 <- Pitching %>%
  select(CG, SHO, ERA) %>% 
  stargazer(type = "text")