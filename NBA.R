setwd("C:/Users/ante1/Documents/Development/R/Projekt/NBA")
playersData <- read.csv(file="./Data/nba-players-stats/Players.csv", header=TRUE, sep=",")
player_data <- read.csv(file="./Data/nba-players-stats/player_data.csv", header=TRUE, sep=",")
seasonsStats <- read.csv(file="./Data/nba-players-stats/Seasons_Stats.csv", header=TRUE, sep=",")

q = quantile(playersData$height, probs = c(0.25, 0.5, 0.75), na.rm = TRUE)
i = IQR(playersData$height, na.rm = TRUE)
upperLimit = q[3] + 1.5 * i
lowerLimit = q[1] - 1.5 * i
tallPlayers = playersData[playersData$height > upperLimit, ]
shortPlayers = playersData[playersData$height < lowerLimit, ]
guards = player_data[player_data$position == "G" , ]

fguards = player_data[player_data$position == "F-G" & fromFactorToInch(player_data$height) > 72, ]

fromFactorToInch <- Vectorize(function(height) {
  tokens <- as.numeric(unlist(strsplit(as.character(height), "-")))
  return(12 * tokens[1] + tokens[2])
})


t.test(fromFactorToInch(guards$height), fromFactorToInch(fguards$height), alt = "two.sided", var.equal = TRUE)
