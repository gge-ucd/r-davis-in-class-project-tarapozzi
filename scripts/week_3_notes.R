# Goals

## Practice using the read.csv() in r
## explore and subset dataframes
## packages and base R vs the tidyverse

# Getting your data into R
surveys <- read.csv("data/portal_data_joined.csv")

# inspecting the data
nrow(surveys)
ncol(surveys)

# what kind of data is surveys
class(surveys)

# look at the top or bottom entries
head(surveys)
tail(surveys)

# look at the data in its entirety
View(surveys)

# more about the data
str(surveys)
summary(surveys)

# indexing
## inside the data brackets it goes df[row, column]

surveys[1,1]
surveys[1,6]
surveys[,6] # extracts a vector
surveys[6] # maintains the df
# check the work
class(surveys[,6])
class(surveys[6])

# special signs for subsetting: colon (:) presents a range and negative sign (-) subtracts
surveys[1:6,] # look at top 6 rows
surveys[-(1:6),] # exclude top 6 rows 
surveys[-1,6]

# subsetting with column name
# output is a dateframe
surveys["species"]
colnames(surveys) # helps identify the names of columns
# output is a vector
surveys[,"species_id"]
#preferred form of subsetting
surveys$species_id

# loading the tidyverse
#install.packages("tidyverse")

# load a package
library(tidyverse)

surveys_t <- read_csv("data/portal_data_joined.csv") # tibble
# this is a tibble
surveys_t
# this is a dateframe
surveys

# inspections
class(surveys_t)

# subsetting is a little different
surveys[,1] # gives us a vector
surveys_t[,1]

## In class notes
head(surveys)
str(surveys) # integer is used so that r can use it with other programs, but it is essentially the same as a number
# factors are imported as characters, you don't want to turn a character into a factor. NUMBERS AND CHARACTERS ARE BETTER
# how many species
length(unique(surveys$species)) #40

# subsetting from a data frame
surveys[1,2] # row 1 and column 2

# subset a new data frame with only 200 rows

surveys_200 <- surveys[1:200,]
str(surveys_200)

# last row of survey data

surveys_last <- surveys[nrow(surveys),]
str(surveys_last)
tail(surveys)

# row in the middle of the data
surveys_middle <- surveys[(nrow(surveys)/2),]
str(surveys_middle)

# mimic head function
surveys_head <-  surveys[-(7:nrow(surveys)),]
str(surveys_head)

## FACTORS
# factors are actually numbers and they have an order 
?factor()
species_factor <- factor(surveys$species)
# it is kind of like a number
typeof(species_factor)
# but also considered a factor
class(species_factor)
levels(species_factor) # there are 40 levels & the default is alphabetical order 

## factors are generally for likert scales or use for making sure your data is ordered in a certain way for something like a plot

