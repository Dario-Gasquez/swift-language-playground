//: [Previous](@previous)

//: # Functions
//: ## Function Parameters and Return Values

func printAndCount(string: String) -> Int {
    print(string)
    return string.count
}

// The return value of a function can be ignored:
func printWithoutCounting(string: String) {
    let _ = printAndCount(string: string)
}

printAndCount(string: "hello")
printWithoutCounting(string: "bye")

//: ### Functions with multiple return values (tuples)
func minMax(array: [Int]) -> (min: Int, max: Int) {
    var min = array[0]
    var max = array[0]
    for number in array[1..<array.count] {
        min = number < min ? number : min
        max = number > max ? number : max
    }
    
    return (min, max)
}

let bounds = minMax(array: [8, -5, 10, 3, 105])
print("min is: \(bounds.min) and max is: \(bounds.max)")


//: ## Function Argument Labels and Parameter Names
/*: 
 - note:
 Each function parameter has both an *argument label* and a *parameter name*. The argument label is used when calling the function. The parameter name is used in the implementation of the function. */
//: ### Specifying arguments labels
func someFunction(argumentLabel parameterName: Int) {
    print("parameter is \(parameterName)")
}
someFunction(argumentLabel: 10)

//: ### Ommiting argument names
func someFunction(_ firstParamName: Int, secondParamName: Int) {
    print(#function + " - firstparam: \(firstParamName), secondParameter: \(secondParamName)")
}
someFunction(10, secondParamName: 20)


//: ### Default parameter value
func aFunc(a: Int, b: Int = 12) {
    print(#function + " - \(a) + \(b) = \(a+b)")
}
aFunc(a: 4)
aFunc(a: 4, b: 20)


//: ### Variadic Parameters
// The parameters in a variadic list are available as an array. In the following example function numbers is an [Double]:
func arithmeticMean(_ numbers: Double...) -> Double {
    var result = 0.0
    
    for number in numbers {
        result += number
    }
    return result / Double(numbers.count)
}

arithmeticMean(1,2,3,5,10.5)

func variadicTest(intNumber: Int, numbers: Double ...) {
    print("intNumber: \(intNumber)")
    
    for number in numbers {
        print(number, terminator: ", ")
    }
    
}

variadicTest(intNumber: 5, numbers: 5.5, 6.0, 7.8)
//: - note: A function can have at most **one** variadic parameter

//: ### In-Out parameters
// Functions parameters are constant by default. Defining parameters as *in-out parameter* allows them to change inside the function.
//: - note: In-Out parameters cannot have default values, and variadic parameters cannot be marked as *inout*.
func swapInts(first: inout Int, second: inout Int) {
    let temp = first
    first = second
    second = temp
}

var anInt = 5, anotherInt = 10
swap(&anInt, &anotherInt)
print("anInt:\(anInt). anotherInt:\(anotherInt)")


//: ## Function Types
// The types of the following 2 functions is the same: (Int, Int) -> Int

func addInts(_ a: Int, _ b: Int) -> Int { return a+b }
func multiplyInts(_ a: Int, _ b: Int) -> Int { return a*b }


//: ## Using Function Types
// function types can be used as other types in Swift. For example to assing functions to variables or constants:
var mathFunc = addInts
mathFunc(4,5)
mathFunc = multiplyInts
mathFunc(4,5)


//: ### Function Types as Parameter Types
func printMathResult(_ aFunc: (Int, Int)->Int, a: Int, b: Int) {
    print(#function + " - the result is: \(aFunc(a, b))")
}

printMathResult(addInts, a: 3, b: 2)
printMathResult(multiplyInts, a: 3, b: 2)


//: ### Function Types as Return Types
func stepForward(_ input: Int)->Int {
    return input + 1
}

func stepBackward(_ input: Int)->Int {
    return input - 1
}

func chooseStepFunction(backward: Bool) -> (Int)->Int {
    return backward ? stepBackward : stepForward
}

var currentValue = -5
var moveToZero = chooseStepFunction(backward: currentValue > 0)
while currentValue != 0 {
    print("\(currentValue)")
    currentValue = moveToZero(currentValue)
}

//: ## Nested Functions
func chooseStepFunction2(backward: Bool) -> (Int)->Int {
    func stepUp(_ input: Int)->Int { return input+1 }
    func stepDown(_ input: Int)->Int { return input-1 }
    return backward ? stepDown : stepUp
}

currentValue = 3
moveToZero = chooseStepFunction2(backward: currentValue > 0)
while currentValue != 0 {
    currentValue = moveToZero(currentValue)
    print("currentValue = \(currentValue)")
}

//: [Next](@next)
