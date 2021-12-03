import Foundation

public struct Rational: Codable, Equatable, Comparable, CustomStringConvertible {
    public var value: Int
    public var scale: Int
    
    public init(value: Int, scale: Int) {
        self.value = value
        self.scale = scale
    }
    
    public static func ==(a: Rational, b: Rational) -> Bool {
        a.value * b.scale == b.value * a.scale
    }
    
    public static func <(a: Rational, b: Rational) -> Bool {
        a.value * b.scale < b.value * a.scale
    }
    
    public func toFloat() -> Float {
        Float(value) / Float(scale)
    }
 
    public var description: String {
        "\(value)/\(scale)"
    }
}
