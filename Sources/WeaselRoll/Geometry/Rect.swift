public struct Rect: RectProtocol {
    public typealias Element = Float
    public typealias SizeType = Size

    public var origin: Point
    public var size: Size

    public init(origin: Point, size: Size) {
        self.origin = origin
        self.size = size
    }
}

extension RectProtocol where Element: BinaryFloatingPoint {
    public func toFloat() -> Rect {
        Rect(origin: origin.toFloat(), size: size.toFloat())
    }
}

extension RectProtocol where Element: BinaryInteger {
    public func toFloat() -> Rect {
        Rect(origin: origin.toFloat(), size: size.toFloat())
    }
}
