import Foundation

extension JSONDecoder {
    fileprivate static func create() -> JSONDecoder {
        let c = JSONDecoder()
        if #available(OSX 10.12, iOS 10.0, *) {
            c.dateDecodingStrategy = .iso8601
        }
        return c
    }
}

extension JSONEncoder {
    fileprivate static func create(outputFormatting: JSONEncoder.OutputFormatting) -> JSONEncoder {
        let c = JSONEncoder()
        c.outputFormatting = outputFormatting
        if #available(OSX 10.12, iOS 10.0, *) {
            c.dateEncodingStrategy = .iso8601
        }
        return c
    }
}

extension Decodable {
    public static func decodeFromJSON(data: Data) throws -> Self {
        return try JSONDecoder.create().decode(Self.self, from: data)
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
    public func encodeToJSONData(outputFormatting: JSONEncoder.OutputFormatting = .prettyPrinted) throws -> Data {
        let data = try JSONEncoder.create(outputFormatting: outputFormatting).encode(self)
        return data
    }
    
    public func storeToJSON(
        file: URL,
        outputFormatting: JSONEncoder.OutputFormatting = .prettyPrinted
    ) throws {
        let data = try encodeToJSONData(outputFormatting: outputFormatting)
        let dir = file.deletingLastPathComponent()
        try fm.createDirectory(at: dir)
        try data.write(to: file, options: [.atomic])
    }
}
