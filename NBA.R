setwd("C:/Users/ante1/Documents/Development/R/Projekt/NBA")
playersData <- read.csv(file="./Data/nba-players-stats/Players.csv", header=TRUE, sep=",")
player_data <- read.csv(file="./Data/nba-players-stats/player_data.csv", header=TRUE, sep=",")
seasonsStats <- read.csv(file="./Data/nba-players-stats/Seasons_Stats.csv", header=TRUE, sep=",")
europeanCountries <- read.csv(file="./Data/nba-players-stats/Countries-Europe.csv", header=TRUE, sep=",")
teamStat <- read.csv(file="./Data/nba-players-stats/Team_Records.csv", header=TRUE, sep=",")
teamNames <- read.csv(file="./Data/nba-players-stats/data_team_names.csv", header=TRUE, sep=",")

# Tallest and smallest players
q = quantile(playersData$height, probs = c(0.25, 0.5, 0.75), na.rm = TRUE)
i = IQR(playersData$height, na.rm = TRUE)
upperLimit = q[3] + 1.5 * i
lowerLimit = q[1] - 1.5 * i
tallPlayers = playersData[playersData$height > upperLimit, ]
shortPlayers = playersData[playersData$height < lowerLimit, ]

# Compare guards ("G") and forward guards ("F-G")
guards = player_data[player_data$position == "G" , ]
fguards = player_data[player_data$position == "F-G" | player_data$position == "G-F", ]
fromFactorToInch <- Vectorize(function(height) {
  tokens <- as.numeric(unlist(strsplit(as.character(height), "-")))
  return(12 * tokens[1] + tokens[2])
})

t.test(fromFactorToInch(guards$height), fromFactorToInch(fguards$height), alt = "two.sided", var.equal = TRUE)

# Statistics between European players and other
europeans = playersData[playersData$birth_state %in% europeanCountries$name, ]
other = setdiff(playersData, europeans)
t.test(europeans$height, other$height, alt = "two.sided")

europeanStats = seasonsStats[seasonsStats$Player %in% europeans$Player, ]
otherStats = seasonsStats[seasonsStats$Player %in% other$Player, ]

playerFTA = c(sum(europeanStats$FTA), sum(otherStats$FTA))
playerFT = c(sum(europeanStats$FT), sum(otherStats$FT))

prop.test(playerFT, playerFTA, alternative="t", correct="FALSE")





