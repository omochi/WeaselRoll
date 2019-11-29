public extension Optional {
    func orThrow(_ error: @autoclosure () -> Error) throws -> Wrapped {
        if let x = self {
            return x
        }
        throw error()
    }
    
    func orThrow(_ message: @autoclosure () -> String) throws -> Wrapped {
        try orThrow(MessageError(message()))
    }
    
    mutating func consume<R>(_ f: (Wrapped) throws -> R) rethrows -> R? {
        guard let x = self else { return nil }
        self = nil
        return try f(x)
    }
    
    @discardableResult
    mutating func assume(_ f: () throws -> Wrapped) rethrows -> Wrapped {
        if let x = self { return x }
        let x = try f()
        self = x
        return x
    }
}
