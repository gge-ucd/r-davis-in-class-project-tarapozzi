
# Load survey data 
surveys <- read.csv("data/portal_data_joined.csv")

# create a new survey data
surveys_base <- surveys[c("species_id", "weight", "plot_type")] #base R
surveys_base <- select(surveys, species_id, weight, plot_type)
surveys_base


# first 60 rows
surveys_base <- surveys_base[1:60,] #baseR # might need to concatenate it if you have characters
surveys_base <- head(surveys_base, 60)

# convert species id and plot type to factors
surveys_base$plot_type <- as.factor(surveys_base$plot_type)
surveys_base$species_id <- as.factor(surveys_base$species_id)

str(surveys_base)

# remove na's
surveys_base <- surveys_base %>%
  na.omit(surveys_base$weight) #OR

surveys_base <- na.omit(surveys_base, surveys_base$weight)

surveys_base <- surveys_base[!is.na(surveys_base$weight),] # another way to remove the na's 

#another way to do it
complete.cases(surveys_bases)

# challenge
challenge_base <- surveys_base[(surveys_base[,2] > 150),]


