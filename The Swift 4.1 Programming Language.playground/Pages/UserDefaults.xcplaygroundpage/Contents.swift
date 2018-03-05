//: [Previous](@previous)

import Foundation

struct SearchTermHistory {
    let maxLenght = 3 //the maximum amount of search terms to store
    let searchTermHistoryKey = "SearchTermHistoryKey"
    
    func addSearchTerm(term: String) {
        //TODO:
        //1. Use NSUserDefaults to save the search term
        let defaults = UserDefaults.standard
        if var searchHistory = defaults.object(forKey: searchTermHistoryKey) as? [String] {
            //2. Check if search list is < 100
            if searchHistory.count >= maxLenght {
                searchHistory.removeSubrange((maxLenght-1)..<searchHistory.endIndex)
            }
            searchHistory.insert(term, at: 0)
        }
    }
    
    func retrieveSearchTermHistory() -> [String]? {
        //TODO
        //get search history from NSUserDefaults
        let defaults = UserDefaults.standard
        if let searchHistory = defaults.object(forKey: searchTermHistoryKey) as? [String] {
            return searchHistory
        } else {
            return nil
        }
    }
    
    var threadModeEnabled: Bool {
        get {
            UserDefaults.standard.register(defaults: [#function: false])
            return UserDefaults.standard.bool(forKey: #function)
        }
        
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
        }
    }
}

var s = SearchTermHistory()

s.addSearchTerm(term: "uno")
s.addSearchTerm(term: "dos")

print ("\(s.retrieveSearchTermHistory())")

let h = s.retrieveSearchTermHistory()
let contain  = h?.contains("uno")

if contain != nil && contain! {
    
}
print("value: \(s.threadModeEnabled)")
s.threadModeEnabled = true
print("value: \(s.threadModeEnabled)")

UserDefaults.standard.set(true, forKey: "threadModeEnabled")
let thread = UserDefaults.standard.bool(forKey: "threadModeEnabled")
//: [Next](@next)
