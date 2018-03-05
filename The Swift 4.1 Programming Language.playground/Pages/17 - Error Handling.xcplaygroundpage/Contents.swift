//: [Previous](@previous)
//: # Error Handling
//: ## Representing and Throwing Errors
//: In Swift errors are values that conform to the `Error` empty protocol. Swift enumerations are a a good way to represent errors.


enum VendingMachineError: Error {
    case invalidSelection
    case insuficientFunds(coinsNeeded: Int)
    case outOfStock
}

/*:
 Throwing an error lets you indicate that something unexpected happened and the normal flow of execution can't continue. The following code throws an error to indicate additional coins are needed:

    throw VendingMachineError.insuficientFunds(coinsNeeded: 5)
*/

//: ## Handling Errors
//: There are four ways to handle errors in Swift. You can propagate the error from a function to the code that calls that function, handle the error using a do-catch statement, handle the error as an optional value, or assert that the error will not occur.
//: - Note: Error handling in Swift resembles exception handling in other languages, with the use of the try, catch and throw keywords. Unlike exception handling in many languages—including Objective-C—error handling in Swift does not involve unwinding the call stack, a process that can be computationally expensive. As such, the performance characteristics of a `throw` statement are comparable to those of a `return` statement.

//: ### Propagating Errors Using Throwing Functions
/*:
 Write the `throws` keyword in the function’s declaration after its parameters. A function marked with `throws` is called a **throwing function**. If the function specifies a return type, you write the throws keyword before the return arrow (->).

    func canThrowErrors() throws -> String
 */

//: - Note: Only throwing functions can propagate errors. Any errors thrown inside a nonthrowing function must be handled inside the function.

struct Item {
    var price: Int
    var count: Int
}

class VendingMachine {
    var inventory = [
        "Candy Bar": Item(price: 12, count: 7),
        "Chips": Item(price: 10, count: 4),
        "Pretzels": Item(price: 7, count: 11)
    ]
    
    var coinsDeposited = 0
    
    func vend(itemNamed name: String) throws {
        guard let item = inventory[name] else { throw VendingMachineError.invalidSelection }
        guard item.count > 0 else { throw VendingMachineError.outOfStock }
        guard item.price < coinsDeposited else { throw VendingMachineError.insuficientFunds(coinsNeeded: item.price - coinsDeposited) }
        
        coinsDeposited -= item.price
        
        var newItem = item
        newItem.count -= 1
        inventory[name] = newItem
        
        print("Dispensing \(name)")
    }
}

let favoriteSnacks = [
    "Alice" : "Chips",
    "Bob" : "Licorice",
    "Eve" : "Pretzels"
]

//: The function below propagates any error thrown by `VendingMachine.vend`
func buyFavoriteSnack(person: String, vendingMachine: VendingMachine) throws {
    let snackName = favoriteSnacks[person] ?? "Candy Bar"
    try vendingMachine.vend(itemNamed: snackName)
}


//: Initializer can also throw errors
struct PurchasedSnack {
    let name: String
    
    init(name: String, vendingMachine: VendingMachine) throws {
        try vendingMachine.vend(itemNamed: name)
        self.name = name
    }
}

//: ### Handling Errors Using Do-Catch
/*:
 You use a do-catch statement to handle errors by running a block of code. If an error is thrown by the code in the do clause, it is matched against the catch clauses to determine which one of them can handle the error.
 
 Here is the general form of a do-catch statement:
 
     do {
        try expression
     } catch pattern 1 {
        statements
     } catch pattern 2 where condition {
        statements
     } catch {
        statements
     }
*/

var vendingMachine = VendingMachine()
vendingMachine.coinsDeposited = 8

do {
    try buyFavoriteSnack(person: "Alice", vendingMachine: vendingMachine)
    print("Success! Yum.")
} catch VendingMachineError.invalidSelection {
    print("Invalid selection")
} catch VendingMachineError.outOfStock {
    print("Out of stock")
} catch VendingMachineError.insuficientFunds(let coinsNeeded) {
    print("Insuficient funds. Please insert an additional \(coinsNeeded) coins.")
} catch {
    print("Unexpected error \(error)")
}


//: The catch clauses don’t have to handle every possible error that the code in the do clause can throw. If none of the catch clauses handle the error, the error propagates to the surrounding scope. However, the error must be handled by some surrounding scope—either by an enclosing do-catch clause that handles the error or by being inside a throwing function. For example, the above example can be written so any error that isn’t a VendingMachineError is instead caught by the calling function:

func nourish(with item: String) throws {
    do {
        try vendingMachine.vend(itemNamed: item)
    } catch is VendingMachineError {
        print("invalid selection, out of stock or not enough money")
    }
}

do {
    try nourish(with: "Pringles")
} catch  {
    print("Unexpected error: \(error)")
}

//: ### Converting Errors to Optional Values
/*:
 You use try? to handle an error by converting it to an optional value. If an error is thrown while evaluating the try? expression, the value of the expression is nil. For example, in the following code x and y have the same value and behavior:

    func aThrowingFunc() throws -> Int {
        // code
    }

    let x = try? aThrowingFunc()

    let y: Int?
    do {
        y = try aThrowingFunc()
    } catch {
        y = nil
    }
 */

/*:
 Using `try?` lets you write concise error handling code when you want to handle all errors in the same way. For example, the following code uses several approaches to fetch data, or returns nil if all of the approaches fail.

    func fetchData -> Data? {
        if let data = try? fetchDataFromDisk() { return data }
        if let data = try? fetchDataFromServer() { return data }
        return nil
    }
 */

//: ### Disabling Error Propagation
/*:
Sometimes you know a throwing function or method won’t, in fact, throw an error at runtime. On those occasions, you can write `try!` before the expression to disable error propagation and wrap the call in a runtime assertion that no error will be thrown. If an error actually is thrown, you’ll get a runtime error.

    let photo = try! loadImage(atPath:"./resources/apple.png")
*/

//: ## Specifying Cleanup Actions
/*:
You use a `defer` statement to execute a set of statements just before code execution leaves the current block of code. This statement lets you do any necessary cleanup that should be performed regardless of how execution leaves the current block of code—whether it leaves because an error was thrown or because of a statement such as `return` or `break`.
 
The deferred statements may not contain any code that would transfer control out of the statements, such as a break or a return statement, or by throwing an error. Deferred actions are executed in the reverse of the order that they’re written in your source code. That is, the code in the first defer statement executes last, the code in the second defer statement executes second to last, and so on. The last defer statement in source code order executes first.

     func processFile(filename: String) throws {
        if exists(filename) {
            let file = open(filename)
            defer {
                close(file)
            }
        }
        while let line = try file.readLine() {
            //work with the file.
        }
 
        //close(file) is called here.
    }
 */



//: [Next](@next)
