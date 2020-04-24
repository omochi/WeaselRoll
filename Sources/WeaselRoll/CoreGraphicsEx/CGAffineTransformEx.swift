#if canImport(CoreGraphics)

import CoreGraphics

extension CGAffineTransform {
    public static func *(a: CGAffineTransform, b: CGAffineTransform) -> CGAffineTransform {
        a.concatenating(b)
    }
    public static func *=(a: inout CGAffineTransform, b: CGAffineTransform) {
        a = a * b
    }

    public static func *(a: CGPoint, b: CGAffineTransform) -> CGPoint {
        a.applying(b)
    }
    public static func *=(a: inout CGPoint, b: CGAffineTransform) {
        a = a * b
    }

    public static func *(a: CGSize, b: CGAffineTransform) -> CGSize {
        a.applying(b)
    }
    public static func *=(a: inout CGSize, b: CGAffineTransform) {
        a = a * b
    }

    public static func *(a: CGRect, b: CGAffineTransform) -> CGRect {
        a.applying(b)
    }
    public static func *=(a: inout CGRect, b: CGAffineTransform) {
        a = a * b
    }
}

extension Angle90 {
    public func toImageRotation<T>(size: T) -> CGAffineTransform where
        T: SizeProtocol, T.Element: BinaryFloatingPoint
    {
        switch self {
        case ._0: return .identity
        case ._90:
            return CGAffineTransform(rotationAngle: Angles.toRadian(90)) *
                CGAffineTransform(translationX: CGFloat(size.height), y: 0)
        case ._180:
            return CGAffineTransform(rotationAngle: Angles.toRadian(180)) *
                CGAffineTransform(translationX: CGFloat(size.width), y: CGFloat(size.height))
        case .minus90:
            return CGAffineTransform(rotationAngle: Angles.toRadian(-90)) *
                CGAffineTransform(translationX: 0, y: -CGFloat(size.width))
        }
    }
}

#endif
