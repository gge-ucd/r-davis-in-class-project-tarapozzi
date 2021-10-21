library(tidyverse)

# question 1
surveys <- read_csv("data/portal_data_joined.csv")

# squestion 2: ubset surveys

surveys.filtered <- head(filter(surveys, weight >30 & weight <60))

str(surveys.filtered)

# question 3: new tibble

biggest_critters <- surveys %>%
  group_by(species_id, sex) %>%
  summarise(max = max(weight), na.rm = T)

biggest_critters


# question 4: where are the na's? from the previous question it looks like a lot of NA's like in the sex and weight column

surveys %>%
  group_by(sex) %>%
  tally()
## there aer 1748 cases of NAs

surveys %>%
  group_by(weight) %>%
  tally() %>%
  arrange(desc(n))
## there are 2503 NA's

# question 5

surveys_avg_weight <- surveys %>%
  filter(!is.na(weight)) %>%
  group_by(species_id, sex) %>%
  mutate(avg_weight = mean(weight)) %>%
  select(species_id, sex, weight, avg_weight)

surveys_avg_weight

# question 6
surveys_avg_weight <- surveys_avg_weight %>%
  mutate(above_average = weight > avg_weight)

surveys_avg_weight