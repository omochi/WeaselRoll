public protocol Modifiable {}

extension Modifiable {
    @discardableResult
    public mutating func modify(_ f: (inout Self) throws -> Void) rethrows -> Self {
        try f(&self)
        return self
    }
    
    public func modified(_ f: (inout Self) throws -> Void) rethrows -> Self {
        var copy = self
        try copy.modify(f)
        return copy
    }
}
