//: [Previous](@previous)
//: # Deinitialization
//: A *deinitializer* is called immediately before a class instance is deallocated. You write deinitializers with the `deinit` keyword, similar to how initializers are written with the `init` keyword. Deinitializers are only available on class types.
//: ### How Deinitialization Works
/*:
 Class definition can have at most **one** deinitializer per class. It does not take parameters and is written witouht parentesis:
 
    deinit {
        // deinitialization code
    }
 */

//: - Note: Because an instance is not deallocated until after its deinitializer is called, a deinitializer can access all properties of the instance it is called on and can modify its behavior based on those properties (such as looking up the name of a file that needs to be closed).

//: ## Deinitializers in Action

class Bank {
    static var coinsInBank = 10_000
    
    static func distribute(coins numbersOfCoinsRequested: Int) -> Int {
        let numberOfCoinsToVend = min(numbersOfCoinsRequested, coinsInBank)
        coinsInBank -= numberOfCoinsToVend
        return numberOfCoinsToVend
    }
    
    static func receive(coins: Int) {
        coinsInBank += coins
    }
}

class Player {
    var coinsInPurse: Int
    
    init(coins: Int) {
        coinsInPurse = Bank.distribute(coins: coins)
    }
    
    func win(coins: Int) {
        coinsInPurse += Bank.distribute(coins: coins)
    }
    
    deinit {
        Bank.receive(coins: coinsInPurse)
    }
}

var playerOne: Player?  = Player(coins: 100)
print("A new player joined with \(String(describing: playerOne!.coinsInPurse)) coins")
print("There are now \(Bank.coinsInBank) coins in the bank")
 playerOne?.win(coins: 2_000)

print("PlayerOne won 2000 coins & now has \(playerOne!.coinsInPurse) coins")
print("The bank has \(Bank.coinsInBank) coins left")

playerOne = nil
print("playerOne left the game")
print("The bank has \(Bank.coinsInBank) coins")

//: [Next](@next)
 
