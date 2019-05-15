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
player = player_data[player_data$position == "C" & asInch(as.character(player_data$height)) > 84, ]
as = asInch(as.character(player_data$height))
chars = as.character(player_data$height)
l = asInch(chars)

h = levels(player$position)
a = player_data$height[1]
tokens <- as.numeric(unlist(strsplit(as.character(a), "-")))


getVectorInch <- function(vec) {
  
}

asInch <- function(height) {
  if (is.vector(height)) {
    result <- numeric()
    for (i in 1:length(height)) {
      result <- c(result, asInch(height[i]))
    } 
    return(result)
  }#
  tokens <- as.numeric(unlist(strsplit(height, "-")))
  return(12 * tokens[1] + tokens[2])
}
asInch("7-0")
