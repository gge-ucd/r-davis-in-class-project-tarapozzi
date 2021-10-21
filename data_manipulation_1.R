
library(tidyverse)

# load data
surveys <- read_csv("data/portal_data_joined.csv") # slightly different way to load data
dim(surveys)
str(surveys)

# keep observations before 1995

surveys <- filter(surveys, year < 1995)

# let's look at specific columns
select(.data = surveys, sex, weight, genus)
head(select(.data = surveys, sex, weight, genus))

# now combine

surveys_base <- surveys %>%
  filter(., year < 1995) %>% # this is me filtering
  select(., sex, weight, year)

# filter is for row selection
filter(surveys, genus == 'Neotoma') # neotoma is a character so we have to put it in quotes
filter(surveys, genus != 'Neotoma') # filter out rows with neotoma

# we can use them together with pipes
## long format
surveys2 <- filter(surveys, genus != 'Neotoma')
surveys3 <- select(surveys2, genus, sex, species)
str(surveys3)

## condensed format
surveys_filtered <- select(filter(surveys, genus != 'Neotoma'), genus, sex, species)

### are they the same
identical(surveys3, surveys_filtered)

## actually piping now
surveys_filtered_again <- surveys %>%
  filter(genus != 'Neotoma') %>%
  select(genus, sex, species)

identical(surveys_filtered, surveys_filtered_again)

# MUTATE
surveys <- surveys %>%
  mutate(weight_kg = weight/1000) %>% # create a new column 
  head()

# Group_by & summary 
surveys %>%
  group_by(sex) %>% # we want to group by sex 
  summarise(avg_weight = mean(weight, na.rm = T), med_weight = median(weight, na.rm = T)) # rename column avg_weight, need a function for weight, need to remove NA's

# tally function
surveys %>%
  group_by(sex) %>%
  tally() # tells you how many observations in each group

## Challenge

surveys_hindfoot_half <- surveys %>%
  mutate(hindfoot_half = hindfoot_length/2, na.rm = T) %>% # create a new column with no na's
  filter(hindfoot_half < 30) %>% # we need to remove everything greater than 30
  select(., species_id, hindfoot_half) %>% # now create a data frame with two columns
  summary()

## challenge

surveys %>%
  group_by(species_id) %>%
  summarise(mean = mean(hindfoot_length, na.rm = T))
