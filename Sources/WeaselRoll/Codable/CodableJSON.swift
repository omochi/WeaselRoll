import Foundation

extension JSONDecoder {
    public static let shared: JSONDecoder = {
        let c = JSONDecoder()
        if #available(OSX 10.12, iOS 10.0, *) {
            c.dateDecodingStrategy = .iso8601
        }
        return c
    }()
}

extension JSONEncoder {
    public static let shared: JSONEncoder = {
        let c = JSONEncoder()
        if #available(OSX 10.12, iOS 10.0, *) {
            c.dateEncodingStrategy = .iso8601
        }
        return c
    }()
}

extension Decodable {
    public static func decodeFromJSON(data: Data) throws -> Self {
        return try JSONDecoder.shared.decode(Self.self, from: data)
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
        let data = try JSONEncoder.shared.encode(self)
        return data
    }
    
    public func storeToJSON(file: URL) throws {
        let data = try encodeToJSONData()
        let dir = file.deletingLastPathComponent()
        try fm.createDirectory(at: dir)
        try data.write(to: file, options: [.atomic])
    }
}
