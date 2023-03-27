//: [Previous](@previous)
//: # Optional Chaining
//: *Optional Chaining* is a process for querying and calling properties, methods and subscripts on an optional that might currently be `nil`. If the optional contains a value, the property, method or subscript call succeeds; if the optional is `nil`, the property, method or subscripts returns `nil`.

//: ## Optional Chaining as an Alternative to Forced Unwrapping
//: The next several code snippets demonstrate how optional chaining differs from forced unwrapping and enables you to check for success.

class Person {
    var residence: Residence?
}

class Residence {
    var numberOfRooms = 1
}

let john = Person()

// Triggers a runtime error because residence == nil
//let roomCourt = john.residence!.numberOfRooms

//: Optional chaining provides a non crashing alternative
if let roomCourt = john.residence?.numberOfRooms {
    print("John's residence has \(roomCourt) room(s)")
} else {
    print("Unable to retrieve the number of rooms")
}

//: ## Defining Model Classes for Optional Chaining
//: You can use optional chaining with calls to properties, methods, and subscripts that are more than one level deep. This enables you to drill down into subproperties within complex models of interrelated types, and to check whether it is possible to access those subproperties.
class PersonBeta {
    var residence: ResidenceBeta?
}

class ResidenceBeta {
    var rooms = [Room]()
    
    var numberOfRooms: Int {
        return rooms.count
    }
    
    subscript(i: Int) -> Room {
        get {
            return rooms[i]
        }
        set {
            rooms[i] = newValue
        }
    }
    
    func printNumberOfRooms() {
        print("The number of rooms is \(numberOfRooms)")
    }
    
    var address: Address?
}

class Room {
    let name: String
    init(name: String) { self.name = name }
}

class Address {
    var buildingName: String?
    var buildingNumber: String?
    var street: String?
    
    func buildingIdentifier() -> String? {
        if let buildingNr = buildingNumber, let streetName = street {
            return "\(buildingNr) \(streetName)"
        } else if buildingName != nil {
            return buildingName
        } else {
            return nil
        }
    }
}

//: ## Accessing Properties Through Optional Chaining
let mary = PersonBeta()
if let roomCount = mary.residence?.numberOfRooms {
    print("Mary's residence has \(roomCount) room(s)")
} else {
    print("Unable to retrieve the number of rooms")
}

let someAddress = Address()
someAddress.buildingNumber = "29"
someAddress.street = "Acacia Road"
mary.residence?.address = someAddress

func createAddress() -> Address {
    print("Function was called")
    
    let someAddress = Address()
    someAddress.buildingNumber = "29"
    someAddress.street = "Acacia Road"
    
    return someAddress
}

mary.residence?.address = createAddress()

//: ## Calling Methods Through Optional Chaining
if mary.residence?.printNumberOfRooms() != nil {
    print("It was possible to print the number of rooms")
} else {
    print("It was not possible to print the number of rooms.")
}

if (mary.residence?.address = someAddress) != nil {
    print("It was possible to assign an address")
} else {
    print("It was not possible to assign an address.")
}

//: ## Accessing Subscripts Through Optional Chaining
//: - Note: When you access a subscript on an optional value through optional chaining, you place the question mark before the subscript’s brackets, not after. The optional chaining question mark always follows immediately after the part of the expression that is optional.

if let firstRoomName = mary.residence?[0].name {
    print("The first room name is \(firstRoomName)")
} else {
    print("Unable to retrieve the first room name.")
}

mary.residence?[0] = Room(name: "Bathroom") //This fails because residence is nil

let marysHouse = ResidenceBeta()
marysHouse.rooms.append(Room(name: "Living Room"))
marysHouse.rooms.append(Room(name: "Kitchen"))
mary.residence = marysHouse

if let firstRoomName = mary.residence?[0].name {
    print("The first room name is \(firstRoomName)")
}  else {
    print("Unable to retrieve the first room name")
}

//: ### Accesing Subscripts of Optional Type
//: If a subscript returns a value of optional type—such as the key subscript of Swift’s Dictionary type—place a question mark after the subscript’s closing bracket to chain on its optional return value:

var testScores = ["Dave": [86, 82, 84], "Bev": [79, 94, 81]]
testScores["Dave"]?[0] = 91
testScores["Bev"]?[0] += 1
testScores["Brian"]?[0] = 72

//: ## Linking Multiple Levels of Chaining
if let maryStreet = mary.residence?.address?.street {
    print("Mary's street name is: \(maryStreet)")
} else {
    print("Unable to retrieve the address")
}

let maryAddress = Address()
maryAddress.buildingName = "The Larches"
maryAddress.street = "Laurel Street"
mary.residence?.address = maryAddress

if let maryStreet = mary.residence?.address?.street {
    print("Mary's street name is \(maryStreet)")
} else {
    print("Unable to retrieve the address")
}

//: ## Chaining on Methods with Optional Return Values
//: You can also use optional chaining to call a method that returns a value of optional type, and to chain on that method’s return value if needed.

if let buildingIdentifier = mary.residence?.address?.buildingIdentifier() {
    print("Mary's building identifier is \(buildingIdentifier)")
}

if let beginsWithThe = mary.residence?.address?.buildingIdentifier()?.hasPrefix("The") {
    if beginsWithThe {
        print("Mary's building id. begins with \"The\".")
    } else {
        print("Mary's building id. DOES NOT begins with \"The\".")
    }
}

//: - Note: In the example above, you place the optional chaining question mark after the parentheses, because the optional value you are chaining on is the buildingIdentifier() method’s return value, and not the buildingIdentifier() method itself.

//: [Next](@next)
