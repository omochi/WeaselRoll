import GLKit
import CoreGraphics

// row major APIを提供する。
// 内部表現は column major。
extension GLKMatrix4: GLKMatrixProtocol {
    public typealias ColumnVector = GLKVector4
    public typealias RowVector = GLKVector4
    
    public init(_ e00: Float, _ e01: Float, _ e02: Float, _ e03: Float,
                _ e10: Float, _ e11: Float, _ e12: Float, _ e13: Float,
                _ e20: Float, _ e21: Float, _ e22: Float, _ e23: Float,
                _ e30: Float, _ e31: Float, _ e32: Float, _ e33: Float)
    {
        self = GLKMatrix4Make(
            e00, e10, e20, e30,
            e01, e11, e21, e31,
            e02, e12, e22, e32,
            e03, e13, e23, e33
        )
    }
    
    public init(elements e: [Float]) {
        self.init(
            e[0], e[1], e[2], e[3],
            e[4], e[5], e[6], e[7],
            e[8], e[9], e[10], e[11],
            e[12], e[13], e[14], e[15]
        )
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
            return [
                m00, m10, m20, m30,
                m01, m11, m21, m31,
                m02, m12, m22, m32,
                m03, m13, m23, m33
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

    public func row(at index: Int) -> GLKVector4 {
        GLKMatrix4GetRow(self, Int32(index))
    }

    public mutating func setRow(at index: Int, _ row: GLKVector4) {
        GLKMatrix4SetRow(self, Int32(index), row)
    }

    public func get(at row: Int, _ column: Int) -> Float {
        switch row {
        case 0:
            switch column {
            case 0: return m00
            case 1: return m10
            case 2: return m20
            case 3: return m30
            default: break
            }
        case 1:
            switch column {
            case 0: return m01
            case 1: return m11
            case 2: return m21
            case 3: return m31
            default: break
            }
        case 2:
            switch column {
            case 0: return m02
            case 1: return m12
            case 2: return m22
            case 3: return m32
            default: break
            }
        case 3:
            switch column {
            case 0: return m03
            case 1: return m13
            case 2: return m23
            case 3: return m33
            default: break
            }
        default: break
        }
        preconditionFailure("invalid position: \(row), \(column)")
    }

    public mutating func set(at row: Int, _ column: Int, _ value: Float) {
        switch row {
        case 0:
            switch column {
            case 0: m00 = value; return
            case 1: m10 = value; return
            case 2: m20 = value; return
            case 3: m30 = value; return
            default: break
            }
        case 1:
            switch column {
            case 0: m01 = value; return
            case 1: m11 = value; return
            case 2: m21 = value; return
            case 3: m31 = value; return
            default: break
            }
        case 2:
            switch column {
            case 0: m02 = value; return
            case 1: m12 = value; return
            case 2: m22 = value; return
            case 3: m32 = value; return
            default: break
            }
        case 3:
            switch column {
            case 0: m03 = value; return
            case 1: m13 = value; return
            case 2: m23 = value; return
            case 3: m33 = value; return
            default: break
            }
        default: break
        }
        preconditionFailure("invalid position: \(row), \(column)")
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

    // CGAffineTransformは行ベクトルに右からかける用なので転置する
    public func toCGAffineTransform() -> CGAffineTransform {
        return CGAffineTransform(
            a: CGFloat(get(at: 0, 0)),
            b: CGFloat(get(at: 1, 0)),
            c: CGFloat(get(at: 0, 1)),
            d: CGFloat(get(at: 1, 1)),
            tx: CGFloat(get(at: 3, 0)),
            ty: CGFloat(get(at: 3, 1))
        )
    }
}

extension CGAffineTransform {
    // CGAffineTransformは行ベクトルに右からかける用なので転置する
    public func toGLKMatrix4() -> GLKMatrix4 {
        GLKMatrix4(
            Float(a), Float(c), 0, Float(tx),
            Float(b), Float(d), 0, Float(ty),
            0, 0, 1, 0,
            0, 0, 0, 1
        )
    }
}

