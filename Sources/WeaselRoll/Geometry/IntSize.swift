public struct IntSize: SizeProtocol {
    public typealias Element = Int
    public typealias PointType = IntPoint
    public typealias RectType = IntRect

    public var width: Int
    public var height: Int
    
    public init(_ width: Int, _ height: Int) {
        self.width = width
        self.height = height
    }
}

extension SizeProtocol where Element: BinaryFloatingPoint {
    public func toInt() -> IntSize {
        IntSize(Int(width), Int(height))
    }
}

extension SizeProtocol where Element: BinaryInteger {
    public func toInt() -> IntSize {
        IntSize(Int(width), Int(height))
    }
}
