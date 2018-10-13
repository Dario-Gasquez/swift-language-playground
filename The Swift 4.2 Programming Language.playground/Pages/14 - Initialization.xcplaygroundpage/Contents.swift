//: [Previous](@previous)
//: # Initialization

//: ## Setting Initial Values for Stored Properties
//: Classes and structures instances need to set all their stored properties to an appropriate initial value. Stored properties can not be in an indetermined state.
//: - Note: when you assign a default value to a stored property, or set its initial value in an initializer, the value of that property is set without calling any property observers.

//: ### Initializers
// basic initializer example:
struct Fahrenheit {
    var temperature: Double
    init() {
        temperature = 32.0
    }
}

let fTemperature = Fahrenheit()
print("default Fahrenheit temperature: \(fTemperature.temperature)")

//: ### Default Property Values
//: A stored property's initial value can be set inside an initializer method as show before, or as a default value during definition as shown below:
struct Fahrenheit2 {
    var temperature = 32.0
}

//: ## Customizing Initialization

//: ### Initialization Parameters
//: Initialization parameters can be provided as part as the initializer's definition.

struct Celsius {
    var temperature: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperature = (fahrenheit - 32.0) / 1.8
    }
    
    init(fromKelvin kelvin: Double) {
        temperature = kelvin - 273.15
    }
}

let waterBoilingTemperatureCelsius = Celsius(fromFahrenheit: 212.0)
let waterFreezingTemperatureCelsius = Celsius(fromKelvin: 273.15)

//: ### Parameter Names and Argument Labels
//: Because init do not have a function name the names and types of an initializer’s parameters play a particularly important role in identifying which initializer should be called.

struct Color {
    let red, green, blue: Double
    
    init(red: Double, green: Double, blue: Double) {
        self.red = red
        self.green = green
        self.blue = blue
    }
    
    init(white: Double) {
        self.red = white
        self.green = white
        self.blue = white
    }
}

let blueColor = Color(red: 0, green: 0, blue: 1)
let whiteColor = Color(white: 1)


//: ### Initializer Parameters Without Argument Labels
//: - Note: If an argument label is not desired, use underscore (_)

struct CelsiusB {
    var temperature: Double
    
    init(fromFahrenheit fahrenheit: Double) {
        temperature = (fahrenheit - 32.0) / 1.8
    }
    
    init(_ celsius: Double) {
        temperature = celsius
    }
}

let bodyTemperature = CelsiusB(36.0)

//: ### Optional Property Types
//: - note: Optional properties are automatically assigned a nil value, if a value is not provided during initalization

class SurveyQuestion {
    var question: String
    var response: String?
    
    init(text: String) {
        self.question = text
    }
    
    func ask() {
        print(question)
    }
}

let cheeseQuestion = SurveyQuestion(text: "Do you like cheese?")
cheeseQuestion.ask()
print( String(describing: cheeseQuestion.response) )
cheeseQuestion.response = "Sure, I do!"
print( String(describing: cheeseQuestion.response) )

//: ### Assigning Constant Properties During Initialization
//: - note: A constant property can be assigned a value at any point during initialization but before the initialization finishes.

//: - note: For classes instances a constant can be modified during initalization only by the class that introduced it and not by a subclass.

class SurveyStaticQuestion {
    let question: String
    var answer: String?
    
    init(text: String) {
        self.question = text
    }
    
    func ask() {
        print(question)
    }
}

let wineQuestion = SurveyStaticQuestion(text: "Do you like wine?")
wineQuestion.ask()


//: ## Default Initializers
//: - note: Swift provides a default initializer for any structure or class that provides default values for all of its properties and does not provide at least one initializer itself. The default initializer simply creates a new instance with all of its properties set to their default values.

class ShoppingListItem {
    var name: String?
    var quantity = 1
    var purchased = true
}

var item = ShoppingListItem()

//: ### Memberwise Initializers for Structure Types
//: - note: Structure types receive automatic memberwise initializer if a custom initializer is not provided.

