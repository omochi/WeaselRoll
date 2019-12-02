public func clamp<T: Comparable>(_ x: T, min mi: T, max ma: T) -> T {
    max(mi, min(x, ma))
}

public func toDegree<T: FloatingPoint>(_ x: T) -> T {
    x * T(180) / T.pi
}

public func toRadian<T: FloatingPoint>(_ x: T) -> T {
    x * T.pi / T(180)
}
