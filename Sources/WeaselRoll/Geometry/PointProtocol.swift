public protocol PointProtocol: Hashable, CustomStringConvertible, Codable {
    associatedtype Element: SignedNumeric, Codable
    associatedtype SizeType: SizeProtocol where SizeType.Element == Self.Element

    var x: Element { get set }
    var y: Element { get set }

    init(_ x: Element, _ y: Element)
}

extension PointProtocol {
    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }

    public var description: String {
        "\(x), \(y)"
    }

    public init(from decoder: Decoder) throws {
        let c = try decoder.singleValueContainer()
        let array = try c.decode([Element].self)
        guard array.count >= 2 else {
            throw DecodingError.dataCorruptedError(in: c,
                                                   debugDescription: "array.count < 2")
        }
        self.init(array[0], array[1])
    }

    public func encode(to encoder: Encoder) throws {
        var c = encoder.singleValueContainer()
        let array = [x, y]
        try c.encode(array)
    }

    public static var zero: Self {
        Self(.zero, .zero)
    }

    public func toSize() -> SizeType {
        SizeType(x, y)
    }

    public static func +(a: Self, b: Self) -> Self {
        Self(a.x + b.x, a.y + b.y)
    }

    public static func +=(a: inout Self, b: Self) {
        a = a + b
    }

    public static func +(a: Self, b: SizeType) -> Self {
        Self(a.x + b.width, a.y + b.height)
    }

    public static func +=(a: inout Self, b: SizeType) {
        a = a + b
    }

    public static func -(a: Self, b: Self) -> SizeType {
        SizeType(a.x - b.x, a.y - b.y)
    }

    public static func -(a: Self, b: SizeType) -> Self {
        Self(a.x - b.width, a.y - b.height)
    }

    public static func -=(a: inout Self, b: SizeType) {
        a = a - b
    }

    public static func *(a: Element, b: Self) -> Self {
        Self(a * b.x, a * b.y)
    }

    public static func *(a: Self, b: Element) -> Self {
        b * a
    }

    public static func *=(a: inout Self, b: Element) {
        a = a * b
    }
}

extension PointProtocol where Element: FloatingPoint {
    public static func /(a: Self, b: Element) -> Self {
        Self(a.x / b, a.y / b)
    }

    public static func /=(a: inout Self, b: Element) {
        a = a / b
    }
}
