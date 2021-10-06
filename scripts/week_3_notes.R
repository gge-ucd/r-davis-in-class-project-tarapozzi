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
