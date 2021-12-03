import Foundation

public enum JSONCodables {
    private static func decoder() -> JSONDecoder {
        let c = JSONDecoder()
        if #available(OSX 10.12, iOS 10.0, tvOS 10.0, *) {
            c.dateDecodingStrategy = .iso8601
        }
        return c
    }

    private static func encoder(outputFormatting: JSONEncoder.OutputFormatting) -> JSONEncoder {
        let c = JSONEncoder()
        c.outputFormatting = outputFormatting
        if #available(OSX 10.12, iOS 10.0, tvOS 10.0, *) {
            c.dateEncodingStrategy = .iso8601
        }
        return c
    }

    private static let fm = FileManagerEx(manager: .default)

    public static func decodeFromJSON<T: Decodable>(type: T.Type, data: Data) throws -> T {
        return try decoder().decode(type, from: data)
    }

    public static func loadFromJSON<T: Decodable>(type: T.Type, file: URL) throws -> T {
        let data = try Data(contentsOf: file)
        return try decodeFromJSON(type: type, data: data)
    }

    public static func loadFromJSONIfExists<T: Decodable>(type: T.Type, file: URL) throws -> T? {
        guard fm.fileExists(at: file) else {
            return nil
        }
        return try loadFromJSON(type: type, file: file)
    }

    public static func encodeToJSONData<T: Encodable>(
        value: T,
        outputFormatting: JSONEncoder.OutputFormatting = .prettyPrinted
    ) throws -> Data {
        let data = try encoder(outputFormatting: outputFormatting).encode(value)
        return data
    }

    public static func storeToJSON<T: Encodable>(
        value: T,
        file: URL,
        outputFormatting: JSONEncoder.OutputFormatting = .prettyPrinted
    ) throws {
        let data = try encodeToJSONData(
            value: value, outputFormatting: outputFormatting
        )
        let dir = file.deletingLastPathComponent()
        try fm.createDirectory(at: dir)
        try data.write(to: file, options: [.atomic])
    }
}
