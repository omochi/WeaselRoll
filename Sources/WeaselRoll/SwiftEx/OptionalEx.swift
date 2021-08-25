infix operator ??=: AssignmentPrecedence

extension Optional {
    public func orThrow(error: @autoclosure () -> Error) throws -> Wrapped {
        if let x = self {
            return x
        }
        throw error()
    }

    public mutating func consume<R>(_ f: (Wrapped) throws -> R) rethrows -> R? {
        guard let x = self else { return nil }
        self = nil
        return try f(x)
    }
    
    @discardableResult
    public mutating func ensure(_ f: () throws -> Wrapped) rethrows -> Wrapped {
        if let x = self { return x }
        let x = try f()
        self = x
        return x
    }

    public static func ??=(a: inout Self, b: Self) {
        a = a ?? b
    }
}
