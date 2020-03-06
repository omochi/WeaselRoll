extension Sequence {
    public func compact<T>() -> [T] where Element == Optional<T> {
        return compactMap { $0 }
    }
}
