public protocol Scopeable {}

extension Scopeable {
    public func `let`<R>(_ f: (Self) throws -> R) rethrows -> R {
        return try f(self)
    }

    public func also(_ f: (Self) throws -> Void) rethrows -> Self {
        try f(self)
        return self
    }

    @discardableResult
    public mutating func modify(_ f: (inout Self) throws -> Void) rethrows -> Self {
        try f(&self)
        return self
    }

    public func modified(_ f: (inout Self) throws -> Void) rethrows -> Self {
        var temp = self
        try f(&temp)
        return temp
    }
}
