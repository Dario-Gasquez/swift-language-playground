//: [Previous](@previous)

//: # Properties
/*:
 - note: Stored Properties are provided by: classes and structures. Computed Properties are provided by: classes, structures and enumerations
 */

//: ## Stored Properties
struct FixedLengthRange {
    var firstValue: Int
    let length: Int
}

var rangeOfThree = FixedLengthRange(firstValue: 0, length: 3)
rangeOfThree.firstValue = 6


//: ### Stored Properties of Constant Structure Instances
let rangeOfFour = FixedLengthRange(firstValue: 0, length: 4)

//This line reports and error because even though the 'firstValue' property is a var, it cannot be modified due to 'rangeOfFour' been a constant (let)
//rangeOfFour.firstValue = 5
print(rangeOfFour)
/*:
 - note: This behavior is due to structures being value types. When an instance of a value type is marked as a constant, so are all of its properties. The same is not true for classes, which are reference types. If you assign an instance of a reference type to a constant, you can still change that instance’s variable properties.
 */

//: ### Lazy Stored Properties
/*:
 - note: a lazy stored properties is a property whose initial value is not calculated until the first time it is used. You must always declare a lazy property as a variable (with the var keyword), because its initial value might not be retrieved until after instance initialization completes. Constant properties must always have a value before initialization completes, and therefore cannot be declared as lazy.
 */

class DataImporter {
    var filename = "data.txt"
}

class DataManager {
    lazy var importer = DataImporter()
    var data = [String]()
}

let manager = DataManager()
manager.data.append("Some data")
manager.data.append("Some more data")

print("manager importer filename: \(manager.importer.filename)")

/*:
 - Important: If a lazy property is accessed by multiple threads simultaneously and the property has not yet been initialized, there is no guarantee that the property will be initialized only once.
 */

//: ## Computed Properties
struct Point {
    var x = 0.0, y = 0.0
}

struct Size {
    var width = 0.0, height = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    var center: Point {
        get {
            let centerX = origin.x + size.width/2
            let centerY = origin.y + size.height/2
            return Point(x: centerX, y: centerY)
        }
        set(newCenterValue) {
            origin.x = newCenterValue.x - size.width/2
            origin.y = newCenterValue.y - size.height/2
        }
    }
}

var square = Rect(origin: Point(x: 0.0, y:0.0), size: Size(width: 10.0, height: 10.0))

let initialSquareCenter = square.center
square.center = Point(x: 10.5, y: 10.5)
print("initial center: \(initialSquareCenter)")
print("new center: \(square.center)")

//: ### Read-Only Computed Properties
/*:
 - note: Read-Only Computed Properties contain a getter but not a setter method. All computed properties must be declared as var, because their values is not fixed (constant).
 */

//Simplifed read-only property (volume) without get keyword and its braces
struct Cuboid {
    var width = 0.0, height = 0.0, depth = 0.0
    var volume: Double {
        return width * height * depth
    }
}


//: ## Property Observers
class StepCounter {
    var totalSteps: Int = 0 {
        willSet(newTotalSteps) {
            print("About to set totalSteps to \(newTotalSteps)")
        }
        didSet {
            if totalSteps > oldValue {
                print("Added \(totalSteps - oldValue) steps")
            }
        }
    }
}

let stepCounter = StepCounter()
stepCounter.totalSteps = 200
stepCounter.totalSteps = 360
//: ## Global and Local Variables
/*:
 - note: Global constants and variables are always computed lazily, in a similar manner to Lazy Stored Properties. Unlike lazy stored properties, global constants and variables do not need to be mareked with the 'lazy' keyword. Local constants and variables are never computed lazily.
 */


//: ## Type Properties
/*:
 - note: Unlike stored instance properties, stored type properties must always have a default value. This is because the type itself does not have an initializer that can assign a value to a stored type property at initialization time. Stored type properties are lazily initialized on their first access. They are guaranteed to be initialized only once, even when accessed by multiple threads at the same time, and they do not need to be marked with the 'lazy' modifier.
 */

//: ### Type Property Syntax
// Use the 'static' keyword to define a type property. For computed properties the 'class' keyword can be used instead to give subclasses the change to override the superclass's implementation.

struct SomeStructure {
    static var storedTypeProperty = "Default struct property value"
    static var computedProperty: Int {
        return 1
    }
}

struct SomeEnumeration {
    static var storedTypeProperty = "default enum property value"
    static var computedTypeProperty: Int {
        return 6
    }
}

class SomeClass {
    static var storedProp = "default class property value"
    static var computedProperty: Int {
        return 15
    }
    
    class var overridableComputedProperty: Int {
        return 25
    }
}

//: - Note: The computed type properties defined above are read-only, but they could by read-write like the computed instance properties by adding setters.

//: [Next](@next)
