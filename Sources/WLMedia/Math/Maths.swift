public func clamp<T: Comparable>(_ x: T, min mi: T, max ma: T) -> T {
    max(mi, min(x, ma))
}
