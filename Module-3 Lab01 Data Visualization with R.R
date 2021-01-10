### Module-3 Lab01 Data Visualization with R - Scatter Plot 

#!!! RStudio Cloud users,
#!!! The following packages have been installed and loaded. No need to redo it if you choose to work in this R script.

#!!! RStudio (desktop) users,
#!!! You need to install and load the following packages. 

install.packages("ggplot2")
library(ggplot2)
install.packages("dplyr")
library(dplyr)
install.packages("Lahman")
library(Lahman)
install.packages("plotly")
library(plotly)

# Notes about this Lab:
# You can click "Zoom" (in the tap of Plots) to open the plot in a separate window. 
# The plot will adjust with the change of the window size.
# To save the plot, click "Export" (in the tap of Plots). You can drag the window to the desired size and then save the plot.

# To select the Batting data in 2017, 2018, and 2019 (The data in 2020 is not available yet in the Lahman database)
Batting2017 <- filter(Batting, yearID >= 2017)

# The plot on page-6 of the slides
hist(Batting2017$G) 

# Page-7 of the slides
p7<-ggplot(Batting2017, aes(x = G))+  
  geom_histogram()
p7

# Page-8 of the slides
ggplotly(p7)

# Page-9 of the slides
plot(HR~AB, col=lgID, data =  Batting2017) 
legend("topright",
       legend = c("AL", "NL"),
       col = c("red", "Blue"),
       pch = 1)

# Page-10 of the slides
p10<- ggplot(Batting2017, aes(x = AB, y = HR, color = lgID)) +
  geom_point()  # You can click "Zoom" to open the plot in a large window         
ggplotly(p10)

# Page-12 of the slides
ggplot(Batting2017)
ggplot(Batting2017, aes(AB, HR))
ggplot(Batting2017, aes(AB, HR)) +
  geom_point()

# Page-19 of the slides
ggplot(Batting2017, aes(AB, HR)) +
  geom_point()

# Page-20 of the slides
ggplot(Batting2017, aes(AB, HR, color = lgID)) +
  geom_point()

# Page-21 of the slides
ggplot(Batting2017, aes(AB, HR, color = teamID)) +
  geom_point()

# Page-22 of the slides
ggplot(Batting2017, aes(AB, HR, shape = lgID)) +
  geom_point() 

# Page-23 of the slides
ggplot(Batting2017, aes(AB, HR, color = HBP)) +
  geom_point()

# Page-24 of the slides
ggplot(Batting2017, aes(AB, HR)) +
  geom_point() +
  geom_smooth() # if you want a straight regression line, you can specify that "method = lm"; "se=F" to remove the shade of regression line.

# Page-25 of the slides
ggplot(Batting2017, aes(AB, HR, color = lgID)) +
  geom_point() +
  geom_smooth()

# Page-35 of the slides
Batting2019 <- filter(Batting, yearID == 2019) # note that this plot uses the Batting2019 (instead of Batting 2017)
ggplot (Batting2019, aes(AB, HR, color = lgID, size = HBP)) +
  geom_point(alpha = 0.99, fill = "#FFFFF0", shape = 1, stroke = 1) +   # alpha modifies the transparency; size modifies the size of marks; shape=1 is the circle; stroke modifies the thickness 
  scale_x_continuous(name = "At Bats", limits = c(0, 700)) +            # you can also use labs(x="At Bats") here; Don't forget to add the quotation mark if you're using character strings (i.e., texts)
  scale_y_continuous(name = "Home Run", limits = c(0, 70)) +
  scale_color_discrete(name = "Leagues", labels = c("American League", "National League")) +
  scale_size_continuous(name = "Hit by Pitch") +
  ggtitle("Distribution of Homerun and At-Bats in 2019 Season")+
  theme_classic()+
  theme(plot.title = element_text(color="#C3142D", size=18, face="bold"))

#Page-36 of the slides
ggplot(Batting2019, aes(AB, HR, color = lgID, size = HBP)) +
  geom_point(alpha = 0.99, fill = "#FFFFF0", shape = 1, stroke = 1) +   # alpha modifies the transparency; size modifies the size of marks; shape=1 is the circle; stroke modifies the thickness 
  labs(title = "Distribution of Homerun and At-Bats in 2019 Season", x = "At Bats", y = "Home Run", color = "Leagues", size = "Hit by Pitch")+
  theme_classic()  