struct Size {
    var width = 0.0
    var height = 0.0
}

let twoByTwo = Size(width: 2.0, height: 2.0)


//: ## Initializer Delegation for Value Type
//: - note: Initializers can call other initializers to perform part of an instance’s initialization. This process, known as initializer delegation, avoids duplicating code across multiple initializers. There are differencies between value types (structs & enums) an class types.

//: - Note: If you want your value type to be initializable with the default initializer and memberwise initializer, and also with your own custom initializers, write your custom initializers in an extension rather than as part of the value type’s original implementation.

struct Point {
    var x = 0.0, y = 0.0
}

struct Rect {
    var origin = Point()
    var size = Size()
    
    init() {}
    
    init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
    
    init(center: Point, size: Size) {
        let originX = center.x - size.width / 2
        let originY = center.y - size.height / 2
        self.init(origin: Point(x: originX, y: originY), size: size)
    }
}

let zeroRect = Rect()
let originRect = Rect(origin: Point(x: 2.0, y: 2.0), size: Size(width: 10.0, height: 10.0))
let centerRect = Rect(center: Point(x: 1.0, y: 1.0), size: Size(width: 5.0, height: 5.0))


//: ## Class Inheritance and Initialization
/*:
 All of a class’s stored properties—including any properties the class inherits from its superclass—must be assigned an initial value during initialization.
\
 There are 2 kinds of class initializers: designated initializers and convenience initalizers.
*/

//: ### Designated Initializers and Convenience Initializers
/*:
 Designated initializers are the primary initializers for a class. A designated initializer fully initializes all properties introduced by that class and calls an appropriate superclass initializer to continue the initialization process up the superclass chain.
 \
 \
 Convenience initializers are secondary, supporting initializers for a class. You can define a convenience initializer to call a designated initializer from the same class as the convenience initializer with some of the designated initializer’s parameters set to default values.
 \
 \
 Every class must have at least one designated initializer. In some cases, this requirement is satisfied by inheriting one or more designated initializers from a superclass.
*/

//: ### Syntax for Desiganted and Convenience Initializers
/*:
Designated initializers for classes are written in the same way as simple initializers for value types:

    init (parameters) {
        statements
    }
*/
/*:
 Convenience initializers are written in the same style, but with the convenience modifier placed before the init keyword, separated by a space:
 
    convenience init(parameters) {
        statements
    }
*/


//: ### Initializer Delegation for Class Types
/*:
 To simplify the relationships between designated and convenience initializers, Swift applies the following three rules for delegation calls between initializers:
 
 **Rule 1**\
 A designated initializer must call a designated initializer from its immediate superclass.
 
 **Rule 2**\
 A convenience initializer must call another initializer from the same class.
 
 **Rule 3**\
 A convenience initializer must ultimately call a designated initializer.
 */

//: ### Two-Phase Initialization

//: ### Initializer Inheritance and Overriding
//: Unlike subclasses in Objective-C, Swift subclasses do not inherit their superclass initializers by default. Swift’s approach prevents a situation in which a simple initializer from a superclass is inherited by a more specialized subclass and is used to create a new instance of the subclass that is not fully or correctly initialized.
//: - Note: Superclass initializers are inherited in certain circumstances, but only when it is safe and appropriate to do so.

//: - Note: You always write the `override` modifier when overriding a superclass designated initializer, even if your subclass’s implementation of the initializer is a convenience initializer.
/*:
 Conversely, if you write a subclass initializer that matches a superclass convenience initializer, that superclass convenience initializer can never be called directly by your subclass, as per the rules described above in Initializer Delegation for Class Types. Therefore, your subclass is not (strictly speaking) providing an override of the superclass initializer. As a result, you do not write the override modifier when providing a matching implementation of a superclass convenience initializer.
*/

class Vehicle {
    var numberOfWheels: Int
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
    
    init() {
        numberOfWheels = 0
        print(self.description)
    }
}

