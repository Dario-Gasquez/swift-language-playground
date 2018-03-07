//: [Previous](@previous)
//: # Generics
//: ## The Problem That Generic Solve
//: Here's a non generic function to swap to integers:
func swap(_ a: inout Int, _ b: inout Int) {
    print("-- int swap -----")
    let temp = a
    a = b
    b = temp
}

//: If we want to swap doubles or strings we need to create addtional functions, even though the code is almost identical:
func swap(_ a: inout Double, _ b: inout Double) {
    print("-- double swap -----")
    let temp = a
    a = b
    b = temp
}

func swap(_ a: inout String, _ b: inout String) {
    print("-- string swap -----")
    let temp = a
    a = b
    b = temp
}

var anInt = 5
var anotherInt = 11
swap(&anInt, &anotherInt)
print("anInt: \(anInt), anotherInt: \(anotherInt)")

var aString = "qwe"
var anotherString = "123"
swap(&aString, &anotherString)
print("aString: \(aString), anotherString: \(anotherString)")


var aDouble = 1.2
var anotherDouble = 2.4
swap(&aDouble, &anotherDouble)
print("aDouble: \(aDouble), anotherDouble: \(anotherDouble)")

//: ## Generic Functions
//: *Generic functions* can work with any type. Here is the generic version of the swap function using `T` as a placeholder type.
func swapGeneric<T>(_ a: inout T, _ b: inout T) {
    print("~~ generic swap ~~~~~")
    let temp = a
    a = b
    b = temp
}

swapGeneric(&anInt, &anotherInt)
print("anInt: \(anInt), anotherInt: \(anotherInt)")

//: - Note: he swap(_:_:) function defined above is inspired by a generic function called swap, which is part of the Swift standard library, and is automatically made available for you to use in your apps. If you need the behavior of the swapTwoValues(_:_:) function in your own code, you can use Swift’s existing swap(_:_:) function rather than providing your own implementation.

//: ## Type Paramenters
/*:
In the swap(_:_:) example above, the placeholder type `T` is an example of a *type parameter*. Type parameters specify and name a placeholder type, and are written immediately after the function’s name, between a pair of matching angle brackets (such as <T>).

 Once you specify a type parameter, you can use it to define the type of a function’s parameters, or as the function’s return type, or as a type annotation within the body of the function. In each case, the type parameter is replaced with an actual type whenever the function is called/
 
 You can provide more than one type parameter by writing multiple type parameter names within the angle brackets, separated by commas.
*/

//: ## Naming Type Parameters
//: In most cases type parameters have descriptive names (rather than just `T`), such as `Key` and `Value` in `Dictionary<Key, Value>` and `Element` in `Array<Element>` which tells the reader the relationship between the type parameter and the generic type or function it's used in. However, if there is no meaningful relationship, it's traditional to name them using single letters such as `T`, `U` and `V`.
//: - Note: Always give type parameters upper camel case names (such as T and MyTypeParameter) to indicate that they’re a placeholder for a type, not a value.

//: ## Generic Types
//: In addition to generic functions, Swift enables you to define your own *generic types*. These are custom classes, structures, and enumerations that can work with any type, in a similar way to `Array` and `Dictionary`.

//: non generic stack of Int values:
struct IntStack {
    var items = [Int]()
    
    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
}

//Generic version of Stack:
struct Stack<Value> {
    var items = [Value]()
    
    mutating func push(_ item: Value) {
        items.append(item)
    }
    
    mutating func pop() -> Value {
        return items.removeLast()
    }
}

var stringsStack = Stack<String>()
stringsStack.push("first")
stringsStack.push("second")
stringsStack.push("3rd")
let popedValue = stringsStack.pop()


//: ## Extending a Generic Type
extension Stack {
    var topItem: Value? {
        return items.isEmpty ? nil : items[items.count - 1]
    }
}

let topString = stringsStack.topItem

//: Extensions of a generic type can also include requirements that instances of the extended type must satisfy in order to gain the new functionality.

//: ## Type Constraints
//: Sometimes its useful or necesary to enforce *type constraints* on the types used in a generic. Type constrains specify that types must inherit from certain class or conform to one or more protocols.

//: ### Type Constraint Syntax
/*:
 The basic syntax for a type contraints on a generic function is shown below:
 
    func someFunc<T: SomeClass, U: SomeProtocol>(a: T, b: U) {
        //function body
    }
*/

//: ### Type Constraints in Action
//: A generic find function could be written like this using `Equatable` as a contraint:
func findIndex<T: Equatable>(of valueToFind: T, in array:[T]) -> Int? {
    for (index, value) in array.enumerated() {
        if value == valueToFind {
            return index
        }
    }
    return nil
}

let doubleIndex = findIndex(of: 9.1, in: [3.14, 9.2, 10.5])
let stringIndex = findIndex(of: "2nd", in: ["0", "1st", "2nd"])

//: ## Associated Types
//: When defining a protocol, it’s sometimes useful to declare one or more associated types as part of the protocol’s definition. An *associated type* gives a placeholder name to a type that is used as part of the protocol. The actual type to use for that associated type isn’t specified until the protocol is adopted. Associated types are specified with the `associatedtype` keyword.

//: ### Associated Types in Action
protocol Container {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//: Here is a version of the non generic `IntStack` adapted to conform to the `Container` protocol:
struct IntStackContainer: Container {
    // Original implementation
    var items = [Int]()

