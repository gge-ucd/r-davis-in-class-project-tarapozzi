library(tidyverse)

surveys <- read_csv("data/portal_data_joined.csv")
str(surveys)

# conditional assignment
summary(surveys$hindfoot_length)

ifelse(surveys$hindfoot_length < mean(surveys$hindfoot_length, na.rm = T), 'small', 'big') # if its less than call it small, if its bigger than call it big
# if selse handles na's well, where casewhen doesn't do this as well
surveys <- mutate(surveys, hindfoot_size = ifelse(surveys$hindfoot_length < mean(surveys$hindfoot_length, na.rm = T), 'small', 'big')) # if its less than call it small, if its bigger than call it big)

# challenge: create a new data frame with iris data
summary(iris$Petal.Length)

iris <- iris  %>%
  mutate(., 
         petal.length.cat = case_when(Petal.Length <= 1.6 ~ 'small', 
                                      Petal.Length > 1.6 &  Petal.Length < 5.1 ~ 'medium', 
                                      TRUE ~ 'large'))

# Joining data
tail <- read_csv("data/tail_length.csv")
str(tail)

# let's combine by record_id
summary(tail$record_id)
summary(surveys$record_id)

surveys_joined <- left_join(surveys, tail, by = "record_id")# joining to include left df
str(surveys_joined)

# Pivot_wider: widens data by creating more columns
surveys_mz <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(genus, plot_id) %>%
  summarize(mean_weight = mean(weight))

unique(surveys_mz$genus)
n_distinct(surveys_mz$genus) # we have 26 distint genus and we are going to turn these into colums

wide_survey <- pivot_wider(surveys_mz, names_from = 'plot_id', values_from = 'mean_weight')

dim(wide_survey)
str(wide_survey)

# pivot_longer
pivot_longer(wide_survey,-genus,names_to = 'plot_id', values_to = 'mean_weight') %>% #pivot all columns except genus column 
  head() # now we have three columns with everying going down from there

# challenge 2

q1 <- surveys %>%
  group_by(plot_id, year) %>%
  summarize(n_genera = n_distinct(genus)) %>%
  pivot_wider(names_from = "year", values_from = "n_genera") %>%
  head()

q1

q2 <- surveys %>%
  pivot_longer(cols = c("hindfoot_length", "weight"), names_to = "measurement_type", values_to = "value")

#cols = columns we want to manipulate 
#names_to = name of new column
#values_to = the values we want to fill our new column with (here we already told the function that we were intersted in hindfoot_length and weight, so it will automatically fill our new column, which we named "values", with those numbers.)
q2

q3 <- q2 %>% 
  group_by(year, measurement_type, plot_type) %>% 
  summarize(mean_value = mean(value, na.rm=TRUE)) %>% 
  pivot_wider(names_from = "measurement_type", values_from = "mean_value")