/*:
 The Vehicle class provides a default value for its only stored property, and does not provide any custom initializers itself. As a result, it automatically receives a default initializer, as described in Default Initializers. The default initializer (when available) is always a designated initializer for a class, and can be used to create a new Vehicle instance with a numberOfWheels of 0:
 */
let vehicle = Vehicle()
//print("Vehicle: \(vehicle.description)")

class Bicycle: Vehicle {
    override init() {
        super.init()
        numberOfWheels = 2
    }
}

let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")

//: - Note: Subclasses can modify inherited variable properties during initialization, but can not modify inherited constant properties.


//: ### Automatic Initializer Inheritance

//: ### Designated and Convenience Initializers in Action

class Food {
    var name: String
    
    init(name: String) {
        self.name = name
    }
    
    convenience init() {
        self.init(name: "[Unnamed]")
    }
}

let namedMeat = Food(name: "Bacon")
let mysteryMeat = Food() //calls the convenience initializer which in turn calls the designated initializer

class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) {
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {
        self.init(name: name, quantity: 1)
    }
}

let oneMysteryItem = RecipeIngredient()
let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Egg", quantity: 6)

class ShoppingListItemB: RecipeIngredient {
    var purchased = false
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " v" : " x"
        return output
    }
}

var breakfastList = [ShoppingListItemB(), ShoppingListItemB(name: "Bacon"), ShoppingListItemB(name: "Egg", quantity: 12)]
breakfastList[0].name = "Orange"
breakfastList[0].purchased = true

for item in breakfastList {
    print(item.description)
}

//: ## Failable Initializers
/*:
 It is sometimes useful to define a class, structure, or enumeration for which initialization can fail. This failure might be triggered by invalid initialization parameter values, the absence of a required external resource, or some other condition that prevents initialization from succeeding.
 
 To cope with initialization conditions that can fail, define one or more failable initializers as part of a class, structure, or enumeration definition. You write a failable initializer by placing a question mark after the init keyword (`init?`).
 */

struct Animal {
    let species: String
    init?(species: String) {
        if species.isEmpty { return nil }
        self.species = species
    }
}

let someGiraffe = Animal(species: "Giraffe")

if let giraffe = someGiraffe {
    print("an animal with species: \(giraffe.species)")
}

let anonymousAnimal = Animal(species: "")
if anonymousAnimal == nil {
    print("the anonymous animal could not be initialzied.")
}

//: ### Failable Initializers for Enumerations
enum TemperatureUnit {
    case kelvin, celsius, fahrenheit
    
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = .kelvin
        case "C":
            self = .celsius
        case "F":
            self = .fahrenheit
        default:
            return nil
        }
    }
}

let fahrenheitUnit = TemperatureUnit(symbol: "F")
if fahrenheitUnit != nil {
    print("succesfully initialiez a valid temperature unit")
}

let unknownUnit = TemperatureUnit(symbol: "X")
if unknownUnit == nil {
    print("This is not a valid temperature unit")
}

//: ### Failable Initializers for Enumerations with Raw Values
enum RawTemperatureUnit: Character {
    case kelvin = "K"
    case celsius = "C"
    case fahrenheit = "F"
}

let fUnit = RawTemperatureUnit(rawValue: "F")
if fUnit != nil {
    print("Valid temperature unit")
}

let xUnit = RawTemperatureUnit(rawValue: "X")
if xUnit == nil {
    print("not a valid unit")
}

//: ### Propagation of Initilization Failure
/*:
 A failable initializer of a class, structure, or enumeration can delegate across to another failable initializer from the same class, structure, or enumeration. Similarly, a subclass failable initializer can delegate up to a superclass failable initializer.
 
 In either case, if you delegate to another initializer that causes initialization to fail, the entire initialization process fails immediately, and no further initialization code is executed.
 */

class Product {
    let name: String
    
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

class CarAccesory: Product {
    let quantity: Int
    
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }
        self.quantity = quantity
        super.init(name: name)
    }
}

if let twoSocks = CarAccesory(name: "sock", quantity: 2) {
    print("Item: \(twoSocks.name), quantity: \(twoSocks.quantity)")
}

