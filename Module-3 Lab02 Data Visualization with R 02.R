### Module-3 Lab02 Data Visualization with R 

#!!! RStudio Cloud users,
#!!! The following packages have been installed and loaded. No need to redo it if you choose to work in this R script.

#!!! RStudio (desktop) users,
#!!! You need to install (if you haven't done so previously) and load the following packages. 

install.packages("ggplot2")
library(ggplot2)
install.packages("dplyr")
library(dplyr)
install.packages("Lahman")
library(Lahman)
install.packages("readr") #read csv files
library(readr)
install.packages("stringr") #process string data
library(stringr)
install.packages("BasketballAnalyzeR") #use the data and shotchart() in the package of "BasketballAnalyzeR"
library(BasketballAnalyzeR)

# To select the Batting data in 2019
Batting2019 <- filter(Batting, yearID == 2019)


# Faceting ----
ABHR <- ggplot(Batting2019, aes(AB, HR)) #use ABHR to represent "ggplot(Batting2019, aes(AB, HR))". This assignment works in this environment. 

## Page-3 of the slides
ABHR +
  geom_point() +
  geom_smooth(se=F) #show the regression line (two common types: linear-lm, nonlinear-loess). We will talk the regression in later classes.

## Page-4 of the slides
ggplot(Batting2019, aes(AB, HR, color = teamID)) +
  geom_point() +
  geom_smooth(se=F)

## Page-6 of the slides
ABHR +
  geom_point() +
  facet_wrap(~teamID, ncol=6) +  #faceting based on the variable of "teamID"; organize subplots in 6 columns 
  geom_smooth(se=F, color="black")

## Page-7 of the slides
ABHR +
  geom_smooth(se=F, color = "black") +
  facet_wrap(~teamID, ncol=6) #remove points which may be a little chaotic in small subplots
  #revise background ang grid with theme_bw(), theme_gray(), theme_dark(), theme_classic(), theme_light(), theme_linedraw(), theme_minimal(), or theme_void()



# Line Chart ----

## Page-8 of the slides
X <- c(1, 4, 3, 2) 
Y <- c(1, 3, 3, 4)
df1 <- data.frame(X, Y)
df1
ggplot(df1, aes(X, Y)) +
  geom_line()
ggplot(df1, aes(X, Y)) +
  geom_path()

## Page-9 of the slides
ggplot(df1, aes(X, Y)) +
  geom_step()

## Page-10 of the slides
ggplot(df1, aes(X, Y)) +
  geom_step(linetype = 2, color = "red")

## Page-11 of the slides
ABHR +
  geom_line(size = 1) + #connects the observations in the order in which they appear on the x axis. Other two related functions geom_path() and geom_step(). Use "?geom_path" to learn more.
  facet_wrap(~teamID, ncol=6)

## Page-12 of the slides
ABHR +
  geom_step(size = 1) + #connects the observations in the order in which they appear on the x axis. Other two related functions geom_path() and geom_step(). Use "?geom_path" to learn more.
  facet_wrap(~teamID, ncol=6)



# Bar Chart ----

## Page-14 of the slides
ggplot(Batting2019, aes(teamID)) +
  geom_bar(fill = "#C3142D") #geom_bar uses stat="count" by default: it counts the number of cases at each x position.

## Page-15 of the slides
ggplot(Batting2019, aes(teamID)) +
  geom_bar(fill = "#C3142D") +
  coord_flip()  # flip x-axis and y-axis of the coordinate system; or specify ggplot(Batting2019, aes(y = HR))

## Page-16 of the slides
ggplot(Batting2019, aes(lgID, HR)) +
  geom_bar(stat ="identity") # stat="identity" leaves the data as is.



# Histogram ----

## Page-17 of the slides
ggplot(Batting2019, aes(HR)) +
  geom_histogram() #geom_histogram uses stat="count" by default: it counts the number of cases at each x position.

## Page-18 of the slides
ggplot(Batting2019, aes(HR)) +
  geom_histogram(binwidth = 5) #you can specify either binwidth or bins to change the bin distribution.

## Page-19 of the slides
ggplot(Batting2019, aes(HR)) +
  geom_histogram() +
  facet_wrap(~teamID)

  
  
# Boxplot ----
  
## Page-21 of the slides
ggplot(Batting2019, aes(teamID, G)) +
    geom_boxplot(outlier.color = "red")  #you can also use other arguments to mark out outliers, such as outlier.shape, outlier.size, outlier.stroke, outlier.alpha.

## Page-22 of the slides
ggplot(Batting2019, aes(factor(0), G)) +
    geom_boxplot(outlier.color = "red")+
    theme(axis.title.x = element_blank(),
          axis.text.x = element_blank(),
          axis.ticks.x = element_blank())


  
# Density Plot ----

