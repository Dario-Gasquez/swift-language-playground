//: [Previous](@previous)

//: # Type Casting
//: *Type casting* is a way to check the type of an instance, or to treat that instance as a different superclass or subclass from somewhere else in its own class hierarchy.

//: ## Defining a Class Hierarchy for Type Casting

class MediaItem {
    var name: String
    init(name: String) {
        self.name = name
    }
}


class Movie: MediaItem {
    var director: String
    
    init(name: String, director: String) {
        self.director = director
        super.init(name: name)
    }
}

class Song: MediaItem {
    var artist: String
    init(name: String, artist: String) {
        self.artist = artist
        super.init(name: name)
    }
}

let mediaLibrary = [
    Movie(name: "Casablanca", director: "Curtiz"),
    Song(name: "Blue suede Shoes", artist: "Elvis Presley"),
    Movie(name: "Citizen Kane", director: "Orson Welles"),
    Song(name: "The One and Only", artist: "Chesney Hawkes"),
    Song(name: "Never Gonna Give You Up", artist: "Rick Astley")
]

//: ## Checking Type
//: Use the *type check operator* `is` to check whether an instance is of a certain subclass type.

var movieCount = 0
var songCount = 0

for item in mediaLibrary {
    if item is Movie {
        movieCount += 1
    } else if item is Song {
        songCount += 1
    }
}

print("Media library contains \(movieCount) movies and \(songCount) songs\n")

//: ## Downcasting
//: A constant or variable of a certain class type may actually refer to an instance of a subclass behind the scenes. Where you believe this is the case, you can try to downcast to the subclass type with a type cast operator (`as?` or `as!`).
//: - Note: Use the forced form of the type cast operator (`as!`) only when you are sure that the downcast will always succeed. This form of the operator will trigger a runtime error if you try to downcast to an incorrect class type.
for item in mediaLibrary {
    if let movie = item as? Movie {
        print("Movie: \(movie.name) was directed by: \(movie.director)")
    } else if let song = item as? Song {
        print("Song: \(song.name), by \(song.artist)")
    }
}

//: ## Type Casting for Any and AnyObject
/*:
 Swift provides two special types for working with nonspecific types:
 
 - `Any` can represent an instance of any type at all, including function types.
 - `AnyObject` can represent an instance of any class type.

 Use `Any` and `AnyObject` only when you explicitly need the behavior and capabilities they provide. It is always better to be specific about the types you expect to work with in your code.
 */

var things = [Any]()

things.append(0)
things.append(0.0)
things.append(42)
things.append(3.14159)
things.append("hello")
things.append((3.0, 5.0))
things.append(Movie(name: "Ghostbusters", director: "Reitman"))
things.append({ (name:String) -> String in "Hello \(name)." })

for thing in things {
    switch thing {
    case 0 as Int:
        print("zero as an Int")
    case 0 as Double:
        print("zero as a Double")
    case let someInt as Int:
        print("an integer value: \(someInt)")
    case let someDouble as Double where someDouble > 0:
        print("a positive double: \(someDouble)")
    case is Double:
        print("another double")
    case let someString as String:
        print("A string with a value: '\(someString)' ")
    case let (x, y) as (Double, Double):
        print("the (\(x), \(y)) tuple")
    case let movie as Movie:
        print("The \(movie.name) movie directed by \(movie.director)")
    case let stringConverter as (String)->String:
        print(stringConverter("Michael"))
    default:
        print("something else")
    }
}

//: - Note: The `Any` type represents values of any type, including optional types. Swift gives you a warning if you use an optional value where a value of type `Any` is expected. If you really do need to use an optional value as an `Any` value, you can use the `as` operator to explicitly cast the optional to `Any`, as shown below.

let optionalNumber: Int? = 3
things.append(optionalNumber) //warning
things.append(optionalNumber as Any) //no warning

//: [Next](@next)
