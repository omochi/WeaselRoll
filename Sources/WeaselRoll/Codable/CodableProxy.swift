import Foundation

public protocol HasDecodableProxy : Decodable {
    associatedtype CodableProxy : Decodable
    init(fromCodableProxy proxy: CodableProxy) throws
}

public protocol HasEncodableProxy : Encodable {
    associatedtype CodableProxy : Encodable
    func encodeToCodableProxy() throws -> CodableProxy
}

public typealias HasCodableProxy = HasDecodableProxy & HasEncodableProxy

extension HasDecodableProxy {
    public init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        let proxy = try c.decode(CodableProxy.self)
        try self.init(fromCodableProxy: proxy)
    }
}

extension HasEncodableProxy {
    public func encode(to encoder: Encoder) throws {
        let proxy = try encodeToCodableProxy()
        var c = encoder.singleValueContainer()
        try c.encode(proxy)
    }
}
