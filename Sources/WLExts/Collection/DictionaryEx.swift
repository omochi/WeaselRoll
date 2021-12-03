import WeaselRoll

extension Dictionary {
    public func mustGet(for key: Key) throws -> Value {
        guard let value = self[key] else {
            throw MessageError("no value for key: key=\(key)")
        }
        return value
    }
}
