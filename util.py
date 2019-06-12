
def addHallOfFame(dataframe, colName):
    dataframe.colNames.append('HOF')
    dataframe.data['HOF'] = []
    for i, name in enumerate(dataframe.data[colName]):
        name, hof = removeAsterisk(name)
        dataframe.data['HOF'].append('TRUE' if hof else 'FALSE')
        if hof: dataframe.data[colName][i] = name

def addPlayoff(dataframe, colName):
    dataframe.colNames.append('PO')
    dataframe.data['PO'] = []
    for i, name in enumerate(dataframe.data[colName]):
        name, po = removeAsterisk(name)
        dataframe.data['PO'].append('TRUE' if po else 'FALSE')
        if po: dataframe.data[colName][i] = name

def asInch(feet):
    tokens = feet.split('-')
    return 12 * tokens[0] + tokens[1]

def asCm(inches):
    return 2.54 * inches

def asKg(lbs):
    return 0.45359237 * lbs

def removeAsterisk(s):
    if len(s) == 0:
        return s, False
    hasAsterisk = s[-1] == '*'
    if hasAsterisk:
        return s[:-1], True
    return s, False

def calculateRatio(dataframe, a, b, c):
    dataframe.data[c] = []
    for value1, value2 in zip(dataframe.data[a], dataframe.data[b]):
        if value1 == '' or value2 == '':
            dataframe.data[c].append('')
            continue
        if float(value1) == 0 or float(value2) == 0:
            dataframe.data[c].append('0')
            continue
        dataframe.data[c].append("{0:.2f}".format(float(value1) / float(value2)))
