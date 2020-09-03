extension Dictionary {
    func mustGet(key: Key) throws -> Value {
        guard let value = self[key] else {
            throw MessageError("no value for key: key=\(key)")
        }
        return value
    }
}
