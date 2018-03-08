//: [Previous](@previous)
//: # Automatic Reference Counting
/*:
 Swift uses *Automatic Reference Counting* (ARC) to track and manage your app’s memory usage. In most cases, this means that memory management “just works” in Swift, and you do not need to think about memory management yourself. ARC automatically frees up the memory used by class instances when those instances are no longer needed.
 
 However, in a few cases ARC requires more information about the relationships between parts of your code in order to manage memory for you. This chapter describes those situations and shows how you enable ARC to manage all of your app’s memory
 
 Reference counting applies only to instances of classes. Structures and enumerations are value types, not reference types, and are not stored and passed by reference.
 */

//: ## How ARC Works
/*:
 Every time you create a new instance of a class, ARC allocates a chunk of memory to store information about that instance. This memory holds information about the type of the instance, together with the values of any stored properties associated with that instance.
 
 Additionally, when an instance is no longer needed, ARC frees up the memory used by that instance so that the memory can be used for other purposes instead. This ensures that class instances do not take up space in memory when they are no longer needed.
 
 However, if ARC were to deallocate an instance that was still in use, it would no longer be possible to access that instance’s properties, or call that instance’s methods. Indeed, if you tried to access the instance, your app would most likely crash.
 
 To make sure that instances don’t disappear while they are still needed, ARC tracks how many properties, constants, and variables are currently referring to each class instance. ARC will not deallocate an instance as long as at least one active reference to that instance still exists.
 
 To make this possible, whenever you assign a class instance to a property, constant, or variable, that property, constant, or variable makes a strong reference to the instance. The reference is called a “strong” reference because it keeps a firm hold on that instance, and does not allow it to be deallocated for as long as that strong reference remains.
*/

//: ## ARC in Action
class Person {
    let name: String
    init(name: String) {
        self.name = name
        print("\(name) person initialized")
    }
    
    deinit {
        print("\(name) person been deinitialized")
    }
}

var personReference1: Person?
var personReference2: Person?
var personReference3: Person?

personReference1 = Person(name: "john")
personReference2 = personReference1
personReference3 = personReference1

personReference1 = nil
personReference2 = nil

//: ARC does not deallocate the Person instance until the third and final strong reference is broken, at which point it’s clear that you are no longer using the Person instance:
personReference3 = nil


//: ## Strong Reference Cycles Between Class Instances
//: It’s possible to write code in which an instance of a class never gets to a point where it has zero strong references. This can happen if two class instances hold a strong reference to each other, such that each instance keeps the other alive. This is known as a *strong reference cycle*.
class PersonWithApartment {
    let name: String
    var apartment: Apartment?
    init(name: String) {
        self.name = name
        print("\(name) person initialized")
    }
    
    deinit {
        print("\(name) person been deinitialized")
    }
}

class Apartment {
    let unit: String
    var tenant: PersonWithApartment?
    
    init(unit: String) {
        self.unit = unit
        print("\(unit) apartment initialized")
    }
    
    deinit {
        print("\(unit) apartment been deinitialized")
    }
}

var john: PersonWithApartment?
var unit14A: Apartment?
john = PersonWithApartment(name: "Johnny")
unit14A = Apartment(unit: "4A")
john?.apartment = unit14A
unit14A?.tenant = john

john = nil
unit14A = nil

//: ## Resolving Strong Reference Cycles Between Class Instances
/*:
 Swift provides two ways to resolve strong reference cycles when you work with properties of class type: weak references and unowned references.

 Use a weak reference when the other instance has a shorter lifetime—that is, when the other instance can be deallocated first. In the `Apartment` example above, it’s appropriate for an apartment to be able to have no tenant at some point in its lifetime, and so a weak reference is an appropriate way to break the reference cycle in this case. In contrast, use an unowned reference when the other instance has the same lifetime or a longer lifetime.
 */
