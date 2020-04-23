public struct IntPoint: PointProtocol {
    public typealias Element = Int
    public typealias SizeType = IntSize

    public var x: Int
    public var y: Int

    public init(_ x: Int, _ y: Int) {
        self.x = x
        self.y = y
    }
}

extension PointProtocol where Element: BinaryFloatingPoint {
    public func toInt() -> IntPoint {
        IntPoint(Int(x), Int(y))
    }
}

extension PointProtocol where Element: BinaryInteger {
    public func toInt() -> IntPoint {
        IntPoint(Int(x), Int(y))
    }
}
