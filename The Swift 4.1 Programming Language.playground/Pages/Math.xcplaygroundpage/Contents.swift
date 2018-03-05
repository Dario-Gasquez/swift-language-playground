//: [Previous](@previous)
import Foundation
import CoreGraphics

//Option A:
//extension Comparable {
//    func closedClamped(to limits: ClosedRange<Self>) -> Self {
//        return min(max(self, limits.lowerBound), limits.upperBound)
//    }
//}
//
//extension ClosedRange {
//    func clamp(_ value : Bound) -> Bound {
//        return self.lowerBound > value ? self.lowerBound
//            : self.upperBound < value ? self.upperBound
//            : value
//    }
//}


//Option B
protocol ClampableCountable {
    associatedtype Bound : Comparable
    var upperBound: Bound { get }
    var lowerBound: Bound { get }
    var isEmpty: Bool { get }
}


protocol ClampableNonCountable: ClampableCountable {
    associatedtype Bound: FloatingPoint
}

protocol ClampablCountableRange: ClampableCountable {
    func clamp(_ value: Bound) -> Bound
}

protocol ClampableNonCountableRange: ClampableNonCountable {
    func clamp(_ value: Bound) -> Bound?
}

extension ClampablCountableRange {
    func clamp(_ value: Bound) -> Bound {
        return min(max(lowerBound, value), upperBound)
    }
}

extension ClampableNonCountableRange {
    func clamp(_ value: Bound) -> Bound? {
        guard !isEmpty else { return nil }
        
        if value < self.lowerBound {
            return self.lowerBound
        } else if value >= self.upperBound {
            return self.upperBound.nextDown
        } else {
            return value
        }
    }
}

extension Range : ClampableNonCountableRange {}
extension ClosedRange : ClampableNonCountableRange {}

extension CountableRange : ClampablCountableRange {}
extension CountableClosedRange : ClampablCountableRange {}


//Test
let aFloat: Float = 10
let aDouble: Double = 5
let aCGFloat: CGFloat = 101.5
let stride: Strideable

let countableClosed = 0...1
countableClosed.isEmpty

let closedRange = 0...1.5
closedRange.isEmpty

let rangehalfOpen = 1.5..<1.500000
rangehalfOpen.clamped(to: 0..<10)
rangehalfOpen.isEmpty
rangehalfOpen.lowerBound
let upperRange = rangehalfOpen.upperBound
let nextRange = rangehalfOpen.upperBound.nextDown
Darwin.nextafter(rangehalfOpen.upperBound, -Double.infinity)

let countableRange = 1..<2
countableRange.clamped(to: 0..<10)
countableRange.isEmpty
countableRange.lowerBound
let upper = countableRange.upperBound
//let upper2 = countableRange.upperBound.nextDown //nextDown not available in integer type
//Darwin.nextafter(countableRange.upperBound, -Double.infinity) //can not invoce nextafter on integer type



(0...20).clamp(10)
rangehalfOpen.clamp(Double(aFloat))
rangehalfOpen.clamp(aDouble)
//aFloat.closedClamped(to: 0...12)
//aFloat.customClamped(to: 0..<12)
//aDouble.customClamped(to: 0..<5)
//aDouble.closedClamped(to: 0...5)
//aDouble.customClamped(to: 0..<6)
//aDouble.closedClamped(to: 0...6)
//: [Next](@next)
