import csv
from dataframe import DataFrame

def empty(l):
    for c in l:
        if len(c.strip()) > 0: return False
    return True

def loadCSV(path):
    csvFile = open(path)

    players = dict()
    colNames = []
    firstRow = True
    for line in csv.reader(csvFile.readlines()):
        if empty(line):
            continue
        if firstRow:
            for name in line:
                name = name.strip()
                colNames.append(name)
                players[name] = []
            firstRow = False
            continue
        for i, value in enumerate(line):
            players[colNames[i]].append(value.strip())

    return DataFrame(players, colNames)

def exportCSV(dataframe, path):
    csvFile = open(path, 'w')
    csvFile.write(','.join(dataframe.colNames) + '\n')
    for i in range(dataframe.nRows()):
        csvFile.write(','.join(dataframe.getRow(i)) + '\n')
    csvFile.close()