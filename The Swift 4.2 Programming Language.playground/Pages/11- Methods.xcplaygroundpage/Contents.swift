//: [Previous](@previous)

//: # Methods
/*:
 - note: The fact that structures and enumerations can define methods in Swift is a major difference from C and Objective-C. In Objective-C, classes are the only types that can define methods. In Swift, you can choose whether to define a class, structure, or enumeration, and still have the flexibility to define methods on the type you create.
 */

//: ## Instance Methods
//Example class with 3 instance methods:
class Counter {
    var count = 0
    
    func increment() {
        count += 1
    }
    
    func increment(by amount: Int) {
        count += amount
    }
    
    func reset() {
        count = 0
    }
}

//calling instance methods
let counter = Counter()
counter.increment()
counter.increment(by: 4)
print("counter after increments: \(counter.count)")
counter.reset()
print("counter after reset: \(counter.count)")

//: ### The self Property

//: ### Modifying Value Types from Within Instance Methods
/*:
 - note: Structures and Enums been value types require the use of the *mutating* keyword at the beggining of a method in order for that method to modify the instance as shown in the next example.
 */
struct Point {
    var x = 0.0, y = 0.0
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        x += deltaX
        y += deltaY
    }
}

var aPoint = Point(x: 1.0, y: 1.0)
aPoint.moveBy(x: 2.5, y: 5.1)
print("point is now at: \(aPoint)")

let constantPoint = Point(x: 2.0, y: 3.0)
//NOTE: cannot call a mutating method on a constant. Uncomment following line to see the error
//constantPoint.moveBy(x: 1.0, y: 1.0)


//: ### Assigning to self Within a Mutation Method
/*:
 - note: Mutating methods can assign a new instance to **self**
 */
struct PointB {
    var x = 0.0, y = 0.0
    
    mutating func moveBy(x deltaX: Double, y deltaY: Double) {
        self = PointB(x: x + deltaX, y: y + deltaY)
    }
}

//Mutating methods for enumarations can set **self** to a different case
enum TriStateSwitch {
    case off, low, high
    mutating func next() {
        switch self {
        case .off:
            self = .low
        case .low:
            self = .high
        case .high:
            self = .off
        }
    }
}

var ovenLight = TriStateSwitch.low
ovenLight.next()
ovenLight.next()
ovenLight.next()

//: ## Type Methods
/*:
 - note: As the name implies this are type level methods. Use the word *static* to define them. Class can also instead use the word *class* to allow sub-classes to override the method.
 Unlike Objective-C where this is only available to classes in Swift it also applies to enums and structs.
 */

class SomeClass {
    class func someTypeMethod() {
        print("someTypeMethod executed")
    }
}

SomeClass.someTypeMethod()


//Structure example with type methods:
struct LevelTracker {
    static var highestUnlockedLevel = 1
    var currentLevel = 1
    
    static func unlock(_ level: Int) {
        if level > highestUnlockedLevel {
            highestUnlockedLevel = level
        }
    }
    
    static func isUnlocked(_ level: Int) -> Bool {
        return level <= highestUnlockedLevel
    }
    
    @discardableResult
    mutating func advance(to level: Int) -> Bool {
        if LevelTracker.isUnlocked(level) {
            currentLevel = level
            return true
        } else {
            return false
        }
    }
}


// LevelTracker client class: Player
class Player {
    var tracker = LevelTracker()
    let playerName: String
    
    init(name: String) {
        playerName = name
    }
    
    func complete(level: Int) {
        LevelTracker.unlock(level + 1)
        tracker.advance(to: level + 1)
    }
}

var player = Player(name: "Argyrios")
player.complete(level: 1)
print("highest unlocked level is now \(LevelTracker.highestUnlockedLevel)")

player = Player(name: "Beto")
if player.tracker.advance(to: 6) {
    print("player is now on level 6")
} else {
    print("level 6 has not yet been unlocked")
}
//: [Next](@next)
