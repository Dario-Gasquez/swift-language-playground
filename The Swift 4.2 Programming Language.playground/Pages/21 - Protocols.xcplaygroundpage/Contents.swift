//: [Previous](@previous)
//: # Protocols
//: A protocol defines a blueprint of methods, properties, and other requirements that suit a particular task or piece of functionality.

//: ## Protocol Syntax
import Foundation
protocol SomeProtocol {
        //protocol definition here
}

/*:
 Custom types state that they adopt a particular protocol by placing the protocol's name after the type's name, separated by a colon. Multiple protocols can be listed.
 
    struct SomeStruct: FirstProtocol, AnotherProtocol {
        //struct definition
    }

 If a class has a superclass, list the superclass name first before any protocols it adopts:
 
    class SomeClass: SuperClass, FirstProtocol, AnotherProtocol {
        //class defintion goes here
    }
 */

//: ## Property Requirements
//: A protocol can require for an instance or type property with a particular name and type. It does not specify if the property has to be stored or computed. It also specify if the property is gettable (read only) or gettable and writable.
protocol SampleProtocol {
    var mustBeSettable: Int { get set }
    var doesNotNeedToBeSettable: Int { get }
}

//: Type properties must be prefixed with `static`. This rules applies even though type properties can be prefixed with `class` or `static` keywords when implemeting a class.
protocol AnotherProtocol {
    static var someTypeProperty: Int { get set }
}

protocol FullyNamed {
    var fullName: String { get }
}

struct Person: FullyNamed {
    var fullName: String
}

let john = Person(fullName: "John Appleseed")

class Starship: FullyNamed {
    var prefix: String?
    var name: String
    
    init(name: String, prefix: String? = nil) {
        self.name = name
        self.prefix = prefix
    }
    
    var fullName: String {
        return (prefix != nil ? prefix! + " " : "") + name
    }
}

var ncc1701 = Starship(name: "Enterprise", prefix: "USS")

//: ## Method Requirements
/*:
 Protocols can require specific instance methods and type methods to be implemented by conforming types. Variadic parameters are allowed, subject to the same rules as for normal methods. Default values, however, can’t be specified for method parameters within a protocol’s definition.
 
As with type property requirements, you always prefix type method requirements with the static keyword when they’re defined in a protocol. This is true even though type method requirements are prefixed with the class or static keyword when implemented by a class:
*/
protocol SomeOtherProtocol {
    static func someTypeMethod()
}

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
        lastRandom = (lastRandom * a + c).truncatingRemainder(dividingBy: m)
        return lastRandom / m
    }
}

let generator = LinearCongruentialGenerator()
print("Here's a random number: \(generator.random())")
print("Add another one: \(generator.random())")

//: ## Mutating Method Requirements
//: If you define a protocol instance method requirement that is intended to mutate instances of any type that adopts the protocol, mark the method with the mutating keyword as part of the protocol’s definition. This enables structures and enumerations to adopt the protocol and satisfy that method requirement.
//: - Note: If you mark a protocol instance method requirement as mutating, you don’t need to write the mutating keyword when writing an implementation of that method for a class. The mutating keyword is only used by structures and enumerations.

protocol Togglable {
    mutating func toggle()
}

enum OnOffSwitch: Togglable {
    case off, on
    
