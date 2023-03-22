//: # The Basics

var boolean: Bool?
var intVar: Int? = 1

boolean = intVar == 1 ? true:false

var a = 5

//if a > 0 {
//    guard a == 5 else { continue }
//    print("something")
//} else {
//    print("asd")
//}

var anInt:Int? = 5

var aString = String(describing: anInt)

//: ## Numeric Literals
let decimalLiteral = 17
let binaryInteger = 0b10001
let octalInteger = 0o21
let hexadecimalInteger = 0x11

// Floating point
let decimalDouble = 12.1875
let exponentDouble = 12.21875e1
let hexadecimalDouble = 0xC.3p0

let paddedDouble = 000123.456
let oneMillion = 1_000_000
let justOverOneMillion = 1_000_000.000_000_1


//: ## Numeric type conversion

//: ### Integer conversion

//Uncomment to see error:
//let notNegative: UInt8 = -1
//let tooBig: Int8 = Int8.max + 1

let twoThousands:UInt16 = 2_000
let one: UInt8 = 1
let twoKandOne = twoThousands + UInt16(one)

//let tooSmall:UInt8 = UInt8(twoKandOne) //runtime error:  Not enough bits to represent the passed value

//: ## Type Aliases
typealias AudioSample = UInt16
let audioSample = AudioSample.max


//: ## Tuples
let httpError = (404, "HTTP error: Not Found")
let (errorCode, errorDescription) = httpError
print("error code: '\(errorCode)'. Error description: '\(errorDescription)'")

let (_, justErrorDescription) = httpError
print(justErrorDescription)

//Access tuple elements through their index value
print("The status code is: '\(httpError.0)'")
print("The error description is: '\(httpError.1)'")

//Tuple elements naming
let http200Ok = (statusCode: 200, description: "OK")
print("status code: '\(http200Ok.statusCode)'. Description: '\(http200Ok.description)'")

//: ## Optionals
let perhapsANumber = "123"
let optionalNumber = Int(perhapsANumber)
print(optionalNumber as Any)

/*:
 - note: Swift's `nil` isn't the same as `nil` in Objective-C where `nil` is a pointer to a nonexistent object. In Swift `nil` is the absence of value. Optionals of *any* type can be set to `nil`, not just object types.
 */

//: ### If Statements and Forced Unwrapping
// Forced unwrapping: !
if optionalNumber != nil {
    print(optionalNumber!)
}

//: ### Optional Binding
if let number = optionalNumber {
    print(number)
}

if var numberVar = optionalNumber {
    numberVar += 5
    print(numberVar)
}

//The following if statements are equivalent:
if let firstNumber = Int("4"),
    let secondNumber = Int("42"),
    firstNumber < secondNumber && secondNumber < 100
{
    print("\(firstNumber) < \(secondNumber) < 100")
}
// Prints "4 < 42 < 100"

if let firstNumber = Int("4") {
    if let secondNumber = Int("42") {
        if firstNumber < secondNumber && secondNumber < 100 {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}
// Prints "4 < 42 < 100"


//: ### Implicitly unwrapped optionals
let optString: String? = "an optional string"
let forcedString: String = optString!

let assumedString: String! = "an implicitly unwrapped optional"
let implicitString: String = assumedString
//You can still treat an implicitly unwrapped optional like a normal optional, to check if it contains a value:
if assumedString != nil {
    print(assumedString)
}

//You can also use an implicitly unwrapped optional with optional binding, to check and unwrap its value in a single statement:
if let definiteString = assumedString {
    print(definiteString)
}

let twoInts = (2,3)

let otpInt: Int? = nil
if otpInt == 2 {
    print("Is 2")
} else {
    print("NOT 2")
}


//: ## Error Handling
func canThrowAnError() throws {
    
}


do {
    try canThrowAnError()
} catch  {
    //an error was thrown
}

//: ## Assertion and Preconditions
/*:
 - note: precondition are evaluated both in debug & production builds. Unlike asserts  which are only evaluated in debug.
 */


//: ### Debugging with Assertion
let age = -3
//assert(age > 0, "age can not be negative")

if age > 10 {
    print("you can ride the roller-coaster")
} else if age >= 0 {
    print("you can ride the ferris wheel")
} else {
 //   assertionFailure("Negative age")
}
//: ### Enforcing Preconditions
//precondition(age >= 0, "age must be greater than 0")

/*:
 - note:
 If you compile in unchecked mode `-0unchecked`, preconditions aren't checked. The compiler assumes the preconditions are always true and optimizes the code accordingly. However, the `fatalError(_:file:line:)` function always halts excecution, regardless of optimization settings.
 You can use `fatalError(_:file:line:)` function during prototyping and early development to create stubs for functioanlity that hasn't been implemented yet, by writing `fatalError("Unimplemented")` as the stub implementation. You can be sure execution will halt if it encounters a stub implementation.
 */
//: [Next](@next)
