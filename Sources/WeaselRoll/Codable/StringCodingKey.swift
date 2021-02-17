public struct StringCodingKey: Swift.CodingKey {
    public init(_ value: String) {
        self.value = value
    }

    public var value: String

    public var stringValue: String { value }

    public init(stringValue: String) {
        self.init(stringValue)
    }

    public var intValue: Int? { Int(stringValue) }

    public init(intValue: Int) {
        self.init(intValue.description)
    }
}
