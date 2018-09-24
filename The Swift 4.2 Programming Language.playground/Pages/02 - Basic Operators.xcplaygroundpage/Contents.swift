//:  [Previous](@previous) - [Next](@next)

//: # Basic Operators

//: ## Assignment Operator

// Tuple assignment example
let a = (first: 1, second: 2)
print(a.first)
print(a.second)

var (x,y) = (a.first, a.second)

/*:
 - note: assignment operator does not return a value as in C or Objective-C.
 */
// The next statement is not valid.
//if x = y {
    //do something
//}


//: ## Arithmetic Operators
//: ### Reminder operator
9 % 5

//In Swift 3.0+ reminder is deprecated for float values
//Deprecated: 8 % 2.5

//: ## Comparison Operators
// Also availabe for tuples
(2, "appld") < (2, "apple")
(3, "apple") < (3, "bird")
(4, "dog") == (4, "dog")

/*:
 - note:
 The Swift standard library includes tuple comparison operators for tuples with fewer than seven elements. To compare tuples with seven or more elements, you must implement the comparison operators yourself.
 */

//: ## Nil-Coalescing operator
// a ?? b
// shorthand for the following code:
// a != nil ? a : b
let defaultColorName = "red"
var userDefinedColorName: String?
var colorNameToUse = userDefinedColorName ?? defaultColorName

//: ## Range Operators
//: ### Closed Range Operator
for index in 1...5 {
    print("index = \(index)")
}

//: ### Half-Open Range Operator
for index in 1..<5 {
    print("half-open range index = \(index)")
}

//: ### One-Sided Ranges
let names = ["Anna", "Alex", "Brian", "Jack"]
for name in names[2...] {
    print(name)
}

for name in names[...2] {
    print(name)
}
//one-sided can be combined with half-range
for name in names[..<2] {
    print(name)
}

//You can check if a range contains a specific value as shown below:
let range = ..<5
range.contains(7)
range.contains(4)
range.contains(5)
range.contains(-10000)

//: ## Logical operators: not (!a), and (a && b), or (a || b)

//:  [Previous](@previous) - [Next](@next)
