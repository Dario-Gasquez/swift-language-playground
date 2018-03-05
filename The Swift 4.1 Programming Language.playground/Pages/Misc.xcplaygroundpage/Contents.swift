//: [Previous](@previous)

import Foundation

var str = "Hello, playground"

let nsecpersec = NSEC_PER_SEC
let intervalSwift2 = NSEC_PER_SEC / 30
let intervalSwift3 = DispatchTimeInterval.nanoseconds(Int(NSEC_PER_SEC/30))

let leewaySwift2 = NSEC_PER_MSEC * 20
let leewaySwift3 = DispatchTimeInterval.milliseconds(20)

let stickerPath = "/docs/stickers"
let directory =  "thumb"
let stickerID = 155


extension String {
    
    var deletingPathExtension: String {
        return (self as NSString).deletingPathExtension
    }
    
    var lastPathComponent: String {
        return (self as NSString).lastPathComponent
    }

    func appendingPathComponent(_ pathComponent: String) -> String {
        return (self as NSString).appendingPathComponent(pathComponent)
    }
}

var path = stickerPath.appendingPathComponent(directory)
path = path.appendingPathComponent(String(stickerID))
//path = path.appendingPathExtension(imageExtension)

guard let length = textEntryTextField.text?.length, length > 0 else { success = false }

let success = textEntryTextField.text?.length > 0

//: [Next](@next)
