//: [Previous](@previous)

class Person {
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
    weak var tenant: Person?
    
    init(unit: String) {
        self.unit = unit
        print("\(unit) apartment initialized")
    }
    
    deinit {
        print("\(unit) apartment been deinitialized")
    }
}

var person:Person? = Person(name: "john")
var apartment: Apartment? = Apartment(unit: "10-A")

person!.apartment = apartment
apartment!.tenant = person

person = nil

//: ### Unowned References and Implicitly Unwrapped Optional Properties
class Country {
    let name: String
    var capitalCity: City?
    
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

let Argentina = Country(name: "Argentina", capitalName: "CABA")

//: [Next](@next)
