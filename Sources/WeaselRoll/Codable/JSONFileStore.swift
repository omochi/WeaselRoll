import Foundation

public final class JSONFileStore<T: Codable> {
    public typealias Value = T
    private let file: URL
    private var value: T

    public init(file: URL, defaultValue: T) throws {
        self.file = file
        self.value = try T.loadFromJSONIfExists(file: file) ?? defaultValue
    }
    
    public func load() -> T {
        return value
    }
    
    public func store(_ value: T) throws {
        self.value = value
        try value.storeToJSON(file: file)
    }
}
