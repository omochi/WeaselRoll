public func clamp<T: Comparable>(_ x: T, min mi: T, max ma: T) -> T {
    return max(mi, min(x, ma))
}

