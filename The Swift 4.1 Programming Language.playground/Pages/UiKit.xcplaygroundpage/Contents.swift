//: [Previous](@previous)

import UIKit


let lbl = UILabel(frame: CGRect(x:0, y:0, width: 300, height:100))
lbl.text = "Hello StackOverflow!"

var attrString = NSMutableAttributedString(string: lbl.text!)

attrString.setAttributes([NSForegroundColorAttributeName: UIColor.red], range: NSRange(location: 6, length: 10))

lbl.attributedText = attrString

//: [Next](@next)