## Page-23 of the slides
ggplot(Batting2019, aes(SO, fill = lgID)) +
  geom_density()




# Visualizing Batting Outcomes (Optional) ----

## Using Scatterplot to visualize the batting outcomes based on pitch types
  CK <- read_csv("kershaw2016.csv")  #the play-by-play data that we use
  View(CK)
  ## Variable description
    #pitch_type - type of pitch thrown
    #px - horizontal location in zone
    #pz - vertical location in zone
    #des - outcome of pitch
    #start_speed - speed of pitch as it leaves the pitcher’s hand
    #event - outcome of the plate appearance
    #stand

  # Creat a strike zone in a coordinate system
  topKzone <- 3.5
  botKzone <- 1.6
  inKzone <- -0.85
  outKzone <- 0.85
  kZone <- data.frame(
    x=c(inKzone, inKzone, outKzone, outKzone, inKzone),
    y=c(botKzone, topKzone, topKzone, botKzone, botKzone)
    )

  # You can take a quick look at the above strike zone with the following code:
  # ggplot() + geom_path(aes(x, y), data = kZone, lwd = 1, col = "black")
  
  # The goal of the following step is create a new variable "Swing". To do this, we need to first creat new variables of "Foul", "InPlay", and "Miss".
  CK1 <- mutate(CK,
                Foul = str_detect(des, "Foul"), #str_detect(), in the package of "stringr", detects the presence or absence of keywords in a string. In this case, it checks if "Foul" within the string variable of "des" and returns TRUE or FLASE for this check.
                InPlay = str_detect(des, "In play"),
                Miss = str_detect(des, "Swing"),
                Swing = Foul | InPlay | Miss) #remember that "|" means "or". This line specifies that "Foul", " Inplay", and "Miss" are all considered as "Swing".
  CK_swing <- filter(CK1, Swing == TRUE) #filter out "Swing" cases

  ggplot(CK_swing, aes(px, pz, color = Miss)) +  # x-axis is "px", y-axis is "pz", 3rd color-based variable is "Miss".
    geom_point(alpha = 0.6) + # set the transparency (ranging fro 0 to 1) at 0.6
    facet_wrap(~ pitch_type, ncol = 2) +  # create multi-panel plots by "pitch_type" and display them in 2 columns. This link shows a great example: http://zevross.com/blog/2019/04/02/easy-multi-panel-plots-in-r-using-facet_wrap-and-facet_grid-from-ggplot2
    geom_path(aes(x, y), data = kZone, lwd = 1, col = "black") + #embed the above-mentioned strike zone
    xlim(-2, 2) + ylim(-0.5, 5) + #set the limitations of x-axis and y-axis
    scale_colour_manual(values = c("gray", "red")) + #manually set the color of points (if not specify, the default colors are red and blue)
    theme(strip.text = element_text(size = rel(1.5), color = "black")) #manually set the size and color of subplot titles


# Shotchart (Optional) ----

library(BasketballAnalyzeR) #install and load BasketballAnalyzeR to use the data and shotchart()
  View(PbP.BDB) #Play-by-play NBA data in 17-18 season produced supplied by BigDataBall, the cases (rows) are the events occurred during the analyzed games and the variables (columns) are descriptions of the events in terms of type, time, players involved, score, area of the court.
  #Variable description
    #original_x, original_y, converted_x, converted_y: coordinates of the shooting player
    #original: track coordinate system half court, (0,0) center of the basket 
    #converted: coordinate in feet full court, (0,0) bottom-left corner

  PbP <- PbPmanipulation(PbP.BDB) #transfer the standard file supplied by BigDataBall to the format required by BasketballAnalyzeR
  subdata <- subset(PbP, player=="Stephen Curry")
  subdata$xx <- subdata$original_x/10  #original_x and original_y are coordinate values captured by the tracking systems.
  subdata$yy <- subdata$original_y/10-41.75 #41.75 is the distance of the hoop center from the center of the court. 

  shotchart(data=subdata, x="xx", y="yy", type=NULL, scatter=TRUE) #shotchart() is within the package of "BasketballAnalyzeR"; shotchart is built with reference to the standard 94 by 50 feet NBA court; use "?shotchart“ to learn the details of this function. 

  shotchart(data=subdata, x="xx", y="yy", z="result", type=NULL, scatter=TRUE)+ #add the "result" of a shot: missed or made; shotchat() is based on ggplot2 and therefore is compatible with others functions in ggplot2.
    scale_fill_manual(values = c("#C3142D", "#C0C0C0"))+ #change to your preferred colors 
    scale_color_manual(values = c("#C3142D", "#C0C0C0"))

  shotchart(data=subdata, x="xx", y="yy", z="playlength",
            num.sect=5, type="sectors", scatter=F, result = "result") # "playlength" factors in; the half basketball court was divided into 5 sectors.
