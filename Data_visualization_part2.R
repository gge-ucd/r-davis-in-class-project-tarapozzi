library(tidyverse)
library(ggthemes)
library(cowplot)

data(mtcars)

str(mtcars)

ggplot(mtcars, aes(mpg, hp)) +
  geom_point() +
  theme_tufte() # a theme from tufte whose a big data viz person

# factor data
ggplot(mtcars, aes(mpg, hp, color = as.factor(cyl))) + # so that it isn't plotted as conintuous variable
  geom_point() +
  scale_color_colorblind() + #colors pop a lot more
  theme_tufte()

# continuous data example
ggplot(mtcars, aes(mpg, hp, color = wt)) +
  scale_color_viridis_c() + # viridis is great base palette which makes a big difference if you have a lot of data
  geom_point() +
  theme_bw()

# spatial plot
library(tigris)
library(sf)

ga_counties <-tigris::counties(state = 'GA', class = 'sf', year = 2017)

ggplot() +
  geom_sf(ga_counties, aes(fill = ALAND)) +
  theme_map() +
  scale_fill_viridis_c()

# accessible visualizations
install.packages('BrailleR')
library('BrailleR')

barplot <- ggplot(diamonds, aes(clarity, fill = cut)) +
  geom_bar() +
  theme(axis.text.x = element_text(angle = 70, vjust = 0.5)) +
  scale_fill_viridis_d((option = "C")) +
  theme_classic()

barplot
#turns your plot into a pithy descrpition of your plot
BrailleR::VI(barplot)

install.packages('sonify') #turns your plot for someone that visually impaired 
library(sonify)

plot(iris$Petal.Width)
sonify(iris$Petal.Width)


# Plots fo rpublication with cowplot()

summary(diamonds) # basic data set in r
summary(iris)
summary(mpg)

diamonds.plot <- ggplot(diamonds, aes(clarity, fill = cut)) + #fill colors the whole data point, not just outline which sometimes color does
  geom_bar() +
  theme(axis.text.x = element_text(angle = 45))

diamonds.plot

mpg.plot <- ggplot(mpg, aes(cty, hwy, color = as.factor(cyl))) +
  geom_point(size = 2.5)

mpg.plot

iris.plot <-  ggplot(iris, aes(Sepal.Length, Petal.Length, color = Species)) +
  geom_point(alpha = 0.3)

iris.plot

# now let's combine the plots
## use plot_grid to line up many plots in even boxes

plot_grid(diamonds.plot, iris.plot, mpg.plot, labels = c("A", "B", "C"))

## gg_draw the draw_plot to line up plots
final.plot <- ggdraw() +
  draw_plot(iris.plot, x = 0, y = 0, width = 1, height = 0.5) + #bottom whole width
  draw_plot(mpg.plot, x = 0, y = 0.5, height = 0.5, width = 0.5) + # top left
  draw_plot(diamonds.plot, x = .5, y = 0.5, height = 0.5, width = 0.5) # top right

#save your plots
getwd()
dir.create("figures")
ggsave("figures/finalplot.png", plot = final.plot, width = 6, height = 4, units = "in")

#interactive plots
library(plotly)

plotly::ggplotly(iris.plot)