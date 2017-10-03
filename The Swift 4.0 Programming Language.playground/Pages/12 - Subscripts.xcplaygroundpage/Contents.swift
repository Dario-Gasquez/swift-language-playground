//: [Previous](@previous)
<<<<<<< HEAD

//:# Subscripts

//:## Subscript Syntax
//Example
struct TimesTables {
    let multiplier: Int
=======
//: # Subscripts
//: ## Subscript Syntax

struct TimeTable {
    let multiplier: Int
    
>>>>>>> fecffc9f4e5cdf19f58915a98b881a016d4132b9
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

<<<<<<< HEAD
let threeTimesTables = TimesTables(multiplier: 3)
print("six times three is: \(threeTimesTables[6])")

//:## Subscript Usage

//:## Subscript Options
/*:
 - note: Subscripts can use variadic parameters, but they can’t use in-out parameters or provide default parameter values.
 */
/*:
 - note: While it is most common for a subscript to take a single parameter, you can also define a subscript with multiple parameters if it is appropriate for your type.
 */

struct Matrix {
=======
let treeTimesTable = TimeTable(multiplier: 3)
print("six times 3 equals: \(treeTimesTable[6])")

//: ## Subscript Usage
//: - note: the exact meaning of "subscript" depends on the contex. They are typically used for accessing members of a collection, but your types may differ from this idea.

//: ## Subscript Options
//: - note: Subscripts can take any number of input parameters, and these input parameters can be of any type. Subscripts can also return any type. Subscripts can use variadic parameters, but they can’t use in-out parameters or provide default parameter values.

struct MAtrix2D {
>>>>>>> fecffc9f4e5cdf19f58915a98b881a016d4132b9
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
<<<<<<< HEAD
    func isIndexValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < self.rows && column >= 0 && column < self.columns
=======
    func indexIsValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < rows && column >= 0 && column < columns
>>>>>>> fecffc9f4e5cdf19f58915a98b881a016d4132b9
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
<<<<<<< HEAD
            assert(isIndexValid(row: row, column: column), "get: index out of range")
            return grid[(row * column) + column]
        }
        
        set {
            assert(isIndexValid(row: row, column: column), "set: index out of range")
            return grid[(row*column + column)] = newValue
        }
        
    }
    
}

var theMatrix = Matrix(rows: 2, columns: 2)

theMatrix[0, 1] = 1.5
theMatrix[1, 0] = 3.2

theMatrix[2,2] = 2.0
=======
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

>>>>>>> fecffc9f4e5cdf19f58915a98b881a016d4132b9
//: [Next](@next)
