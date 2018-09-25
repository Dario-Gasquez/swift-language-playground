//: [Previous](@previous)

//: # Collection Types
//: ## Mutability of Collections
/*:
  A collection assigned to a variable is *mutable*, on the other hand asigning it to a constant will render it *inmutable*
 */

//: ## Arrays
/*:
 Swift's `Array` is bridged to Foundation's `NSArray` class
 */
//These 2 arrays are equivalent
let anIntArray: Array<Int> = [1, 2, 3, 4]
let anotherIntArray: [Int] = [1, 2, 3, 4]
anotherIntArray.count

let filtered = anotherIntArray.filter { $0 % 2 == 0 }
print(filtered)

func getArray() -> [Int] {
    return anIntArray
}

var testarray = getArray()
testarray.append(5)

print(anIntArray)
print(anotherIntArray)
print(testarray)

class Person {
    let name: String
    let age: Int
    var gender: String?
    init(name: String, age: Int) {
        self.name = name
        self.age = age
    }
}

let personArray: [Person] = [Person(name: "Maria", age:20), Person(name: "John", age: 15), Person(name: "Ana", age: 35)]
let sortedArray = personArray.sorted { $0.name < $1.name }
for person in sortedArray {
    print("\(person.name) is \(person.age) old")
}

for person in personArray {
    print("\(person.name) is \(person.age) old and gender \(String(describing: person.gender))")
}

personArray[0].gender = "Female"

for person in personArray {
    print("\(person.name) is \(person.age) old and gender \(String(describing: person.gender))")
}

//: ### Creating an empty array
var someInts = [Int]()

//: ### Creating an array with a Default Value
let fivesDoubleArray = Array(repeating: 5.0, count: 3)
let anotherFivesDoubleArray = [Double](repeating: 5.0, count: 3)
let fivesIntArray = Array(repeating: 5, count: 3)
let anotherFivesIntArray = [Int](repeating: 5, count: 3)

//: ### Creatign an Array by Adding two arrays
var addedArray = fivesDoubleArray + anotherFivesDoubleArray

//: ### Accesing and modifying an Array
// Count the elements -----
print("added array contains: \(addedArray.count) elements")

//: ### Check if is empty
var isEmpty = ""
if !addedArray.isEmpty {
    isEmpty = "NOT "
}
print("addedArray is \(isEmpty)empty")

//: ### Append items at the end
// Append method -----
addedArray.append(3.0)

// += overload -----
addedArray += [2.0, 1.0]

//: ### Retrieve/replace items
// With Subscript Syntax -----
let firstElement = addedArray[0]
let secondToFourthElements = addedArray[1...3]

// replace first to third items -----
print("before replacing 1st - 3rd with 0: " + addedArray.debugDescription)
addedArray[0...2] = [0.0]
print("after replacing 1st - 3rd with 0: " + addedArray.debugDescription)
//: - note: You can't use subscript syntax to append a new item at the end of an array.
// Insert at specific index -----
addedArray.insert(1.0, at: 0)

// Remove item at specific index -----
addedArray.remove(at: 1)
addedArray

// Remove last item -----
let lastItem = addedArray.removeLast()
// Remove first item -----
let firstItem = addedArray.removeFirst()

//: ### Iterating Over an Array
print("for in")
var theArray = ["first", "second", "third", "fourth"]
for element in theArray {
    print(element)
}

// Gettig (index, value) tuple from array ---

print("for (index, vale)")
for (index, value) in theArray.enumerated() {
    print("index: \(index) - value: \(value)")
}

print("while")
var anArray = [1, 2, 3, 4, 5, 6, 7, 8, 9]
while let x = anArray.popLast() , x % 2 == 1 {
    print(x)
}

//: ## Sets
//: ### Hash Values for Set Types
/*:
 - Important:
 A type must be *hashable* in order to be stored in a set. That is, it must provide a way to compute a hash value for itself.
 Make your types conform to the `Hashable` protocol to insert them in a set. The value returned by `hashValue` property is not required to be the same accross different executions of the same program, or in different programs. */

//: ### Creating and Initializing an Emtpy Set
var letters = Set<Character>()

