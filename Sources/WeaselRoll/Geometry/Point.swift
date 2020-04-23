public struct Point: PointProtocol {
    public typealias Element = Float
    public typealias SizeType = Size

    public var x: Float
    public var y: Float

    public init(_ x: Float, _ y: Float) {
        self.x = x
        self.y = y
    }
}

extension PointProtocol where Element: BinaryFloatingPoint {
    public func toFloat() -> Point {
        Point(Float(x), Float(y))
    }
}

extension PointProtocol where Element: BinaryInteger {
    public func toFloat() -> Point {
        Point(Float(x), Float(y))
    }
}
