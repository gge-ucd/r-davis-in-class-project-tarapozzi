
# Load survey data 
surveys <- read.csv("data/portal_data_joined.csv")

# subset data
surveys_base <- surveys[c("species_id", "weight", "plot_type")] 

# first 60 rows
surveys_base <- surveys_base[1:60,]

# convert species id and plot type to factors
surveys_base$plot_type <- as.factor(surveys_base$plot_type)
surveys_base$species_id <- as.factor(surveys_base$species_id)

str(surveys_base)

# remove na's
surveys_base <- na.omit(surveys_base)

# challenge
challenge_base <- surveys_base[(surveys_base[,2] > 150),]