//: ### Creating a Set with an Array Literal
// Comment: Because this is set, although "Rock" appears twice in the initialization array, it will be contained only once in the set.
let favoriteGenres: Set<String> = ["Rock", "Classical", "80s Pop", "Rock"]

// Type infered -----
var musicGenres: Set = ["Country", "Folk"]
musicGenres.insert("Country")
musicGenres

//: ### Accessing and modifying a Set
//:  - note: Same as Array, use count to get number of elements and `isEmpty` for what it name implies :)
// Add item with insert -----
let inserted = musicGenres.insert("New Age")
print(inserted)
print("\(inserted.0) , \(inserted.1)")

// Remove item ---
let removed = musicGenres.remove("Folk")
if let genre = removed, !musicGenres.contains(genre) {
    print("\(genre) was removed")
}

// Iterating over a set -----
for genre in favoriteGenres {
    print(genre, separator: " - ", terminator: " | ")
}
print("")
// Retrieve sorted Array from Set -----
let sortedArrayFromSet = favoriteGenres.sorted()
print(sortedArrayFromSet)


//: ## Performing Set Operations
let oddDigits: Set = [1, 3, 5, 7]
let evenDigits: Set = [2, 4, 6, 8]
let primeNumbers: Set = [2, 3, 5, 7]

let unionSet = oddDigits.union(evenDigits)
let intersection = oddDigits.intersection(primeNumbers)
let substraction = oddDigits.subtracting(primeNumbers)
let symetricDifference = oddDigits.symmetricDifference(evenDigits)

//: ### Set membership and Equality
let houseAnimals: Set = ["cat", "dog"]
let farmAnimals: Set = ["cow", "chicken", "cat", "dog"]
let cityAnimals: Set = ["mouse", "pigeon"]

houseAnimals.isSubset(of: farmAnimals)
farmAnimals.isSuperset(of: cityAnimals)
cityAnimals.isDisjoint(with: houseAnimals)


//: ## Dictionaries
//: - Important: A dictionary Key type must conform to the `Hashable` protocol, like a set’s value type.

//: ### Creating an Empty Dictionary
var anIntStringDictionary: Dictionary<Int, String> = Dictionary()
anIntStringDictionary[0] = "zero"
anIntStringDictionary[1] = "one"
print(anIntStringDictionary)

var anotherIntStringDictionary = [Int:String]()
anotherIntStringDictionary[0] = "zero"
anotherIntStringDictionary[1] = "one"
print(anotherIntStringDictionary)

//: ### Creating a Dictionary with a Dictionary Literal
var airports = ["YYZ":"Toronto Pearson", "DUB":"Dublin"]

/*:
 - note: Same as Array and Set, use count to get number of elements and isEmpty for what it name implies :) */
//: ### Adding a new element to a dictionary
// Adding with subscript syntax -----
airports["LHR"] = "London"

// Change value with subscript syntax -----
airports["LHR"] = "London Heathrow"

// Set a new value or update an existing using updateValue method -----
var oldValue = airports.updateValue("Dublin Airport", forKey: "DUB")
print(" the old value was: \(String(describing: oldValue))")
oldValue = airports.updateValue("Cordoba", forKey: "COR")
if oldValue == nil {
    print("new key-value added to dictionary")
}

//: ### Removing a value for a key
airports["LHR"] = nil // using subscript syntax
airports.removeValue(forKey: "COR") // using removeValue method

//: ### Iterating Over a Dictionary
for (airportCode, airportName) in airports {
    print("\(airportName) airport's code is: \(airportCode)")
}

// Retrieve iteratable collection of keys -----
let keyCollection = airports.keys
print("keyCollection: \(keyCollection)")
for key in keyCollection {
    print(key, separator:"", terminator:", ")
}

print("\nairport names:")
// Retrieve iteratable collection of values -----
let valueCollection = airports.values
for value in airports.values {
    print(value, separator:"", terminator:", ")
}

// Retrieve as array instead of iterable collection ---
let keyArray = [String](airports.keys)
let valueArray = Array(airports.values)

// Getting a sorted array -----
let sortedKeyArray = airports.keys.sorted()
let sortedValueArray = airports.values.sorted()

//: [Next](@next)