//: ### Weak References
/*:
 A *weak reference* is a reference that does not keep a strong hold on the instance it refers to, and so does not stop ARC from disposing of the referenced instance. This behavior prevents the reference from becoming part of a strong reference cycle. You indicate a weak reference by placing the `weak` keyword before a property or variable declaration.
 
 Because a weak reference does not keep a strong hold on the instance it refers to, it’s possible for that instance to be deallocated while the weak reference is still referring to it. Therefore, ARC automatically sets a weak reference to `nil` when the instance that it refers to is deallocated. And, because weak references need to allow their value to be changed to `nil` at runtime, they are always declared as variables, rather than constants, of an optional type.
 */
//: - Note: Property observers aren’t called when ARC sets a weak reference to `nil`.

//: The example below is identical to the `PersonWithApartment` and `Apartment` example from above, with one important difference. This time around, the Apartment type’s `tenant` property is declared as a weak reference:
class PersonWithApartmentWeak {
    let name: String
    var apartment: ApartmentWeak?
    init(name: String) {
        self.name = name
        print("\(name) person initialized")
    }
    
    deinit {
        print("\(name) person been deinitialized")
    }
}

class ApartmentWeak {
    let unit: String
    init(unit: String) { self.unit = unit }
    weak var tenant: PersonWithApartmentWeak?
    deinit { print("Apartment \(unit) is being deinitialized") }
}

var mary: PersonWithApartmentWeak?
var unit5B: ApartmentWeak?
mary = PersonWithApartmentWeak(name: "Mary")
unit5B = ApartmentWeak(unit: "5B")
mary?.apartment = unit5B
unit5B?.tenant = mary
mary = nil
unit5B = nil

//: - Note: In systems that use garbage collection, weak pointers are sometimes used to implement a simple caching mechanism because objects with no strong references are deallocated only when memory pressure triggers garbage collection. However, with ARC, values are deallocated as soon as their last strong reference is removed, making weak references unsuitable for such a purpose.

//: ### Unowned References
/*:
 Like a weak reference, an unowned reference does not keep a strong hold on the instance it refers to. Unlike a weak reference, however, an unowned reference is used when the other instance has the same lifetime or a longer lifetime. You indicate an unowned reference by placing the unowned keyword before a property or variable declaration.
 
 An unowned reference is expected to always have a value. As a result, ARC never sets an unowned reference’s value to nil, which means that unowned references are defined using nonoptional types.
 */

//: - Important: Use an unowned reference only when you are sure that the reference **always** refers to an instance that has not been deallocated. If you try to access the value of an unowned reference after that instance has been deallocated, you’ll get a runtime error.

/*:
 The following example defines two classes, `Customer` and `CreditCard`, which model a bank customer and a possible credit card for that customer. These two classes each store an instance of the other class as a property. This relationship has the potential to create a strong reference cycle.
 
 Because a credit card will always have a customer, you define its `customer` property as an unowned reference, to avoid a strong reference cycle:
 */
class Customer {
    let name: String
    var card: CreditCard?
    init(name: String) {
        self.name = name
    }
    deinit { print("\(name) is being deinitialized") }
}

class CreditCard {
    let number: UInt64
    unowned let customer: Customer
    init(number: UInt64, customer: Customer) {
        self.number = number
        self.customer = customer
    }
    deinit { print("Card \(number) is being deinitialized") }
}

var pablin: Customer?
pablin = Customer(name: "Pablin")
pablin?.card = CreditCard(number: 1234_5678_9012, customer: pablin!)
pablin = nil

/*: - Note:
 The examples above show how to use safe unowned references. Swift also provides unsafe unowned references for cases where you need to disable runtime safety checks—for example, for performance reasons. As with all unsafe operations, you take on the responsibility for checking that code for safety. You indicate an unsafe unowned reference by writing unowned(unsafe). If you try to access an unsafe unowned reference after the instance that it refers to is deallocated, your program will try to access the memory location where the instance used to be, which is an unsafe operation.
*/

