public protocol Modifiable {
    mutating func modify(_ f: (inout Self) -> Void)
}

extension Modifiable {
    public mutating func modify(_ f: (inout Self) -> Void) {
        f(&self)
    }
}
