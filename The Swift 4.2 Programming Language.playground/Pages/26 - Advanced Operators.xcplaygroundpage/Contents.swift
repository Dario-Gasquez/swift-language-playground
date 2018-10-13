//: [Previous](@previous)
//: # Advanced Operators
import Foundation
/*:
 These include all bitwise and bit shifting operators.

 Unlike C operators, Swift arithmetic op. do not overflow by default. Overflow is trapped and reported as error. To opt in to overflow behavior, use the set of operators that overflow such as the *overflow addition operator* (`&+`). All of these operators begin with: `&`.
 
 It is possible to provide custom implementeations of the standard Swift operators in your custom types.
*/

//: ## Bitwise Operators
//: *Bitwise Operators* enable you to manipulate the individual raw data bits within a data structure. Swift supports all the bitwise operators foudn in C, as described below.

//: ### Bitwise NOT Operator
//: The *bitwise NOT operator* (`~`) inverts all bits in a number:
let initialBits: UInt8 = 0b00001111
let invertedBits = ~initialBits
print("\(String(invertedBits, radix: 2))")

//: ### Bitwise AND Operator
//: The *bitwise AND operator* (`&`) combines the bits of two numbers. It returns a new number whose bits are set to 1 only if the bits were equal to 1 in both input numbers:
let firstSixBits: UInt8 = 0b11111100
let lastSixBits: UInt8 = 0b00111111
let middleFour = firstSixBits & lastSixBits
print("\(String(middleFour, radix: 2))")

//: ### Bitwise OR Operator
//: The *bitwise OR operator* (`|`) compares the bits of two numbers. The operator returns a new number whose bits are set to 1 if the bits are equal to 1 in either input number:
let somebits: UInt8 = 0b10110010
let morebits: UInt8 = 0b01111110
let oredbits = somebits | morebits
print("\(String(oredbits, radix: 2))")

//: ### Bitwise XOR Operator
//: The *bitwise XOR operator*, or “exclusive OR operator” (`^`), compares the bits of two numbers. The operator returns a new number whose bits are set to 1 where the input bits are different and are set to 0 where the input bits are the same:
let firstbits: UInt8 = 0b10010100
let otherbits: UInt8 = 0b00000101
let xored = firstbits ^ otherbits
print(String(xored, radix:2))

//: ### Bitwise Left and Right Shift Operators
//: The *bitwise left shift operator* (`<<`) and *bitwise right shift operator* (`>>`) move all bits in a number to the left or the right by a certain number of places, according to the rules defined below.

//: #### Shifting Behavior for Unsigned Integers
/*:
 The bit-shifting behavior for unsigned integers is as follows:
- Existing bits are moved to the left or right by the requested number of places.
- Any bits that are moved beyond the bounds of the integer’s storage are discarded.
- Zeros are inserted in the spaces left behind after the original bits are moved to the left or right.
 
This approach is known as a logical shift.

Here’s how bit shifting looks in Swift code:
*/
let shiftBits: UInt8 = 4    // 00000100 in binary
shiftBits << 1              // 00001000
shiftBits << 2              // 00010000
shiftBits << 5              // 10000000
shiftBits << 6              // 00000000
shiftBits >> 2              // 00000010
print(String(shiftBits, radix: 2))
//: #### Shifting Behavior for Signed Integers
/*:
 The shifting behavior is more complex for signed integers than for unsigned integers, because of the way signed integers are represented in binary. In this case shifting adds 0s or 1s as needed to mantain the sign.
 */

//: ## Overflow Operators
/*:
 If you try to insert a number into an integer constant or variable that cannot hold that value, by default Swift reports an error rather than allowing an invalid value to be created. This behavior gives extra safety when you work with numbers that are too large or too small.
 
 For example, the Int16 integer type can hold any signed integer between -32768 and 32767. Trying to set an Int16 constant or variable to a number outside of this range causes an error:
 */
var potentialOverflow = Int16.max
//potentialOverflow += 1 //this should cause an error
/*:
 When you specifically want an overflow condition to truncate the number of available bit, you can opt in to this behavior rather than triggering an error. Swift provides three arithmetic overflow operators that opt in to the overflow behavior for integer calculations. These operators all begin with an ampersand (`&`):
- Overflow addition (`&+`)
- Overflow subtraction (`&-`)
- Overflow multiplication (`&*`)
 */

//: ### Value Overflow
//: Here’s an example of what happens when an unsigned integer is allowed to overflow in the positive direction, using the overflow addition operator (`&+`):
var unsignedOverflow = UInt8.max
unsignedOverflow = unsignedOverflow &+ 1

//: And the oposite case with the overflow subtraction operator (`&-`):
var underflow = UInt8.min
underflow = underflow &- 1

//: Overflow also occurs for signed integers:
var signedOverflow = Int8.min
signedOverflow = signedOverflow &- 1

