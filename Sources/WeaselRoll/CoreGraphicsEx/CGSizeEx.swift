import CoreGraphics

extension CGSize: SizeProtocol {
    public typealias Element = CGFloat
    public typealias PointType = CGPoint
    public typealias RectType = CGRect

    public init(_ width: CGFloat, _ height: CGFloat) {
        self.init(width: width, height: height)
    }
}

extension SizeProtocol where Element: BinaryFloatingPoint {
    public func toCGSize() -> CGSize {
        CGSize(CGFloat(width), CGFloat(height))
    }
}

extension SizeProtocol where Element: BinaryInteger {
    public func toCGSize() -> CGSize {
        CGSize(CGFloat(width), CGFloat(height))
    }
}