if let zeroShirts = CarAccesory(name: "shirt", quantity: 0) {
    print("Item: \(zeroShirts.name), quantity: \(zeroShirts.quantity)")
} else {
    print("unable to initialize zero shirts")
}

if let oneNotName = CarAccesory(name: "", quantity: 1) {
    print("Item: \(oneNotName.name), quantity: \(oneNotName.quantity)")
} else {
    print("unable to initialize oneNotName")
}

//: ### Overriding a Failable Initializer
/*:
 You can override a superclass failable initializer in a subclass, just like any other initializer. Alternatively, you can override a superclass failable initializer with a subclass *nonfailable* initializer. This enables you to define a subclass for which initialization cannot fail, even though initialization of the superclass is allowed to fail.
 
 Note that if you override a failable superclass initializer with a nonfailable subclass initializer, the only way to delegate up to the superclass initializer is to force-unwrap the result of the failable superclass initializer.
 */

//: - Note: You can override a failable initializer with a nonfailable initializer but not the other way around.

class Document {
    var name: String?
    
    init() {}
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}

let document = Document()
document.name

class AutoNamedDocument: Document {
    override init() {
        super.init()
        name = "[Unnamed]"
    }
    
    override init?(name: String) {
        super.init()
        if name.isEmpty {
            self.name = "[Unnamed]"
        } else {
            self.name = name
        }
    }
}

//: Forced unwrapping can be used on a failable initializer if you are sure it want return nil:
class UntitledDocument: Document {
    override init() {
        super.init(name: "[Untitled]")!
    }
}

let untitledDoc = UntitledDocument()
print(untitledDoc.name!)

//: ### The init! Failable Initializer
/*:
 You typically define a failable initializer that creates an optional instance of the appropriate type by placing a question mark after the *init* keyword (*init?*). Alternatively, you can define a failable initializer that creates an implicitly unwrapped optional instance of the appropriate type. Do this by placing an exclamation mark after the *init* keyword (*init!*) instead of a question mark.
 
 You can delegate from *init?* to *init!* and vice versa, and you can override *init?* with *init!* and vice versa. You can also delegate from *init* to *init!*, although doing so will trigger an assertion if the *init!* initializer causes initialization to fail.
 */

//: ## Required Initializers
//: Write the *required* modifier before the definition of a class initializer to indicate that every subclass of that class **must** implement that initializer:
class SomeClass {
    var value: Double
    required init() {
        value = 5
    }
}
//: - Note: You do not have to provide an explicit implementation of a required initializer if you can satisfy the requirement with an inherited initializer.

class SubClass: SomeClass {
    init(name: String) {
        print(name)
    }
    
    required init() {
    }
}

let instance = SubClass()
print(instance.value)

//: ## Setting a Default Property Value with a Closure or Function
//: If a stored property’s default value requires some customization or setup, you can use a closure or global function to provide a customized default value for that property.
//: Here is a skeleton outline of how a closure can be used to provide a default value:
class AClass {
    let someProperty: Int = {
       return 5
    }()
    
}

let anObject = AClass()
print(anObject.someProperty)

//: - Note: If you use a closure to initialize a property, remember that the rest of the instance has not yet been initialized at the point that the closure is executed. This means that you cannot access any other property values from within your closure, even if those properties have default values. You also cannot use the implicit self property, or call any of the instance’s methods.

struct Chesboard {
    let boardColors: [Bool] = {
        var temporaryBoard = [Bool]()
        var isBlack = false
        for i in 1...8 {
            for j in 1...8 {
                temporaryBoard.append(isBlack)
                isBlack = !isBlack
            }
        }
        return temporaryBoard
    }()
    
    func squareIsBlackAt(row: Int, column: Int) -> Bool {
        return boardColors[(row * 8) + column]
    }
}

let board = Chesboard()
print(board.squareIsBlackAt(row: 0, column: 1))
print(board.squareIsBlackAt(row: 7, column: 7))
//: [Next](@next)
