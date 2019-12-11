public protocol Modifiable {
    mutating func modify(_ f: (inout Self) throws -> Void) rethrows
    
    func modified(_ f: (inout Self) throws -> Void) rethrows -> Self
}

extension Modifiable {
    public mutating func modify(_ f: (inout Self) throws -> Void) rethrows {
        try f(&self)
    }
    
    public func modified(_ f: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try copy.modify(f)
        return copy
    }
}
