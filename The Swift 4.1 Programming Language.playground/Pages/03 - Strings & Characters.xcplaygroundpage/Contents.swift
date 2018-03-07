//: [Previous](@previous)

import Foundation

// NOTE: String is fully bridged NSString
var str = "some"

//: ## Multiline string literal
let multilineString = """
The white rabbit put on his spectacles. "Where Shall I Begin,
please your Majesty?" he asked.

"Begin at the beginning", etcetera.
"""
print("multiline: '\(multilineString)'")

//: ## Initializing an empty string
//these two are equivalent
var emptyString = ""
var anotherEmptyString = String()

if emptyString.isEmpty {
    print("emtpyString is empty")
}
 
/*:
 - note: Strings are value types !!, but can be modified using inout
 */
func update(aString: inout String) {
    aString += " UPDATED"
}

var someString = "sample text"
update(aString: &someString)
print(someString)


//: ## Working with characters
// Swift 4 simplifed syntax (Strings are collections now, no need to resort to .characters attrib)
for character in "sample string" {
    print(character, separator: "", terminator: " ")
}
print("\n")

let exclamationMark: Character = "!"
let chatCharacters: [Character] = ["C", "a", "t", "!", "🐱"]
var catString = String(chatCharacters)

//: ## Concatenating Strings and Characters
catString.append("A")
catString.count

let string1 = "string1"
let string2 = " string2"
var string12 = string1 + string2

var string3 = "string3"
string3 += string2

//: ## String Interpolation
let multiplier = 3
let message = "\(multiplier) times 2.5 is \(Double(multiplier) * 2.5)"

//: ## Unicode
//: ### Unicode Scalars
/*:
 - note: A Unicode scalar is any Unicode code point in the range U+0000 to U+D7FF inclusive or U+E000 to U+10FFFF inclusive. Unicode scalars do not include the Unicode surrogate pair code points, which are the code points in the range U+D800 to U+DFFF inclusive. */

//: ### Special Characters in String Literals
//String literals can contain special characters. Examples:
let einsteinWords = "\"Imagination is more important than knowledge\" = Einstein"
let dollarSignUnicode = "\u{24}"
let blackHeartUnicode = "\u{2665}"
let babyChickenUnicode = "\u{1F425}"

//: ### Extended Grapheme Clusters
/*:
 - note: Every Character instance represents a single extended grapheme cluster: a sequence of 1 or more Unicode scalars that combined produce a single human-readable character. */
// example, 2 ways to represent é
let eAcute: Character = "\u{E9}"
let combinedEAcute: Character = "\u{65}\u{301}" // e character plus accent

//: ## Character counting
var word = "cafe"
print("characters in \(word) is \(word.count)")

//Note: not always modifying a String changes its count
word += "\u{301}" //combinging Acute accent: U+0301
print("# of characters in \(word) is \(word.count)")

/*:
 - note:
 Extended grapheme clusters can be composed of multiple Unicode scalars. This means that different characters — and different representations of the same character — can require different amounts of memory to store. Because of this, characters in Swift do not each take up the same amount of memory within a string’s representation. As a result, the number of characters in a string cannot be calculated without iterating through the string to determine its extended grapheme cluster boundaries. If you are working with particularly long string values, be aware that the count property must iterate over the Unicode scalars in the entire string in order to determine the characters for that string. The count of the characters returned by the count property is not always the same as the length property of an NSString that contains the same characters. The length of an NSString is based on the number of 16-bit code units within the string’s UTF-16 representation and not the number of Unicode extended grapheme clusters within the string.
 */

//: ## Accessing and Modifying a String

//: ### String Indices

print("\(catString[catString.startIndex]) at \(catString.startIndex)")

catString.startIndex
catString.endIndex
let index = catString.index(catString.startIndex, offsetBy: 4)
catString[index]

for index in catString.indices {
    print("index: \(index). Character at index: \(catString[index])")
}

//: ### Inserting and removing
// Insert
var welcome = "hello"
welcome.insert("!", at: welcome.endIndex) //insert a character
welcome.insert(contentsOf: " the end", at: welcome.endIndex)

