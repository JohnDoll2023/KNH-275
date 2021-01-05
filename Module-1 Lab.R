# Module-1 Lab _ Basic Operators and Data Types

## Basic Operators ----
1+1
2-1
2*3
186/518 # BA=H/AB of Babe Ruth in 1930
2^3

3>2
2>3
3>=2
2>=2
2=2
2==2
3!=2
sqrt(256)

1:10 # numbers in sequence
1:100
202:205


a1 <- 1 # Use "<-" to assign a value, instead of "="; "="is the sign of argument.
a1
#b7 <- matrix(c(3, 4, 5,  6, 7, 8,  9, 10, 11), nrow=3, ncol=3, byrow = T)

a2 <- a3 <- a4 <- a5 <- 2 # Multiple assign
a2 
a3
a4
a5

print ("Go Redhawks")


## Data Type ----

### Numeric ====
### Name ####
b1 <- 1
b1
typeof(b1) #Numeric value includes two formats: integer and double (double precision floating point numbers)

###  Character ####
b2 <- "Cincinnati Reds"
b2
typeof(b2)


###  Vector ####
b6 <- c(3, 4, 5)
b6

b6[c(1,3)] # 1st and 3rd elements of the vector
b6[c(2)] # 2nd element of the vector

###  List ####
b11 <- list("Cincinnati Reds", TRUE, c(2018, 2019, 2020), 5, 4, 4)
b11

###  Matrix ####
b7 <- matrix(c(3, 4, 5,  6, 7, 8,  9, 10, 11), nrow=3, ncol=3, byrow = T)
b7

b8 <- matrix(c(3:11), nrow=3, ncol=3, byrow=T) # using ":"  operator write the above matrix
b8

b9 <- matrix(c(3:11), nrow=3, ncol=3, byrow=F)
b9

b10 <- c(762, 755, 714, 1, 2, 3)
aaa <- c("Barry Bonds", "Hank Aaron", "Babe Ruth")
bbb <- c("HR", "Rank")
nottoday <- matrix(b10, nrow=3, ncol=2, byrow=F, dimnames=list(aaa, bbb))
nottoday

###  Array ####
b12 <- array(1:40, c(5, 4, 2)) #(Data, dimensions(rows, columns, tables))
b12
?array()

###  Data Frame ####
Season <- c(2015, 2016, 2017, 2018, 2019, 2020)
Team <- c("Reds", "Reds", "Reds", "Reds", "Reds", "Reds")
Rank_NLC <- c(5,5,5,5,4,3) # We are ranking No.3 now, Yikes!
TorF <- c(T, T, T, T, T, T)

df1 <- as.data.frame(cbind(Season, Team, Rank_NLC, TorF))
df1


df2 <- data.frame(Season, Team, Rank_NLC, TorF) #simplfied codes
df2
