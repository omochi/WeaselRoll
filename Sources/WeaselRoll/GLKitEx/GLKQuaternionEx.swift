import GLKit

extension GLKQuaternion {
    public init(_ x: Float, _ y: Float, _ z: Float, _ w: Float) {
        self = GLKQuaternionMake(x, y, z, w)
    }
    
    public init(elements e: [Float]) {
        self = GLKQuaternion(e[0], e[1], e[2], e[3])
    }
    
    public init(_ matrix: GLKMatrix3) {
        self = GLKQuaternionMakeWithMatrix3(matrix)
    }
    
    public init(_ matrix: GLKMatrix4) {
        self = GLKQuaternionMakeWithMatrix4(matrix)
    }

    public var elements: [Float] {
        get {
            return [x, y, z, w]
        }
        set {
            self = GLKQuaternion(elements: newValue)
        }
    }

    
    public func interpolate(to other: GLKQuaternion, rate: Float) -> GLKQuaternion {
        GLKQuaternionSlerp(self, other, rate)
    }
    
    public func rotate(_ vector: GLKVector3) -> GLKVector3 {
        GLKQuaternionRotateVector3(self, vector)
    }
}

extension GLKQuaternion: CustomStringConvertible {
    public var description: String {
        elements.description
    }
}
