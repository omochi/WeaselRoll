import Foundation
import WeaselRoll

extension Decodable {
    public static func decodeFromJSON(data: Data) throws -> Self {
        try JSONCodables.decodeFromJSON(type: Self.self, data: data)
    }
    
    public static func loadFromJSON(file: URL) throws -> Self {
        try JSONCodables.loadFromJSON(type: Self.self, file: file)
    }
    
    public static func loadFromJSONIfExists(file: URL) throws -> Self? {
        try JSONCodables.loadFromJSONIfExists(type: Self.self, file: file)
    }
}

extension Encodable {
    public func encodeToJSONData(outputFormatting: JSONEncoder.OutputFormatting = .prettyPrinted) throws -> Data {
        try JSONCodables.encodeToJSONData(value: self, outputFormatting: outputFormatting)
    }
    
    public func storeToJSON(
        file: URL,
        outputFormatting: JSONEncoder.OutputFormatting = .prettyPrinted
    ) throws {
        try JSONCodables.storeToJSON(value: self, file: file, outputFormatting: outputFormatting)
    }
}