//: ## Precedence and Associativity
/*:
 Operator *precedence* gives some operators higher priority than others.
 
 Operator *associativity* defines how operators of the same precedence are grouped together (either from the left, or from the right).
 
 Precedence and associativty explain why the following expresion is equal to 17:
 
    2 + 3 % 4 * 5
 
 which is equivalent to this:
 
    2 + ( (3 % 4) * 5 )
 */

//: - Note: Swift’s operator precedences and associativity rules are simpler and more predictable than those found in C and Objective-C. However, this means that they are not exactly the same as in C-based languages. Be careful to ensure that operator interactions still behave in the way you intend when porting existing code to Swift.

//: ## Operator Methods
/*:
 Classes and structures can provide their own implementations of existing operators. This is known as *overloading* the existing operators.
 
 The next example shows how to implement the arithmatic addition operator: `+`:
*/
struct Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
    
    var x = 0.0, y = 0.0
}

//: The type method can be used as an infix operator between existing Vector2D instances:
let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)
let combinedVector = vector + anotherVector

//: ### Prefix and Postfix Operators
//: The example shown above demonstrates a custom implementation of a binary infix operator. Classes and structures can also provide implementations of the standard *unary operators*. Unary operators operate on a single target. They are *prefix* if they precede their target (such as -a) and postfix operators if they follow their target (such as b!).

extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}

let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
let alsoPositive = -negative

//: ### Compound Assignment Operators
//: *Compound assignment operators* combine assignment (`=`) with another operation. For example, the addition assignment operator (`+=`). You mark a compound assignment operator’s left input parameter type as `inout`, because the parameter’s value will be modified directly from within the operator method:
extension Vector2D {
    static func += (lhs: inout Vector2D, rhs: Vector2D) {
        lhs = lhs + rhs
    }
}
//: Because an addition operator was defined earlier, you don’t need to reimplement the addition process here. Instead, the addition assignment operator method takes advantage of the existing addition operator method, and uses it to set the left value to be the left value plus the right value.
var original = Vector2D(x: 1.0, y: 2.0)
var vectorToAdd = Vector2D(x: 3.0, y: 4.0)
original += vectorToAdd
//: - Note: It is not possible to overload the default assignment operator (`=`). Only the compound assignment operators can be overloaded. Similarly, the ternary conditional operator (`a ? b : c`) cannot be overloaded.

//: ### Equivalence Operators
//: Custom classes and structures do not receive a default implementation of the equivalence operators, known as the “equal to” operator (`==`) and “not equal to” operator (`!=`). It is not possible for Swift to guess what would qualify as “equal” for your own custom types, because the meaning of “equal” depends on the roles that those types play in your code.

extension Vector2D {
    static func == (left: Vector2D, right: Vector2D) -> Bool {
        return (left.x == right.x) && (left.y == right.y)
    }
    
    static func != (left: Vector2D, right: Vector2D) -> Bool {
        return !(left == right)
    }
}

let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)
if twoThree == anotherTwoThree {
    print("they are equal")
}

//: ## Custom Operators
/*:
 You can declare and implement your own custom operators in addition to the standard operators provided by Swift. For a list of characters that can be used to define custom operators, see [Operators](https://developer.apple.com/library/content/documentation/Swift/Conceptual/Swift_Programming_Language/LexicalStructure.html#//apple_ref/doc/uid/TP40014097-CH30-ID418).

 New operators are declared at a global level using the `operator` keyword, and are marked with the `prefix`, `infix` or `postfix` modifiers:
 */
 prefix operator +++
//: The example above defines a new prefix operator called `+++`. This operator does not have an existing meaning in Swift, and so it is given its own custom meaning below in the specific context of working with `Vector2D` instances. For the purposes of this example, `+++` is treated as a new “prefix doubling” operator. It doubles the `x` and `y` values of a `Vector2D` instance, by adding the vector to itself with the addition assignment operator defined earlier. To implement the `+++` operator, you add a type method called `+++` to `Vector2D` as follows:
extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector
        return vector
    }
}

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
print(afterDoubling)

//: ### Precence for Custom Infix Operators
/*:
 Custom infix operators each belong to a precedence group. A precedence group specifies an operator’s precedence relative to other infix operators, as well as the operator’s associativity.
 
 A custom infix operator that is not explicitly placed into a precedence group is given a default precedence group with a precedence immediately higher than the precedence of the ternary conditional operator.
 
 The following example defines a new custom infix operator called `+-`, which belongs to the precedence group `AdditionPrecedence`:
 */
infix operator +-: AdditionPrecedence
extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}

let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector

//: - Note: You do not specify a precedence when defining a prefix or postfix operator. However, if you apply both a prefix and a postfix operator to the same operand, the postfix operator is applied first.

//: [Next](@next)
