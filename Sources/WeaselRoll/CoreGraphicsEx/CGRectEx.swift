import CoreGraphics

extension CGRect: RectProtocol {
    public typealias Element = CGFloat
    public typealias SizeType = CGSize
}

extension RectProtocol where Element: BinaryFloatingPoint {
    public func toCGRect() -> CGRect {
        CGRect(origin: origin.toCGPoint(), size: size.toCGSize())
    }
}

extension RectProtocol where Element: BinaryInteger {
    public func toCGRect() -> CGRect {
        CGRect(origin: origin.toCGPoint(), size: size.toCGSize())
    }
}