    mutating func push(_ item: Int) {
        items.append(item)
    }
    
    mutating func pop() -> Int {
        return items.removeLast()
    }
    
    // Container conformance
    typealias Item = Int //This line is optional, the compiler could infer the type.
    mutating func append(_ item: Int) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Item {
        return items[i]
    }
}

//: The generic stack can also be modified to conform to `Container`:
struct GenericStack<Element>: Container {
    var items = [Element]()
    
    mutating func push(_ item: Element) {
        items.append(item)
    }
    
    mutating func pop() -> Element {
        return items.removeLast()
    }
    // Container conformance
    mutating func append(_ item: Element) {
        self.push(item)
    }
    var count: Int {
        return items.count
    }
    subscript(i: Int) -> Element {
        return items[i]
    }
}

//: ### Extending an Existing Type to Specifiy an Associated Type
//: Existing types can be extended to add conformance to a protocol. The extension can be empty if the type already has implements the protocol's requirement, for example:
extension Array: Container {}

//: ### Using Type Annotations to Constrain an Associated Type
//: You can add a type annotation to an associated type in a protocol, to require that conforming types satisfy the constraints described by the type annotation.
protocol EquatableContainer {
    associatedtype Item: Equatable
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(i: Int) -> Item { get }
}

//: ### Using a Protocol in Its Associated Type's Constraints
//: A protocol can appear as part of its own requirements (Swift 4.1):
//WARNING: will only compile with Swift 4.1 compiler (Xcode 9.3 or +)
/*
protocol SuffixableContainer: Container {
    associatedtype Suffix: SuffixableContainer where Suffix.Item == Item
    func suffix(_ size: Int) -> Suffix
}
extension GenericStack: SuffixableContainer {
    func suffix(_ size: Int) -> GenericStack {
        var result = GenericStack()
        for index in (count-size)..<count {
            result.append(self[index])
        }
    }
}

var stackOfInts = GenericStack<Int>()
stackOfInts.append(10)
stackOfInts.append(20)
stackOfInts.append(30)
let suffix = stackOfInts.suffix(2)
*/

//: ## Generic Where Clauses
/*:
 Type constraints, as described in Type Constraints, enable you to define requirements on the type parameters associated with a generic function, subscript, or type.

It can also be useful to define requirements for associated types. You do this by defining a *generic where clause*.
 */

func allItemsAreEqual<C1: Container, C2: Container>(_ firstContainer: C1, _ secondContainer: C2) -> Bool where C1.Item == C2.Item, C1.Item: Equatable {
    
    // Check that both containers contain the same number of items
    if firstContainer.count != secondContainer.count {
        return false
    }
    
    // Check each pair of items to see if they're equivalent
    for i in 0..<secondContainer.count {
        if firstContainer[i] != secondContainer[i] {
            return false
        }
    }
    
    return true
}

var stackOfStrings = GenericStack<String>()
stackOfStrings.push("first")
stackOfStrings.push("second")
stackOfStrings.push("third")

var stringArray = ["first","second", "third"]

if allItemsAreEqual(stackOfStrings, stringArray) {
    print("All items are equal")
} else {
    print("not all items match")
}

//: ## Extensions with a Generic Where Clause
//: `where` clauses can also be used as part of a generic extension:
extension GenericStack where Element: Equatable {
    func isTop(_ item: Element) -> Bool {
        let result = (item == items.last ? true : false)
        return result
    }
}

if stackOfStrings.isTop("third") {
    print("third is top")
}

//: You can use a generic `where` clause with extensions to a protocol:
extension Container where Item: Equatable {
    func startsWith(_ item: Item) -> Bool {
        return count >= 1 && self[0] == item
    }
}

if [9, 8, 7].startsWith(7) {
    print("it starts with 7")
}

//: The generic `where` clause in the example above requires `Item` to conform to a protocol, but you can also write a generic `where` clauses that require `Item` to be a specific type. For example:
extension Container where Item == Double {
    func average() -> Double {
        var sum = 0.0
        for index in 0..<count {
            sum += self[index]
        }
        return sum / Double(count)
    }
}

[1.5, 1.5, 3.0].average()
//: You can include multiple requirements in a generic `where` clause that is part of an extension, just like you can for a generic `where` clause that you write elsewhere. Separate each requirement in the list with a comma.

//: ## Associated Types with a Generic Where Clause
//: You can include a generic `where` clause on an associated type:
protocol Container2 {
    associatedtype Item
    mutating func append(_ item: Item)
    var count: Int { get }
    subscript(index: Int) -> Item { get }
    
    associatedtype Iterator: IteratorProtocol where Iterator.Element == Item
    func makeIterator() -> Iterator
}

//: For a protocol that inherits from another protocol, you add a constraint to an inherited associated type by including the generic `where` clause in the protocol declaration:
protocol ComparableContainer: Container2 where Item: Comparable {}

//: ## Generic Subscripts
//: Subscripts can be generic, and they can include generic `where` clauses:
extension Container {
    subscript<Indices: Sequence>(indices: Indices) -> [Item] where Indices.Iterator.Element == Int {
        var result = [Item]()
        for index in indices {
            result.append(self[index])
        }
        return result
    }
}

stringArray.append("4th")
stringArray.append("5th")
print(stringArray)
let result = stringArray[[0,2,3]]

//: [Next](@next)
