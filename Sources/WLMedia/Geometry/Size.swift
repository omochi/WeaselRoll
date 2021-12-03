public struct Size: SizeProtocol {
    public typealias Element = Float
    public typealias PointType = Point
    public typealias RectType = Rect

    public var width: Float
    public var height: Float
    
    public init(_ width: Float,
                _ height: Float)
    {
        self.width = width
        self.height = height
    }
}

extension SizeProtocol where Element: BinaryFloatingPoint {
    public func toFloat() -> Size {
        Size(Float(width), Float(height))
    }
}

extension SizeProtocol where Element: BinaryInteger {
    public func toFloat() -> Size {
        Size(Float(width), Float(height))
    }
}

