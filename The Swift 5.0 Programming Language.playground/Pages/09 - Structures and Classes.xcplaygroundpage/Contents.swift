//: [Previous](@previous)
//: # Structures and Classes
//: ## Comparing Structures and Classes
//: ### Definition Syntax
class SomeClass {
    // class definition
    var name: String
    init(named: String) {
        self.name = named
    }
}

struct SomeStructure {
    // structure definition
    let someClass: SomeClass
}

let aSomeClass = SomeClass(named: "aSomeClass")

let aStruct = SomeStructure(someClass: aSomeClass)
let anotherStruct = SomeStructure(someClass: aSomeClass)
let yetAnotherStruct = aStruct

aSomeClass.name = "new name"
print(aStruct.someClass === anotherStruct.someClass)
print(aStruct.someClass === yetAnotherStruct.someClass)
print(aStruct.someClass.name)
print(anotherStruct.someClass.name)
print(yetAnotherStruct.someClass.name)

aStruct.someClass.name = "none & some"
print(aStruct.someClass.name)
print(anotherStruct.someClass.name)
print(yetAnotherStruct.someClass.name)



//Examples:
struct Resolution {
    var width  = 0
    var height = 0
}

class VideoMode {
    var resolution = Resolution()
    var interlaced = false
    var frameRate = 0.0
    var name: String?
}

//: ### Structure and Class Instances
let someResolution = Resolution()
let someVideoMode = VideoMode()

//: ### Accessing Properties
someVideoMode.resolution.width = 320
print("video mode resolution with: \(someVideoMode.resolution.width)")

//: ### Memberwise Initializers for Structure Types
let vga = Resolution(width: 320, height: 200)


//: ## Structures & Enumerations are Value Types
let hd = Resolution(width: 1920, height: 1080)
var cinema = hd
cinema.width = 2048

print("cinema is now: \(cinema)")
print("hd is: \(hd)")

//: ## Classes are Reference Types
let interlacedVideoMode = someVideoMode
print("someVideo mode interlaced before: \(someVideoMode.interlaced)")
interlacedVideoMode.interlaced = true
print("someVideo mode interlaced after: \(someVideoMode.interlaced)")

//: ### Identity operator
// used to check if 2 constants/variables refer to the same instance
// read === as "identical to"
if interlacedVideoMode === someVideoMode {
    print("interlaceVideoMode and someVideoMode refer to the same instance")
}

/*:
 - note: Note that “identical to” (represented by three equals signs, or ===) does not mean the same thing as “equal to” (represented by two equals signs, or ==). “Identical to” means that two constants or variables of class type refer to exactly the same class instance. “Equal to” means that two instances are considered “equal” or “equivalent” in value, for some appropriate meaning of “equal”, as defined by the type’s designer.
 When you define your own custom classes and structures, it is your responsibility to decide what qualifies as two instances being “equal”. The process of defining your own implementations of the “equal to” and “not equal to” operators is described in Equivalence Operators.*/

//: ### Pointers
/*:
 - note: If you have experience with C, C++, or Objective-C, you may know that these languages use pointers to refer to addresses in memory. A Swift constant or variable that refers to an instance of some reference type is similar to a pointer in C, but is not a direct pointer to an address in memory, and does not require you to write an asterisk (*) to indicate that you are creating a reference. Instead, these references are defined like any other constant or variable in Swift
 */

//: ### Choosing between Classes and Structures
/*:
 - note: As a general guideline, consider creating a **Structure** when one or more of these conditions apply:
 -  The structure’s primary purpose is to encapsulate a few relatively simple data values.
 - It is reasonable to expect that the encapsulated values will be copied rather than referenced when you assign or pass around an instance of that structure.
 - Any properties stored by the structure are themselves value types, which would also be expected to be copied rather than referenced.
 - The structure does not need to inherit properties or behavior from another existing type.
*/


//:## Assignment and Copy Behavior for Strings, Arrays, and Dictionaries
/*:
 - note: In Swift, many basic data types such as String, Array, and Dictionary are implemented as structures. This means that data such as strings, arrays, and dictionaries are copied when they are assigned to a new constant or variable, or when they are passed to a function or method. */
/*:
 - note: This behavior is different from Foundation: NSString, NSArray, and NSDictionary are implemented as classes, not structures. Strings, arrays, and dictionaries in Foundation are always assigned and passed around as a reference to an existing instance, rather than as a copy. */


//: [Next](@next)
