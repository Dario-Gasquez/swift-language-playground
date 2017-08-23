//: # The Basics

import Foundation

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


//: ### Type Aliases
typealias AudioSample = UInt16
let audioSample = AudioSample.max


//: ### Tuples
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

//: ### Optionals
let perhapsANumber = "123"
let optionalNumber = Int(perhapsANumber)
print(optionalNumber)

// Forced unwrapping: !
if optionalNumber != nil {
    print(optionalNumber!)
}

// Optional binding
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

if let firstNumber = Int("4")
{
    if let secondNumber = Int("42")
    {
        if firstNumber < secondNumber && secondNumber < 100
        {
            print("\(firstNumber) < \(secondNumber) < 100")
        }
    }
}
// Prints "4 < 42 < 100"


// Implicitly unwrapped optionals -----
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
//: ### Assertion and Preconditions
/*:
 - note: precondition are evaluated both in debug & production builds. Unlike asserts  which are only evaluated in debug.
 */

let age = -3
//assert(age > 0, "age can not be negative")
precondition(age >= 0, "age must be greater than 0")


//: [Next](@next)
