import CoreGraphics

extension CGPoint: PointProtocol {
    public typealias Element = CGFloat
    public typealias SizeType = CGSize
    public typealias RectType = CGRect

    public init(_ x: CGFloat, _ y: CGFloat) {
        self.init(x: x, y: y)
    }
}

extension PointProtocol where Element: BinaryFloatingPoint {
    public func toCGPoint() -> CGPoint {
        CGPoint(CGFloat(x), CGFloat(y))
    }
}

extension PointProtocol where Element: BinaryInteger {
    public func toCGPoint() -> CGPoint {
        CGPoint(CGFloat(x), CGFloat(y))
    }
}
