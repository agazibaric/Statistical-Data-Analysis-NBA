
class DataFrame:

    def __init__(self, data, colNames):
        self.data = data
        self.colNames = colNames
    
    def nRows(self):
        return len(self.data[self.colNames[0]])

    def nCols(self):
        return len(self.data.keys())

    def getRow(self, i):
        row = []
        for name in self.colNames:
            row.append(self.data[name][i])
        return row

    def getCol(self, colName):
        return self.data[colName]

    def renameCol(self, oldName, newName):
        self.colNames[self.colNames.index(oldName)] = newName
        self.data[newName] = self.data[oldName]
        self.data.pop(oldName, None)

    def removeCol(self, colName):
        self.colNames.remove(colName)
        self.data.pop(colName, None)
