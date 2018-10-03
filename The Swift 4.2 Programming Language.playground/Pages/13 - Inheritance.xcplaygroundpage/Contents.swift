//: [Previous](@previous)
//: # Inheritance
//: ## Defining a Base Class
//: - note: Swift classes do not inherit from a universal base class.

class Vehicle {
    var currentSpeed = 0.0
    var description: String {
        return "this vehicle is going at: \(currentSpeed) Km/h."
    }
    
    func makeNoise() {
        
    }
}

let aGenericVehicle = Vehicle()
aGenericVehicle.currentSpeed = 120.0
print ("Vehicle: \(aGenericVehicle.description)")

//: ## Subclassing
class Bicycle: Vehicle {
    var hasBasket = false
    
    override func makeNoise() {
        print("squeech...squeech...squeech")
    }
}

let aBike = Bicycle()
aBike.currentSpeed = 10.0
print("I'm driving my bike: \(aBike.description)")
aBike.makeNoise()

//: ## Overriding
//: - note: A subclass can override: instance methods, type/class methods, instance property, type property or subscript. Make the intention to override explicit using the *override* keyword.

//: ### Accessing Superclass Methods, Properties and Subscripts
/*:
 - note: access a superclass implementation using the *super* keyword:
 - super.someMethod()
 - super.someProperty
 - super[anIndex]
 */

//: ### Overriding Methods
class Train: Vehicle {
    override func makeNoise() {
        print("choo.. chooo")
    }
}

let aTrain = Train()
aTrain.makeNoise()

//: ### Overriding Properties
//: #### Overriding Property Getters and Setters
//: - note: A subclass does not know if a certain inherited property is stored or computed, only its name and type.

class Car: Vehicle {
    var gear = 1
    override var description: String {
        return super.description + " in gear \(gear)"
    }
}

let myCar = Car()
myCar.currentSpeed = 140.5
myCar.gear = 5
print("Car: \(myCar.description)")

//: #### Overriding Property Observers
//: - note: propery overriding can be used to add observers to an inherited property, regardless if that property had observers or not.

class AutomaticCar: Car {
    override var currentSpeed: Double {
        didSet {
            gear = Int(currentSpeed / 30.0) + 1
        }
    }
}

let automaticCar = AutomaticCar()
automaticCar.currentSpeed = 130.0
print("Auto Car: \(automaticCar.description)")

//: ### Preventing Overrides
//: - note: You can prevent a method override by marking it with the *final* keyword, before the method, property or subscript, for example: *final var*, *final func*, *final class func* and *final subscript*

//: - note: A class can also be marked as final, thus preventing any subclassing attempt.

//: [Next](@next)
