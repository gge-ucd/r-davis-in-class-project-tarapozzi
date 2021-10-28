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

## Challenge: Use what you just learned to create a scatter plot of weight and 
#species_id with weight on the Y-axis, and species_id on the X-axis. 
#Have the colors be coded by plot_type. 
#Is this a good way to show this type of data? What might be a better graph?

challenge.plot <- ggplot(surveys, aes(species_id, weight)) +
  geom_point(alpha = 0.3, aes(color=plot_type))

challenge.plot # this doesn't seem super helpful maybe a boxplot would be better?

challenge.plot2 <- ggplot(surveys, aes(species_id, weight)) +
  geom_point() +
  facet_wrap(~ plot_type)

challenge.plot2 

ggplot(data = surveys, mapping = aes(x = species_id, y = weight)) +
  geom_boxplot(alpha = 0) +
  geom_jitter(alpha = 0.3, color = "tomato") #notice our color needs to be in quotations


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

## Challenge 2
# boxplot does show the shape of the data, use violin to show the distribution
ggplot(surveys, mapping = aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3, color = "tomato") +
  geom_violin(alpha = 0)

# try changing the scale fo the axis to see what effect this has on the data
ggplot(surveys, mapping = aes(x = species_id, y = weight)) +
  geom_jitter(alpha = 0.3, color = "tomato") +
  geom_violin(alpha = 0) +
  scale_y_log10()

# now make a new plot looking at hindfoot_length for species NL and PF
surveys %>% 
  filter(species_id == "NL" | species_id == "PF") %>% 
  ggplot(mapping = aes(x= species_id, y = hindfoot_length)) + # remove call for dataset because it's piped
  geom_jitter(alpha = 0.3, aes(color = as.factor(plot_id))) + # we want to color the plot_id, need to do as factor becuase ggplot sees it as a continue variable instead of a "categorical" number
  geom_boxplot()

surveys %>% 
  filter(species_id == "NL" | species_id == "PF") %>% 
  mutate(plot_factor = as.factor(plot_id)) %>% # could also create a new column for plot_id as a factor
  ggplot(mapping = aes(x= species_id, y = hindfoot_length)) + # remove call for dataset because it's piped
  geom_jitter(alpha = 0.3, aes(color = as.factor(plot_factor))) + # we want to color the plot_id, need to do as factor becuase ggplot sees it as a continue variable instead of a "categorical" number
  geom_boxplot()