//Remove
welcome.remove(at: welcome.startIndex) //remove char at index
print(welcome)

let range = welcome.index(welcome.endIndex, offsetBy: -3)..<welcome.endIndex //remove substring
welcome.removeSubrange(range)

//: ## Substrings
/*:
 - note: When you get a substring from a string —for example, using a subscript or a method like prefix(_:)— the result is an instance of Substring, not another string. Substrings in Swift have most of the same methods as strings, which means you can work with substrings like strings. Unlike strings, you use substrings for only a short amount of time while performing actions on a string. When you’re ready to store the result for a longer time, you convert the substring to an instance of String. For example
 */
let greeting = "Hello, Earth"
let greetingIndex = greeting.index(of: ",") ?? greeting.endIndex
let beginning = greeting[..<index]

//Convert 'beginning' substring to String for long-term storage.
let beginningString = String(beginning)

/*:
 -note: Both String and Substring conform to the StringProtocol protocol. If you’re writing code that manipulates string data, accepting a StringProtocol value lets you pass that string data as either a String or Substring value.
 */



//: ## Comparing strings
// Swift provides 3 ways to compare textual values: string & character equality, prefix equality and suffix equality

//: ### String and Character Equality
let aString = "a string"
let anotherString = "a string"
if aString == anotherString {
    print("strings are equal")
}

// Canonically equivalent strings ----
let acuteCafe = "Café"
let combinedAcuteCafe = "Caf\u{65}\u{301}"
if acuteCafe == combinedAcuteCafe {
    print("strings are cannonically equivalent (they have the same linguistic meaning)")
}

// Similar characters but not equivalent (Latin A vs. Cyrillic A) ---
let latinA = "\u{41} letter"
let cyrillicA = "\u{0410} letter"
if latinA != cyrillicA {
    print("non equivalent")
}

//: ### Prefix and Suffix equality
let romeoAndJuliet = [
    "Act 1 Scene 1: Verona, A public place",
    "Act 1 Scene 2: Capulet's mansion",
    "Act 1 Scene 3: A room in Capulet's mansion",
    "Act 1 Scene 4: A street outside Capulet's mansion",
    "Act 1 Scene 5: The Great Hall in Capulet's mansion",
    "Act 2 Scene 1: Outside Capulet's mansion",
    "Act 2 Scene 2: Capulet's orchard",
    "Act 2 Scene 3: Outside Friar Lawrence's cell",
    "Act 2 Scene 4: A street in Verona",
    "Act 2 Scene 5: Capulet's mansion",
    "Act 2 Scene 6: Friar Lawrence's cell"
]

var scenesInAct1 = 0
for scene in romeoAndJuliet {
    if scene.hasPrefix("Act 1") {
        scenesInAct1 += 1
    }
}
print("Scenes in act 1 = \(scenesInAct1)")

//hasSuffix can be used in a similar what to check for string suffix equality


//: ## Unicode Representation of Strings
let catDogString = "🐱at🐶og!"
print("utf8: ")
for codeUnit in catDogString.utf8 {
    print(codeUnit, terminator: " ")
}
print("\nutf16: ")
for codeUnit in catDogString.utf16 {
    print(codeUnit, terminator: " ")
}

//: ## working with filename and extensions
import Foundation

var destFileName = ProcessInfo.processInfo.globallyUniqueString
let metadataPath = "/effects/bear.png"
let url = URL(fileURLWithPath: metadataPath)
let pathExtension = (metadataPath as NSString).pathExtension
let extensionFromURL = url.pathExtension



extension CharacterSet {
    func allCharacters() -> [Character] {
        var result: [Character] = []
        for plane: UInt8 in 0...16 where self.hasMember(inPlane: plane) {
            for unicode in UInt32(plane) << 16 ..< UInt32(plane + 1) << 16 {
                if let uniChar = UnicodeScalar(unicode), self.contains(uniChar) {
                    result.append(Character(uniChar))
                }
            }
        }
        return result
    }
}

let decomposable = CharacterSet.decomposables

print("\ndecomplosable :\(decomposable.contains("ž"))")


//: [Next](@next)