    mutating func toggle() {
        switch self {
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}

var lightSwitch = OnOffSwitch.off
lightSwitch.toggle()

//: ## Initializer Requirements
//:Protocols can require specific initializers to be implemented by conforming types.
    protocol InitProtocol {
        init(someParameter: Int)
    }

//: ### Class Implementations of Protocol Initializer Requirements
//: It is possible to implement a protocol initializer requirement on a conforming class as a designated or convenience initializer. In both cases, you must mark the implementation with `required`
class SomeClass: SomeProtocol {
    required init(someParameter: Int) {
        //implementation here
    }
}
//: The use of `required` ensures an explicit or inherited implementation is provided on all subclasses of the confirming class, such that they conform to the protocol.
//: - Note: You don’t need to mark protocol initializer implementations with the `required` modifier on classes that are marked with the `final` modifier, because `final` classes can’t be subclassed.

//: If a subclass overrides a designated initializer for a superclass, and also implements a matching initializer requirement from a protocol, mark the initializer implementation with both the `required` and `override` modifiers:
protocol SmallProtocol {
    init()
}

class SomeSuperClass {
    init() {
        //implementation
    }
}

class SomeSubClass: SomeSuperClass, SmallProtocol {
    // required from SmallProtocol conformance and override from SomeSuperClass
    required override init() {
        //implementation
    }
}

//: ### Failable Initializer Requirements
/*:
 Protocols can define failable initializer requirements for conforming types.
 
 A failable initializer requirement can be satisfied by a failable or nonfailable initializer on a conforming type. A nonfailable initializer requirement can be satisfied by a nonfailable initializer or an implicitly unwrapped failable initializer.
*/

//: ## Protocols as Types
/*:
 Because it’s a type, you can use a protocol in many places where other types are allowed, including:
- As a parameter type or return type in a function, method, or initializer
- As the type of a constant, variable, or property
- As the type of items in an array, dictionary, or other container
 */

//: - Note: Because protocols are types, begin their names with a capital letter (such as FullyNamed and RandomNumberGenerator) to match the names of other types in Swift (such as Int, String, and Double).

//: ## Delegation
//: *Delegation* is a design pattern that enables a class or structure to hand off (or delegate) some of its responsibilities to an instance of another type. This design pattern is implemented by defining a protocol that encapsulates the delegated responsibilities, such that a conforming type (known as a delegate) is guaranteed to provide the functionality that has been delegated.


//: ## Adding Protocol Conformance with an Extension
//: You can extend an existing type to adopt and conform to a new protocol, even if you don’t have access to the source code for the existing type. Extensions can add new properties, methods, and subscripts to an existing type, and are therefore able to add any requirements that a protocol may demand.

protocol TextRepresentable {
    var textualDescription: String { get }
}


//: ### Conditionally Conforming to a Protocol
//:You can make a generic type conditionally conform to a protocol by listing constraints when extending the type. Write these constraints after the name of the protocol you’re adopting using a generic `where` clause.

// WARNING: will only compile with Swift 4.1 compiler (Xcode 9.3 or +)
extension Array: TextRepresentable where Element: TextRepresentable {
    var textualDescription: String {
        let itemsAsText = self.map { $0.textualDescription }
        return "[" + itemsAsText.joined(separator: ", ") + "]"
    }
}

//Swift 4.0 version
//extension Array where Element: TextRepresentable {
//    var textualDescription: String {
//        let textItems = self.map { $0.textualDescription }
//        return "[ \(textItems.joined(separator: ", ")) ]"
//    }
//}

//: ### Declaring Protocol Adoption with an Extension
//: If a type already conforms to all of the requirements of a protocol, but has not yet stated that it adopts that protocol, you can make it adopt the protocol with an empty extension:

struct Hamster {
    var name: String
    var textualDescription: String {
        return "A hamster named \(name)"
    }
}

extension Hamster: TextRepresentable {}

let simmonTheHamster = Hamster(name: "Simon")
let aTextRepresentable: TextRepresentable = simmonTheHamster
print(aTextRepresentable.textualDescription)

//: - Note: Types don't automatically adopt a protocol just by satisfying its requirements. They must always explicitly declare their adoption of the protocol.

//: ## Collections of Protocol Types
//: A protocol can be used as a collection type:
extension Int: TextRepresentable {
    var textualDescription: String {
        return String(self)
    }
}

let things: [TextRepresentable] = [simmonTheHamster, 5]
for thing in things {
    print(thing.textualDescription)
    if thing is Hamster { print("this thing is an animal") }
}

//: ## Protocol Inheritance
/*:
 A protocol can inherit one or more other protocols adding requirements in the process.

    protocol InheritingProtocol: SomeProtocol, AnotherProtocol {
        // additional definitions
    }
 */

protocol PrettyTextRepresentable: TextRepresentable {
    var prettyTextualRepresentation: String { get }
}

extension Hamster: PrettyTextRepresentable {
    var prettyTextualRepresentation: String {
        return "a pretty hamster named \(name)"
    }
}

simmonTheHamster.textualDescription
simmonTheHamster.prettyTextualRepresentation

//: ## Class-Only Protocols
/*:
Protocol adoption can be limited to class only by adding `AnyObject` to the inheritance list

    protocol AClassOnlyProtocol: AnyObject, SomeInheritedProtocol {
        //definition
    }
 */

//: - Note: Use a class-only protocol when the behavior defiend by that protocol's requirement assumes or requires that a conforming type has reference semantics rather than value semantics.


//: ## Protocol Composition
//: You can combine multiple protocols into a single requirement with a *protocol composition* using the `&` to combine the desired protocols. Protocol compositions behave as if you defined a temporary local protocol that has the combined requirements of all protocols in the composition. Protocol compositions don’t define any new protocol types.
protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}

struct Persona: Named, Aged {
    var name: String
    var age: Int
}

func wishHappyBirthday(to celebrator: Named & Aged) {
    print("happy birthday, \(celebrator.name), you're \(celebrator.age)!")
}

let birthdayPerson = Persona(name: "Malcom", age: 50)
wishHappyBirthday(to: birthdayPerson)

//: Protocol composition also allows the use of classes:
class Location {
    var latitude: Double
    var longitude: Double
    init(latitude: Double, longitude: Double) {
        self.latitude = latitude
        self.longitude = longitude
    }
}

class City: Location, Named {
    var name: String
    init(name: String, location: Location) {
        self.name = name
        super.init(latitude: location.latitude, longitude: location.longitude)
    }
}

func concert(in location: Location & Named) {
    print("hello \(location.name)")
}

let somewhere = City(name: "cityName", location: Location(latitude: 5.0, longitude: 10.4))
concert(in: somewhere)


//: ## Checking for Protocol Conformance
//: use of `is` and `as` can be applied to protocols as well.

protocol HasArea {
    var area: Double { get }
}

class Circle: HasArea {
    let pi = Double.pi
    var radius: Double
    var area: Double { return pi * radius * radius }
    init(radius: Double) { self.radius = radius }
    
}

class Country: HasArea {
    var name: String
    var area: Double
    init(name: String, area: Double) { self.name = name; self.area = area }
}

class Animal {
    var legs: Int
    init(legs: Int) { self.legs = legs }
}

let objects: [AnyObject] = [
    Circle(radius: 2.0),
    Country(name: "Zaraza Country", area: 243_610),
    Animal(legs: 3)
]

for object in objects {
    if let objectWithArea = object as? HasArea {
        print("Area is \(objectWithArea.area)")
        if objectWithArea is Country {
            print("Also a country: \((objectWithArea as! Country).name)")
        }
    } else {
        print("Something that does not have an area")
    }
}


//: ## Optional Protocol Requirements
//: Its possible to define *optional requirements* for protocols by prefixing them with `optional`. Both the protocol and the optional requirements must be marked with `@objc`.
//: - Note:  `@objc` protocols can be adopted only by classes that inherit from Objective-C classes or other @objc classes. They can’t be adopted by structures or enumerations.
@objc protocol CounterDataSource {
    @objc optional func increment(forCount count: Int) -> Int
    @objc optional var fixedIncrement: Int { get }
}

class Counter {
    var count = 0
    var dataSource: CounterDataSource?
    func increment() {
        if let amount = dataSource?.increment?(forCount: count) {
            count += amount
        } else if let amount = dataSource?.fixedIncrement {
            count += amount
        }
    }
}

class ThreeSource: NSObject, CounterDataSource {
    let fixedIncrement = 3
}

var counter = Counter()
counter.dataSource = ThreeSource()
for _ in 1...4 {
    counter.increment()
    print(counter.count)
}

//: ## Protocol Extensions
//: Protocols can be extended to provide method, initializer, subscript, and computed property implementations to conforming types. This allows you to define behavior on protocols themselves, rather than in each type’s individual conformance or in a global function.
extension RandomNumberGenerator {
    func randomBool() -> Bool {
        return random() > 0.5
    }
}

//: Now all types conforming to `RandomNumberGenerator` gain the protocol's extended functionality:
let boolGenerator = LinearCongruentialGenerator()
print("random number: \(boolGenerator.random())")
print("random bool: \(boolGenerator.randomBool())")

//: ### Providing Default Implementations
//: You can use protocol extensions to provide a default implementation to any method or computed property requirement of that protocol. If a conforming type provides its own implementation of a required method or property, that implementation will be used instead of the one provided by the extension.

extension PrettyTextRepresentable {
    var prettyTextualDescription: String {
        return textualDescription
    }
}

//: ### Adding Constraints to Protocol Extensions
//: When you define a protocol extension, you can specify constraints that conforming types must satisfy before the methods and properties of the extension are available. You write these constraints after the name of the protocol you’re extending using a generic `where` clause.
extension Collection where Element: Equatable {
    func allEqual() -> Bool {
        for element in self {
            if element != self.first { return false }
        }
        return true
    }
}

//: - Note: If a conforming type satisfies the requirements for multiple constrained extensions that provide implementations for the same method or property, Swift uses the implementation corresponding to the most specialized constraints.


//: [Next](@next)
