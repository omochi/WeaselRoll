import GLKit

extension GLKVector4: GLKVectorProtocol {
    public init(_ x: Float, _ y: Float, _ z: Float, _ w: Float) {
        self = GLKVector4Make(x, y, z, w)
    }
    
    public init(elements e: [Float]) {
        self.init(e[0], e[1], e[2], e[3])
    }
    
    public var elements: [Float] {
        get { [x, y, z, w] }
        set { self = GLKVector4(elements: newValue) }
    }
    
    public var length: Float {
        GLKVector4Length(self)
    }
    
    public func rawNormalized() -> GLKVector4 {
        GLKVector4Normalize(self)
    }
    
    public func interpolate(to other: GLKVector4, rate: Float) -> GLKVector4 {
        GLKVector4Lerp(self, other, rate)
    }
    
    public func to2() -> GLKVector2 {
        return GLKVector2(x, y)
    }
    
    public func to3() -> GLKVector3 {
        return GLKVector3(x, y, z)
    }
    
    public static let zero = GLKVector4(0, 0, 0, 0)
    
    public static var ones = GLKVector4(1, 1, 1, 1)
    
    public static let unitX = GLKVector4(1, 0, 0, 0)
    
    public static let unitY = GLKVector4(0, 1, 0, 0)
    
    public static let unitZ = GLKVector4(0, 0, 1, 0)
    
    public static let unitW = GLKVector4(0, 0, 0, 1)
    
    public static prefix func -(a: GLKVector4) -> GLKVector4 {
        GLKVector4Negate(a)
    }
    
    public static func +(a: GLKVector4, b: GLKVector4) -> GLKVector4 {
        return GLKVector4Add(a, b)
    }
    
    public static func -(a: GLKVector4, b: GLKVector4) -> GLKVector4 {
        return GLKVector4Subtract(a, b)
    }
    
    public static func *(a: Float, b: GLKVector4) -> GLKVector4 {
        return GLKVector4MultiplyScalar(b, a)
    }
}