//: ### Unowned References and Implicitly Unwrapped Optional Properties
//: There is a third scenario, in which both properties should always have a value, and neither property should ever be `nil` once initialization is complete. In this scenario, it’s useful to combine an unowned property on one class with an implicitly unwrapped optional property on the other class.

class Country {
    let name: String
    var capitalCity: City!
    
    init(name: String, capitalName: String) {
        self.name = name
        self.capitalCity = City(name: capitalName, country: self)
    }
}

class City {
    let name: String
    unowned let country: Country
    init(name: String, country: Country) {
        self.name = name
        self.country = country
    }
}

let pais = Country(name: "Argentina", capitalName: "CABA")
//: In the example above, the use of an implicitly unwrapped optional means that all of the two-phase class initializer requirements are satisfied. The capitalCity property can be used and accessed like a nonoptional value once initialization is complete, while still avoiding a strong reference cycle.

//: ## Strong Reference Cycles for Closures
/*:
 A strong reference cycle can also occur if you assign a closure to a property of a class instance, and the body of that closure captures the instance. This capture might occur because the closure’s body accesses a property of the instance, such as `self.someProperty`, or because the closure calls a method on the instance, such as `self.someMethod()`. In either case, these accesses cause the closure to “capture” `self`, creating a strong reference cycle.

 This strong reference cycle occurs because closures, like classes, are *reference types*. When you assign a closure to a property, you are assigning a *reference* to that closure.
 */

class HTMLElement {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

let heading = HTMLElement(name: "h1")
let defaultText = "some default text"
heading.asHTML = {
    return "<\(heading.name)>\(heading.text ?? defaultText)</\(heading.name)>"
}
print(heading.asHTML())

//: - Note: The `asHTML` property is declared as a lazy property, because it’s only needed if and when the element actually needs to be rendered as a string value for some HTML output target. The fact that `asHTML` is a lazy property means that you can refer to `self` within the default closure, because the lazy property will not be accessed until after initialization has been completed and `self` is known to exist.

var paragraph: HTMLElement? = HTMLElement(name: "p", text: "hello earth")
print(paragraph!.asHTML())
paragraph = nil //not deallocated due to strong self reference in asHTML property.

//: ## Resolving String Reference Cycles for Closures
//: You resolve a strong reference cycle between a closure and a class instance by defining a capture list as part of the closure’s definition. A capture list defines the rules to use when capturing one or more reference types within the closure’s body. As with strong reference cycles between two class instances, you declare each captured reference to be a weak or unowned reference rather than a strong reference.

//: ### Defining a Capture List
/*:
 Place the capture list before a closure’s parameter list and return type if they are provided:
 
    lazy var someClosure: (Int, String) -> String = {
        [unowned self, weak delegate = self.delegate!] (index: Int, stringToProcess: String) -> String in
        // closure body goes here
    }
 
 If a closure does not specify a parameter list or return type because they can be inferred from context, place the capture list at the very start of the closure, followed by the in keyword:
 
    lazy var someClosure: () -> String = {
        [unowned self, weak delegate = self.delegate!] in
        // closure body goes here
    }
 */

//: ### Weak and Unowned References
//: - Note: If the captured reference will never become `nil`, it should always be captured as an unowned reference, rather than a weak reference.

//: An unowned reference is the appropriate capture method to use to resolve the strong reference cycle in the HTMLElement example from earlier. Here’s how you write the HTMLElement class to avoid the cycle:
class HTMLElement2 {
    let name: String
    let text: String?
    
    lazy var asHTML: () -> String = {
        [unowned self] in
        if let text = self.text {
            return "<\(self.name)>\(text)</\(self.name)>"
        } else {
            return "<\(self.name) />"
        }
    }
    
    init(name: String, text: String? = nil) {
        self.name = name
        self.text = text
    }
    
    deinit {
        print("\(name) is being deinitialized")
    }
}

var paragraph2: HTMLElement2? = HTMLElement2(name: "p2", text: "hello earth 2")
print(paragraph2!.asHTML())
paragraph2 = nil
//: [Next](@next)
