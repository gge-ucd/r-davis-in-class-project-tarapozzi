library(tidyverse)

gapminder <- read_csv("https://gge-ucd.github.io/R-DAVIS/data/gapminder.csv") #ONLY change the "data" part of this path if necessary

## 
## ℹ Use `spec()` to retrieve the full column specification for this data.
## ℹ Specify the column types or set `show_col_types = FALSE` to quiet this message.

# question one
str(gapminder)

lifeexp.plot <- gapminder %>%
  group_by(year, continent) %>%
  summarize(mean_lifeexp = mean(lifeExp)) %>%
  ggplot(., aes(year, mean_lifeexp)) +
  geom_point(aes(color = continent)) +
  geom_line(aes(color = continent))

lifeexp.plot

# question two
# liza's code
ggplot(gapminder, aes(x = gdpPercap, y = lifeExp)) +
  geom_point(aes(color = continent, size = pop)) +   
  scale_x_log10() + # this is because there is a large variation in gdp size?
  geom_smooth(method = 'lm', color = 'black', linetype = 'dashed') + # this creates a regression line that represents the linear relationship between life expetancy and gdpPercap
  theme_bw()

#quesiton three
countries <- c("Brazil", "China", "El Salvador", "Niger", "United States") #create a vector for the specific data names we want
gapminder %>%
  filter(country %in% countries) %>% # this filters the names in "country" column that are also in the "countries" vector
  ggplot(aes(country, lifeExp)) +
  geom_boxplot() +
  geom_jitter(alpha = 0.6, color = "aquamarine") +
  ggtitle("Life Expectancy of Five Countries") +
  xlab("Country") +
  ylab("Life Expectancy") +
  theme_bw()