public protocol Modifiable {
    mutating func modify(_ f: (inout Self) -> Void)
}

public extension Modifiable {
    mutating func modify(_ f: (inout Self) -> Void) {
        f(&self)
    }
}
