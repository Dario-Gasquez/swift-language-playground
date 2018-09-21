//: [Previous](@previous)
//: # Memory Safety
/*:
 By default, Swift prevents unsafe behavior from happening in your code. For example, Swift ensures that variables are initialized before they’re used, memory isn’t accessed after it’s been deallocated, and array indices are checked for out-of-bounds errors.
 
 Swift also makes sure that multiple accesses to the same area of memory don’t conflict, by requiring code that modifies a location in memory to have exclusive access to that memory. Because Swift manages memory automatically, most of the time you don’t have to think about accessing memory at all. However, it’s important to understand where potential conflicts can occur, so you can avoid writing code that has conflicting access to memory. If your code does contain conflicts, you’ll get a compile-time or runtime error.
 */

//: ## Understanding Conflicting Access to Memory
//: Access to memory happens in your code when you do things like set the value of a variable or pass an argument to a function. For example, the following code contains both a read access and a write access:

// write access to the memory where one is stored:
var one = 1

//read access from the memory where one is stored:
print("we're number \(one)")

//: - Note: If you’ve written concurrent or multithreaded code, conflicting access to memory might be a familiar problem. However, the conflicting access discussed here can happen on a single thread and doesn’t involve concurrent or multithreaded code. If you have conflicting access to memory from within a single thread, Swift guarantees that you’ll get an error at either compile time or runtime.

//: ### Characteristics of Memory Access
/*:
A conflict occurs if you have two accesses that meet all of the following conditions:
 
 - At least one is a write access.
 - They access the same location in memory.
 - Their durations overlap.
 
 An access is instantaneous if it’s not possible for other code to run after that access starts but before it ends. By their nature, two instantaneous accesses can’t happen at the same time. Most memory access is instantaneous. For example, all the read and write accesses in the code listing below are instantaneous:
 */
func oneMore(than number: Int) -> Int {
    return number + 1
}

var myNumber = 1
myNumber = oneMore(than: myNumber)
print(myNumber)

/*:
 However, there are several ways to access memory, called long-term accesses, that span the execution of other code. The difference between instantaneous access and long-term access is that it’s possible for other code to run after a long-term access starts but before it ends, which is called overlap. A long-term access can overlap with other long-term accesses and instantaneous accesses.
 
 Overlapping accesses appear primarily in code that uses in-out parameters in functions and methods or mutating methods of a structure. The specific kinds of Swift code that use long-term accesses are discussed in the sections below.
*/

//: ## Conflicting Access to In-Out Parameters
/*:
 A function has long-term write access to all of its in-out parameters. The write access for an in-out parameter starts after all of the non-in-out parameters have been evaluated and lasts for the entire duration of that function call. If there are multiple in-out parameters, the write accesses start in the same order as the parameters appear.
 
 One consequence of this long-term write access is that you can’t access the original variable that was passed as in-out, even if scoping rules and access control would otherwise permit it—any access to the original creates a conflict. For example:
 */
var stepSize = 3
func incrementInPlace(_ number: inout Int) {
    number += stepSize
}

incrementInPlace(&stepSize) //Conflicting access to stepSize

//: Another consequence of long-term write access to in-out parameters is that passing a single variable as the argument for multiple in-out parameters of the same function produces a conflict. For example:
func balance(_ x: inout Int, _ y: inout Int) {
    let sum = x + y
    x = sum / 2
    y = sum - x
}
var p1Score = 42
var p2Score = 30
balance(&p1Score, &p2Score) //OK
//balance(&p1Score, &p1Score) //Conflicting access to p1Score


//: ## Conflicting Access to self in Methods
//: A mutating method on a structure has write access to self for the duration of the method call. For example, consider:
struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    static let maxHealth = 30
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

extension Player {
    mutating func shareHealth(with teammate: inout Player) {
        balance(&teammate.health, &health)
    }
}

var oscar = Player(name: "oscar", health: 10, energy: 10)
var maria = Player(name: "maria", health: 5, energy: 10)
oscar.shareHealth(with: &maria) // OK
//oscar.shareHealth(with: &oscar) //Conflicting access to oscar

//: ## Conflicting Access to Properties
//: Types like structures, tuples, and enumerations are made up of individual constituent values, such as the properties of a structure or the elements of a tuple. Because these are value types, mutating any piece of the value mutates the whole value, meaning read or write access to one of the properties requires read or write access to the whole value. For example, overlapping write accesses to the elements of a tuple produces a conflict:
var playerInformation = (health: 10, energy: 20)
balance(&playerInformation.health, &playerInformation.energy) // Conflicting access to properties of playerInformation

var holly = Player(name: "holly", health: 10, energy: 10)
balance(&holly.health, &holly.energy)

/*:
 The restriction against overlapping access to properties of a structure isn’t always necessary to preserve memory safety.
 
 Specifically, it can prove that overlapping access to properties of a structure is safe if the following conditions apply:

- You’re accessing only stored properties of an instance, not computed properties or class properties.
- The structure is the value of a local variable, not a global variable.
- The structure is either not captured by any closures, or it’s captured only by nonescaping closures.
If the compiler can’t prove the access is safe, it doesn’t allow the access.
*/

//: [Next](@next)
