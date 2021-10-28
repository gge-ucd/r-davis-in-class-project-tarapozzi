library(tidyverse)

# create a tibble 
surveys <- read_csv("data/portal_data_joined.csv")

# question 1: new data frame with plot type as unique columns 
surveys.wide <- surveys %>%
  filter(!is.na(hindfoot_length)) %>%
  group_by(genus, plot_type) %>%
  summarize(mean_length = mean(hindfoot_length)) %>% # this creates a new column for mean length 
  pivot_wider(., names_from = 'plot_type', values_from = 'mean_length') %>% # names from becomes the column names and values from fills in the value 
  arrange(Control) # sorted by values int eh control type. I don't understand this part of the code

# question 2
summary(surveys$weight)

#if else and case when handle na's differently so make sure to look into this when i use these functions
surveys <- mutate(surveys, 
                  weight_cat = ifelse(surveys$weight <= 20, "small",
                                      ifelse(surveys$weight > 20 & surveys$weight < 48, "medium", 
                                             "high")))
surveys <- surveys %>%
  mutate(., 
         weight_cat = case_when(weight <= 20 ~ 'small', 
                                      weight > 20 &  weight < 40 ~ 'medium', 
                                      TRUE ~ 'large'))