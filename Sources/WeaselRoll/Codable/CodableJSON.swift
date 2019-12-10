import Foundation

extension Decodable {
    public static func decodeFromJSON(data: Data) throws -> Self {
        let decoder = JSONDecoder()
        return try decoder.decode(Self.self, from: data)
    }
    
    public static func loadFromJSON(file: URL) throws -> Self {
        let data = try Data(contentsOf: file)
        return try decodeFromJSON(data: data)
    }
    
    public static func loadFromJSONIfExists(file: URL) throws -> Self? {
        guard fm.fileExists(at: file) else {
            return nil
        }
        return try loadFromJSON(file: file)
    }
}

extension Encodable {
    public func encodeToJSONData() throws -> Data {
        let encoder = JSONEncoder()
        let data = try encoder.encode(self)
        return data
    }
    
    public func storeToJSON(file: URL) throws {
        let data = try encodeToJSONData()
        let dir = file.deletingLastPathComponent()
        try fm.createDirectory(at: dir, withIntermediateDirectories: true)
        try data.write(to: file, options: [.atomic])
    }
}
