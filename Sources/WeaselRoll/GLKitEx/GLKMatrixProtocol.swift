import GLKit

public protocol GLKMatrixProtocol: CustomStringConvertible {
    associatedtype ColumnVector
    
    init(elements: [Float])
    
    init(columns: [ColumnVector])
    
    var elements: [Float] { get set }
    
    var transposed: Self { get }
    
    func rawInverted(isInvertible: inout Bool) -> Self
    
    func inverted() -> Self?
    
    func column(at index: Int) -> ColumnVector
    mutating func setColumn(at index: Int, _ column: ColumnVector)
    
    static var identity: Self { get }
    
    static func *(a: Self, b: Self) -> Self
    static func *=(a: inout Self, b: Self)
    
    static func *(a: Self, b: ColumnVector) -> ColumnVector
}

extension GLKMatrixProtocol {
    public var description: String {
        elements.description
    }
    
    public func inverted() -> Self? {
        var ok = false
        let ret = rawInverted(isInvertible: &ok)
        return ok ? ret : nil
    }
    
    public static func *=(a: inout Self, b: Self) {
        a = a * b
    }
}
