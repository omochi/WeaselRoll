import Foundation

public protocol HasDecodableProxy : Decodable {
    associatedtype CodableProxy : Decodable
    init(fromCodableProxy proxy: CodableProxy)
}

public protocol HasEncodableProxy : Encodable {
    associatedtype CodableProxy : Encodable
    func encodeToCodableProxy() -> CodableProxy
}

public typealias HasCodableProxy = HasDecodableProxy & HasEncodableProxy

extension HasDecodableProxy {
    public init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        let proxy = try c.decode(CodableProxy.self)
        self.init(fromCodableProxy: proxy)
    }
}

extension HasEncodableProxy {
    public func encode(to encoder: Encoder) throws {
        let proxy = encodeToCodableProxy()
        var c = encoder.singleValueContainer()
        try c.encode(proxy)
    }
}
