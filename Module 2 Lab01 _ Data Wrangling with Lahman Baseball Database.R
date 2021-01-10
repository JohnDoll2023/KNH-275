# Module 2 Lab01 Data Wrangling with dplyr

#!!! RStudio Cloud users,
#!!! The following packages have been installed and loaded. No need to redo it if you choose to work in this R script.

#!!! RStudio (desktop) users,
#!!! You need to install and load the following packages. 

### Packages used in this lab
install.packages("dplyr") #to install the package of dplyr for data wrangling
library(dplyr) #to load the package of dplyr
install.packages("Lahman") #to install the package of Lahman for Lahman Database
library(Lahman) #to load the package of Lahman
install.packages("magrittr") # to use the pipe/piping operator "%>%". magrittr is a sub-package under the umbrella of tidyverse, so is dplyr.
library(magrittr)

### FYI only, a few commands dealing with missing value.
   # Base package (embedded within R Studio itself) offers a series of basic data wrangling commands and functions
   # is.na() checks if a data frame contains missing value
   # na.rm=TRUE is used as an argument to remove missing value from analyses (i.e., an element in the function)
   # na.omit() returns the object with listwise deletion of missing values. This function is within package "stats"
   # rm(list=ls()) to clear the listed data frames and values in environment (i.e., your environment window will be reset) 

### Data Wrangling package and functions-----

# dplyr is a library providing useful functions for data wrangling; dplyr functions take a data frame as the first argument.
 # Functions working with rows:
   # filter() chooses rows based on column values.
   # slice() chooses rows based on location.
   # arrange() changes the order of the rows.
 # Functions working with columns:
   # select() changes whether or not a column is included.  
   # rename() changes the name of columns.
   # mutate() changes the values of columns and creates new columns.
   # relocate() changes the order of the columns.
 # Functions of merging data frames
   # bind_rows() merges data frams by rows. 
   # bind_cols() merges data frames by coloums.
   # inner_join() merges data frams by join-predicate (a specific column we decide to link the data on)


# Check out your data ----
View(LahmanData) # View() shows the data frames in the Lahman database; function terms are case-sensetive. In this case, remeber to use the uppercase of "V".
View(Batting)
head(Batting) # head() shows only the first 6 rows of a data frame, as well as the variable names
tail(Batting) # tail() shows only the last 6 rows of a data frame.


## Functions working with rows -----   
  # filter() chooses rows based on column values.
  # slice() chooses rows based on location.
  # arrange() changes the order of the rows.

# filter() ====
filter(Batting, HR >= 55) # Fliter the cases with certain conditions (e.g., HR >=55). "|'represent the condition of "or"; "&" represents the condition of "and"; "!" indicates logical negation "NOT"; "xor" indicates elementwise "exclusive OR".
filter(Batting, HR >= 55 & H >= 200)
filter(Batting, HR >= 55 | H >= 200)
filter(Batting, HR != 0)
# Another similar but slightly different function is subset(). Major differences include: 1. fliter() drops row names, whereas subset doesn't; 2. filter() supports group_by(), whereas subset() doesn't; 3. subset() recycles its condition argument, whereas filter() doesn't; 4. filter() can operate on SQL databases without pulling the data into memory (so it is faster when dealing with big data), whereas subset() doesn't; 
# subset (Batting, HR >= 55)

# slice() ====
slice(Batting, 1:300) #slice() to select data based on the row number.

# arrange() ====
arrange(Batting, HR)
arrange(Batting, desc(HR))


# Task Challenge: In the 1st 300 cases, select the cases with hits over 28.77, and then rank them in an ascending order based on Hits.
arrange(filter(slice(Batting, 1:300), H >= 28.77), H) # Ascending order
arrange(filter(slice(Batting, 1:300), H >= 28.77), desc(H)) # Descend order
# Let's try to solve the above task with "%>%", the piping/pipe operator. It largely simplifies your coding efforts and makes your codes readable. 
#install.packages("magrittr") # "%>%" is available under this package; magrittr is a sub-package under the umberalla of tidyverse, so is dplyr.
#library(magrittr)
Batting %>% slice (1:300) %>% filter(H >= 28.77) %>% arrange(H) # Ascending order
Batting %>% slice (1:300) %>% filter(H >= 28.77) %>% arrange(desc(H)) # Descending order


## Functions working with columns ----
  # select() changes whether or not a column is included.
  # rename() changes the name of columns.
  # mutate() changes the values of columns and creates new columns.
  # relocate() changes the order of the columns.

# select() ====
select(Batting, playerID:SO, GIDP) #OR
select(Batting, -IBB, -HBP, -SH, -SF) # put "-" in front of the variable you wanna drop off

Batting %>% select(playerID:SO, GIDP)
Batting %>% select(-IBB, -HBP, -SH, -SF)

# rename() ====
rename(Batting, HomeRun = HR) # new name at the left side of "=" and old name at the right side
Batting %>% rename(HomeRun = HR)

# mutate() ====
Batting %>% mutate(BA = H/AB)

# relocate() ====
Batting %>% relocate(HR, .before = H)
Batting %>% relocate(teamID, .after = H)


## Functions of merging data frames ----
  # bind_rows() merges data frames by rows. 
  # bind_cols() merges data frames by columns
  # inner_join() merges data frames by join-predicate (a specific column we decide to link the data on)

  # setwd("put the address of your working directory here, such as C:/Users/Week-3/Data") to set your working directory where your data will store
  # getwd() to retrieve your working directory

NL_Pitching2014 <- read.csv("NL_Pitching2014.csv") #Here, We are using "<-" to assign the right side code [read.csv("NL_Pitching2014.csv")] to the left side term [NL_Pitching2014].
                                                   #Hereafter, we can use NL_Pitching2014 to represent this data frame.
NL_Pitching2015 <- read.csv("NL_Pitching2015.csv") 


# bind_rows()
NL_Pitching2014.2015_row <- bind_rows(NL_Pitching2014, NL_Pitching2015)
View(NL_Pitching2014.2015_row)

# bind_cols()
NL_Pitching2014.2015_col <- bind_cols(NL_Pitching2014, NL_Pitching2015)
View(NL_Pitching2014.2015_col)

# inner_join() 
NL_Pitching2014.2015_ij <- inner_join(NL_Pitching2014, NL_Pitching2015, by = "Tm")  # As to other types of join functions, please refer to this webpage https://dplyr.tidyverse.org/reference/join.html; this page provides some straightforward examples: https://medium.com/@HollyEmblem/joining-data-with-dplyr-in-r-874698eb8898
View(NL_Pitching2014.2015_ij)


### Optional
# group_by() takes an existing data frame and converts it into a grouped data frame where operations are performed "by group". FYI, grouping doesn't change how the data looks.
NL_Pitching2014.2015 %>% group_by(Tm) %>% select(PAge) %>% summarise(mean(PAge))
Batting %>% group_by(teamID) %>% summarise(mean(HR))

