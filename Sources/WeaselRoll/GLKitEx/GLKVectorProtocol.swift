public protocol GLKVectorProtocol: CustomStringConvertible {
    init(elements: [Float])
    
    var elements: [Float] { get set }
    
    var isFinite: Bool { get }
    
    var length: Float { get }
    
    func rawNormalized() -> Self

    func normalized() -> Self?
    
    func distance(to target: Self) -> Float
    
    func direction(to target: Self) -> Self?
    
    func interpolate(to other: Self, rate: Float) -> Self
    
    static var zero: Self { get }
    
    static var ones: Self { get }
    
    static func +(a: Self, b: Self) -> Self
    static func +=(a: inout Self, b: Self)
    
    static func -(a: Self, b: Self) -> Self
    static func -=(a: inout Self, b: Self)
    
    static func *(a: Float, b: Self) -> Self
    static func *(a: Self, b: Float) -> Self
    static func *=(a: inout Self, b: Float)
    
    static func /(a: Self, b: Float) -> Self
    static func /=(a: inout Self, b: Float)
}

extension GLKVectorProtocol {
    public var description: String {
        elements.description
    }
    
    public var isFinite: Bool {
        elements.allSatisfy { $0.isFinite }
    }
    
    public func normalized() -> Self? {
        let ret = self.rawNormalized()
        return ret.isFinite ? ret : nil
    }
    
    public func distance(to target: Self) -> Float {
        (target - self).length
    }
    
    public func direction(to target: Self) -> Self? {
        (target - self).normalized()
    }
    
    public static func +=(a: inout Self, b: Self) {
        a = a + b
    }
    
    public static func -=(a: inout Self, b: Self) {
        a = a - b
    }
    
    public static func *(a: Self, b: Float) -> Self {
        b * a
    }
    
    public static func *=(a: inout Self, b: Float) {
        a = a * b
    }
    
    public static func /(a: Self, b: Float) -> Self {
        (1 / b) * a
    }

    public static func /=(a: inout Self, b: Float) {
        a = a / b
    }
}
