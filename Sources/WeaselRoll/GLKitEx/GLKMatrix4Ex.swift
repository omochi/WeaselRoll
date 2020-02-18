import GLKit

extension GLKMatrix4: GLKMatrixProtocol {
    public typealias ColumnVector = GLKVector4
    
    public init(_ e00: Float, _ e01: Float, _ e02: Float, _ e03: Float,
                _ e10: Float, _ e11: Float, _ e12: Float, _ e13: Float,
                _ e20: Float, _ e21: Float, _ e22: Float, _ e23: Float,
                _ e30: Float, _ e31: Float, _ e32: Float, _ e33: Float)
    {
        let m = GLKMatrix4Make(e00, e01, e02, e03,
                               e10, e11, e12, e13,
                               e20, e21, e22, e23,
                               e30, e31, e32, e33)
        self = m.transposed
    }
    
    public init(elements e: [Float]) {
        self.init(e[0], e[1], e[2], e[3],
                  e[4], e[5], e[6], e[7],
                  e[8], e[9], e[10], e[11],
                  e[12], e[13], e[14], e[15])
    }
    
    public init(columns c: [GLKVector4]) {
        self = GLKMatrix4MakeWithColumns(c[0], c[1], c[2], c[3])
    }
    
    public init(matrix3 m3: GLKMatrix3, translation t: GLKVector3) {
        self.init(columns: [
            m3.column(at: 0).to4(w: 0),
            m3.column(at: 1).to4(w: 0),
            m3.column(at: 2).to4(w: 0),
            t.to4(w: 1)
        ])
    }
    
    public var elements: [Float] {
        get {
            let m = self.transposed
            return [
                m.m00, m.m01, m.m02, m.m03,
                m.m10, m.m11, m.m12, m.m13,
                m.m20, m.m21, m.m22, m.m23,
                m.m30, m.m31, m.m32, m.m33
            ]
        }
        set {
            self = GLKMatrix4(elements: newValue)
        }
    }
    
    public var transposed: GLKMatrix4 {
        GLKMatrix4Transpose(self)
    }
    
    public func rawInverted(isInvertible: inout Bool) -> GLKMatrix4 {
        GLKMatrix4Invert(self, &isInvertible)
    }
    
    public func column(at index: Int) -> GLKVector4 {
        GLKMatrix4GetColumn(self, Int32(index))
    }
    
    public mutating func setColumn(at index: Int, _ column: ColumnVector) {
        GLKMatrix4SetColumn(self, Int32(index), column)
    }
    
    public func transform(_ vector: GLKVector3) -> GLKVector3 {
        GLKMatrix4MultiplyAndProjectVector3(self, vector)
    }

    public var translation: GLKVector3 {
        column(at: 3).to3()
    }
    
    public var matrix3: GLKMatrix3 {
        GLKMatrix4GetMatrix3(self)
    }
    
    public static let identity = GLKMatrix4Identity
    
    public static func translation(_ t: GLKVector3) -> GLKMatrix4 {
        GLKMatrix4MakeTranslation(t.x, t.y, t.z)
    }
    
    public static func rotation(angle: Float, axis: GLKVector3) -> GLKMatrix4 {
        return GLKMatrix4MakeRotation(GLKMathDegreesToRadians(angle), axis.x, axis.y, axis.z)
    }
    
    public static func rotation(_ quaternion: GLKQuaternion) -> GLKMatrix4 {
        return GLKMatrix4MakeWithQuaternion(quaternion)
    }
    
    public static func scale(_ s: GLKVector3) -> GLKMatrix4 {
        return GLKMatrix4MakeScale(s.x, s.y, s.z)
    }
    
    public static func lookAt(position: GLKVector3,
                              target: GLKVector3,
                              up: GLKVector3)
        -> GLKMatrix4
    {
        let m = GLKMatrix4MakeLookAt(position.x, position.y, position.z,
                                     target.x, target.y, target.z,
                                     up.x, up.y, up.z)
        return m.inverted()!
    }
    
    public static func frustum(fovY: Float,
                               width: Float,
                               height: Float,
                               near: Float,
                               far: Float) -> GLKMatrix4
    {
        let sy = 1.0 / tan(GLKMathDegreesToRadians(fovY / 2))
        let sx = sy * height / width
        let c = -(far + near) / (far - near)
        let d = -2 * far * near / (far - near)
        let m = GLKMatrix4(sx, 0, 0, 0,
                           0, sy, 0, 0,
                           0, 0, c, d,
                           0, 0, -1, 0)
        return m
    }
    
    public static func *(a: GLKMatrix4, b: GLKMatrix4) -> GLKMatrix4 {
        return GLKMatrix4Multiply(a, b)
    }
    
    public static func *(a: GLKMatrix4, b: GLKVector4) -> GLKVector4 {
        return GLKMatrix4MultiplyVector4(a, b)
    }
}
