import GLKit
import CoreGraphics

extension GLKVector2: GLKVectorProtocol {
    public init(_ x: Float, _ y: Float) {
        self = GLKVector2Make(x, y)
    }
    
    public init(elements e: [Float]) {
        self.init(e[0], e[1])
    }
    
    public var elements: [Float] {
        get { [x, y] }
        set { self = GLKVector2(elements: newValue) }
    }
    
    public var length: Float {
        GLKVector2Length(self)
    }

    public func dot(_ other: GLKVector2) -> Float {
        GLKVector2DotProduct(self, other)
    }

    public func cross(_ other: GLKVector2) -> Float {
        x * other.y - y * other.x
    }
    
    public func rawNormalized() -> GLKVector2 {
        GLKVector2Normalize(self)
    }
    
    public func interpolate(to other: GLKVector2, rate: Float) -> GLKVector2 {
        GLKVector2Lerp(self, other, rate)
    }

    public func to3(z: Float) -> GLKVector3 {
        GLKVector3(x, y, z)
    }
    
    public static let zero = GLKVector2(0, 0)
    
    public static let ones = GLKVector2(1, 1)
    
    public static let unitX = GLKVector2(1, 0)
    
    public static let unitY = GLKVector2(0, 1)
    
    public static prefix func -(a: GLKVector2) -> GLKVector2 {
        GLKVector2Negate(a)
    }
    
    public static func +(a: GLKVector2, b: GLKVector2) -> GLKVector2 {
        GLKVector2Add(a, b)
    }
    
    public static func -(a: GLKVector2, b: GLKVector2) -> GLKVector2 {
        GLKVector2Subtract(a, b)
    }
    
    public static func *(a: Float, b: GLKVector2) -> GLKVector2 {
        GLKVector2MultiplyScalar(b, a)
    }

    public func toCGPoint() -> CGPoint {
        CGPoint(x: CGFloat(x), y: CGFloat(y))
    }

    public func toPoint() -> Point {
        Point(x, y)
    }
}

extension PointProtocol where Element: BinaryFloatingPoint {
    public func toGLKVector() -> GLKVector2 {
        GLKVector2(Float(x), Float(y))
    }
}

extension SizeProtocol where Element: BinaryFloatingPoint {
    public func toGLKVector() -> GLKVector2 {
        GLKVector2(Float(width), Float(height))
    }
}

