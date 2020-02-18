import CoreGraphics
import GLKit

extension CGPoint {
    public func toCGSize() -> CGSize {
        CGSize(width: x, height: y)
    }
    
    public func toGLKVector() -> GLKVector2 {
        GLKVector2(Float(x), Float(y))
    }
    
    public static func +(a: CGPoint, b: CGSize) -> CGPoint {
        CGPoint(x: a.x + b.width, y: a.y + b.height)
    }
    
    public static func +=(a: inout CGPoint, b: CGSize) {
        a = a + b
    }
    
    public static func -(a: CGPoint, b: CGSize) -> CGPoint {
        CGPoint(x: a.x - b.width, y: a.y - b.height)
    }
    
    public static func -=(a: inout CGPoint, b: CGSize) {
        a = a - b
    }
    
    public static func -(a: CGPoint, b: CGPoint) -> CGSize {
        CGSize(width: a.x - b.x, height: a.y - b.y)
    }
    
    public static func *(a: CGFloat, b: CGPoint) -> CGPoint {
        CGPoint(x: a * b.x, y: a * b.y)
    }
    
    public static func *(a: CGPoint, b: CGFloat) -> CGPoint {
        b * a
    }
    
    public static func *=(a: inout CGPoint, b: CGFloat) {
        a = a * b
    }
    
    public static func /(a: CGPoint, b: CGFloat) -> CGPoint {
        CGPoint(x: a.x / b, y: a.y / b)
    }
    
    public static func /=(a: inout CGPoint, b: CGFloat) {
        a = a / b
    }    
}

extension CGSize {
    public var transposed: CGSize {
        CGSize(width: height, height: width)
    }
    
    public func fit(width: CGFloat) -> CGSize {
        CGSize(width: width,
               height: width * self.height / self.width)
    }
    
    public func fit(height: CGFloat) -> CGSize {
        CGSize(width: height * self.width / self.height,
               height: height)
    }
    
    public func fit(size: CGSize) -> CGSize {
        if width * size.height >= height * size.width {
            return fit(width: size.width)
        } else {
            return fit(height: size.height)
        }
    }
    
    public func fill(size: CGSize) -> CGSize {
        if width * size.height >= height * size.width {
            return fit(height: size.width)
        } else {
            return fit(width: size.height)
        }
    }
    
    public func fit(widthOf bounds: CGRect) -> CGRect {
        let size = self.fit(width: bounds.width)
        return CGRect(x: bounds.minX,
                      y: bounds.minY + 0.5 * (bounds.height - size.height),
                      width: size.width,
                      height: size.height)
    }
    
    public func fit(heightOf bounds: CGRect) -> CGRect {
        let size = self.fit(height: bounds.height)
        return CGRect(x: bounds.minX + 0.5 * (bounds.width - size.width),
                      y: bounds.minY,
                      width: size.width,
                      height: size.height)
    }
    
    public func fit(bounds: CGRect) -> CGRect {
        if width * bounds.height >= height * bounds.width {
            return fit(widthOf: bounds)
        } else {
            return fit(heightOf: bounds)
        }
    }
    
    public func fill(bounds: CGRect) -> CGRect {
        if width * bounds.height >= height * bounds.width {
            return fit(heightOf: bounds)
        } else {
            return fit(widthOf: bounds)
        }
    }
    
    public func toCGPoint() -> CGPoint {
        CGPoint(x: width, y: height)
    }
    
    public static func +(a: CGSize, b: CGSize) -> CGSize {
        CGSize(width: a.width + b.width, height: a.height + b.height)
    }
    
    public static func +=(a: inout CGSize, b: CGSize) {
        a = a + b
    }
    
    public static func -(a: CGSize, b: CGSize) -> CGSize {
        CGSize(width: a.width - b.width, height: a.height - b.height)
    }
    
    public static func -=(a: inout CGSize, b: CGSize) {
        a = a - b
    }
    
    public static func *(a: CGSize, b: CGFloat) -> CGSize {
        b * a
    }
    
    public static func *=(a: inout CGSize, b: CGFloat) {
        a = a * b
    }
    
    public static func *(a: CGFloat, b: CGSize) -> CGSize {
        CGSize(width: a * b.width, height: a * b.height)
    }

    public static func /(a: CGSize, b: CGFloat) -> CGSize {
        CGSize(width: a.width / b, height: a.height / b)
    }
    
    public static func /=(a: inout CGSize, b: CGFloat) {
        a = a / b
    }
}

extension CGRect {
    public init(center: CGPoint, size: CGSize) {
        self.init(origin: center - size / 2,
                  size: size)
    }
    
    public var center: CGPoint {
        origin + size / 2
    }
    
    public var end: CGPoint {
        origin + size
    }
}
