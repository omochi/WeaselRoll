import GLKit

extension GLKMatrix3: GLKMatrixProtocol {
    public typealias ColumnVector = GLKVector3
    
    public init(_ e00: Float, _ e01: Float, _ e02: Float,
                _ e10: Float, _ e11: Float, _ e12: Float,
                _ e20: Float, _ e21: Float, _ e22: Float)
    {
        let m = GLKMatrix3Make(e00, e01, e02,
                               e10, e11, e12,
                               e20, e21, e22)
        self = m.transposed
    }
    
    public init(elements e: [Float]) {
        self.init(e[0], e[1], e[2],
                  e[3], e[4], e[5],
                  e[6], e[7], e[8])
    }
    
    public init(columns c: [GLKVector3]) {
        self = GLKMatrix3MakeWithColumns(c[0], c[1], c[2])
    }
    
    public var elements: [Float] {
        get {
            let m = self.transposed
            return [
                m.m00, m.m01, m.m02,
                m.m10, m.m11, m.m12,
                m.m20, m.m21, m.m22
            ]
        }
        set {
            self = GLKMatrix3(elements: newValue)
        }
    }
    
    public var transposed: GLKMatrix3 {
        GLKMatrix3Transpose(self)
    }
    
    public func rawInverted(isInvertible: inout Bool) -> GLKMatrix3 {
        GLKMatrix3Invert(self, &isInvertible)
    }
    
    public func column(at index: Int) -> GLKVector3 {
        GLKMatrix3GetColumn(self, Int32(index))
    }
    
    public mutating func setColumn(at index: Int, _ column: ColumnVector) {
        GLKMatrix3SetColumn(self, Int32(index), column)
    }
    
    public var determinant: Float {
        let a11 = m00
        let a12 = m10
        let a13 = m20
        let a21 = m01
        let a22 = m11
        let a23 = m21
        let a31 = m02
        let a32 = m12
        let a33 = m22
        
        return a11 * a22 * a33
            - a11 * a23 * a32
            - a12 * a21 * a33
            + a12 * a23 * a31
            + a13 * a21 * a32
            - a13 * a22 * a31
    }
    
    public static let identity = GLKMatrix3Identity
    
    public static func rotation(angle: Float, axis: GLKVector3) -> GLKMatrix3 {
        GLKMatrix3MakeRotation(GLKMathDegreesToRadians(angle),
                               axis.x, axis.y, axis.z)
    }
    
    public static func rotation(_ quaternion: GLKQuaternion) -> GLKMatrix3 {
        GLKMatrix3MakeWithQuaternion(quaternion)
    }
    
    public static func scale(_ scale: GLKVector3) -> GLKMatrix3 {
        GLKMatrix3MakeScale(scale.x, scale.y, scale.z)
    }
    
    public static func *(a: GLKMatrix3, b: GLKMatrix3) -> GLKMatrix3 {
        return GLKMatrix3Multiply(a, b)
    }
    
    public static func *(a: GLKMatrix3, b: GLKVector3) -> GLKVector3 {
        return GLKMatrix3MultiplyVector3(a, b)
    }
}
