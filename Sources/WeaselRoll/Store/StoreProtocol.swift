public protocol StoreProtocol {
    associatedtype Value

    func load() throws -> Value
    func store(_ value: Value) throws
}

extension StoreProtocol {
    @discardableResult
    public func modify(_ f: (inout Value) throws -> Void) throws -> Value {
        var value = try load()
        try f(&value)
        try store(value)
        return value
    }
}
