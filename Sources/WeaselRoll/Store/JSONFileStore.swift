import Foundation

public final class JSONFileStore<Value: Codable>: StoreProtocol {
    public typealias Value = Value
    private let file: URL
    private let defaultValue: Value
    private var cache: Value?
    public var isCacheEnabled: Bool {
        didSet {
            if !isCacheEnabled {
                discardCache()
            }
        }
    }

    public init(file: URL, defaultValue: Value, isCacheEnabled: Bool = false) {
        self.file = file
        self.defaultValue = defaultValue
        self.isCacheEnabled = isCacheEnabled
    }

    public convenience init<T>(file: URL, isCacheEnabled: Bool = false) where T? == Value {
        self.init(file: file, defaultValue: nil, isCacheEnabled: isCacheEnabled)
    }

    public func load() throws -> Value {
        if let cache = self.cache {
            return cache
        }

        let value = try JSONCodables.loadFromJSONIfExists(
            type: Value.self, file: file
        ) ?? defaultValue

        if isCacheEnabled {
            self.cache = value
        }

        return value
    }

    public func store(_ value: Value) throws {
        try JSONCodables.storeToJSON(value: value, file: file)

        if isCacheEnabled {
            self.cache = value
        }
    }

    public func discardCache() {
        cache = nil
    }
}

