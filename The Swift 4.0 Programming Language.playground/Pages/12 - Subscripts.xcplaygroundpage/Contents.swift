//: [Previous](@previous)
//: # Subscripts
//: ## Subscript Syntax

struct TimeTable {
    let multiplier: Int
    
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

let treeTimesTable = TimeTable(multiplier: 3)
print("six times 3 equals: \(treeTimesTable[6])")

//: ## Subscript Usage
//: - note: the exact meaning of "subscript" depends on the contex. They are typically used for accessing members of a collection, but your types may differ from this idea.

//: ## Subscript Options
//: - note: Subscripts can take any number of input parameters, and these input parameters can be of any type. Subscripts can also return any type. Subscripts can use variadic parameters, but they can’t use in-out parameters or provide default parameter values.

struct MAtrix2D {
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
            assert(indexIsValid(row: row, column: column), "index out of range")
            return grid[row * columns + column]
        }
        set {
            assert(indexIsValid(row: row, column: column), "index out of range")
            grid[row * columns + column] = newValue
        }
    }
}

var matrix = MAtrix2D(rows: 2, columns: 2)
matrix[0, 1] = 1.5
matrix[1, 0] = 3.2

//: [Next](@next)
