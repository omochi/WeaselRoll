import GLKit

extension GLKVector3: GLKVectorProtocol {
    public init(_ x: Float, _ y: Float, _ z: Float) {
        self = GLKVector3Make(x, y, z)
    }
    
    public init(elements e: [Float]) {
        self.init(e[0], e[1], e[2])
    }
    
    public var elements: [Float] {
        get { [x, y, z] }
        set { self = GLKVector3(elements: newValue) }
    }
    
    public var length: Float {
        GLKVector3Length(self)
    }
    
    public func dot(_ other: GLKVector3) -> Float {
        GLKVector3DotProduct(self, other)
    }
    
    public func cross(_ other: GLKVector3) -> GLKVector3 {
        GLKVector3CrossProduct(self, other)
    }
    
    public func rawNormalized() -> GLKVector3 {
        GLKVector3Normalize(self)
    }
    
    public func interpolate(to other: GLKVector3, rate: Float) -> GLKVector3 {
        GLKVector3Lerp(self, other, rate)
    }
    
    public func to2() -> GLKVector2 {
        return GLKVector2(x, y)
    }
    
    public func to4(w: Float) -> GLKVector4 {
        return GLKVector4(x, y, z, w)
    }

    public static let zero = GLKVector3(0, 0, 0)
    
    public static var ones = GLKVector3(1, 1, 1)
    
    public static let unitX = GLKVector3(1, 0, 0)
    
    public static let unitY = GLKVector3(0, 1, 0)
    
    public static let unitZ = GLKVector3(0, 0, 1)
    
    public static func +(a: GLKVector3, b: GLKVector3) -> GLKVector3 {
        return GLKVector3Add(a, b)
    }
    
    public static func -(a: GLKVector3, b: GLKVector3) -> GLKVector3 {
        return GLKVector3Subtract(a, b)
    }
    
    public static func *(a: Float, b: GLKVector3) -> GLKVector3 {
        return GLKVector3MultiplyScalar(b, a)
    }
}
