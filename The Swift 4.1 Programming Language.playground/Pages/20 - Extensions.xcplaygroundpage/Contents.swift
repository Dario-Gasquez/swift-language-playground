//: [Previous](@previous)
//: # Extensions
//: Extensions add new functionality to an existing class, structure, enumeration, or protocol type. This includes the ability to extend types for which you do not have access to the original source code (known as retroactive modeling). Extensions are similar to categories in Objective-C. (Unlike Objective-C categories, Swift extensions do not have names.)
//: - Note: Extensions can add new functionality to a type, but they cannot override existing functionality.

//: ## Extension Syntax
/*:
 
    extension SomeType {
        // new functionality
    }
*/
/*:
 An extension can make an existing type addopt one or more protocols.
 
    extension SomeType: SomeProtocol, AnotherProtocol {
        //protocols requirements implementation
    }
*/
//: - Note: an extension that adds functionality to an existing type will affect all existing instances of that type even if they were instantiated before the exension was defined.

//: ## Computed Properties
//: Extensions can add computed instance and computed type properties.
extension Double {
    var km: Double { return self * 1_000.0 }
    var m: Double { return self }
    var cm: Double  { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}

let oneInch = 25.4.mm
print("one inch is \(oneInch) meters")

let threeFeet = 3.ft
print("three feet is \(threeFeet) meters")

let aMarathon = 42.km + 195.m
print("A marathon is \(aMarathon) meters long")
//: - Note: Extensions can add new computed properties, but they cannot add stored properties, or add property observers to existing properties.

//: ## Initializers
//: Extensions can add new convenience initializers to a class, but they cannot add new designated initializers or deinitializers to a class. Designated initializers and deinitializers must always be provided by the original class implementation.
//: - Note: If you use an extension to add an initializer to a value type that provides default values for all of its stored properties and does not define any custom initializers, you can call the default initializer and memberwise initializer for that value type from within your extension’s initializer.
struct Size {
    var width = 0.0
    var height = 0.0
}

struct Point {
    var x = 0.0
    var y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
}

extension Rect {
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let centerRect = Rect.init(center: Point(x: 4.0, y: 4.0), size: Size(width: 3.0, height: 3.0))
//: - Note: If you provide a new initializer with an extension, you are still responsible for making sure that each instance is fully initialized once the initializer completes.

//: ## Methods
//: Extension can add both instance and type methods.
extension Int {
    func repetitions(task: () -> Void) {
        for _ in 0..<self {
            task()
        }
    }
}

3.repetitions {
    print("hello")
}

//: ### Mutating Instance Methods
//: Instance methods added with an extension can also modify (or *mutate*) the instance itself. Structure and enumeration methods that modify `self` or its properties must mark the instance method as `mutating`, just like mutating methods from an original implementation.
extension Int {
    mutating func square() {
        self = self * self
    }
}
var someInt = 3
someInt.square()

//: ## Subscripts
//: Extension can add new subscripts to an existing type. See example below:

extension Int {
    subscript(digitIndex: Int) -> Int {
        var decimalBase = 1
        for _ in 0..<digitIndex {
            decimalBase *= 10
        }
        return (self / decimalBase) % 10
    }
}

64123890[0]
64123890[1]
64123890[5]

//: If the `Int` value does not have enough digits it returns 0 as if the number was padded to the left with zeros.
64123890[9]

//: ## Nested Types
//: Extension can add nested types to classes, structures and enumerations:
extension Int {
    enum Kind {
        case negative, zero, positive
    }

    var kind: Kind {
        switch self {
        case let x where x > 0:
            return .positive
        case let x where x < 0:
            return .negative
        default:
            return .zero
        }
    }
}


func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        }
    }
    print("")
}

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])

//: [Next](@next)
