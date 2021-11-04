library(tidyverse)

gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv") #ONLY change the "data" part of this path if necessary


gapminder %>%
  filter(year %in% c(2002, 2007)) %>%
  pivot_wider(id_cols = country, names_from = year, values_from = pop) %>%
  mutate(popDiff = `2007` - `2002`) # have to use special quote let it know that you are refering to a column that happens to look like a number
