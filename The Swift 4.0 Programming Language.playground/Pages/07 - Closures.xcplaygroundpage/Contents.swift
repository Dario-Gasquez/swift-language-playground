//: [Previous](@previous)
//: # Closures
//: ## Closures Expresions
//: ### The Sorted Method
let names = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]

func backward(_ s1: String, _ s2: String) -> Bool {
    return s1 > s2
}
var reversedNames = names.sorted(by: backward)

//: ### Closure Expression Syntax
reversedNames = names.sorted(by: {
    (s1: String, s2: String) -> Bool in
    return s1 > s2
})

// One line version:
reversedNames = names.sorted(by: { (s1: String, s2: String) -> Bool in return s1 > s2 } )

//: ### Inferring type from context
reversedNames = names.sorted(by: { s1, s2 in return s1 > s2 } )


//: ### Implicit returns from single-expression closures
reversedNames = names.sorted(by: { s1, s2 in s1 > s2 } )


//: ### Shorthand argument name
reversedNames = names.sorted(by: { $0 > $1 } )


//: ### Operator methods
reversedNames = names.sorted(by: >)


//: ## Trailing Closures
func someFuncThatTakesAClosure(closure: ()->Void) {
    //function body
}

// Calling the function without trailing closure syntax:
someFuncThatTakesAClosure(closure: {
    // closure body
})

// Calling the function using trailing closure:
someFuncThatTakesAClosure() {
    // closure body
}

// Also without parenthesis because the closure is the only argument:
someFuncThatTakesAClosure {
    // closure body
}

reversedNames = names.sorted() { $0 > $1 }
reversedNames = names.sorted { $0 > $1 }

let digitNames = [
    0: "Zero", 1: "One", 2: "Two", 3: "Three", 4: "Four",
    5: "Five", 6: "Six", 7: "Seven", 8: "Eight", 9: "Nine"
]

let numbers = [15, 143, 6]
let stringfied = numbers.map {
    (number: Int) -> String in
    var n = number
    var output = ""
    repeat {
        output = digitNames [n % 10]! + output
        n /= 10
    } while n > 0
    return output
}


//: ## Capturing Values
func makeIncrementer(forIncrement amount: Int) -> () -> Int {
    var runningTotal = 0
    func incrementer()->Int {
        runningTotal += amount
        print("running total: \(runningTotal) -- amount: \(amount)")
        return runningTotal
    }
    
    return incrementer
}

let incrementByTen = makeIncrementer(forIncrement: 10)
incrementByTen()
incrementByTen()

let incrementByFive = makeIncrementer(forIncrement: 5)
incrementByFive()
incrementByFive()

/*: 
 - note: If you assign a property to a class instance, and the closure captures that instance by referring to the instance or its members, you will create a strong reference cycle between the instance and the closure. Swift uses **capture lists** to break this cycles. */


//: ## Closure are reference types
let alsoIncrementByTen = incrementByTen
alsoIncrementByTen()


//: ## Escaping Closures
// A closure passed as argument to a function escapes that function if it is called after the function has returned.
var completionHandlers: [()->Void] = []
func aFuncWithEscapingClosure(completionHandler: @escaping ()->Void) {
    completionHandlers.append(completionHandler)
}

func aFuncWithoutEscapingClosure(closure: ()->Void) {
    closure()
}

class SomeClass {
    var x = 10
    func doSomething() {
        aFuncWithEscapingClosure { self.x = 100 }
        aFuncWithoutEscapingClosure { x = 200 }
    }
}

let instance = SomeClass()
instance.doSomething()
print(instance.x)
completionHandlers.first?()
print(instance.x)


//: ## Autoclosures
// An autoclosure is a closure that is automatically created to wrap an expression passed as an argument to a function. 
// An autoclosure lets you delay evaluation, because the code inside isn’t run until you call the closure. Delaying evaluation is useful for code that has side effects or is computationally expensive, because it lets you control when that code is evaluated. The code below shows how a closure delays evaluation.
var customersInLine = ["Chris", "Alex", "Ewa", "Barry", "Daniella"]
print("customers in line: \(customersInLine.count)")

let customerProvider = { customersInLine.remove(at: 0) }
print("customers in line: \(customersInLine.count)")

customerProvider()
print("customers in line: \(customersInLine.count)")

func serve(customer costumerProvider: ()->String) {
    print(#function + "Now serving: \(costumerProvider())")
}
serve(customer: { customersInLine.remove(at: 0) })

// Autoclosure serve version:
func serve(customer customerProvider: @autoclosure ()->String) {
    print(#function + "serving: \(customerProvider())")
}

serve(customer: customersInLine.removeLast())

// Autoclosure can be combined with escaping:
var customerProviders: [()->String] = []
func collectCustomerProvider(_ customerProvider: @autoclosure @escaping ()->String) {
    customerProviders.append(customerProvider)
}

collectCustomerProvider(customersInLine.remove(at: 0))
collectCustomerProvider(customersInLine.remove(at: 0))
print("collected \(customerProviders.count) closures")
for provider in customerProviders {
    print("now serving \(provider())")
}
print("customers in line: \(customersInLine.count)")


//: [Next](@next)
