from csvutil import loadCSV, exportCSV
import util

seasons = loadCSV('data/seasons.csv')
util.addPlayoff(seasons, 'Tm')

exportCSV(seasons, 'data/seasons.csv')