#if canImport(GLKit)

import GLKit

extension GLKMatrix3: GLKMatrixProtocol {
    public typealias ColumnVector = GLKVector3
    public typealias RowVector = GLKVector3
    
    public init(_ e00: Float, _ e01: Float, _ e02: Float,
                _ e10: Float, _ e11: Float, _ e12: Float,
                _ e20: Float, _ e21: Float, _ e22: Float)
    {
        self = GLKMatrix3Make(
            e00, e10, e20,
            e01, e11, e21,
            e02, e12, e22
        )
    }
    
    public init(elements e: [Float]) {
        self.init(
            e[0], e[1], e[2],
            e[3], e[4], e[5],
            e[6], e[7], e[8]
        )
    }
    
    public init(columns c: [GLKVector3]) {
        self = GLKMatrix3MakeWithColumns(c[0], c[1], c[2])
    }
    
    public var elements: [Float] {
        get {
            return [
                m00, m10, m20,
                m01, m11, m21,
                m02, m12, m22
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

    public func row(at index: Int) -> GLKVector3 {
        GLKMatrix3GetRow(self, Int32(index))
    }

    public mutating func setRow(at index: Int, _ row: GLKVector3) {
        GLKMatrix3SetRow(self, Int32(index), row)
    }


    public func get(at row: Int, _ column: Int) -> Float {
        switch row {
        case 0:
            switch column {
            case 0: return m00
            case 1: return m10
            case 2: return m20
            default: break
            }
        case 1:
            switch column {
            case 0: return m01
            case 1: return m11
            case 2: return m21
            default: break
            }
        case 2:
            switch column {
            case 0: return m02
            case 1: return m12
            case 2: return m22
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
            default: break
            }
        case 1:
            switch column {
            case 0: m01 = value; return
            case 1: m11 = value; return
            case 2: m21 = value; return
            default: break
            }
        case 2:
            switch column {
            case 0: m02 = value; return
            case 1: m12 = value; return
            case 2: m22 = value; return
            default: break
            }
        default: break
        }
        preconditionFailure("invalid position: \(row), \(column)")
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

#endif
