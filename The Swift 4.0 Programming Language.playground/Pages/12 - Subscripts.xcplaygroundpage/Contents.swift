//: [Previous](@previous)

//:# Subscripts

//:## Subscript Syntax
//Example
struct TimesTables {
    let multiplier: Int
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}

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
    let rows: Int, columns: Int
    var grid: [Double]
    
    init(rows: Int, columns: Int) {
        self.rows = rows
        self.columns = columns
        grid = Array(repeating: 0.0, count: rows * columns)
    }
    
    func isIndexValid(row: Int, column: Int) -> Bool {
        return row >= 0 && row < self.rows && column >= 0 && column < self.columns
    }
    
    subscript(row: Int, column: Int) -> Double {
        get {
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
//: [Next](@next)
