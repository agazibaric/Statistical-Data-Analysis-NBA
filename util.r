
asInch <- function(height) {
  if (length(height) == 1) {
    height <- as.character(height)
    tokens <- as.numeric(unlist(strsplit(height, "-")))
    return(12 * tokens[1] + tokens[2])
  }
  heightInInches = rep(0, length(height))
  for (i in 1:length(height)) {
    heightInInches[i] <- asInch(height[i])
  }
  return(heightInInches)
}

asCm <- function(height) {
  return(2.54 * asInch(height))
}

asKg <- function(weight) {
  if (length(weight) == 1) {
    return(0.45359237 * weight)
  }
  weightInKgs = rep(0, length(weight))
  for (i in 1:length(weight)) {
    weightInKgs[i] <- asKg(weight[i])
  }
  return(weightInKgs)
}



fixPosition <- function(position) {
  if (length(position) == 1) {
    position <- as.character(position)
    tokens <- sort(unlist(strsplit(position, "-")), decreasing=TRUE)
    return(paste(tokens, collapse="-"))
  }
  positions = rep(0, length(position))
  for (i in 1:length(position)) {
    positions[i] <- fixPosition(position[i])
  }
  return(factor(positions))
}

preparePlayerData <- function(players) {
  players$position <- fixPosition(players$position)
  players$height <- asCm(players$height)
  players$weight <- asKg(players$weight)
  return(players)
}

removeAsterisk <- function(name) {
  if (length(name) == 1) {
    if (grepl("\\*", name)) {
      return(substr(name, 1, nchar(name)-1))
    }
    return(name)
  }
  names = rep(0, length(name))
  for (i in 1:length(names)) {
    names[i] <- removeAsterisk(name[i])
  }
  return(names)
}

prepareSeasonsStatsData <- function(seasonsStats, players) {
  ss <- seasonsStats
  ss$Player <- removeAsterisk(as.character(ss$Player))
  ss <- ss[which(ss$Player != ""), ]
  return(ss)
}
