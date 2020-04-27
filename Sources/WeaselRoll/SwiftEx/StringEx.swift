extension String {
    public func noneIfEmpty() -> String? {
        if isEmpty { return nil }
        return self
    }
}
