//: [Previous](@previous)
//: # Enumerations
/*:
 - note: An enum case value is not mandatory (unlike C enums that have an integer value). A Swift's enum value, when available, is named **raw value**. A raw value can be a string, a character, or a value of any integer or floating-point type.
    Alternatively, enumerations cases can specify associated values of **any** type to be stored along with each different case, similar to union or variants in other languages.*/
/*:
 - note: Enumerations are first-class types, adopting features usually available for classes such as: computed properties or instance methods. */

enum CompassPoint {
    case north
    case south
    case east
    case west
}

var directionToHead = CompassPoint.west
directionToHead = .east


//: ## Associated Values

enum Barcode {
    case upc(Int, Int, Int, Int)
    case qrCode(String)
}

var upcProductBarcode = Barcode.upc(8, 85906, 51226, 3)
var qrProductBarcode = Barcode.qrCode("qwer1234")

// extracting associated values (as constants or variables) with let or var

switch upcProductBarcode {
case .upc(let numberSystem, let manufacturer, let product, let check):
    print("UPC: \(numberSystem) -- \(manufacturer + 1) -- \(product) -- \(check)")
case .qrCode(let code):
    print("QR code: \(code)")
}

//: ## Raw Values
/*:
 - note: As an alternative to associated values, enumeration cases can contain a default value (same type for all cases) to be used as a default value, these are called **raw values**. */

enum ASCIIControlCharacter: Character {
    case tab = "\t"
    case lineFeed = "\n"
    case carriegeReturn = "\r"
}


/*:
 - note: Raw values are not the same as associated values. Raw values are set to prepopulated values when you first define the enumeration in your code, like the three ASCII codes above. The raw value for a particular enumeration case is always the same. Associated values are set when you create a new constant or variable based on one of the enumeration’s cases, and can be different each time you do so. */

//: ### Implicitly assigned raw value
// When storing string or integer values, there is no need to assing explicit values for each case.

enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

enum CompassPointString: String {
    case north, south, east, west
}

let thirdRock = Planet.earth
print("planet \(thirdRock) raw value is: \(thirdRock.rawValue)")

let east = CompassPointString.east
print("heading: \(east) raw: \(east.rawValue)")


//: ### Initializing from Raw Value
let planetFromRawValue = Planet(rawValue: 5)
print("planetFromRawValue: \(String(describing: planetFromRawValue))")


//: ## Recursive Enumerations
/*:
 - note: A recursive enumeration is an enumeration that has another instance of the enumeration as the associated value for one or more of the enumeration cases. You indicate that an enumeration case is recursive by writing indirect before it, which tells the compiler to insert the necessary layer of indirection.*/
enum ArithmeticExpresion {
    case number(Int)
    indirect case addition(ArithmeticExpresion, ArithmeticExpresion)
    indirect case multiplication(ArithmeticExpresion, ArithmeticExpresion)
}

// (5 + 2) * 4
let five = ArithmeticExpresion.number(5)
let two = ArithmeticExpresion.number(2)
let sum = ArithmeticExpresion.addition(five, two)
let four = ArithmeticExpresion.number(4)
let product = ArithmeticExpresion.multiplication(sum, four)

//: [Next](@next)
