//: [Previous](@previous)
//: ## For-In Loops
for index in 1...5 {
    print("\(index) times 5 is \(index*5)")
}

let base = 3
let power = 10
var answer = 1
// Ignoring the values of the sequence if not needed using underscore
for _ in 1...power {
    answer *= base
}
print("\(base) to the power of \(power) is \(answer)")

// hal-open range -----
let minutes = 60
print("tickMarks:")
for tickMark in 0..<minutes {
    print(tickMark, terminator: " >> ")
}

// strides to skip not needed intermediate values -----
let strideSize  = 5
print("\nstride tick marks closed range:")
for strideTickMark in stride(from: 0, through: minutes, by: strideSize) {
    print(strideTickMark, terminator: " -> ")
}

//Strides can also use half-range (to: instead of through:) -----
print("\nstride tick marks half-range:")
for strideMark in stride(from: 0, to: minutes, by: strideSize) {
    print(strideMark, terminator: " -> ")
}

let names = ["John", "Alex", "Brian", "Jack"]
print("\ngreetings:")
for name in names {
    print("Hi \(name)", terminator: ", ")
}

//Iterate over dictionary
print("\nanimal legs:")
let numberOfLegs = ["spider":8, "ant":6, "cat":4]
for (name, legs) in numberOfLegs {
    print("the \(name) has \(legs) legs", terminator: ", ")
}

//: ## Conditional statements
//: ### If
//: ### Switch
let someCharacter: Character? = "2"

switch someCharacter {
case .some("a"), .some("A"):
    print("first letter in the alphabet")
case "z"?, "Z"?:
    print("last letter in the alphabet")
case  .none:
    print("nil")
default:
    print("some character")
}

// Interval Matching -----
let approximateCount = 62
let countedThings = "moons orbiting Saturn"
var naturalCount: String
switch approximateCount {
case 0:
    naturalCount = "no"
case 1..<5:
    naturalCount = "a few"
case 5..<12:
    naturalCount = "several"
case 12..<100:
    naturalCount = "dozens of"
case 100..<1000:
    naturalCount = "hundreds of"
default:
    naturalCount = "many"
}
print("there are \(naturalCount) \(countedThings)")

// Tuples -----
let somePoint = (3, 1)
switch somePoint {
case (0, 0):
    print("\(somePoint) is at the origin")
case (_, 0):
    print("\(somePoint) is on the x-axis")
case (0, _):
    print("\(somePoint) is on the y-axis")
case (-2...2, -2...2):
    print("(\(somePoint.0), \(somePoint.1)) is inside the box")
default:
    print("\(somePoint) is outside the box")
}


// Value Bindings: -----
// note: constants (let) used in the example, but var are also available
let anotherPoint = (2, 0)
switch anotherPoint {
case (let x, 0):
    print("on the x-axis with an x value of: \(x)")
case (0, let y):
    print("on the y-axis with an x value of: \(y)")
case (let x, let y):
    print("somewhere else with a value of: (\(x), \(y))")
}

// Where -----
let yetAnotherPoint = (1, -1)
switch yetAnotherPoint {
case let (x, y) where x == y:
    print("\(yetAnotherPoint) is on the line x == y")
case let (x, y) where x == -y:
    print("\(yetAnotherPoint) is on the line x == -y")
case let (x, y):
    print("\(x),\(y) is somewhere else")
}

// Compound cases -----
let someChar: Character = "e"
switch someChar {
case "a", "e","i","o","u":
    print("\(someChar) is a vowel")
case "b", "c","d","f","g","h", "j", "k", "l", "m",
     "n", "p", "q", "r", "s", "t", "v", "w", "x", "y", "z":
    print("\(someChar) is a consonant")
default:
    print("another type of char")
}

// Compound cases + value binding ----
let aPoint = (9, 0)
switch aPoint {
case (let distance, 0), (0, let distance):
    print("on an axis \(distance) from the origin")
default:
    print("not on axis")
}

//: ### Control Transfer Statements

//Break & Continue -------
let puzzleInput = "great minds think alike"
var puzzleOutput = ""
for character in puzzleInput.characters {
    switch character {
    case "a", "e", "i", "o", "u", " ":
        continue // execution jumps to begining of next for iteration. if 'break' used, execution continues at the end of the switch statement
    default:
        puzzleOutput.append(character)
    }
    print("end of switch") //printed 23 times with 'break' but only 13 times with 'continue'
}
print(puzzleOutput)

//: ### Early Exit: Guard statement
func greet(person: [String: String]) {
    guard let name = person["name"] else { return }

    print("hello \(name)")

    guard let location = person["location"] else {
        print("I hope wheather is nice in your location")
        return
    }
    
    print("I hope the weather is nice in \(location)")
}

greet(person: ["name": "Pedrin"])
greet(person: ["name": "Maria", "location":"España"])


//: ### Checking API Availability
/*
 if #available(platform_name version, ..., *) {
    statements to execute if the APIs are available
 } else {
    fallback statements to execute if the APIs are unavailable
 }
 */

if #available(iOS 10, macOS 10.12, *) {
    // use iOS 10 APIs on iOS and macOS 10.12 APIs on macOS
} else {
    // fall back to earlier iOS and macOS APIs
}

//: [Next](@next)
