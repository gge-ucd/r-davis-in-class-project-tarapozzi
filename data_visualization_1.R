library(tidyverse)

surveys <- read.csv("data/portal_data_joined.csv") %>%
  filter(complete.cases(.))

# ggplot basics

#blank canvas
ggplot(surveys)

# now we add aes
ggplot(surveys, aes(x = weight, y = hindfoot_length)) 

# now add geom for shape
ggplot(surveys, aes(x = weight, y = hindfoot_length))  +
  geom_point()

base_plot <- ggplot(surveys, aes(x = weight, y = hindfoot_length))  +
  geom_point()

# adding plot elements: transparency = alpha, color= color, infill = fill
base_plot + geom_point(alpha = 0.2)
base_plot + geom_point(color = "blue")
base_plot + geom_point(color = "aquamarine")
base_plot + geom_point(alpha = 0.5, color = "red")

# color by categorical

ggplot(surveys, aes(weight, hindfoot_length)) +
  geom_point(mapping = aes(color = species_id)) # another mapping argument that specifies species_id as another data with color

# geom_boxplot

ggplot(surveys, aes(species_id, weight)) +
  geom_boxplot()

base_plot2 <- ggplot(surveys, aes(species_id, weight)) 

base_plot2 +
  geom_boxplot(color = "purple") +
  geom_point()

base_plot2 +
  geom_boxplot() +
  geom_jitter(alpha = 0.2, aes(color = species_id)) # since it is just specified in jitter it only colors the points and not the boxplots

## data visualization part 1b
surveys_complete <- read.csv("data/portal_data_joined.csv") %>%
  filter(complete.cases(.))

yearly.counts <- surveys_complete %>%
  count(year, species_id)
str(yearly.counts)

ggplot(yearly.counts, aes(year, n, group = species_id)) + # make sure to tell ggplot how to group data so it makes sense
  geom_line() +
  facet_wrap(~ species_id, scales = 'free_y') # split each species id into a new plot  # scales you can allow axis to adjust to individual data

ggplot(yearly.counts, aes(year, n, group = species_id)) + # make sure to tell ggplot how to group data so it makes sense
  geom_line() +
  facet_wrap(~ species_id, scales = 'free_y') +
  theme(plot.background = element_rect(fill = 'black')) 

ggplot(yearly.counts, aes(year, n, group = species_id)) + # make sure to tell ggplot how to group data so it makes sense
  geom_line() +
  facet_wrap(~ species_id, scales = 'free_y') +
  theme_minimal()

library(ggthemes) # has a lot of pre-established themes. looks super useful

